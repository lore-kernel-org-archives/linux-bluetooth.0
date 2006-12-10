Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061209015000.GD3119@163.com>
References: <20061208084508.GA3317@163.com>
	<1165573471.5529.24.camel@aeonflux.holtmann.net>
	<20061209015000.GD3119@163.com>
Date: Sun, 10 Dec 2006 13:39:32 +0100
Message-Id: <1165754372.22251.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] [Bluez-devel] How to setup a reliable
	RFCOMM	connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

> > > How to setup a reliable RFCOMM connection, that is, a connection with
> > > infinite flush timeout. I find the RFCOMM_LM_RELIABLE option in the
> > > example program l2test.c. It compiles, but at runtime setsockopt with
> > > RFCOMM_LM give me an error. I'm using kernel-2.4.21 patched by
> > > patch-2.4.21-mh10. So what's the problem. Doesn't kernel-2.4.21-mh10
> > > support RFCOMM_LM? If so, how can I setup a reliable RFCOMM connection?
> > 
> > the RFCOMM channels are always reliable. No need for any other options.
> > 
> Does that mean that the Automatic Flush Timeout Timer for the L2CAP
> connection underlying the RFCOMM connection is set to 0xFFFF by
> default? And when does the RFCOMM_LM option introduced?

this won't fly. The underlaying L2CAP connection must be reliable and so
we are not using an automatic flush timeout at all for that channel.
Please check the specification for details.

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
