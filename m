Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] newb request
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f30e2610412090850b7f5f85@mail.gmail.com>
References: <5f30e2610412090850b7f5f85@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102611436.9988.237.camel@pegasus>
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
Date: Thu, 09 Dec 2004 17:57:16 +0100

Hi Jeff,

> I have about 5 years experience with sockets programming, but I am new
> to BlueZ.  I am interested in developing applications using HCI.  I
> have skimmed through the Bluetooth specifications (through 2.0) and I
> have created a "Hello World" app using hcitool.c (bluez-utils-2.7) as
> a guide.
> 
> What other documents are available?  Is there a FAQ, man page, or a
> central location for API documentation somewhere? Looking at the
> source of hcitool is helpful, but it only gets me so far.  Where can I
> get more details?
> 
> I am looking for anything to help me translate the Bluetooth spec into
> the practical workings of the BlueZ implementation.

I think what you really wanna do is using L2CAP or RFCOMM as transport
layers and so better look a l2test.c and rctest.c files.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
