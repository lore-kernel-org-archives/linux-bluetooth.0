Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <70DCB28C5BB04A4BBB1C8512589BAC65E69930@MAIL006.mail.lan>
References: <70DCB28C5BB04A4BBB1C8512589BAC65E69930@MAIL006.mail.lan>
Date: Mon, 19 Jun 2006 20:09:04 +0200
Message-Id: <1150740544.4277.28.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bccmd patch
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Chris,

> I didn't see any response to this patch - resending to ensure that it
> didn't get missed.
> 
> I discovered a couple of things :
> 1. bccmd has some nice features that aren't mentioned in its "usages".
> 2. bccmd psset didn't work for keys with a size > 32 bits (because the
> OPT_PSKEY macro returned an error if you specified more than one value
> for the key, but it expected a list of bytes if the length is more than
> 1 or 2).
>  
> Here's a patch (against bluez-utils version 2.25) :

please create a patch against the latest CVS (or bluez-utils-3.1) and
attach it. Your mail client is messing up whitespaces and newlines.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
