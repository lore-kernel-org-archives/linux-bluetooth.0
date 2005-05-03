Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050503132345.24700.qmail@web8302.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] A2DP sink code finally
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050501171637.412450f8.henryk@ploetzli.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Tue, 3 May 2005 14:23:45 +0100 (BST)

Henryk,

> Ah, stupid me. I forgot to enable pairing mode on
> the audio dongle.

Never mind. better late than never.

> > > Is there anything else I've got to do apart from
> 
> > > | hciconfig hci0 class 0x200404
> > 
> > Don't know whether this is required...?
> 
> Seems so. After doing
> 
> > > | sdptool add A2SNK
> > > | ./a2snk
> 
> _and_ enabling pairing on the audio dongle nothing
> happened. But as soon
> as I changed my device class the audio dongle
> started a connection. Now
> a2snk stalls after "Sent Stream End Point Discovery
> Response".


I suggest you scan the hcidump and see whether  avdtp
commands are being exchanged properly. This was the
problem i faced while coding the a2recv. Please refer
to my query mail in which i raised the question of
exchanging the position of packet_type and
message_type.

I interchanged them and it started working.

If i don't, then the sink sends a cont command which
the source rejects and sends a disconnection.

Also, do send me a copy of the dump.

Regards,

Mayank

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
