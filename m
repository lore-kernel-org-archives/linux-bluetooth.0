Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050524194038.35b3ed78.szz@freemail.hu>
References: <freemail.20050424121317.54568@fm14.freemail.hu>
	 <1116936381.30044.143.camel@pegasus>
	 <20050524194038.35b3ed78.szz@freemail.hu>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1116954260.30044.149.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 May 2005 19:04:20 +0200

Hi Zol,

> > since you used dpkg to show a package list, I assume it is a Debian
> > based system. In this case "apt-get install hotplug" should do the
> > job.
> You are right, it's a Debian based system: UHU-linux.
>=20
> # apt-cache search hotplug
> uhu-hotplug - Eszk=F6zcsere-vez=E9rl=F5 programok
>=20
> # apt-get install uhu-hotplug
> uhu-hotplug is already the newest version.
>=20
> But it has only usb and ieee1394 parts:
> /etc
> /etc/hotplug
> /etc/hotplug/agents
> /etc/hotplug/agents/ieee1394
> /etc/hotplug/agents/usb
> /sbin
> /sbin/hotplug

don't ask me. Ask the package maintainer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
