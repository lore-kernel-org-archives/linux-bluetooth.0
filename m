Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Question regarding sdptool
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43463752.7000802@ruault.com>
References: <43463752.7000802@ruault.com>
Content-Type: text/plain
Message-Id: <1128677887.8750.18.camel@localhost.localdomain>
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
Date: Fri, 07 Oct 2005 11:38:06 +0200

Hi Charles,

> i'm developping a Midlet using JSR82 on a Nokia 6680.
> The midlet is running as a server and therefore registers a service in
> the device SDP.
> I had been desperately trying to see if everything was going ok on the
> device using sdptool browse add and i was not seeing my service ...
> I was getting kind of desperate since everything was looking fine in my
> code when i tried using
> sdptool records btaddr and there i saw my service listed !
> Can someone explain the difference between the browse & records options
> of sdptool ?

the browse command looks for records in the public browse group and the
records command brute forces the record handles 0x10000 onwards.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
