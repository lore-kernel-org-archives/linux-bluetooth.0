Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A small query
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050503130909.22723.qmail@web8302.mail.in.yahoo.com>
References: <20050503130909.22723.qmail@web8302.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1115134715.8206.29.camel@notepaq>
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
Date: Tue, 03 May 2005 17:38:35 +0200

Hi Mayank,

> Does it matter whether I declare packet_type before or
> after message_type. I am not sure, but if I declare it
> before somehow, the hcidump on the a2recv side is not
> correct. 
> I mean, there is something wrong in the hcidump. It
> considers the commands as 'Cont' command and this is
> when the source sends me a disconnect without
> hesitation.
> What I want to say is that if I declare packet_type
> after message_type, then both the source's and sink's
> dump are ok.

I can't follow it right now, but you should not trust hcidump per se. It
can happen that the AVDTP decoding is wrong. Especially because it uses
two L2CAP connections on the same PSM and to assigning signal and media
channel is not an easy task for a decoder.

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
