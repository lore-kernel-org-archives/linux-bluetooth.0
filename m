Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607181644.05026.denis.kenzior@trolltech.com>
References: <200607181644.05026.denis.kenzior@trolltech.com>
Date: Tue, 18 Jul 2006 12:54:17 +0200
Message-Id: <1153220057.4639.17.camel@localhost>
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

> Is it a good idea/Are there any plans to extend the current DBUS API to enable 
> Major/Minor/Service classes of the local Adapter to be available/settable in 
> integer form? The string representations are nice and user-friendly, however 
> we need to maintain internationalized versions of these, so doing conversion 
> ourselves is much easier.  
> 
> This would also solve the problem of combination minor device numbers (e.g. in 
> case of peripherals).  How would you set "Pointing device" + "Joystick" via 
> the current API?  It would also bring the API closer in line with the 
> RemoteDevice API which uses uint32 to represent the class.
> 
> Perhaps SetClass(uint32) and 
> uint32 GetClass()?
> 
> If this is wanted, I can work on a patch.

the choice for strings has been made to make it easier for languages
like Python etc. to handle this. Another thing is that we only support
the change of the minor class if the major class is "computer". No other
change through the D-Bus API makes really sense.

If another major class has to be supported, then this has to be set in
hcid.conf and it will disable the ListAvailableMinorClasses() and
SetMinorClass() methods. This will be true for all embedded devices
running BlueZ. They will set the major and minor class through hcid.conf
and then no more changes to it are needed. The only exception at the
moment will be an access point where the minor class indicates the
number of connected clients. However this should also not be changed
through the D-Bus API. We will integrate another method for this once we
started working on the access point daemon.

The service classes are need to be under control of sdpd, because they
depend on the registered services. So a generic method to change the
class of device is not a good idea.

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
