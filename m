Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447F71B5.8060905@xmission.com>
Date: Thu, 01 Jun 2006 17:01:09 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <70DCB28C5BB04A4BBB1C8512589BAC65D4F2D8@MAIL006.mail.lan>
	<1149202516.32406.0.camel@localhost>
In-Reply-To: <1149202516.32406.0.camel@localhost>
Subject: Re: [Bluez-devel] Strange behaviour
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

> can we try to reproduce this with a non-thread test program. If we can
> reproduce it this way, it will be much easier to debug.

maybe using async socket i/o would reproduce it.

threads implementations and debugging threads has improved from the bad
old days but I can understand the desire to avoid the issue.

brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
