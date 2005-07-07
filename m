Return-Path: <domen@homer.coderock.org>
Message-Id: <20050707213032.828120000@homer>
Date: Thu, 07 Jul 2005 23:30:33 +0200
From: domen@coderock.org
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net, Victor Fusco <victor@cetuc.puc-rio.br>,
   domen@coderock.org
Subject: [patch 1/3] bluetooth.h: fix sparse warnings (__nocast type)
List-ID: <bluez-devel.lists.sourceforge.net>

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"

File/Subsystem: include/net/bluetooth/bluetooth.h

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 bluetooth.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: quilt/include/net/bluetooth/bluetooth.h
===================================================================
--- quilt.orig/include/net/bluetooth/bluetooth.h
+++ quilt/include/net/bluetooth/bluetooth.h
@@ -141,7 +141,8 @@ struct bt_skb_cb {
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)(skb->cb)) 
 
-static inline struct sk_buff *bt_skb_alloc(unsigned int len, int how)
+static inline struct sk_buff *bt_skb_alloc(unsigned int len,
+                                           unsigned int __nocast how)
 {
 	struct sk_buff *skb;
 

--
