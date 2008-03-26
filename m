Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0803260937i21870643xa2207770239d469a@mail.gmail.com>
Date: Wed, 26 Mar 2008 17:37:41 +0100
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <81E635B3-43C3-4956-B5ED-D9C4BFE8E235@holtmann.org>
MIME-Version: 1.0
References: <89b6ba3a0803231540t258807bdk703d843a18a63a3e@mail.gmail.com>
	<81E635B3-43C3-4956-B5ED-D9C4BFE8E235@holtmann.org>
Subject: Re: [Bluez-users] Recent bluez-gnome problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Mar 26, 2008 at 5:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Patryk,
>  > I'm in the middle of packaging bluez-gnome 0.25 for PLD Linux. I
>  > already have obex-data-server (with --enable-system-config) packaged
>  > but hit a strange problem.
>  don't use --enable-system-config unless you know what this implies.
>  Running ODS inside the user session is good enough.

So you suggest we disable it in distro builds? Will do. I thought it
only affected system bus activation?

>  > The interface is visible and hcid is running. I've noticed the
>  > transfer service is no longer part of bluez-utils. First I was unable
>  > to get bluez to a point where it detects any devices. I can see my
>  > laptop from my cell phone but not the other way araound. After bonding
>  > (initialized from the phone) I can send files from my laptop to my
>  > cell phone (it shows bonded devices even if discovery fails to work).
>  > I can't send any files from the phone and I can't browse the phone
>  > contents (phone asks for permission but nautilus shows "connect
>  > failed" when trying to use gvfs-mount obex://[...]/).
>  >
>  > bluez-* is 3.29, obex-data-server is 0.3
>  I don't see a problem here. The latest bluez-gnome has options to
>  enable file transfer and push service.

yes, the options are there but there seems to be a problem with device
discovery somewhere in my setup. Is running hcid enough for the device
detection to work? It seems only the already paired devices show up
(it worked fine at least with bluez-gnome 0.15) so I assume it only
displays a memorized list of devices not doing discovery at all. How
do I debug it? I'm a programmer so if you point me to the right
internals I think I could fix the issues or at least provide you with
more info.

-- 
Patryk Zawadzki
PLD Linux Distribution

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
