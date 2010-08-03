Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/8] Bluetooth: Make sure the L2CAP FCS is only enabled
 for ERTM or streaming.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org
In-Reply-To: <alpine.DEB.2.00.1008030814570.19861@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-2-git-send-email-mathewm@codeaurora.org>
	 <1280777912.12579.37.camel@localhost.localdomain>
	 <20100802212014.GB20149@vigoh>
	 <alpine.DEB.2.00.1008021519430.18432@linux-sea-02>
	 <1280789488.12579.60.camel@localhost.localdomain>
	 <alpine.DEB.2.00.1008030814570.19861@linux-sea-02>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 09:11:10 -0700
Message-ID: <1280851870.12579.84.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi mat,

> >>>>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >>>>> ---
> >>>>>  net/bluetooth/l2cap.c |   12 ++++++++----
> >>>>>  1 files changed, 8 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> >>>>> index 9ba1e8e..aed72f2 100644
> >>>>> --- a/net/bluetooth/l2cap.c
> >>>>> +++ b/net/bluetooth/l2cap.c
> >>>>> @@ -3127,8 +3127,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> >>>>>  		goto unlock;
> >>>>>
> >>>>>  	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
> >>>>> -		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> >>>>> -		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
> >>>>> +		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
> >>>>> +			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
> >>>>> +			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
> >>>>> +			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
> >>>>>  			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
> >>>>
> >>>> this becomes unreadable and my brain starts to throw a core dump. So it
> >>>> clearly needs to be put into a helper inline function.
> >>>
> >>> Actually we don't need that, since the code that deals with Basic Mode
> >>> never check  and use the l2cap_pi(sk)->fcs. So we don't care about FCS
> >>> value in the Basic Mode.
> >>
> >> There isn't currently any Basic Mode code that triggers this latent
> >> bug, but I have a patch coming up that does require this fix.
> >>
> >> As it stands, getsockopt() on a connected basic mode socket shows FCS
> >> enabled, so this bug is visible from userspace.
> >
> > can we just fail the setsockopt() when trying to set basic mode and FCS
> > off.
> 
> It definitely makes sense to have more validation of L2CAP_OPTIONS 
> passed to setsockopt().
> 
> > And also in case fallback to basic mode happens, then FCS should be set
> > to be enabled. Since for FCS and basic mode we always have to use FCS.
> > So that seems just fine to me.
> 
> The spec says "The FCS option shall only be used when the mode is 
> being, or is already configured to Enhanced Retransmission mode or 
> Streaming mode."  FCS is never used in basic mode (fallback or not).
> 
> (Maybe I've misunderstood your point)

So basic mode uses CRC16 as FCS. And with basic that is not changeable.
If you try basic mode + no FCS then we should clearly fail the call to
setsockopt() for that.

> > Maybe you need to explain a bit more in detail what you are trying to
> > achieve in conjunction with userspace API.
> 
> My goal is to only have l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16 when the 
> FCS option is actually in use.  Otherwise, any logic checking for FCS 
> also has to check the L2CAP mode.  Might as well check the mode once 
> and set fcs accordingly -- which is what my patch does.
> 
> Gustavo is correct that l2cap_pi(sk)->fcs is currently only checked on 
> code paths used with ERTM and streaming mode.  However, future code 
> (including a patch I'll be posting soon) will depend on the fcs value 
> being accurate in all modes.

As I said, I have no problem with returning basic mode + crc16. Since
that is actually what you are doing in that case.

The only thing that we have to keep in mind to be backward compatible is
to allow setting of basic mode and fcs = 0x00 and then change that into
crc16.

Regards

Marcel


