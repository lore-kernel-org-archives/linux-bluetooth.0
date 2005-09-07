Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] LM_AUTH and LM_ENCRYPT
	support	for	outgoing sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <431F0CEB.30605@palmsource.com>
References: <4316C4A0.1070100@palmsource.com>
	 <1125922059.11955.15.camel@pegasus>  <431F0401.4010808@palmsource.com>
	 <1126107009.10631.69.camel@blade>  <431F0CEB.30605@palmsource.com>
Content-Type: text/plain
Message-Id: <1126110986.10631.74.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Sep 2005 18:36:26 +0200

Hi Fred,

> Find attached the l2cap patch.

this will actually need some time, because your patch is quite complex.

However looking at the first chunk. This means you wanna authenticate
after we established the ACL link. I think this is wrong. We should
first send the connection request and on a positive response we will
authenticate. The reason for this is that the other side might request
also the authentication and if they do we don't have to do anything.

Can you fix this?

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
