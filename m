Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041005060130.18216.qmail@web13125.mail.yahoo.com>
From: Ka Fai Lau <iamkafai2002@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-699606226-1096956090=:15620"
Subject: [Bluez-devel] ftp patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 4 Oct 2004 23:01:30 -0700 (PDT)

--0-699606226-1096956090=:15620
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

I d/l the ftp from cvs but somehow broken to me.  I have made a patch to the obex and ftp.  It is
a really quick patch.  Hopefully, I didn't make too many mistakes :D

--KaFai


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
--0-699606226-1096956090=:15620
Content-Type: text/x-patch; name="obex_ftp.patch"
Content-Description: obex_ftp.patch
Content-Disposition: inline; filename="obex_ftp.patch"

Index: ftp/main.c
===================================================================
RCS file: /cvsroot/bluez/obex/ftp/main.c,v
retrieving revision 1.3
diff -p -b -u -r1.3 main.c
--- ftp/main.c	12 Jul 2004 12:12:20 -0000	1.3
+++ ftp/main.c	5 Oct 2004 05:43:38 -0000
@@ -31,8 +31,11 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <signal.h>
+#include <libgen.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -126,6 +129,57 @@ static void cmd_get(int od, int argc, ch
 	}
 }
 
+static void cmd_put(int od, int argc, char **argv)
+{
+	int fd;
+	struct stat a_stat;
+	char *data;
+
+	if (argc != 1) {
+		printf("Usage: put local-file\n");
+		return;
+	}
+
+	fd = open(argv[0], O_RDONLY);
+	if (fd == -1) {
+		perror("open:");
+		return;
+	}
+
+	if (fstat(fd, &a_stat) == -1) {
+		perror("fstat:");
+		goto rel_fd;
+		return;
+	}
+
+	data = (char*)mmap(NULL, (size_t) a_stat.st_size, PROT_READ, 
+			   MAP_SHARED, fd, 0);
+	if(!data) {
+		perror("mmap:");
+		goto rel_fd;
+		return;
+	}
+
+	if (obex_put(od, NULL, basename(argv[0]), data, a_stat.st_size) == 0) {
+		printf("%lu bytes sent\n", a_stat.st_size);
+	}
+
+	munmap(data, a_stat.st_size);
+ rel_fd:
+	close(fd);
+}
+
+static void cmd_del(int od, int argc, char **argv)
+{
+	if (argc != 1) {
+		printf("Usage: del remote file\n");
+		return;
+	}
+
+	obex_put(od, NULL, argv[0], NULL, 0);
+
+}
+
 struct {
 	char *cmd;
 	char *alt;
@@ -138,6 +192,8 @@ struct {
 	{ "cd",    "chdir", cmd_chdir, "[dir]",  "Change directory"     },
 	{ "mkdir", "",      cmd_mkdir, "<dir>",  "Create new directory" },
 	{ "get",   "mget",  cmd_get,   "<file>", "Retrieve file"        },
+	{ "put",   "put",   cmd_put,   "<file>", "Upload file"          },
+ 	{ "del",   "delete",cmd_del,   "<file>"  "delete remove file"   },
 	{ NULL, NULL, NULL, 0, 0 }
 };
 
Index: goep/obex.c
===================================================================
RCS file: /cvsroot/bluez/obex/goep/obex.c,v
retrieving revision 1.4
diff -p -b -u -r1.4 obex.c
--- goep/obex.c	12 Jul 2004 12:11:48 -0000	1.4
+++ goep/obex.c	5 Oct 2004 05:43:38 -0000
@@ -207,6 +207,9 @@ static void obex_request_done(obex_t *ha
 				memset(context->data_buf, 0, hl + 1);
 				memcpy(context->data_buf, hd.bs, hl);
 				break;
+			case OBEX_HDR_TYPE:
+				/* [TODO]: interpret type later. MIME?? */
+				break;
 			default:
 				printf("Hdr: Unknown header %02x\n", hi);
 				break;
@@ -330,13 +333,17 @@ int obex_put(int od, const char *type, c
 			OBEX_HDR_NAME, hd, len, OBEX_FL_FIT_ONE_PACKET);
 	}
 
+	if (size) {
 	hd.bq4 = size;
 	OBEX_ObjectAddHeader(handle, object,
-		OBEX_HDR_LENGTH, hd, 4, OBEX_FL_FIT_ONE_PACKET);
+				     OBEX_HDR_LENGTH, hd, 4, 
+				     OBEX_FL_FIT_ONE_PACKET);
 
 	hd.bs = data;
 	OBEX_ObjectAddHeader(handle, object,
-		OBEX_HDR_BODY, hd, size, OBEX_FL_FIT_ONE_PACKET);
+				     OBEX_HDR_BODY, hd, size, 
+				     OBEX_FL_FIT_ONE_PACKET);
+	}
 
 	if ((err = OBEX_Request(handle, object)) < 0)
 		return err;

--0-699606226-1096956090=:15620--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
