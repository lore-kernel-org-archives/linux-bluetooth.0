Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061210141030.GA3730@163.com>
References: <20061208084508.GA3317@163.com>
	<1165573471.5529.24.camel@aeonflux.holtmann.net>
	<20061209015000.GD3119@163.com>
	<1165754372.22251.14.camel@aeonflux.holtmann.net>
	<20061210141030.GA3730@163.com>
Date: Sun, 10 Dec 2006 15:18:53 +0100
Message-Id: <1165760333.20427.1.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [Bluez-users] How to setup a reliable
	RFCOMM	connection
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

> > > > > How to setup a reliable RFCOMM connection, that is, a connection with
> > > > > infinite flush timeout. I find the RFCOMM_LM_RELIABLE option in the
> > > > > example program l2test.c. It compiles, but at runtime setsockopt with
> > > > > RFCOMM_LM give me an error. I'm using kernel-2.4.21 patched by
> > > > > patch-2.4.21-mh10. So what's the problem. Doesn't kernel-2.4.21-mh10
> > > > > support RFCOMM_LM? If so, how can I setup a reliable RFCOMM connection?
> > > > 
> > > > the RFCOMM channels are always reliable. No need for any other options.
> > > > 
> > > Does that mean that the Automatic Flush Timeout Timer for the L2CAP
> > > connection underlying the RFCOMM connection is set to 0xFFFF by
> > > default? And when does the RFCOMM_LM option introduced?
> > 
> > this won't fly. The underlaying L2CAP connection must be reliable and so
> > we are not using an automatic flush timeout at all for that channel.
> > Please check the specification for details.
> In my understanding of the specification, the Automatic Flush Timeout
> is applied on a connection handle which corresponds to the ACL link.
> So does that mean once a RFCOMM connection is established, the
> automatic flush timeout would be disabled(to ensure link reliability)?
> Or that bluez doesn't use automatic flush timeout at all for all
> connections?

we should use automatic flush timeout, but we actually don't. It
currently makes no sense for use to use it, because all upper layers
assume that the lower layers are reliable. With Bluetooth 2.1 this will
change and you can mark L2CAP channels as flushable. This is needed for
the A2DP audio channels were it doesn't matter if you loose a packet.

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
