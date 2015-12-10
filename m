Return-Path: <john@metanate.com>
Date: Thu, 10 Dec 2015 11:08:39 +0000
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] Install btattach with "make install"
Message-ID: <20151210110839.1eb744e2.john@metanate.com>
In-Reply-To: <1449052500-10755-1-git-send-email-john@metanate.com>
References: <1449052500-10755-1-git-send-email-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed,  2 Dec 2015 10:34:58 +0000, John Keeping wrote:

> Following a discussion last week [1], it seems that btattach should be
> used in preference to hciattach when possible.  This series adds a
> manual page for it and updates the makefile so that btattach is
> installed via the standard mechanism.
> 
> For now, btattach is still marked as experimental so it wil only be
> built and installed when experimental features are enabled.
> 
> [1] http://article.gmane.org/gmane.linux.bluez.kernel/65807

Ping?  Does anyone have any feedback on this?

> John Keeping (2):
>   tools/btattach: add manual page
>   tools/btattach: install during "make install"
> 
>  Makefile.tools   |  8 +++++++-
>  tools/btattach.1 | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 tools/btattach.1
