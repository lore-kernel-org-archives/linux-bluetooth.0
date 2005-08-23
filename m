Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth SCO message sending (sco_send_frame)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <430B28C7.8000406@core.kaist.ac.kr>
References: <430B28C7.8000406@core.kaist.ac.kr>
Content-Type: text/plain
Message-Id: <1124805168.23599.164.camel@pegasus>
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
Date: Tue, 23 Aug 2005 15:52:48 +0200

Hi Youngwoo,

> When the SCO message size is larger than MTU, sco_send_fram function is
> just returned
> and sco message is not sent.
> 
> For that reason, I can't use bluetooth sound application using SCO
> channel through h4 interface.
> (Of course, I adjusted the MTU size more larger but failed to hear
> bluetooth sound.)
> 
> I fixed it to divide bluetooth message along with the MTU size and send
> more message..
> Although it is not perfect, it operate well..
> 
> My patch is below..

the problem is that your patch is unreadable. Follow the coding style
and only diff the needed changes.

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
