Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030513165931.0d377d88@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<000201c31771$70577930$6400a8c0@baked>
	<5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513153902.0d3016d8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030513165931.0d377d88@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1052872215.4608.44.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 14 May 2003 02:30:08 +0200

Hi Max,

> >But I don't like the name and your meaning of this options. It sounds
> >like something that it is not and will never be. For the description of
> >this option I think it should be something like
> >
> >        "Notify me when you detect an error in the ACL payload"
> ACL is a lower lever. If baseband detects error in ACL payload it retransmits 
> a packet :).

ok, so "L2CAP frame" would be the better and correct description.

> >And the option name can be L2CAP_CHECKACL. This is not very good, I
> >know, so any other proposals?
> L2CAP_LM_RELIABLE

I don't like it either, because we can't detect all errors which makes
the connection unreliable. But I don't know a better name :(

> Implementation is very very very simple and code for 2.4 is already in BK :).
> http://linux-bt.bkbits.net:8080/bt-2.4/patch@1.1163?nav=index.html|ChangeSet@-1h|cset@1.1163
> 
> We didn't even need a new socket option. Just another LM (link mode) flag. And common case 
> is not affected at all.

Very nice and small patch. I will delay the new -mh patches because of
this and hopefully the SO_LINGER support. Can you please also take a
look at the RFCOMM problem I posted to the list. My day is definitive
over and I will take some sleep :)

> Now we just need to add support for it in l2test.

Daryl, it is your test :)

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
