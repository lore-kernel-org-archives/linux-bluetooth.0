Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 21 Jul 2006 15:02:24 +1000
References: <200607181644.05026.denis.kenzior@trolltech.com>
	<1153220057.4639.17.camel@localhost>
In-Reply-To: <1153220057.4639.17.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607211502.24913.denis.kenzior@trolltech.com>
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

Marcel,

What you say makes sense, but I'd like to raise the same question about the 
Remote device class.  Currently the RemoteDeviceFound and RemoteClassUpdated 
signals use the numberic form of the device class.   However, 
GetRemoteMajorClass, GetRemoteMinorClass and GetRemoteServiceClasses use the 
string format.  Would it make sense to add the GetRemoteClass method which 
would return the uint32 format as well?  Would certainly make some tasks 
easier to program than having to rely on RemoteClassUpdated signal.

Another question, I noticed that Manufacturer, Company, Revision, Version 
attributes are not discovered until an initial connection is made.  A user 
might want to take extra steps to be presented with such information (e.g. 
remote device properties dialog), and it would be nice if I could force the 
DBUS API to get that information for me somehow, even if the device has not 
been previously connected to.  Is there a solution? 

-Denis

On Tuesday 18 July 2006 20:54, Marcel Holtmann wrote:
> the choice for strings has been made to make it easier for languages
> like Python etc. to handle this. Another thing is that we only support
> the change of the minor class if the major class is "computer". No other
> change through the D-Bus API makes really sense.
>
> If another major class has to be supported, then this has to be set in
> hcid.conf and it will disable the ListAvailableMinorClasses() and
> SetMinorClass() methods. This will be true for all embedded devices
> running BlueZ. They will set the major and minor class through hcid.conf
> and then no more changes to it are needed. The only exception at the
> moment will be an access point where the minor class indicates the
> number of connected clients. However this should also not be changed
> through the D-Bus API. We will integrate another method for this once we
> started working on the access point daemon.
>
> The service classes are need to be under control of sdpd, because they
> depend on the registered services. So a generic method to change the
> class of device is not a good idea.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your opinions on IT & business topics through brief surveys -- and earn
> cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
