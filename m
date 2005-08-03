Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DUN lookup on Samsung D500 raises SIGSEGV
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42F102E2.5060608@csr.com>
References: 
	 <Pine.LNX.4.33.0508031910480.4458-100000@redbean.intranet.gw-instruments.de>
	 <42F102E2.5060608@csr.com>
Content-Type: text/plain
Message-Id: <1123094332.8331.34.camel@pegasus>
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
Date: Wed, 03 Aug 2005 20:38:52 +0200

Hi Steven,

> > without realy knowing the internals this looks to me like BlueZ does not
> > support 32 Bit UUIDS. It is a little bit unusual to use 32 Bit UUIDs but
> > legal. So BlueZ SDP Parser shall support them.
> 
> We've been through this before and someone also suggested that the 32 bit
> UUIDs were the problem. They're not. The Samsung D-500 DUN SDP record is
> incorrect (or at the very least bizarre) and sdptool doesn't do proper
> input validation (always a security risk).
> 
> An archived copy of the thread starts at:
> 
>   http://sourceforge.net/mailarchive/message.php?msg_id=11057683
> 
> The correct diagnosis is at:
> 
>   http://sourceforge.net/mailarchive/message.php?msg_id=11057684
> 
> I suspect sdptool is "knows" that a BluetoothProfileDescriptorList
> should be a sequence of sequences and so doesn't validate the input.
> Perhaps the way to go is to add a getNextAsSequence call to sdptool
> which looks to see if the next element in the stream is a sequence.
> If it is, it returns it, if it isn't, it wraps it in a dummy sequence
> with an appropriate length and returns that.

if someone is willing to donate one of these buggy Samsung phones, I am
happy to fix it and implement a workaround for it. If not, then this
problem will exists until someone else sends me a patch for. I am not
changing something in the SDP code without being able to test it with
real life hardware.

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
