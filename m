Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
From: Marcel Holtmann <marcel@holtmann.org>
To: patbert@patbert.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4116692D.1060003@patbert.com>
References: <4115A5E3.8000107@patbert.com> <1091959881.2773.6.camel@pegasus>
	 <411649EB.9020407@patbert.com> <1091980492.2773.33.camel@pegasus>
	 <41165ACF.10802@patbert.com> <1091985064.2773.36.camel@pegasus>
	 <4116692D.1060003@patbert.com>
Content-Type: text/plain
Message-Id: <1092005589.2773.53.camel@pegasus>
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
Date: Mon, 09 Aug 2004 00:53:09 +0200

Hi Patrick,

> In my log there were such obvious errors as....
> 
> Aug  8 13:38:53 Kawaii64 hcid[7695]: Bluetooth HCI daemon
> Aug  8 13:38:53 Kawaii64 hcid[7695]: Can not open /etc/bluetooth/hcid.conf
> Aug  8 13:38:53 Kawaii64 hcid[7695]: Config load failed
> Aug  8 13:38:53 Kawaii64 hcid[7695]: Can't open PIN file 
> /etc/bluetooth/pin. No such file or directory(2)
> 
> When bluez installed it made all those files in /usr/etc/bluetooth/ but 
> I guess it wasn't looking there so I copied it all over to 
> /etc/bluetooth and things are looking up...

if you overwrite the prefix you should also overwrite the sysconfdir
unless you really want it that way. Look at the configure example from
the README file.

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
