Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] headset$
Message-ID: <20040701094518.GB4505@gmx.net>
References: <amsbr1-glo.ln1@ID-90813.users.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <amsbr1-glo.ln1@ID-90813.users.dfncis.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 1 Jul 2004 11:45:18 +0200

On  0, Steffen Schwientek <schwientek@web.de> wrote:
> I want to use my plantronics M9000 headset. Since it?s my only bluetooth
> part, I can?t figure out, if bluetooth works. Connecting the USB dongle,
> the kernel (2.6.6) reports:

Better use 2.6.7 or apply the latest -mh patch to 2.6.6. 

> An hcitool scan detects (if I put the headset in pairing mode)
> 00:03:89:46:E2:0F       M3000 by Plantronics
> 
> So nice, so far. Unfortunately I don?t know what I need next (I tried the
> kbluetooth daemon, but this doesn?t detect the headset at all, or failed
> due to an timeout.

Did you pair Headset and Computer? Normally you have to switch the
headset in pairing mode (-> Manual) and then insert the pin on the
computer. (you can also specifiy pin in a file?) This should happen
transparently, when  a program tries to connect to a remote device and
their was no pairing before, then it tries to get the Pin from pinhelper
application or from file. 

> Next I try an hcitool cc, but nothing happens. kdebluetooth shows me an
> connection, but after a while it reports an error (0x22).
> /var/log/messages shows no error.
 
Try the syslog file, if your distribution offers one. hcitool cc is not
recommend for users, it is more a development and debugging feature.

nicholas


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
