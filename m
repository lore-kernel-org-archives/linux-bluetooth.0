Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 19:02:38 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: QuiC AMP development
Message-ID: <20100810220238.GB3203@vigoh>
References: <4C5F6B58.6000702@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C5F6B58.6000702@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

* Ron Shaffer <rshaffer@codeaurora.org> [2010-08-08 21:43:36 -0500]:

> As requested in today's summit discussions, here's a link that can be
> used to inspect the code we've done to add AMP support on the latest
> next tree.
> 
> https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next-2.6.git;a=summary
> branch pk-upstream


I'll put here some comments I have about some L2CAP patches:


+static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
+{
+       u16 allocSize;
                                                                               
No capital letter here. Do alloc_size. Check the rest of your code for similar
stuff.                                                                         
                                                                               
                                                                               
        u8 event;                                                              
        struct sk_buff *skb;                                                   
 };                                                                            
+                                                                              
 #endif /* __AMP_H */                                                          
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c                         
index f43d7d8..16e74f6 100644                                                  
--- a/net/bluetooth/amp.c                                                      
+++ b/net/bluetooth/amp.c                                                      
@@ -40,6 +40,7 @@ static struct workqueue_struct *amp_workqueue;               
 LIST_HEAD(amp_mgr_list);
 DEFINE_RWLOCK(amp_mgr_list_lock);
 
+
 static void remove_amp_mgr(struct amp_mgr *rem)
 {
        struct amp_mgr *mgr = NULL;

Do not add new lines random places into your patch. Check you code for others
things like that. Also check for lines overstepping the column 80.



+struct l2cap_enhanced_hdr {
+       __le16     len;
+       __le16     cid;
+       __le16     control;
+} __attribute__ ((packed));
+#define L2CAP_ENHANCED_HDR_SIZE                6

Get ride off this struct, that actually doesn't help. We tried that before and
Marcel and I agreed that it does not help.



-               if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+
+               if (memcpy_fromiovec(skb_put(*frag, count),
+                               msg->msg_iov, count))
                        return -EFAULT;

Avoid changes like that in your patches, you are just breaking a line here. If
you want to do that do in a separeted patch.



+/* L2CAP ERTM / Streaming extra field lengths */
+#define L2CAP_FCS_SIZE          2

Separated patch for that, so then you replace 2 for L2CAP_FCS_SIZE in one
patch, instead of doing that in many patches like you are doing now. The same
goes for L2CAP_SDULEN_SIZE.



-/* L2CAP Supervisory Function */
+/* L2CAP Supervisory Frame Types */
+#define L2CAP_SFRAME_RR            0x00
+#define L2CAP_SFRAME_REJ           0x01
+#define L2CAP_SFRAME_RNR           0x02
+#define L2CAP_SFRAME_SREJ          0x03
 #define L2CAP_SUPER_RCV_READY           0x0000
 #define L2CAP_SUPER_REJECT              0x0004
 #define L2CAP_SUPER_RCV_NOT_READY       0x0008
 #define L2CAP_SUPER_SELECT_REJECT       0x000C
 
 /* L2CAP Segmentation and Reassembly */
+#define L2CAP_SAR_UNSEGMENTED      0x00
+#define L2CAP_SAR_START            0x01
+#define L2CAP_SAR_END              0x02
+#define L2CAP_SAR_CONTINUE         0x03
 #define L2CAP_SDU_UNSEGMENTED       0x0000
 #define L2CAP_SDU_START             0x4000
 #define L2CAP_SDU_END               0x8000

What is that? we already have such defines.



commit 162e6de6d5c11b8ffea91a9fa2d597340afdeb6e
Author: Mat Martineau <mathewm@codeaurora.org>
Date:   Thu Aug 5 16:59:46 2010 -0700

    Bluetooth: Remove unused L2CAP code.

 net/bluetooth/l2cap.c | 1104 +------------------------------------------------
 1 files changed, 15 insertions(+), 1089 deletions(-)

That's not acceptable, we have to modify the existent base code and make it
work with the new features, instead writing a new one and then switch to it.



commit 09850f68219572288fe62a59235fda3d2629c7b2
Author: Peter Krystad <pkrystad@codeaurora.org>
Date:   Wed Aug 4 16:55:11 2010 -0700

    Rename l2cap.c to el2cap.c.
    
    Necessary before additional files can be added to l2cap module.
    A module cannot contain a file with the same name as the module.

We don't neeed that. We might split l2cap.c into smaller chunks before merge
all the AMP stuff into it, so we won't have the module name problem anymore. 

-- 
Gustavo F. Padovan
http://padovan.org
