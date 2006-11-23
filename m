Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 23 Nov 2006 10:53:22 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CEPZFcVoadZ6SKW"
Message-Id: <200611231053.22669.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] XML output for sdptool
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_CEPZFcVoadZ6SKW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

This patch adds the --xml option to the following commands:
- records
- get
- browse
- search

If the --xml option is specified, the output is in XML format.

-Denis

--Boundary-00=_CEPZFcVoadZ6SKW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sdptool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdptool.patch"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/tools/Makefile.am,v
retrieving revision 1.41
diff -u -5 -r1.41 Makefile.am
--- Makefile.am	4 Jun 2006 12:09:31 -0000	1.41
+++ Makefile.am	23 Nov 2006 00:16:17 -0000
@@ -45,11 +45,11 @@
 hcitool_SOURCES = hcitool.c
 hcitool_LDADD = @BLUEZ_LIBS@ $(top_builddir)/common/libhelper.a
 
 l2ping_LDADD = @BLUEZ_LIBS@
 
-sdptool_LDADD = @BLUEZ_LIBS@
+sdptool_LDADD = @BLUEZ_LIBS@ $(top_builddir)/common/libhelper.a
 
 ciptool_LDADD = @BLUEZ_LIBS@
 
 ppporc_LDADD = @BLUEZ_LIBS@
 
Index: sdptool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/sdptool.c,v
retrieving revision 1.61
diff -u -5 -r1.61 sdptool.c
--- sdptool.c	15 Oct 2006 13:07:47 -0000	1.61
+++ sdptool.c	23 Nov 2006 00:16:18 -0000
@@ -43,10 +43,12 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
 #include <netinet/in.h>
 
+#include "sdp-xml.h"
+
 #ifndef APPLE_AGENT_SVCLASS_ID
 #define APPLE_AGENT_SVCLASS_ID 0x2112
 #endif
 
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, 0)) != -1)
@@ -65,10 +67,11 @@
 }
 
 #define DEFAULT_VIEW	0	/* Display only known attribute */
 #define TREE_VIEW	1	/* Display full attribute tree */
 #define RAW_VIEW	2	/* Display raw tree */
+#define XML_VIEW	3	/* Display xml tree */
 
 /* Pass args to the inquiry/search handler */
 struct search_context {
 	char		*svc;		/* Service */
 	uuid_t		group;		/* Browse group */
@@ -3327,10 +3330,15 @@
 
 	for (i = 0; i < count; i++)
 		handler(&ii[i].bdaddr, arg);
 }
 
+static void doprintf(void *data, const char *str)
+{
+	printf(str);
+}
+
 /*
  * Search for a specific SDP service
  */
 static int do_search(bdaddr_t *bdaddr, struct search_context *context)
 {
@@ -3381,10 +3389,14 @@
 		case TREE_VIEW:
 			/* Display full tree */
 			print_tree_attr(rec);
 			printf("\n");
 			break;
+		case XML_VIEW:
+			/* Display raw XML tree */
+			convert_sdp_record_to_xml(rec, 0, doprintf);
+			break;
 		default:
 			/* Display raw tree */
 			print_raw_attr(rec);
 			break;
 		}
@@ -3407,18 +3419,19 @@
 
 static struct option browse_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",	0, 0, 'x' },
 	{ "uuid",	1, 0, 'u' },
 	{ "l2cap",	0, 0, 'l' },
 	{ 0, 0, 0, 0 }
 };
 
 static char *browse_help = 
 	"Usage:\n"
-	"\tbrowse [--tree] [--raw] [--uuid uuid] [--l2cap] [bdaddr]\n";
+	"\tbrowse [--tree] [--raw] [--xml] [--uuid uuid] [--l2cap] [bdaddr]\n";
 
 /*
  * Browse the full SDP database (i.e. list all services starting from the
  * root/top-level).
  */
@@ -3438,10 +3451,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		case 'u':
 			if (sscanf(optarg, "%i", &num) != 1 || num < 0 || num > 0xffff) {
 				printf("Invalid uuid %s\n", optarg);
 				return -1;
 			}
@@ -3471,16 +3487,17 @@
 static struct option search_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "bdaddr",	1, 0, 'b' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",	0, 0, 'x' },
 	{ 0, 0, 0, 0}
 };
 
 static char *search_help = 
 	"Usage:\n"
-	"\tsearch [--bdaddr bdaddr] [--tree] [--raw] SERVICE\n"
+	"\tsearch [--bdaddr bdaddr] [--tree] [--raw] [--xml] SERVICE\n"
 	"SERVICE is a name (string) or UUID (0x1002)\n";
 
 /*
  * Search for a specific SDP service
  *
@@ -3512,10 +3529,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(search_help);
 			return -1;
 		}
 	}
@@ -3608,10 +3628,14 @@
 	case TREE_VIEW:
 		/* Display full tree */
 		print_tree_attr(rec);
 		printf("\n");
 		break;
+	case XML_VIEW:
+		/* Display raw XML tree */
+		convert_sdp_record_to_xml(rec, 0, doprintf);
+		break;
 	default:
 		/* Display raw tree */
 		print_raw_attr(rec);
 		break;
 	}
@@ -3622,16 +3646,17 @@
 
 static struct option records_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",	0, 0, 'x' },
 	{ 0, 0, 0, 0 }
 };
 
 static char *records_help = 
 	"Usage:\n"
-	"\trecords [--tree] [--raw] bdaddr\n";
+	"\trecords [--tree] [--raw] [--xml] bdaddr\n";
 
 /*
  * Request possible SDP service records
  */
 static int cmd_records(int argc, char **argv)
@@ -3650,10 +3675,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(records_help);
 			return -1;
 		}
 	}
@@ -3684,16 +3712,17 @@
 static struct option get_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "bdaddr",	1, 0, 'b' },
 	{ "tree",	0, 0, 't' },
 	{ "raw",	0, 0, 'r' },
+	{ "xml",	0, 0, 'x' },
 	{ 0, 0, 0, 0 }
 };
 
 static char *get_help = 
 	"Usage:\n"
-	"\tget [--tree] [--raw] [--bdaddr bdaddr] record_handle\n";
+	"\tget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\n";
 
 /*
  * Get a specific SDP record on the local SDP server
  */
 static int cmd_get(int argc, char **argv)
@@ -3716,10 +3745,13 @@
 			context.view = TREE_VIEW;
 			break;
 		case 'r':
 			context.view = RAW_VIEW;
 			break;
+		case 'x':
+			context.view = XML_VIEW;
+			break;
 		default:
 			printf(get_help);
 			return -1;
 		}
 	}

--Boundary-00=_CEPZFcVoadZ6SKW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_CEPZFcVoadZ6SKW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_CEPZFcVoadZ6SKW--
