Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Aug 2010 00:15:51 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: QuiC AMP development
Message-ID: <20100811031551.GA8985@vigoh>
References: <4C5F6B58.6000702@codeaurora.org>
 <20100810220238.GB3203@vigoh>
 <alpine.DEB.2.00.1008101925000.6276@linux-sea-02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1008101925000.6276@linux-sea-02>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 19:55:34 -0700]:

> 
> Gustavo -
> 
> On Tue, 10 Aug 2010, Gustavo F. Padovan wrote:
> 
> >Hi all,
> >
> >* Ron Shaffer <rshaffer@codeaurora.org> [2010-08-08 21:43:36 -0500]:
> >
> >>As requested in today's summit discussions, here's a link that can be
> >>used to inspect the code we've done to add AMP support on the latest
> >>next tree.
> >>
> >>https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next-2.6.git;a=summary
> >>branch pk-upstream
> >
> >
> >I'll put here some comments I have about some L2CAP patches:
> 
> Thanks for taking the time to look over all these changes!
> 
> >
> >
> >+static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
> >+{
> >+       u16 allocSize;
> >
> >No capital letter here. Do alloc_size. Check the rest of your code for similar
> >stuff.
> 
> Yes, someone caught that in our internal code review too.  I think
> this was the only one.
> 
> >
> >
> >       u8 event;
> >       struct sk_buff *skb;
> >};
> >+
> >#endif /* __AMP_H */
> >diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
> >index f43d7d8..16e74f6 100644
> >--- a/net/bluetooth/amp.c
> >+++ b/net/bluetooth/amp.c
> >@@ -40,6 +40,7 @@ static struct workqueue_struct *amp_workqueue;
> >LIST_HEAD(amp_mgr_list);
> >DEFINE_RWLOCK(amp_mgr_list_lock);
> >
> >+
> >static void remove_amp_mgr(struct amp_mgr *rem)
> >{
> >       struct amp_mgr *mgr = NULL;
> >
> >Do not add new lines random places into your patch. Check you code for others
> >things like that. Also check for lines overstepping the column 80.
> 
> We definitely know we have work to do to clean up these patches and
> add proper commit messages.  Please be assured that we'll have these
> more tidied up before posting patches to linux-bluetooth.

;)

> 
> >
> >
> >+struct l2cap_enhanced_hdr {
> >+       __le16     len;
> >+       __le16     cid;
> >+       __le16     control;
> >+} __attribute__ ((packed));
> >+#define L2CAP_ENHANCED_HDR_SIZE                6
> >
> >Get ride off this struct, that actually doesn't help. We tried that before and
> >Marcel and I agreed that it does not help.
> 
> If you guys don't like it, I'll take it out.
> 
> >
> >-               if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> >+
> >+               if (memcpy_fromiovec(skb_put(*frag, count),
> >+                               msg->msg_iov, count))
> >                       return -EFAULT;
> >
> >Avoid changes like that in your patches, you are just breaking a line here. If
> >you want to do that do in a separeted patch.
> >
> >
> >
> >+/* L2CAP ERTM / Streaming extra field lengths */
> >+#define L2CAP_FCS_SIZE          2
> >
> >Separated patch for that, so then you replace 2 for L2CAP_FCS_SIZE in one
> >patch, instead of doing that in many patches like you are doing now. The same
> >goes for L2CAP_SDULEN_SIZE.
> 
> Yes, I already split that commit up to send the "RFC" patch set
> earlier today.  Unfortunately I missed that commit when generating
> my patches :(
> 
> 
> >-/* L2CAP Supervisory Function */
> >+/* L2CAP Supervisory Frame Types */
> >+#define L2CAP_SFRAME_RR            0x00
> >+#define L2CAP_SFRAME_REJ           0x01
> >+#define L2CAP_SFRAME_RNR           0x02
> >+#define L2CAP_SFRAME_SREJ          0x03
> >#define L2CAP_SUPER_RCV_READY           0x0000
> >#define L2CAP_SUPER_REJECT              0x0004
> >#define L2CAP_SUPER_RCV_NOT_READY       0x0008
> >#define L2CAP_SUPER_SELECT_REJECT       0x000C
> >
> >/* L2CAP Segmentation and Reassembly */
> >+#define L2CAP_SAR_UNSEGMENTED      0x00
> >+#define L2CAP_SAR_START            0x01
> >+#define L2CAP_SAR_END              0x02
> >+#define L2CAP_SAR_CONTINUE         0x03
> >#define L2CAP_SDU_UNSEGMENTED       0x0000
> >#define L2CAP_SDU_START             0x4000
> >#define L2CAP_SDU_END               0x8000
> >
> >What is that? we already have such defines.
> 
> I was trying to not break existing code, while also creating
> constants that were useful for modified code that will work with
> either extended or enhanced headers.  The new values are important,
> but I agree that this is not the way to introduce the changes.  See
> below for more detail.
> 
> >commit 162e6de6d5c11b8ffea91a9fa2d597340afdeb6e
> >Author: Mat Martineau <mathewm@codeaurora.org>
> >Date:   Thu Aug 5 16:59:46 2010 -0700
> >
> >   Bluetooth: Remove unused L2CAP code.
> >
> >net/bluetooth/l2cap.c | 1104 +------------------------------------------------
> >1 files changed, 15 insertions(+), 1089 deletions(-)
> >
> >That's not acceptable, we have to modify the existent base code and make it
> >work with the new features, instead writing a new one and then switch to it.
> 
> When setting up the commits for this git branch, I had to pick
> between two approaches:
> 
>  * Build up a modified state machine in parallel, so the switchover
> could happen in one patch.  The code would compile and run after
> every patch.
> 
>  * Or, start modifying the state machine piece by piece.  Until all
> of the modifications were done, ERTM would not work.
> 
> I don't think my approach worked out well (mostly because it doesn't
> preserve history adequately, and doesn't make it clear where code
> has been modified instead of newly written).  However, it's what we
> had to share coming in to the Bluetooth summit, and we felt it was
> very important to share it.  I want to refine the approach to these
> patches to put them in some acceptable form, so lets talk about the
> best way to do that.

I see. But now that they are public we can talk about and put them in
shape for the merge into the mainline.
I think it's possible to add AMP stuff without break ERTM (and we have
to take care about that, because now ERTM pass all PTS tests). We can
arrange your commits to not break ERTM any time.

> 
> 
> >commit 09850f68219572288fe62a59235fda3d2629c7b2
> >Author: Peter Krystad <pkrystad@codeaurora.org>
> >Date:   Wed Aug 4 16:55:11 2010 -0700
> >
> >   Rename l2cap.c to el2cap.c.
> >
> >   Necessary before additional files can be added to l2cap module.
> >   A module cannot contain a file with the same name as the module.
> >
> >We don't neeed that. We might split l2cap.c into smaller chunks before merge
> >all the AMP stuff into it, so we won't have the module name problem anymore.
> 
> There is a technical reason for this.  We changed the Makefile to
> create l2cap.ko from two source files - one for L2CAP and one for
> AMP. However, the build system fails if you try to link l2cap.c and
> amp.c in to l2cap.ko.  We had to come up with some other name for
> l2cap.c in order to keep the module name the same.  There's probably
> a better choice than el2cap.c - any suggestions are welcome.

Yeah, I know, that's why the l2cap.c split will help this. Marcel
told that on the meeting Sunday.

-- 
Gustavo F. Padovan
http://padovan.org
