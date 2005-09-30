Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: DUN lookup on Samsung D500 raises SIGSEGV
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <433D16A7.5030805@inelis.org>
References: <433D16A7.5030805@inelis.org>
Content-Type: text/plain
Message-Id: <1128082139.4955.33.camel@localhost.localdomain>
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
Date: Fri, 30 Sep 2005 14:08:59 +0200

Hi Loic,

> Here is a patch to fix the SEGV when doing DUN lookup on Samsung phones
> (at least D500 and E720).
> The diagnostic for the bug is here:
> http://sourceforge.net/mailarchive/message.php?msg_id=11057684
> The problem is that the Samsung phones return a sequence of uuid for
> BTProfileDescList instead
> of a sequence of (sequence uuid version).
> 
> The patch detects the "sequence of uuid" case and uses a default version
> number of 0x100,
> as recommended in:
> http://sourceforge.net/mailarchive/message.php?msg_id=11202759
> The other case is unchanged.
> 
> Tested with these phones: Samsung D500 and E720, Nokia 6680.

your mailer is broken. Please resend the patch as attachment.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
