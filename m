Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: RE : [Bluez-users] SuSE and Audio
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Stadelmann <jerome.stadelmann@hta-bi.bfh.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <007401c3e99b$5947db70$2d105793@N64101>
References: <007401c3e99b$5947db70$2d105793@N64101>
Content-Type: text/plain
Message-Id: <1075734800.29899.58.camel@pegasus>
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
Date: Mon, 02 Feb 2004 16:13:20 +0100

Hi Jerome,

> I just install the new 2.6.21 kernel and updated it with your patch (mh3 I
> think) but the problem is the same.

what kernel are you talking about 2.4.21 or 2.6.1? For the 2.4.21 you
need at least -mh4.

> I can establish a contact with hsplay or hstest and I can hear some noise in
> the headset, but nothing like the mp3 file I am sending to it.

What does "hciconfig hci0 revision" say? You need a SCO over HCI mapping
and I never tested this stuff on a 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
