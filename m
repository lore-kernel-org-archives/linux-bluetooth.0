Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Epox BT-MS02B Bluetooth HID mouse, authorization	and encryption?
Message-ID: <20040918172056.GA367853@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
References: <20040917202651.GA485579@kosh.hut.fi> <1095456519.5973.15.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095456519.5973.15.camel@pegasus>
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
Date: Sat, 18 Sep 2004 20:20:56 +0300

On Fri, Sep 17, 2004 at 11:28:39PM +0200, Marcel Holtmann wrote:
> > I got it working, but few things (3) I'd need to find out still. hidd
> > program seems to be so new, there is no yet any documentation with it.
> > Maybe later there will FAQ for Linux HID.
> 
> the hidd manpage is still missing. May you wanna write it for me?

Maybe when/if I'll understand this BT stuff fully. I've sometimes tried
to draw a ISO/OSI preference model presentation of Bluetooth stack, but
it is messy, I think, this far at least. 

> Don't set auth and encrypt in hcid.conf. This puts your device in
> security mode 3 and you don't wanna do this. So mailing list archive for
> more details.

Actually I was pretty happy to keep my device (BT dongle) in security
mode 3 this far, before starting to use this HID mouse. Now when I had to turn
authorization and encryption off, anyone could download one of ogg/mp3
files from my computer with Bemused, not that I wouldn't share, and also
write to my home directory through gnome-obex-server (Cool .bashrc anyone?)

> This is a problem of the OBEX-server. Ask the author to implement proper
> support for it.

And Bemused, and ... quite many BT applications rely just on the lower lever
security, althoug it is known to be vulnerable.

> See above and read the Bluetooth specification to understand the
> differences between device and service security.

Ok, have to do that. Any good URI which would explain it like "for
Dummies"?
I just wonder, if service security will work with
mobile phones then. I mean, is it possible to make obex-server such that
mobile phone's OBEX software when sending some object understands the
server needs additional password. Or maybe it works like obex-server
would ask the lower HCI level to authenticate and encrypt after the
initial connection. Well, have to study that.

> You only have to press a mouse button and what for the reconnect of the
> mouse. To make this working you need to start hidd --server as root at
> boot time.

Yep, that worked and works now. (Just have to keep that security level
down)

// jouni



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
