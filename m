Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511011108v13f75f08i6291e266eb235a34@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
In-Reply-To: <e1effdeb0511010521x6dfff470o9580b22bebd1c75d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3682_19784819.1130872084900"
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
	 <1130760726.17124.17.camel@blade>
	 <e1effdeb0510310547m51a457f2m19f00ec5cf194289@mail.gmail.com>
	 <1130850674.31561.65.camel@blade>
	 <e1effdeb0511010521x6dfff470o9580b22bebd1c75d@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 1 Nov 2005 17:08:04 -0200

------=_Part_3682_19784819.1130872084900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here is patch to move the find_conn function to lib.c file.

Regarding the error related functions, can I move to a error.c file or
it's better keep them in the dbus.c?

Another point is the Disconnect signal. Which approach you preffer
exit or create a timer to re-connect each x seconds?

IMHO, I think it not necessary handle this scenario. Restart the
dbus-daemon is not common.


Regards,
Claudio.





On 11/1/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>
> I will wait the D-Bus path changes before submit this changes.
>
> Regarding the error.c file it's just organization, I would like move
> all error related function to other file.
>
> Regards,
> Claudio
>
>
> On 11/1/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
> > > Probably in the future when we start develop another features(rfcomm,
> > > pan, ...) we will find more shared functions. I will put the find_con=
n
> > > to a lib.c(inside de hcid) directory first according with your
> > > suggestion. In the future we can discuss it later again.
> > > Another file that I want create is the error.c
> >
> > send me a separate patch for the move to the lib.c file.
> >
> > What do you wanna put into the error.c file. Explain me your idea behin=
d
> > it and the benefits.
> >
> > > When the dbus-daemon exits, the hcid will receive a "Disconnect"
> > > signal. The hcid can start a task to re-establish the bus connection
> > > each X seconds or it can exit.
> > > Currently, hcid catches the signal, but there is no action associated
> > > with this signal.
> >
> > I see and it seems we need a patch to deal with the dbus-daemon exits i=
n
> > case of restarts or errors in it. Please come up with a patch for it.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by the JBoss Inc.
> > Get Certified Today * Register for a JBoss Training Course
> > Free Certification Exam for All Training Attendees Through End of 2005
> > Visit http://www.jboss.com/services/certification for more information
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_3682_19784819.1130872084900
Content-Type: text/x-patch; name=find_conn.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="find_conn.patch"

--- bluez-utils-cvs.orig/hcid/hcid.h	2005-11-01 14:41:12.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/hcid.h	2005-11-01 14:44:08.000000000 -0200
@@ -23,10 +23,6 @@
  *
  */
 
-#include <syslog.h>
-#include <sys/types.h>
-#include <sys/ioctl.h>
-
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 
@@ -153,32 +149,3 @@
 int read_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key);
 int read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
 
-static inline int find_conn(int dd, int dev_id, long arg)
-{
-	struct hci_conn_list_req *cl;
-	struct hci_conn_info *ci;
-	int i;
-
-	cl = malloc(10 * sizeof(*ci) + sizeof(*cl));
-	if (!cl) {
-		syslog(LOG_ERR, "Can't allocate memory");
-		return 0;
-	}
-
-	cl->dev_id = dev_id;
-	cl->conn_num = 10;
-	ci = cl->conn_info;
-
-	if (ioctl(dd, HCIGETCONNLIST, (void *) cl)) {
-		syslog(LOG_ERR, "Can't get connection list");
-		return 0;
-	}
-
-	for (i = 0; i < cl->conn_num; i++, ci++)
-		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
-			return 1;
-
-	free(cl);
-
-	return 0;
-}
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-11-01 14:41:12.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-11-01 14:39:02.000000000 -0200
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <signal.h>
 #include <syslog.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -42,6 +43,7 @@
 #include "glib-ectomy.h"
 
 #include "hcid.h"
+#include "lib.h"
 #include "dbus.h"
 
 static DBusConnection *connection;
--- bluez-utils-cvs.orig/hcid/lib.h	2005-11-01 14:41:12.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/lib.h	2005-11-01 15:17:50.000000000 -0200
@@ -25,6 +25,8 @@
 
 #include <errno.h>
 
+int find_conn(int dd, int dev_id, long arg);
+
 char *expand_name(char *dst, int size, char *str, int dev_id);
 
 char *get_host_name(void);
--- bluez-utils-cvs.orig/hcid/lib.c	2005-11-01 14:41:12.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/lib.c	2005-11-01 15:22:12.000000000 -0200
@@ -34,6 +34,8 @@
 #include <stdarg.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/ioctl.h>
+#include <syslog.h>
 #include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
@@ -45,6 +47,36 @@
 
 volatile sig_atomic_t __io_canceled;
 
+int find_conn(int dd, int dev_id, long arg)
+{
+	struct hci_conn_list_req *cl;
+	struct hci_conn_info *ci;
+	int i;
+
+	cl = malloc(10 * sizeof(*ci) + sizeof(*cl));
+	if (!cl) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		return 0;
+	}
+
+	cl->dev_id = dev_id;
+	cl->conn_num = 10;
+	ci = cl->conn_info;
+
+	if (ioctl(dd, HCIGETCONNLIST, (void *) cl)) {
+		syslog(LOG_ERR, "Can't get connection list");
+		return 0;
+	}
+
+	for (i = 0; i < cl->conn_num; i++, ci++)
+		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
+			return 1;
+
+	free(cl);
+
+	return 0;
+}
+
 /* 
  * Device name expansion 
  *   %d - device id

------=_Part_3682_19784819.1130872084900--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
