Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
	 <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
	 <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1132949177.10237.5.camel@blade>
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
Date: Fri, 25 Nov 2005 21:06:17 +0100

Hi Claudio,

> I think we are confusing some D-Bus concepts.
> 
> Currently, hcid is connected to the "system" bus, because the
> Bluetooth adapter is a shared resource and it can be used by any
> logged-in user or remote users. As long as I known the "system bus"
> should be used for notification from the system to user sessions(it's
> accessible to all applications on the system). The "session bus"
> should be used to implement desktop environments communication. The
> address of the per-session bus daemon is automatically discovered by
> reading an environment variable. A login session message bus is
> started each time a user logs in.

this is my understanding, too.

> If we choose use the session bus, probably it will required huge code
> modification in order to support multiple bus session connection or
> start a new BlueZ D-Bus daemon for each user session. In my opinion,
> this approach is not feasible.

This will simply not work, because there can be only one daemon at a
time and it must run all the time.

> If you want provide BlueZ D-Bus services only for the logged-in user,
> we can try analise the modifications required to control the D-Bus
> connections and its drawbacks.

The D-Bus services are available in general, but I wanna restrict the
methods that are actually modifying settings to the root user and/or the
currently logged in user. The hal.conf uses "<policy at_console="true">"
to provide this (if I am not mistaken).

Remember that we are talking about the default configuration. We don't
need to provide the best security model, but at least a decent one. For
me this means that the root user and the currently logged in user have
full control over the device. All other users are restricted.

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
