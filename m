Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Oct 2011 11:00:30 +0300
From: 'Andrei Emeltchenko' <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez 0/2] Add BT 3.0+HS signalling definitions
Message-ID: <20111027080028.GB27602@aemeltch-MOBL1>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
 <20111026073641.GA11385@aemeltch-MOBL1>
 <000001cc9406$f707f430$e517dc90$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001cc9406$f707f430$e517dc90$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Oct 26, 2011 at 10:44:51AM -0700, Peter Krystad wrote:
> Hi Andrei,
>  
> > Patches looks OK (taking that typedef is a standard way in bluez).
> > 
> > The only note: I think that we need to differentiate AMP and A2MP. When we
> > are dealing with A2MP protocol we could name structures / functions as
> > a2mp_*
> 
> I tried to follow the convention of the spec, which uses A2MP only when
> referring to the protocol as a whole and when referring to the feature mask
> and the fixed channel. It uses AMP or 'AMP Protocol' in all other places,
> including individual protocol elements.
> 
> Consider this, and if you still think it should be a2mp_ I'll do it.

I think we can do a little brainstorming here :-)

My idea is to use name A2MP when we are talking about 
"AMP Manager Protocol" and use AMP when we are dealing with
"Alternate MAC PHY" controller.

BTW: in your kernel repository you use correct names
https://www.codeaurora.org/gitweb/quic/la/?p=kernel/msm.git;a=blob;f=include/net/bluetooth/amp.h;h=4b080791ffc74ad17fd504583f7949cd4df1fa82;hb=refs/heads/msm-3.0
...
/* A2MP command codes */
#define A2MP_COMMAND_REJ         0x01
#define A2MP_DISCOVER_REQ        0x02
#define A2MP_DISCOVER_RSP        0x03
...

in your patch "[PATCH bluez 2/2] Add A2MP definitions" you use AMP instead
of A2MP.

Best regards 
Andrei Emeltchenko 
