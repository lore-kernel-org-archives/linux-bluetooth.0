Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075316178.553.18.camel@akka.yeti.nocrew.org>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075317841.553.22.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Jan 2004 20:24:02 +0100

ons 2004-01-28 klockan 19.56 skrev Fredrik Noring:
>    device 00:11:22:33:44:55
>    {
> 	# Device options for bdaddr 00:11:22:33:44:55...
>    }

Btw., a variation on the theme is to allow:

   device hci0
   {
	# Device options for interface hci0...
   }

I don't know which one is most useful or if both should be allowed.

Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
