Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSDUN failed. Connection timed out(110)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <532f6c3c0512121336u36cae97av@mail.gmail.com>
References: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
	 <1134418604.429.9.camel@blade>
	 <532f6c3c0512121252r14ebe56bn@mail.gmail.com>
	 <1134422155.429.16.camel@blade>
	 <532f6c3c0512121336u36cae97av@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134423827.6919.2.camel@blade>
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
Date: Mon, 12 Dec 2005 22:43:47 +0100

Hi,

> > the PDA sends AT commands and not the magic CLIENTSERVER string. So you
> > may wanna try it without the --msdun switch.
> 
> Works without --msdun and with this magic at-cmd.pl script like a charm :) Thnx.
> This was probably not server-side problem, but (terrible) bluetooth
> stack upgrade on my pda.
> 
> Thnx one more time for a hint.

you are welcome.

> BTW. You said it shoudn't be nessesary to register DUN service with
> '/usr/local/bin/sdptool add DUN' on every bluetooth start? Well, i
> cannot connect without it, but it should be done with dund, right?

You don't need it, because dund is registering the record when it starts
up. However it might be buggy. Use "sdptool browse --raw local" to see
if there are any differences in the records. Make sure that you really
start the sdpd and dund from bluez-utils-2.23 and don't have an old copy
somewhere in /usr/bin or /usr/sbin.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
