Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1ed4a0130611280741j6f8c3583n9d4ef956833393dd@mail.gmail.com>
References: <1ed4a0130611280741j6f8c3583n9d4ef956833393dd@mail.gmail.com>
Date: Sun, 03 Dec 2006 14:56:57 +0100
Message-Id: <1165154217.19590.41.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] No scroll wheel or extra buttons for MS
	Wireless	Notebook Presenter Mouse 8000
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

Hi Russell,

> I am able to get my new Microsoft Wireless Notebook Presenter Mouse
> 8000 working with the scroll wheel and extra buttons.  It does work
> with the basic three buttons.  I haven't even attempted to get the
> extra presentation features working as that is probably a lost cause. 
> 
> http://www.microsoft.com/hardware/mouseandkeyboard/productdetails.aspx?pid=085
> 
> $ rpm -q bluez-libs
> bluez-libs-3.7-1 
> 
> $ uname -a
> Linux rusharri-lnx2 2.6.18-1.2849.fc6 #1 SMP Fri Nov 10 12:45:28 EST
> 2006 i686 i686 i386 GNU/Linux
> 
> I'm not sure if this is related to the kernel bug described in the
> bluez-users list or if its going to require new drivers for this
> device entirely.  Hopefully its just misconfiguration on my part.
> Does anyone know if the patch made its way into the current FC6
> kernel? 
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=30640322&forum_id=1883
> 
> Any help would be much appreciated, Just let me know what information
> I can get you. 

you have to use at least the -mh patch or wait until we merged that back
into the upstream kernel. This might happen with 2.6.20 or 2.6.21
depending how well testing goes.

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
