Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/9] Bluetooth: Add BT_AMP_POLICY socket option
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Sat, 15 Oct 2011 11:43:16 -0700
In-Reply-To: <alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
	  <1318543247-27130-2-git-send-email-mathewm@codeaurora.org>
	 <1318549090.15441.49.camel@aeonflux>
	 <alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318704223.15441.71.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> >> Allow control of AMP functionality on L2CAP sockets. By default,
> >> connections will be restricted to BR/EDR.  Manipulating the
> >> BT_AMP_POLICY option allows for channels to be moved to or created
> >> on AMP controllers.
> >>
> >> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> >> ---
> >>  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
> >>  1 files changed, 27 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> >> index e727555..14ae418 100644
> >> --- a/include/net/bluetooth/bluetooth.h
> >> +++ b/include/net/bluetooth/bluetooth.h
> >> @@ -77,6 +77,33 @@ struct bt_power {
> >>  #define BT_POWER_FORCE_ACTIVE_OFF 0
> >>  #define BT_POWER_FORCE_ACTIVE_ON  1
> >>
> >> +#define BT_AMP_POLICY	10
> >> +
> >> +/* Require BR/EDR (default policy)
> >> + *   AMP controllers cannot be used.
> >> + *   Channel move requests from the remote device are denied.
> >> + *   If the L2CAP channel is currently using AMP, move the channel to BR/EDR.
> >> + */
> >> +#define BT_AMP_POLICY_REQUIRE_BR_EDR   0
> >
> > so lets brainstorm a little bit with the names here. Do we really wanna
> > use the term AMP_POLICY? Is it really AMP specific? Or do we better make
> > ourselves a bit more future proof?
> >
> > I am currently thinking a bit more generic. Maybe this is not the best
> > choice, but lets entertain this for a bit. So what about calling this
> > BT_CHANNEL_POLICY?
> >
> > And instead of REQUIRE_BR_EDR I would call it BREDR_ONLY.
> 
> It's no problem to fine-tune the names.
> 
> So, if BT_CHANNEL_POLICY is a good option name, how about these option 
> values:
> 
> BT_CHANNEL_POLICY_BREDR_ONLY
> BT_CHANNEL_POLICY_AMP_PREFERRED
> BT_CHANNEL_POLICY_BREDR_PREFERRED

lets resort the list as

BT_CHANNEL_POLICY_BREDR_ONLY
BT_CHANNEL_POLICY_BREDR_PREFERRED
BT_CHANNEL_POLICY_AMP_PREFERRED

and I would think we are good. However any other opinion on the naming
would be welcome here as well. I was just brainstorming here.

> >> +/* Prefer AMP
> >> + *   Allow use of AMP controllers
> >> + *   If the L2CAP channel is currently on BR/EDR and AMP controller
> >> + *     resources are available, initiate a channel move to AMP.
> >> + *   Channel move requests from the remote device are allowed.
> >> + *   If the L2CAP socket has not been connected yet, try to create
> >> + *     and configure the channel directly on an AMP controller rather
> >> + *     than BR/EDR.
> >> + */
> >> +#define BT_AMP_POLICY_PREFER_AMP       1
> >> +
> >> +/* Prefer BR/EDR
> >> + *   Allow use of AMP controllers.
> >> + *   If the L2CAP channel is currently on AMP, move it to BR/EDR.
> >> + *   Channel move requests from the remote device are allowed.
> >> + */
> >> +#define BT_AMP_POLICY_PREFER_BR_EDR    2
> >
> > We might also wanna look into the option of having a SCM message in the
> > socket that tells us the current type. Or at least tells us when we
> > successfully switched to AMP or back to BR/EDR. Since obviously we are
> > not blocking on the setsockopt call.
> >
> > Not sure if applications actually do care, but for OBEX it might be
> > interesting to know if you are on an AMP controller right now or not.
> 
> Yes, that would be a nice feature.  OBEX seems to work well even 
> without it, though.  The OBEX connection is made over BREDR, and the 
> socket option is changed after the OBEX connection is made but before 
> any gets or puts.  What you see in hcidump is that the move starts 
> before the first get or put goes out over BREDR - those OBEX packets 
> sit in the ERTM tx queue while the channel move happens.  When the 
> move completes, the transfer immediatly proceeds on the AMP 
> controller.

If it works for fine for you guys right now, then we could do that later
and don't have to worry right now. However before we make enable_hs on
by default I like to have this figured out.

Regards

Marcel


