Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050830111665325706@mail.gmail.com>
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
	 <e1effdeb05082210394bed468@mail.gmail.com>
	 <1124733046.23599.81.camel@pegasus>
	 <e1effdeb050822124710aa8798@mail.gmail.com>
	 <e1effdeb0508291413753e3b2e@mail.gmail.com>
	 <1125351995.17698.37.camel@pegasus>
	 <e1effdeb050830061474e1e560@mail.gmail.com>
	 <e1effdeb050830111665325706@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1125568671.5496.11.camel@localhost.localdomain>
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
Date: Thu, 01 Sep 2005 11:57:51 +0200

Hi Claudio,

> Regarding the special HCI_DEV_NONE system socket with vendor packet
> type. Do you 
> have a patch for it or it just ideas for BlueZ improvements? What are
> exactly the events that 
> you want send in this socket?

the latest hcidump has support for dumping these packets, but at the
moment the kernel is not sending any of them. I still have to implement
the kernel part for it. Only the basic frame format is defined at the
moment, but no actual message packets are defined.

The main messages would be notifying about added/removed adapters on the
system. Also the exchange of pin code and link keys between the kernel
and the userspace is what I have in mind. The other thing would be
notification of inquiry responses and name resolves. And then I am open
for suggestions.

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
