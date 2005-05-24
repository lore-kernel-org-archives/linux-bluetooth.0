Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-2?Q?Szab=F3_Zolt=E1n?= <szz@freemail.hu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
Message-Id: <20050524194038.35b3ed78.szz@freemail.hu>
In-Reply-To: <1116936381.30044.143.camel@pegasus>
References: <freemail.20050424121317.54568@fm14.freemail.hu>
	<1116936381.30044.143.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
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
Date: Tue, 24 May 2005 19:40:38 +0200

Hi Marcel,

> since you used dpkg to show a package list, I assume it is a Debian
> based system. In this case "apt-get install hotplug" should do the
> job.
You are right, it's a Debian based system: UHU-linux.

# apt-cache search hotplug
uhu-hotplug - Eszk=F6zcsere-vez=E9rl=F5 programok

# apt-get install uhu-hotplug
uhu-hotplug is already the newest version.

But it has only usb and ieee1394 parts:
/etc
/etc/hotplug
/etc/hotplug/agents
/etc/hotplug/agents/ieee1394
/etc/hotplug/agents/usb
/sbin
/sbin/hotplug

Regards

Zol


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
