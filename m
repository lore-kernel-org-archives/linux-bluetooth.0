Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050508124400.70168.qmail@web8302.mail.in.yahoo.com>
From: Mayank Batra <mayankbatra@yahoo.co.in>
Subject: Re: [Bluez-devel] A small query
To: bluez-devel@lists.sourceforge.net
In-Reply-To: 6667
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
Date: Sun, 8 May 2005 13:44:00 +0100 (BST)

Marcel,


> > Swapping message_type and packet_type makes no
> > difference to a2play but it makes a lot of
> difference
> > to a2recv.
> 
> Why can this be? Doesn't a2play uses message_type
> and packet_type at
> all?
> 


This is because a2play sends commands and not replies.
In commands the message_type is always 0 and
packet_type is also 0, thus it makes no difference
whether packet_type is before or after message_type.

But, in a2recv we have to send replies, and this is
when the trouble comes up. In replies, message_type is
whether the message was acceped or denied. But
packet_type is again 0. So here message_type is not
always 0. Thus interchanging them WILL create a mess
up.

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
