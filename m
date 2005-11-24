Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com>
	 <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
	 <20051118082828.GA16438@localhost.localdomain>
	 <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1132872886.3170.3.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Nov 2005 23:54:46 +0100

Hi Eduardo,

> maybe we should create a bluetooth group and only allow users of that
> group to make write operations. I'll also check eht dbus auth to see
> if that can help. Do you have in mind any operation->"security level"
> map?

come up with some proposals. I have real clue, but we should have some
special rights for the current session user.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
