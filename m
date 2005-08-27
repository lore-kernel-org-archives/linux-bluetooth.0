Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] help needed with rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <259637e0508260635526d51f6@mail.gmail.com>
References: <259637e0508241221e7f081b@mail.gmail.com>
	 <1124916916.8019.20.camel@pegasus>
	 <259637e05082506435fb9a5fc@mail.gmail.com>
	 <1124980168.8019.31.camel@pegasus>
	 <259637e0508260635526d51f6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1125147309.14395.0.camel@blade>
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
Date: Sat, 27 Aug 2005 14:55:09 +0200

Hi Rui,

> now it works with SOCK_STREAM, and i havent changed anythig to the
> program. i realy don't understand how this could be. I'm using kernel
> 2.6.12-CK and the bluez libs version 2.19?

this is how it should be. I fixed the kernel code to prevent creating
connections with the SOCK_RAW interface.

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
