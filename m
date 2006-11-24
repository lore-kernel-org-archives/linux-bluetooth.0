Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <018a01c70f98$5e21d670$8935c70a@dlh.st.com>
References: <018a01c70f98$5e21d670$8935c70a@dlh.st.com>
Date: Fri, 24 Nov 2006 08:31:05 +0100
Message-Id: <1164353465.28284.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] L2CAP disconnect problem
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

Hi Summeet,

> The patch worked. But after the L2CAP disconnection, the ACL channel doesn't disconnect. Is there some other patch also at HCI Level? Please send it also.

are we talking about the 2.4 or 2.6 kernel here. I didn't recall any
problems with the 2.6 kernel. We had a problem some time ago where the
creator doesn't terminates his own ACL connections, but that was fixed
around 2.6.1 or so.

Make sure you have a "hcidump -X -V" to show what happens.

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
