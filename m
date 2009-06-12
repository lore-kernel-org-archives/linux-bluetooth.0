Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Jun 2009 15:25:10 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
Subject: Re: Apple Bluetooth devices: Battery level?
In-Reply-To: <1244617386.3068.22.camel@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.0906121521490.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>  <1244589738.5973.1954.camel@cookie.hadess.net> <1244617386.3068.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 10 Jun 2009, Marcel Holtmann wrote:

> there is no real downside in having this all times available since you
> have to store that binary record somewhere anyway during runtime. We
> should fix that and put it into debugfs, but nobody bothered so far
> sending a patch for it. 

JFYI, I have just pushed super-preliminary version of the code that moves 
the whole HID-device debugging (report descriptor and report/event 
dumping) into debugfs. It's 'debugfs' branch of my HID tree, for those who 
are interested.
Please bear in mind that this is more or less a snapshot of the current 
code (which is working, though), not production quality yet. Hopefully 
they will get properly polished for 2.6.31.

I will post the patches as a followup to this mail, if anyone is 
interested.

Comments and patches welcome, as usual.

-- 
Jiri Kosina
SUSE Labs
