Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4577F18C.2010806@csr.com>
Date: Thu, 07 Dec 2006 10:48:44 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY108-F14D0E2C437D8EE10A1C0CF84E50@phx.gbl>
	<Pine.LNX.4.63.0611281554510.30196@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0611281554510.30196@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Peter Wippich wrote:
> No quite sure but it is a problem with your BT chip. It only allows 3 
> connection. If it is a CSR chip may be soembody has configured it to allow 
> only 3 ACL connections. You can find out using bccmd. There is a PS-key 
> named something like MAX_ACL_CONNECTIONS.

No. It's not a baseband issue. If it were, the connection would be
rejected at the HCI level. Instead, the connection is being rejected at
the L2CAP level indicating that the baseband was happy to accept the
connection, but something that's nominally in the host has rejected it.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
