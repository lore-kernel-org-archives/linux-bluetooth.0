Return-Path: <domen@homer.coderock.org>
Message-Id: <20050707213035.624483000@homer>
Date: Thu, 07 Jul 2005 23:30:35 +0200
From: domen@coderock.org
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net, Victor Fusco <victor@cetuc.puc-rio.br>,
   domen@coderock.org
Subject: [patch 3/3] bpa10x: fix sparse warnings (__nocast type)
List-ID: <bluez-devel.lists.sourceforge.net>

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/bluetooth/bpa10x.c

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 bpa10x.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: quilt/drivers/bluetooth/bpa10x.c
===================================================================
--- quilt.orig/drivers/bluetooth/bpa10x.c
+++ quilt/drivers/bluetooth/bpa10x.c
@@ -307,7 +307,9 @@ unlock:
 	read_unlock(&data->lock);
 }
 
-static inline struct urb *bpa10x_alloc_urb(struct usb_device *udev, unsigned int pipe, size_t size, int flags, void *data)
+static inline struct urb *bpa10x_alloc_urb(struct usb_device *udev, unsigned int pipe,
+                                           size_t size, unsigned int __nocast flags,
+                                           void *data)
 {
 	struct urb *urb;
 	struct usb_ctrlrequest *cr;

--
