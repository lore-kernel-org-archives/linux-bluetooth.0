Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcast and reassembly
From: Marcel Holtmann <marcel@holtmann.org>
To: Thor Egil Skaug <paxtonrd@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000101c402dd$9f3316d0$9349edc7@thores>
References: <000101c402dd$9f3316d0$9349edc7@thores>
Content-Type: text/plain
Message-Id: <1078526281.19852.48.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 05 Mar 2004 23:38:02 +0100

Hi Thor,

> I am experiencing some problems when reassembling active broadcast
> messages when the
> (hci) num_broadcast_retransmissions is set > 0 (at the sender), and with
> a decent L2CAP message size,
> > 100 bytes.
> 
> I constantly get start_fragments and continuing_fragments that are out
> of order, and since
> the l2cap header is the only way I can know when I am done reading one
> message and can expect
> another, this is troublesome. I thought the device was supposed to
> deliver messages in order?
> 
> Has anyone ever implemented this, and hopefully had the same
> experiences?

I never worked with any kind of broadcast and Bluetooth. Some people
tried this before, but nobody came up with a patch or something else.
This can be your job ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
