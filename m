Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multihop question
From: Marcel Holtmann <marcel@holtmann.org>
To: libo <libo@semit.com.cn>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040730104427.19ffd026.libo@semit.com.cn>
References: <41090B25.6090806@xmission.com>
	 <1091112872.12651.50.camel@pegasus>
	 <20040730104427.19ffd026.libo@semit.com.cn>
Content-Type: text/plain
Message-Id: <1091176264.12651.171.camel@pegasus>
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
Date: Fri, 30 Jul 2004 10:31:04 +0200

Hi,

> I need to implement multihop using bluetooth devices.
> The topology is as follows:
> [Ethernet]---A---B---C
> BT device C can visit Ethernet through B and A.
> I want to know if I can implement multihop using BlueZ and what I shall do.

if you use BNEP as the underlaying protocol, you can use IP on top of it
and this is all about IP routing.

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
