Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 20:51:35 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCH 7/9] Bluetooth: Use symbolic values for the fixed channel
 map
Message-ID: <20111014235135.GF30989@joana>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
 <1318543247-27130-8-git-send-email-mathewm@codeaurora.org>
 <20111014123608.GB4753@aemeltch-MOBL1>
 <alpine.DEB.2.02.1110141559060.9993@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1110141559060.9993@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-10-14 16:04:01 -0700]:

> 
> 
> On Fri, 14 Oct 2011, Andrei Emeltchenko wrote:
> 
> >Hi Mat,
> >
> >On Thu, Oct 13, 2011 at 03:00:45PM -0700, Mat Martineau wrote:
> >>The A2MP fixed channel bit is only set when high-speed mode is enabled.
> >
> >It might make sense to merge previous patch with definitions of
> >L2CAP_FC_L2CAP and L2CAP_FC_A2MP, otherwise these 2 patches are a bit
> >small.
> >
> >>
> >>Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >>---
> >> net/bluetooth/l2cap_core.c |    6 +++++-
> >> 1 files changed, 5 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>index d023156..e38258b 100644
> >>--- a/net/bluetooth/l2cap_core.c
> >>+++ b/net/bluetooth/l2cap_core.c
> >>@@ -60,7 +60,7 @@ int disable_ertm;
> >> int enable_hs;
> >>
> >> static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
> >>-static u8 l2cap_fixed_chan[8] = { 0x02, };
> >>+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
> >
> >I personally do not like present approach with allocating 8-octet array
> >when we need only one octet _FOR_NOW_. (Also assigning is not clear enough).
> >
> >Why not:
> >
> ><------8<-----------------------------------------------
> >|  @@ -60,7 +60,7 @@ int disable_ertm;
> >|   int enable_hs;
> >|
> >|   static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
> >|  -static u8 l2cap_fixed_chan[8] = { 0x02, };
> >|  +static u8 l2cap_fixed_chan = L2CAP_FC_L2CAP;
> >|
> >|   static LIST_HEAD(chan_list);
> >|   static DEFINE_RWLOCK(chan_list_lock);
> >|
> ><------8<-----------------------------------------------
> 
> Since the fixed channel map is 8 bytes, it makes some sense to have
> this data structure match what is used in the info request.  The 8th
> byte contains a bit that's defined for the AMP test manager too.

Yes, let's keep the 8 octet array. It make more sense as we use it on the
information response.  Btw, I fine with this patch.

	Gustavo
