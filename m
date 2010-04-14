Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983A1E128A57@SC1EXMB-MBCL.global.atheros.com>
References: <k2i2d5a2c101004140110s5834b2e6u86290c6466baa723@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128A57@SC1EXMB-MBCL.global.atheros.com>
Date: Wed, 14 Apr 2010 22:29:47 +0300
Message-ID: <y2q2d5a2c101004141229gaf2dbac4u89e4e627004ddd95@mail.gmail.com>
Subject: Re: detecting dead link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 14, 2010 at 7:31 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
> Hi Luiz,
> [MT] Page timeout is for creating ACL data link. In this case, ACL link is already created so page timeout is not involved. The 20 second timeout is the default link supervision timeout and the 35 second timeout is the LMP timeout (actually 30 seconds). I think if you have the sniff log for the LMP, it would appear that one of the LMP might be lost during SCO negotiation and it is quite possibly due to the existing sniff mode. A proper implementation of host stack shall probably exit sniff mode first before start the SCO link creation. So the log would look like this,
>
>        HCI command: Exit Sniff Mode
>        HCI event:   Command status, Exit Sniff Mode
>        HCI event:   Mode changed
>        HCI command: Setup Synchronous Connection

That exactly what Im arguing about, we have a 30 sec LMP timeout
compared to 5 sec of page timeout , if we are not willing to wait more
than 5 sec for a new ACL link why would we wait 30 sec? This is
completely disproportional and we should probably need to respond way
before that thus my suggestion to derive the LMP timeout for the page
timeout. This not only affect SCO connection but any attempt to
transfer data in the middle of the link loss.

> I think the host was sending the commands out of order. It asks controller to set up SCO link before it asks controller to exit sniff mode. Note that both commands are async commands (meaning it will request controller to go through several state transition for those commands), so the controller might have hard time executing the host commands.

I guess it doesn't matter the order, as long as it detects the link
loss faster, things like PulseAudio cannot afford 30 sec of the stream
lost because the controller has lost the link, if the headset has been
moved away or shutdown in the middle of the playback we want to route
it back to the speaker as soon as possible.

-- 
Luiz Augusto von Dentz
Computer Engineer
