Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v3 1/2] Add external dummy plugin for testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Date: Sun, 14 Aug 2011 14:12:55 -0700
In-Reply-To: <1313068216-16802-2-git-send-email-szymon.janc@tieto.com>
References: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
	 <1313068216-16802-2-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313356383.3373.168.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>  Makefile.am              |    7 +++++++
>  plugins/external-dummy.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/external-dummy.c

I prefer if patches are actually tested if the apply cleanly:

Applying: Add external dummy plugin for testing
/data/devel/bluez/.git/rebase-apply/patch:30: new blank line at EOF.
+
fatal: 1 line adds whitespace errors.

Since my patch and git foo is reaching guru status, I fixed this up for
you ;)

Regards

Marcel


