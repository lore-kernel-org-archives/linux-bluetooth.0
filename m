Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061126143026.GA17505@163.com>
References: <20061126143026.GA17505@163.com>
Date: Sun, 26 Nov 2006 18:33:31 +0100
Message-Id: <1164562411.25914.40.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Cross Compile bluez-utils failed on
	dbus	dependency !
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

Hi,

> I'm cross compiling bluez-utils-3.7 to arm platform. The cross 
> compiler I  use is arm-linux-gcc-3.4, and I have already cross 
> compiled bluez-libs successfully! When run 
> 
> 	CC=arm-linux-gcc ./configure --host=i386-linux --target=arm-linux 
> 
> I got the following error:
> 
> 	checking for DBUS... configure: error: dbus > 0.35 is required
> 
> As I can imagine, this is because bluez-utils depends on dbus, which 
> doesn't exist on my target platform, and nor does I like to build the
> dbus system on my target platform. 
> 
> Is there a way to avoid this?
> 
> I want to download some older releases of bluez to avoid the dbus
> stuff, but I can't find any link on the bluez homepage. Does anyone
> has a clue ?

you can go with bluez-utils-2.x to avoid the D-Bus dependency, but in
general you wanna do the effort to get D-Bus running on your system. You
should trust me on that one. At some point you start loving it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
