Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061208084508.GA3317@163.com>
References: <20061208084508.GA3317@163.com>
Date: Fri, 08 Dec 2006 11:24:31 +0100
Message-Id: <1165573471.5529.24.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [Bluez-users] How to setup a reliable RFCOMM
	connection
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

Hi,

> How to setup a reliable RFCOMM connection, that is, a connection with
> infinite flush timeout. I find the RFCOMM_LM_RELIABLE option in the
> example program l2test.c. It compiles, but at runtime setsockopt with
> RFCOMM_LM give me an error. I'm using kernel-2.4.21 patched by
> patch-2.4.21-mh10. So what's the problem. Doesn't kernel-2.4.21-mh10
> support RFCOMM_LM? If so, how can I setup a reliable RFCOMM connection?

the RFCOMM channels are always reliable. No need for any other options.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
