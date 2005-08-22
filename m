Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05082210394bed468@mail.gmail.com>
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
	 <8c9e090508191027e4646f1@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
	 <e1effdeb05082210394bed468@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1124733046.23599.81.camel@pegasus>
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
Date: Mon, 22 Aug 2005 19:50:46 +0200

Hi Claudio,

> After this long discussion I think control multiple apdaters
> will not be easy. If we register multiple paths will not be easy 
> map device register/unregister to D-Bus paths. When the user 
> remove the default dongle the D-Bus path should be unregistered and 
> the default adapter should be changed. 

never was and never will be ;)

> Considering that bluez daemons are using the BDADDR_ANY. The D-Bus 
> services should use the same approach. I agree that the default 
> adapter must go through the kernel.
> 
> Is there a way/interface to change the default adapter in the kernel? 

No. It has a simple route heuristic and normally uses the first adapter
that is marked as up and is not a raw device. Unless the destination is
not itself.

This means that the default adapter depends on the destination which is
not easy to configure.

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
