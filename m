Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 27 Nov 2006 09:18:50 +0800
From: amateur <ztl.post@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061127011850.GA3195@163.com>
References: <20061126143026.GA17505@163.com>
	<1164562411.25914.40.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1164562411.25914.40.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Cross Compile bluez-utils failed on dbus
	dependency !
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

On Sun, Nov 26, 2006 at 06:33:31PM +0100, Marcel Holtmann wrote:
> Hi,
> 
> > I'm cross compiling bluez-utils-3.7 to arm platform. The cross 
> > compiler I  use is arm-linux-gcc-3.4, and I have already cross 
> > compiled bluez-libs successfully! When run 
> > 
> > 	CC=arm-linux-gcc ./configure --host=i386-linux --target=arm-linux 
> > 
> > I got the following error:
> > 
> > 	checking for DBUS... configure: error: dbus > 0.35 is required
> > 
> > As I can imagine, this is because bluez-utils depends on dbus, which 
> > doesn't exist on my target platform, and nor does I like to build the
> > dbus system on my target platform. 
> > 
> > Is there a way to avoid this?
> > 
> > I want to download some older releases of bluez to avoid the dbus
> > stuff, but I can't find any link on the bluez homepage. Does anyone
> > has a clue ?
> 
> you can go with bluez-utils-2.x to avoid the D-Bus dependency, but in
> general you wanna do the effort to get D-Bus running on your system. You
> should trust me on that one. At some point you start loving it.
> 
> Regards
> 
> Marcel
> 
> 
-------------------------

thank you for the fast reply!
I am not familiar with dbus for the moment, so I think bluez-utils-2.x
should be a better solution for now. Maybe I will try dbus later. How
big is cost of build dbus system on a arm embedded platform. I mean,
do I need to recompile busybox for dbus support or that I need enable
dbus support in some of my key services ?


-- 
This is the first age that's paid much attention to the future, which is a
little ironic since we may not have one.
		-- Arthur Clarke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
