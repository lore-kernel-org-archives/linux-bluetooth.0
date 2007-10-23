Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Date: Wed, 24 Oct 2007 00:10:35 +0200
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<9e0cf0bf0710231057lf60ce17ldd38489850cdf7c5@mail.gmail.com>
In-Reply-To: <9e0cf0bf0710231057lf60ce17ldd38489850cdf7c5@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200710240010.35799.rjw@sisk.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [BUG] rfcomm]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tuesday, 23 October 2007 19:57, Alon Bar-Lev wrote:
> On 10/23/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > first of all, please check if this still happens with 2.6.23, because we
> > had some patches in the area of the RFCOMM TTY code that might have
> > fixed this.
> 
> These messages are of 2.6.23.
> 
> > Second, can you try without uswsusp or suspend2. Both of
> > them are not upstream and I can't tell how much these would effect this
> > kind of behavior.
> 
> How can I test this without doing suspend?
> uswsusp is not upstream?!?! Rafael?

It is upstream and is supposed to work.

Greetings,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
