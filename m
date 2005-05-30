Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils-2.17 -- Error compiling dbus.o
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <e1effdeb0505300532fe36918@mail.gmail.com>
References: <12a241ad05052907591c593c6@mail.gmail.com>
	 <1117379509.7072.95.camel@pegasus>
	 <12a241ad050529081764ef7ed1@mail.gmail.com>
	 <e1effdeb0505300532fe36918@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117456782.7072.141.camel@pegasus>
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
Date: Mon, 30 May 2005 14:39:42 +0200

Hi Claudio,

> The DBUS is under development, the functions name/signatures changed.
> The bluez-utils 2.17 is compatible with D-Bus 0.23.
> 
> I recommend use the D-Bus version 0.23. Change hcid and bluez-pin
> to support D-Bus 0.33 will require a signicant effort due bugs in the 
> array iterator functions. I not sure if this problem was solved in the 
> CVS version.

I never tested it against D-Bus 0.33, but it should be fixed.

The bluez-pin is another story, but I am not responsible for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
