Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
From: Marcel Holtmann <marcel@holtmann.org>
To: patbert@patbert.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <411649EB.9020407@patbert.com>
References: <4115A5E3.8000107@patbert.com> <1091959881.2773.6.camel@pegasus>
	 <411649EB.9020407@patbert.com>
Content-Type: text/plain
Message-Id: <1091980492.2773.33.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 08 Aug 2004 17:54:52 +0200

Hi Patrick,

> Alright I got libz, utils, and pin 2.9. I had to install dbus to get 
> bluez-pin to compile.
> 
> Now I have to do hciconfig hci0 up to get the adaptor to wake up...

start the hcid and sdpd from a boot script. Make sure that only one hcid
is running.

> Now whenever I try to connect with hidd it always times out.
> 
> Ah yes and I am using a 2.6.8-rc3 colonel now.

On first connect to your keyboard you must input the PIN on it and press
enter. Run "hcidump -x" as root to check what is going on.

> 2.7 was a package from my distro, I had to do 2.9 by hand. I guess there 
> is a chance I missed something but it all seemed to go over without a 
> hitch installation wise.

I hope you removed the distro packages first, before installing the new
ones. Ask the package maintainer to adapt the upstream version.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
