Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 21:28:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Watson <cjwatson@ubuntu.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit: Fix test failures with glib 2.39.0
Message-ID: <20140106192824.GB25443@x220.p-661hnu-f1>
References: <20140106120700.GZ5883@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140106120700.GZ5883@riva.ucam.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Mon, Jan 06, 2014, Colin Watson wrote:
> glib 2.39.0 made this change:
> 
>    - g_source_remove() will now throw a critical in the case that you
>      try to remove a non-existent source.  We expect that there is some
>      code in the wild that will fall afoul of this new critical but
>      considering that we now reuse source IDs, this code is already
>      broken and should probably be fixed.
> 
> This patch fixes the test suite to keep better track of whether sources have
> already been removed and avoid double-removals.
> ---
>  unit/test-avdtp.c          |  8 ++++++--
>  unit/test-gobex-transfer.c |  6 ++++--
>  unit/test-gobex.c          | 13 ++++++++-----
>  unit/util.c                |  1 +
>  unit/util.h                |  1 +
>  5 files changed, 20 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
