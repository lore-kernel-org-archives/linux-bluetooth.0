Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: bluez-devel@lists.sourceforge.net, jim.oleary@rococosoft.com
In-Reply-To: <1117032099.5854.56.camel@baroque.rococosoft.com>
References: <1117032099.5854.56.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1117032403.30044.218.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Small fix for L2CAP MTU
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
Date: Wed, 25 May 2005 16:46:43 +0200

Hi Steve,

> I've attached a small change to the L2CAP layer which causes it to
> better adhere to a sender's choice of MTU.
> 
> The background is that we have a test here where the client asks for an
> omtu of 50 and tries to send more than this to the server, which in turn
> checks that only 50 bytes were sent.
> 
> With the current kernel code, the omtu is always returned as the default
> MTU (672) which causes our test to fail.
> 
> I've attached a patch against 2.6.11.10 (proposed by my colleague Jim
> O'Leary) which assigns omtu from that proposed by the peer, iff we don't
> care about the omtu.

please use unified diff. I am unable to read context diffs.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
