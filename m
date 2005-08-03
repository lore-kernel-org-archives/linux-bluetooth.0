Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42F102E2.5060608@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DUN lookup on Samsung D500 raises SIGSEGV
References: 
    <Pine.LNX.4.33.0508031910480.4458-100000@redbean.intranet.gw-instruments.de>
In-Reply-To: 
    <Pine.LNX.4.33.0508031910480.4458-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain; charset="us-ascii"
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
Date: Wed, 03 Aug 2005 18:46:10 +0100

Peter Wippich wrote:
> without realy knowing the internals this looks to me like BlueZ does not
> support 32 Bit UUIDS. It is a little bit unusual to use 32 Bit UUIDs but
> legal. So BlueZ SDP Parser shall support them.

We've been through this before and someone also suggested that the 32 bit
UUIDs were the problem. They're not. The Samsung D-500 DUN SDP record is
incorrect (or at the very least bizarre) and sdptool doesn't do proper
input validation (always a security risk).

An archived copy of the thread starts at:

  http://sourceforge.net/mailarchive/message.php?msg_id=11057683

The correct diagnosis is at:

  http://sourceforge.net/mailarchive/message.php?msg_id=11057684

I suspect sdptool is "knows" that a BluetoothProfileDescriptorList
should be a sequence of sequences and so doesn't validate the input.
Perhaps the way to go is to add a getNextAsSequence call to sdptool
which looks to see if the next element in the stream is a sequence.
If it is, it returns it, if it isn't, it wraps it in a dummy sequence
with an appropriate length and returns that.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
