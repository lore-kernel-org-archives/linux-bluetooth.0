Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <F8B9B12641FB6B4FAC761BDEF9D63B040C9FEE38@tlv-ex-01.adprod.bmc.com>
References: <F8B9B12641FB6B4FAC761BDEF9D63B040C9FEE38@tlv-ex-01.adprod.bmc.com>
Date: Thu, 26 Apr 2007 19:30:17 +0200
Message-Id: <1177608617.14980.108.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] tcs-bin
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

Hi Nimco,

> Where can I find docs/examples  about howto implement tcs-bin in c
> with bluez

I did an implementation a long time ago, but can't find the code right
now. However TCS-BIN can use the L2CAP socket interface directly. It is
quite simple. Check l2test.c for an example on how to use it. Getting
the SCO interaction correct is the bigger problem.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
