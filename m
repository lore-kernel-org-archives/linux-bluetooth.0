Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061019115608.GB31910@suse.de>
References: <20061019115608.GB31910@suse.de>
Date: Thu, 19 Oct 2006 14:04:29 +0200
Message-Id: <1161259469.27710.40.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DiscoverDevices with apitest?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Stefan,

> i tried today to discover devices with apitest (instead of "hcitool scan"),
> but it did not work:
> 
> seife@strolchi:~> apitest DiscoverDevices
> None
> 
> and it returns immediately. So i tried my luck with direct "dbus-send":
> seife@strolchi:~> dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0 org.bluez.Adapter.DiscoverDevices
> method return sender=:1.541 -> dest=:1.867
> 
> No luck either.
> I always get this in my syslog from hcid:
> Oct 19 13:52:39 strolchi hcid[17330]: Introspect path:/org/bluez
> Oct 19 13:52:39 strolchi hcid[17330]: Introspect path:/org/bluez/hci0
> Oct 19 13:52:39 strolchi hcid[17330]: name_listener_add(:1.869)
> Oct 19 13:52:39 strolchi hcid[17330]: DiscoverDevices requestor at :1.869 exited before the operation finished
> Oct 19 13:52:39 strolchi hcid[17330]: name_listener_remove(:1.869)
> Oct 19 13:52:39 strolchi hcid[17330]: remove_name_listener: no listener for :1.869
> 
> So why doesn't the dbus call block? I also tried with a "apitest -l"
> running in parallel, to see if this would get something discovered, but it
> didn't:
> seife@strolchi:~> apitest -l
> Listening for events...
> DiscoveryStarted - /org/bluez/hci0:
> DiscoveryCompleted - /org/bluez/hci0:
> DiscoveryStarted - /org/bluez/hci0:
> DiscoveryCompleted - /org/bluez/hci0:
> Caught signal, exiting

You need to keep the calling application running, because otherwise hcid
will stop the discovery. That is actually what you see in syslog.

It is not blocking, because this is simply not a blocking task. You
might wanna have a look at this blog on how to do it with Python:

http://blogs.gnome.org/view/jamesh/2006/10/19/0

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
