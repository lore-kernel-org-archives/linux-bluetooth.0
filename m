Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 24 Oct 2007 11:56:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Kosina <jikos@jikos.cz>
Message-ID: <20071024095626.GA18877@elf.ucw.cz>
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
	<1193163905.6184.214.camel@violet>
	<Pine.LNX.4.64.0710232026180.18815@twin.jikos.cz>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0710232026180.18815@twin.jikos.cz>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
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

On Tue 2007-10-23 20:28:04, Jiri Kosina wrote:
> On Tue, 23 Oct 2007, Marcel Holtmann wrote:
> 
> > > actually uswsusp has been upstream for quite some time already. See 
> > > Documentation/power/userland-swsusp.txt
> > nice. I've never used it. Currently I am using what comes with Ubuntu
> > 7.10 and that seems to work.
> 
> Never used ubuntu, so I have no idea what they ship, I guess you use 
> s2ram/s2disk utilitie. If so, you are using uswsusp too.

Ubuntu may be crazy enough to use suspend2. Anyway, this is driver
problem, and I believe it is reproducible even with plain-old
in-kernel swsusp.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
