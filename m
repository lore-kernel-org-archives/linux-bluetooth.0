Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Nagle Algorithm
From: Marcel Holtmann <marcel@holtmann.org>
To: dsas@mega.ist.utl.pt
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1085671672.40b608f822846@webmail.rnl.ist.utl.pt>
References: <1085671672.40b608f822846@webmail.rnl.ist.utl.pt>
Content-Type: text/plain
Message-Id: <1085673757.2797.29.camel@merlin>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 27 May 2004 18:02:38 +0200

Hi Didier,

> I'd like to know if bluez uses the nagle algorithm and if it can be disabled
> with the setsockopt in a rfcomm connection.

I don't think we don't use the algorithm in RFCOMM. Actually I never
thought about that before, so go and look at the source code. What I
definitiv can say is that no option exists to control the reaction of
the flow control mechanism.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
