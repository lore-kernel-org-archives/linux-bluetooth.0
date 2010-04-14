Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983A1E128B32@SC1EXMB-MBCL.global.atheros.com>
References: <k2i2d5a2c101004140110s5834b2e6u86290c6466baa723@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128A57@SC1EXMB-MBCL.global.atheros.com>
	 <y2q2d5a2c101004141229gaf2dbac4u89e4e627004ddd95@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128B32@SC1EXMB-MBCL.global.atheros.com>
Date: Wed, 14 Apr 2010 23:34:26 +0300
Message-ID: <z2k2d5a2c101004141334kc91838fatc9bcce8d81e38740@mail.gmail.com>
Subject: Re: detecting dead link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 14, 2010 at 10:49 PM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
>>> I agree that 30 second LMP timeout is really too long, however it was defined in the spec. and is not changeable unless we go through errata process and get everyone in the Bluetooth CSWG to agree with it.
>
>>> There is another way to shorten the timeout which is to change the link supervision timeout to less than that, for instance, 2 seconds. But based on the log, it would seem to me that the link supervision timeout was not detected prior to LMP timeout (because disconnect event didn't come at 20 seconds).

Im not saying we have to change the LMP timeout, that is bellow hci
layer which I guess we have no control in BlueZ, obviously you are
misunderstanding me, there is no need to change the LMP timeout
whatsoever it is just that we don't need to wait for it.

> I guess it doesn't matter the order, as long as it detects the link
> loss faster, things like PulseAudio cannot afford 30 sec of the stream
> lost because the controller has lost the link, if the headset has been
> moved away or shutdown in the middle of the playback we want to route
> it back to the speaker as soon as possible.
>
>>> Here I am just stating the fact that multiple async commands from host can cause difficulty on the controller side because there is only 1 physical link available and the media needs to be shared. I guess it matters if we want less frustration from end user and better connection quality. This is a common practice from many popular Bluetooth host stacks. I think that we won't loss the link if host does the command order as suggested. Because shorten the link disconnection timeout will just let user realize that the link establishment failed sooner, does not change the fact that it is still a failure and user can't get what they want,

Sorry, again I guess you are misunderstanding me, the link is _lost_,
the device has being moved away or has been shutdown so I guess it
pretty impossible to give anything else but disconnect to the user, or
there is any way to maintain a link to an unreachable device?

Btw, the trace I gave here was from a carkit which when turned off
doesn't send any hci disconnect.

-- 
Luiz Augusto von Dentz
Computer Engineer
