Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
Message-ID: <20051118112611.GA17062@localhost.localdomain>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com> <1131119054.11673.1.camel@localhost.localdomain> <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com> <20051108222033.GA12368@localhost.localdomain> <1131489534.5544.20.camel@blade> <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com> <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com> <20051118082828.GA16438@localhost.localdomain> <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3013cac80511180251w1d2fa8f5s80ce1da7318327e7@mail.gmail.com>
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
Date: Fri, 18 Nov 2005 13:26:11 +0200

On Fri, Nov 18, 2005, Eduardo Rocha wrote:
> Could you give any comments about the hci_send_req timeout (maybe is
> too high)

I'd guess that the command should take max. 100ms, so 2s timeout is
probably unnecessarely big. However, Marcel might have had a good reason
to use the current timeout in hciconfig.

> and the extended inquire parameters that is set cmd_name function in
> hciconfig app (is that needed here?).

If it's not there, then we should at least provide a D-BUS method to set
the extended inquiry parameters (which is probably a good thing as the
user might want to have other informantion there besides the name, e.g.
SDP UUID list).

> About the parameters, I've done an if to detect each property name so
> we can treat  the parameter diferently.

Yeah, you're right, that works also. However, I was thinking of
solutions where dbus-send wouldn't need to know the property name -
property type mapping.

Johan


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
