Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Zoom 4312 PCMCIA Bluetooth freezes laptop
References: <opsj5ahvnzdfsa41@dfavro-3>
From: "David Favro" <dfavro@users.sourceforge.net>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Message-ID: <opsj5r1azldfsa41@dfavro-3>
In-Reply-To: <opsj5ahvnzdfsa41@dfavro-3>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 05 Jan 2005 21:04:12 -0500

On Wed, 05 Jan 2005 14:45:21 -0500, David Favro <dfavro@users.sourceforge.net> wrote:

> Hello --
>
> I recently acquired the Zoom model 4312 bluetooth PCMCIA adapter for my
> eMachines M5312 laptop running Fedora Core 2 (I want to use it for my
> bluetooth mouse).  The whole set-up works fine under Windows-XP, so
> apparently there is no hardware incompatibility, but it hangs the
> machine under Linux.
>
> Prior to the malfunction, everything seems to be OK with the exception
> of an error message when the PCMCIA card is initialized: "cs: warning:
> no high memory space available!" and "cs: unable to map card memory!"
> (full dmesg trace and much other system info included as an
> attachment).  The card seems to initialize and flashes its L.E.D.  I
> did no system configuration for the card beyond installing all of the
> bluez packages from the FC2 repositories.  I don't know how to resolve
> the memory-map problem or if it is relevant.
>
> The problem is that when I do "hciattach ttyS16 bcsp" (per
> http://sourceforge.net/mailarchive/message.php?msg_id=9958619), it
> stays up long enough to display the next shell prompt, and then the
> machine completely hangs.  The caps-lock L.E.D. starts _flashing_ (and
> continues to do so indefinitely -- strange, I don't know what that
> means) and the video display remains unchanged, but the machine is
> completely unresponsive to all input: the keyboard, the touch-pad and
> mouse-buttons, the connected ethernet interface... completely hung.
> Network-connected ssh's go dead, the machine will give no visible
> response to any keystrokes at all, the mouse-pointer will not move,
> etc.  The only way to get it restarted is to hold down the power button
> long enough that it turns off uncleanly.
>
> I'm no expert on PCMCIA nor Bluetooth, so I am clueless as to how to
> address this.  I don't know if this is the BT protocol driver or the
> PCMCIA config that is causing the problem, but it is hard to deal with
> due to the machine being so totally disabled.  I've retried many times
> and it is repeatable very consistently.  Should I try a PCMCIA mailing
> list?  Am I correct to do the hciattach command?  If I don't, the card
> seems not to be noticed by hciconfig (see attached logs).

[attachment stripped]

After about 30 trial-and-error power-off cycles, I found some patterns:

+ The memory-map error messages only occur when the reboot happens after
   the freeze + hard-power-off.  If the machine is then soft-power-cycled
   without attempting to hciattach, they do not occur on the next
   boot-up.

+ The freeze occurs when hciattach is attempted, whether or not the
   memory-map error messages occurred during boot-up.

+ When I tried booting an older FC2 kernel (2.6.8-1.521 rather than
   2.6.9-1.11_FC2), the card becomes ttyS5 rather than ttyS16, the freeze
   does not occur, and I am able to successfully run "hciattach ttyS5
   bcsp".

I still hope to find a fix for the newer kernel, but at least I have a
way to start experimenting with my new card.  Thanks to anyone who can
help me to understand what is happening.

David Favro
Meta-Dynamic Solutions, LLC
dfavro@users.sourceforge.net


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
