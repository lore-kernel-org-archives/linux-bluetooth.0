Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>, "'Max Krasnyansky'" <maxk@qualcomm.com>
In-Reply-To: <000701c318d7$e6598e90$1a01010a@baked>
References: <000701c318d7$e6598e90$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1052783343.1132.159.camel@pegasus.local>
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
Date: 13 May 2003 01:48:56 +0200

Hi Daryl,

> What happens when you close an L2CAP connection?

if you close() the L2CAP connection, we send a L2CAP_DISCONN_REQ and set
a timeout of 5 seconds. In the case of L2CAP_DISCONN_RSP or the timeout,
we close the L2CAP channel.

Max, please correct me if this is wrong, because I am not 100% sure.

> There is a test (see below) where the IUT sends an L2CAP disconnect request
> but the tester ignores it (doesn't send a disconnect response). To pass the
> test we must at least show an "L2CAP_DisconnectCfm" to the application.
> Indicating that a timeout ocurred is optional.

I don't understand why the application needs to now if the L2CAP channel
is correctly disconnected? We close the L2CAP socket and the rest has to
be done by the kernel. If the link is dead and the other side didn't
response, waiting 60 seconds won't help. Or did you see any advantage of
a blocking close()?

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
