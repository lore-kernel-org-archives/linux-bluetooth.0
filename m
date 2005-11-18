Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
Message-ID: <20051118082828.GA16438@localhost.localdomain>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com> <1131119054.11673.1.camel@localhost.localdomain> <e1effdeb0511081241w20503576id78ab38764b8b96b@mail.gmail.com> <20051108222033.GA12368@localhost.localdomain> <1131489534.5544.20.camel@blade> <3013cac80511171116n33c7faech6006e7264821fb16@mail.gmail.com> <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3013cac80511171252g4a4f1581l915e364a244ec8ea@mail.gmail.com>
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
Date: Fri, 18 Nov 2005 10:28:28 +0200

Hi Eduardo,

Your patch looks ok in general, however there are a couple of issues I'd
like to comment on:

1. The string given to the syslog call in the "if (status)" part of the
handle_device_set_propety_req_name function is wrong (just a simple
copy-paste mistake).

2. The list assigned to the dev_cmds variable in the dbus-test app could
be reformated to be max 80 chars wide.

3. There are several places in dbus-test where the indentation is wrong:
some places there are extra spaces, others have too few. You have also
mixed tabs and spaces in a couple of places (the indentation should, at
least for now, use 4 spaces).

4. You don't need to use dbus.String(var) when giving a string variable
to a method call using the python bindings.

5. We should think of how to allow giving different types (bool, byte,
string) to the SetProperty method using dbus-test. One way to do it
would be to give four parameters in the command line (e.g. "SetProperty
connectable b true" or "SetProperty name s MyName"). Another option is
to change to the HAL way of doing properties (by having
SetPropertyString, SetPropertyBoolean, etc).

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
