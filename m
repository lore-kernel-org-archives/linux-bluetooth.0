Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] LM_AUTH and LM_ENCRYPT support
	for	outgoing sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <431F0401.4010808@palmsource.com>
References: <4316C4A0.1070100@palmsource.com>
	 <1125922059.11955.15.camel@pegasus>  <431F0401.4010808@palmsource.com>
Content-Type: text/plain
Message-Id: <1126107009.10631.69.camel@blade>
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
Date: Wed, 07 Sep 2005 17:30:09 +0200

Hi Fred,

> This patch can help us to develop an application to create pairing 
> between devices with no need to be root. Further more, in Handsfree 
> profile it is written that : "If both devices support authentication and 
> encryption, the application on either device may require its use."

I don't really like it, but I already opened my mind to accept such a
patch. However this must be tested a lot so we can be sure that it
doesn't break any state machine.

> I have updated the patch so it should no more break userspace.

The RFCOMM part is wrong. You can't set the LM mode of RFCOMM to the
underlaying L2CAP. This means that the authentication/encryption will be
triggered when the L2CAP connection is created and not on the SABM at
RFCOMM level.

Please drop the RFCOMM part for now and send in patch that only modifies
the L2CAP layer. We need to get this right and tested first anyhow.

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
