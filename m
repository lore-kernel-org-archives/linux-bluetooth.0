Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Creating a new SDP service
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Eiser <alexe@mac.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <D303E807-5443-11D8-9C26-000A959C67D2@mac.com>
References: <D303E807-5443-11D8-9C26-000A959C67D2@mac.com>
Content-Type: text/plain
Message-Id: <1075591715.2720.91.camel@pegasus>
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
Date: Sun, 01 Feb 2004 00:28:35 +0100

Hi Alex,

> I need to create a custom SDP service to perform some communications 
> between a Mac OS X machine and a linux machine. While I could 
> accomplish this by using serial ports, this makes the macos programing 
> a lot uglier.
> 
> Is there a way to create a new service with the SDP tool, with out 
> adding new code to sdptool.c?

No, you have to write your own code. But this code must not be in
sdptool. Look at pand for an example.

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
