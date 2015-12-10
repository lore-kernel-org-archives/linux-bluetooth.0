Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 10 Dec 2015 21:27:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: John Keeping <john@metanate.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] Install btattach with "make install"
Message-ID: <20151210192727.GA3541@t440s>
References: <1449052500-10755-1-git-send-email-john@metanate.com>
 <20151210110839.1eb744e2.john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151210110839.1eb744e2.john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Dec 10, 2015, John Keeping wrote:
> > Following a discussion last week [1], it seems that btattach should be
> > used in preference to hciattach when possible.  This series adds a
> > manual page for it and updates the makefile so that btattach is
> > installed via the standard mechanism.
> > 
> > For now, btattach is still marked as experimental so it wil only be
> > built and installed when experimental features are enabled.
> > 
> > [1] http://article.gmane.org/gmane.linux.bluez.kernel/65807
> 
> Ping?  Does anyone have any feedback on this?

Sorry for the delay. Both patches look good and have now been applied to
bluez.git. Thanks.


Johan
