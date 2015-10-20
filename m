Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2015 16:10:55 +0200
From: Martin Pitt <martin.pitt@ubuntu.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] systemd: Check if bluetooth is supported in the kernel
Message-ID: <20151020141055.GA2657@piware.de>
References: <1445336685-20506-1-git-send-email-martin.pitt@ubuntu.com>
 <3C809C59-9F50-40AC-B55D-C5456B333183@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C809C59-9F50-40AC-B55D-C5456B333183@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

Marcel Holtmann [2015-10-20 15:19 +0200]:
> > +ConditionPathIsDirectory=/sys/class/bluetooth
> 
> and this is not a race condition? I mean that directory might be not
> present because the module has not yet been loaded. So strictly
> speaking the kernel has been compiled with Bluetooth support, but it
> has not been yet loaded. Are we not exchanged one issue for another?

If it's started automatically by a package or during boot and
bluetooth.service is started before the module loaded, won't it
currently fail anyway? With the condition it just won't be attempted
to start.

Remember though that this isn't the normal mode of operation --
normally bluetooth.target gets activated through udev if/when BT
hardware actually becomes available:

  /lib/udev/rules.d/99-systemd.rules:SUBSYSTEM=="bluetooth", TAG+="systemd", ENV{SYSTEMD_WANTS}+="bluetooth.target"

and bluetooth.service hooks into that in its [Install]. This is race
free as only the completion of the module load and the appearance of
/sys/class/bluetooth triggers the above rule. (For that case it seems
systemd (re-)starts an already failed bluetooth.service as well.)

So in summary, this is a little cleanup, doesn't affect the main
"dynamic via udev" case, but unclutters startup requests which aren't
triggered by hardware.

Thanks,

Martin

-- 
Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)
