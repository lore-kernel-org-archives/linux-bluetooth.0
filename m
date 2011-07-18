Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jul 2011 00:13:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Subject: Re: [PATCH] Fix compilation with --disable-sap and glib < 2.28
Message-ID: <20110718211327.GA27879@dell.ger.corp.intel.com>
References: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jul 18, 2011, Szymon Janc wrote:
> ---
>  audio/telephony-maemo6.c |    3 +++
>  audio/telephony-ofono.c  |    3 +++
>  2 files changed, 6 insertions(+), 0 deletions(-)

Thanks, the patch has been upstream (after I rewrote the commit message
since I don't see how this has anything to do with SAP).

Johan
