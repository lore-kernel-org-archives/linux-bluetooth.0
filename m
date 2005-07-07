Return-Path: <domen@homer.coderock.org>
Message-Id: <20050707213034.335385000@homer>
Date: Thu, 07 Jul 2005 23:30:34 +0200
From: domen@coderock.org
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net, Victor Fusco <victor@cetuc.puc-rio.br>,
   domen@coderock.org
Subject: [patch 2/3] hci_usb: fix sparse warnings (__nocast type)
List-ID: <bluez-devel.lists.sourceforge.net>

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/bluetooth/hci_usb.c

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 hci_usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/bluetooth/hci_usb.c
===================================================================
--- quilt.orig/drivers/bluetooth/hci_usb.c
+++ quilt/drivers/bluetooth/hci_usb.c
@@ -126,7 +126,7 @@ static struct usb_device_id blacklist_id
 	{ }	/* Terminating entry */
 };
 
-static struct _urb *_urb_alloc(int isoc, int gfp)
+static struct _urb *_urb_alloc(int isoc, unsigned int __nocast gfp)
 {
 	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
 				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);

--
