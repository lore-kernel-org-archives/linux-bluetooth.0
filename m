Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zoom 4312 PCMCIA Bluetooth freezes laptop
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <opsj5r1azldfsa41@dfavro-3>
References: <opsj5ahvnzdfsa41@dfavro-3>  <opsj5r1azldfsa41@dfavro-3>
Content-Type: text/plain
Message-Id: <1105005023.32055.19.camel@kabel>
Mime-Version: 1.0
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
Date: Thu, 06 Jan 2005 10:50:23 +0100

On Thu, 2005-01-06 at 03:04, David Favro wrote:
> > I'm no expert on PCMCIA nor Bluetooth, so I am clueless as to how to
> > address this.  I don't know if this is the BT protocol driver or the
> > PCMCIA config that is causing the problem, but it is hard to deal with
> > due to the machine being so totally disabled.  I've retried many times
> > and it is repeatable very consistently.  Should I try a PCMCIA mailing
> > list?  Am I correct to do the hciattach command?  If I don't, the card
> > seems not to be noticed by hciconfig (see attached logs).

It seems to me that you have a problem with pcmcia and serial+serial_cs.
You should first figure out if the same problem appears with serial_cs
only (without any bluetooth module, and without using hciattach). Try to
send some data (like "echo XX > /dev/ttySxx") to see if the lockup
occurs already here (IRQ problem?).

Regards,
Erwin




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
