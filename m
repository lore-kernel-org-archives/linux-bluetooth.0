Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A small query
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050505122914.45406.qmail@web8303.mail.in.yahoo.com>
References: <20050505122914.45406.qmail@web8303.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1115298786.8496.153.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 05 May 2005 15:13:06 +0200

Hi Mayank,

> > > I mean, there is something wrong in the hcidump.
> > It
> > > considers the commands as 'Cont' command and this
> > is
> > > when the source sends me a disconnect without
> > > hesitation.
> > > What I want to say is that if I declare
> > packet_type
> > > after message_type, then both the source's and
> > sink's
> > > dump are ok.
> 
> I did not mean that hcidump is not functioning
> correctly, I meant that maybe we have not declared the
> structure correctly.

don't put too much trust on hcidump. It must not always be right and I
had some situations where I trusted it too much.

> Swapping message_type and packet_type makes no
> difference to a2play but it makes a lot of difference
> to a2recv.

Why can this be? Doesn't a2play uses message_type and packet_type at
all?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
