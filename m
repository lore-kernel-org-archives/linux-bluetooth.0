Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030513105017.0d234df0@unixmail.qualcomm.com>
References: <1052783343.1132.159.camel@pegasus.local>
	<5.1.0.14.2.20030513105017.0d234df0@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1052865860.4609.13.camel@pegasus.local>
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
Date: 14 May 2003 00:44:13 +0200

Hi Max,

> What we need is SO_LINGER option support. Application doesn't care so much about
> the disconnect itself but it does care if all the data that it had written to a 
> socket has been sent.
> i.e. 
>         connect(sk);
>         send(sk, stuff, sizeof(stuff));
>         close(sk);
> 
> Some apps want close() to sleep until all data has been sent and connection was 
> successfully closed.

I never have tought about it before, but SO_LINGER support seems useful.
And with this passing the test will be easy. Did using shutdown() for
disabling sending and receiving works?

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
