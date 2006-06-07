Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fe0a97c20606070328h4924fb22n28d30bce79cb54d7@mail.gmail.com>
References: <fe0a97c20606052352j37b71f20mad12696fdff7c08d@mail.gmail.com>
	<fe0a97c20606070328h4924fb22n28d30bce79cb54d7@mail.gmail.com>
Date: Wed, 07 Jun 2006 22:13:22 +0200
Message-Id: <1149711202.22472.49.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Does rfcomm manipulate the data??
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

Hi Soumya,

> Is rfcomm a transparent socket?? Does it manipulate the data sent from
> one side to another??

it doesn't change any data. What you put in on one sides comes out on
the other.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
