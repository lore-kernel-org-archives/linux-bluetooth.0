Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MX900 page updated
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040624205328.47bf51ee@bluez.bueche.ch>
References: <20040624205328.47bf51ee@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1088107922.4296.135.camel@pegasus>
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
Date: Thu, 24 Jun 2004 22:12:02 +0200

Hi Charles,

> now that gentoo has a 2.6.7 kernel, I have tried Marcel's mh patch with
> success, and I have updated my page about my setup :

aren't there any Gentoo packages for bluez-libs and bluez-utils?

> I'm not sure wheter I still need the uinput module since I switched to
> hidd. I remember Marcel saying uinput is not needed with hidd. So who
> sends events to /dev/input/mice ? hidd directly ?

You don't need uinput anymore. The HIDP Module will do this all by
itself. On my presentation at LinuxTag tomorrow I am going to show how
this all works. I created some nice new graphics ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
