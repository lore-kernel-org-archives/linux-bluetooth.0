Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcidump supports real raw packets ??
From: Marcel Holtmann <marcel@holtmann.org>
To: Emmanuel Mendoza <emma_kev@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20040924T204722-566@post.gmane.org>
References: <loom.20040924T204722-566@post.gmane.org>
Content-Type: text/plain
Message-Id: <1096056211.6925.39.camel@pegasus>
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
Date: Fri, 24 Sep 2004 22:03:31 +0200

Hi Emmanuel,

> I'm using Bluez for programming a hcidump based sniffer, but I'm confused
> about the captured packets. Do packets have ACCESS_CODE + HEADER + BODY format??
> Can or would can hcidump has this support??. I probe this feature using -R
> command, but the packets has a different format.

the tool is called hcidump and can only sniff HCI and upper layers. No
radio, baseband or link manager sniffing.

> Also I'd like to know if someone knows a Bluetooth Adaptor USB's firmware that
> support the monitor mode to achieve real sniff. I know that hcidump only sniff
> the local connections. If some firmware supports the monitor mode, would hcidump
> work fine in this case?

There is nothing like a monitor mode. For this kind of sniffing you need
a protocol analyzer. Look at www.catc.com or www.fte.com.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
