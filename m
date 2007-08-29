Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46D57FE3.2090508@andorsystems.com>
Date: Wed, 29 Aug 2007 16:17:07 +0200
From: giulio fedel <giulio.fedel@andorsystems.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] hci_inquiry problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
I'm working on an arm embedded system. It turn out that hci_inquiry in 
hci.c (libs) calls

--> buf = malloc(sizeof(*ir) + (sizeof(inquiry_info) * (nrsp)))
...
--> ioctl(dd, HCIINQUIRY, (unsigned long) buf)
...

My problem is that sizeof(struct hci_inquiry_req) is not the same in 
kernel space and in user space (nothing strange), so when in the kernel 
driver in hci_core.c we do:

--> hci_inquiry_req * ir;
...
--> ptr += sizeof(ir);
--> copy_to_user(ptr, buf, sizeof(struct inquiry_info) * ir.num_rsp)

and in the library code (hci_inquiry)

--> hci_inquiry_req * ir;
...
--> memcpy((void *) *ii, buf + sizeof(*ir), size);

the things do not work as aspected.
I solved my problem with __attribute__ ((packed)) in hci.h
in the kernel tree (include/net/bluetooth/) and in the library
(include/hci.h).

Regards.

     Giulio Fedel


patches on hci(s).h

Kernel side:


--- linux-2.6.22.1/include/net/bluetooth/hci.h.orig     2007-08-29 
15:14:49.000000000 +0200
+++ linux-2.6.22.1/include/net/bluetooth/hci.h  2007-08-29 
15:14:35.000000000 +0200
@@ -845,7 +845,7 @@
         __u8  lap[3];
         __u8  length;
         __u8  num_rsp;
-};
+} __attribute__ ((packed));
  #define IREQ_CACHE_FLUSH 0x0001

  #endif /* __HCI_H */


library:

--- bluez-libs-3.16/include/hci.h.orig  2007-08-29 15:18:25.000000000 +0200
+++ bluez-libs-3.16/include/hci.h       2007-08-29 15:18:58.000000000 +0200
@@ -1815,7 +1815,7 @@
         uint8_t  lap[3];
         uint8_t  length;
         uint8_t  num_rsp;
-};
+} __attribute__ ((packed)) ;
  #define IREQ_CACHE_FLUSH 0x0001

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
