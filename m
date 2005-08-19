Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] hcid/dbus crasher fix
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Nathaniel McCallum <npmccallum@asbury.edu>
In-Reply-To: <1124383820.2312.3.camel@vacation.asbury.edu>
References: <1124383820.2312.3.camel@vacation.asbury.edu>
Content-Type: text/plain
Message-Id: <1124463220.6398.13.camel@notepaq>
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
Date: Fri, 19 Aug 2005 16:53:40 +0200

Hi Nathaniel,

> The following patch corrects a crasher bug when using hcid with dbus.
> 
> I'm still having a problem even after this bug, hcid just exits with
> exitstatus 1 (but at least it doesn't crash).  Any ideas?

this patch is not correct, because ba2str() then writes 18 bytes to a
pointer where you haven't allocated memory for. Why do you need this
kind of fix.

> BTW, I'm not subscribed to the list, so please CC me in any responses.

Why don't you subscribe?

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
