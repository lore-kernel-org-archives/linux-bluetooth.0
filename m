Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm confusion
From: Marcel Holtmann <marcel@holtmann.org>
To: Ken <a5a33956@telus.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40AB4D9F.7010307@telus.net>
References: <40AB4D9F.7010307@telus.net>
Content-Type: text/plain
Message-Id: <1084969555.4327.60.camel@pegasus>
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
Date: Wed, 19 May 2004 14:25:55 +0200

Hi Ken,

> I am trying to create a bluetooth serial connection between my linux 
> laptop and iPAQ pda.

is this a Windows or a Linux based iPAQ?

> I'm using the command "rfcomm connect hci0 00:11:22:33 1" and it appears 
> to work.

The <dev> is not the HCI device. It is the RFCOMM device you wanna
create. So use "rfcomm0" or "0" for short.

> the connection shows up on the iPAQ and when I go to the status it 
> displays 0 bytes transfered - 0 bytes received.

Where do you see this?

> so, now i'm trying to send some data over this connection. my 
> expectation was that i could do something like:
> echo "test" > /dev/rfcomm0
> and then see 4 bytes received on the iPAQ interface, however the byte 
> counts on the ipaq remain 0.

Actually this depends on the program on the other side. If it is a
Windows iPAQ I don't know how they count the bytes.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
