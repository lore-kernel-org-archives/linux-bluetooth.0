Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] PAN,just one connected line???
Cc: "Sammy" <sammy@autumn.ccl.itri.org.tw>
References: <00be01c47b6a$e84062a0$7053608c@ccl.itri.org.tw>
In-Reply-To: <00be01c47b6a$e84062a0$7053608c@ccl.itri.org.tw>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200408060930.08633.pavouk@pavouk.org>
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
Date: Fri, 6 Aug 2004 09:30:08 +0200

Hello,

> There are four nodes had been connected by pand.
> but after i assign the static IP to every interface,
> the 'ping' command can't work normally besides the line between PANU1 and
> GN(the first connection). I don't know it is normal or i loss some
> configuration ...

this will not work, because your BNEP interfaces are in independent networks
with same IP space. You ha two choices:
1. Routing
----------------
You can give independent IP spaces for BNEP interfaces.
10.0.0.0/30
10.0.0.4/30
10.0.0.8/30
...
It means 10.0.0.1 on BNEP0 on GN, 10.0.0.2 on BNEP0 on PANU1
with mask 255.255.255.252

You must have enabled IP forwarding on GN for connecting between PANUs.
On PANUs it's great to set default gateway to GNs IP address.

2. Bridging
-------------------
You must enable bridge support on GN.
Complete manual is here:
http://bluez.sourceforge.net/contrib/HOWTO-PAN

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
