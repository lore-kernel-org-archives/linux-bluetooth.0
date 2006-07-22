Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607211502.24913.denis.kenzior@trolltech.com>
References: <200607181644.05026.denis.kenzior@trolltech.com>
	<1153220057.4639.17.camel@localhost>
	<200607211502.24913.denis.kenzior@trolltech.com>
Date: Sun, 23 Jul 2006 01:11:29 +0200
Message-Id: <1153609889.5050.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBUS API - Service Classes as ints?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> What you say makes sense, but I'd like to raise the same question about the 
> Remote device class.  Currently the RemoteDeviceFound and RemoteClassUpdated 
> signals use the numberic form of the device class.   However, 
> GetRemoteMajorClass, GetRemoteMinorClass and GetRemoteServiceClasses use the 
> string format.  Would it make sense to add the GetRemoteClass method which 
> would return the uint32 format as well?  Would certainly make some tasks 
> easier to program than having to rely on RemoteClassUpdated signal.

actually I left it out on purpose at the moment. It is easier to extend
the API than remove a method. Send in a patch and then get opinions from
other people. I am open for it.

> Another question, I noticed that Manufacturer, Company, Revision, Version 
> attributes are not discovered until an initial connection is made.  A user 
> might want to take extra steps to be presented with such information (e.g. 
> remote device properties dialog), and it would be nice if I could force the 
> DBUS API to get that information for me somehow, even if the device has not 
> been previously connected to.  Is there a solution? 

It is not as easy as you think and we didn't had the time to schedule
HCI commands to retrieve this information if they are missing. Feel free
to send in a patch.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
