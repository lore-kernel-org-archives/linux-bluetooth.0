Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <532f6c3c0512121336u36cae97av@mail.gmail.com>
From: Beware of the Hare <hujumuju@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MSDUN failed. Connection timed out(110)
In-Reply-To: <1134422155.429.16.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
	 <1134418604.429.9.camel@blade>
	 <532f6c3c0512121252r14ebe56bn@mail.gmail.com>
	 <1134422155.429.16.camel@blade>
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
Date: Mon, 12 Dec 2005 22:36:45 +0100

2005/12/12, Marcel Holtmann <marcel@holtmann.org>:

> the PDA sends AT commands and not the magic CLIENTSERVER string. So you
> may wanna try it without the --msdun switch.

Works without --msdun and with this magic at-cmd.pl script like a charm :) =
Thnx.
This was probably not server-side problem, but (terrible) bluetooth
stack upgrade on my pda.

Thnx one more time for a hint.

BTW. You said it shoudn't be nessesary to register DUN service with
'/usr/local/bin/sdptool add DUN' on every bluetooth start? Well, i
cannot connect without it, but it should be done with dund, right?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
