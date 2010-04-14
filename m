Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 14 Apr 2010 12:49:11 -0700
Subject: RE: detecting dead link
Message-ID: <35B17FE5076C7040809188FBE7913F983A1E128B32@SC1EXMB-MBCL.global.atheros.com>
References: <k2i2d5a2c101004140110s5834b2e6u86290c6466baa723@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128A57@SC1EXMB-MBCL.global.atheros.com>
 <y2q2d5a2c101004141229gaf2dbac4u89e4e627004ddd95@mail.gmail.com>
In-Reply-To: <y2q2d5a2c101004141229gaf2dbac4u89e4e627004ddd95@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Wednesday, April 14, 2010 12:30 PM
To: Mike Tsai
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: detecting dead link

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

>> I agree that 30 second LMP timeout is really too long, however it was defined in the spec. and is not changeable unless we go through errata process and get everyone in the Bluetooth CSWG to agree with it.

>> There is another way to shorten the timeout which is to change the link supervision timeout to less than that, for instance, 2 seconds. But based on the log, it would seem to me that the link supervision timeout was not detected prior to LMP timeout (because disconnect event didn't come at 20 seconds).

> I think the host was sending the commands out of order. It asks controller to set up SCO link before it asks controller to exit sniff mode. Note that both commands are async commands (meaning it will request controller to go through several state transition for those commands), so the controller might have hard time executing the host commands.

I guess it doesn't matter the order, as long as it detects the link
loss faster, things like PulseAudio cannot afford 30 sec of the stream
lost because the controller has lost the link, if the headset has been
moved away or shutdown in the middle of the playback we want to route
it back to the speaker as soon as possible.

>> Here I am just stating the fact that multiple async commands from host can cause difficulty on the controller side because there is only 1 physical link available and the media needs to be shared. I guess it matters if we want less frustration from end user and better connection quality. This is a common practice from many popular Bluetooth host stacks. I think that we won't loss the link if host does the command order as suggested. Because shorten the link disconnection timeout will just let user realize that the link establishment failed sooner, does not change the fact that it is still a failure and user can't get what they want,

-- 
Luiz Augusto von Dentz
Computer Engineer
