Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 15:26:07 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Add GStreamer version check in acinclude.m4
Message-ID: <20110224182607.GA16528@jh-x301>
References: <1298466787-2854-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298466787-2854-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 23, 2011, Szymon Janc wrote:
> Since commit cc04c6a2f7500f3d29d56634e645130ff3bd80fb compilation
> fails with GStreamer 0.10.28 or older.
> ---
>  acinclude.m4 |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

The patch has been pushed upstream. Thanks. Btw, be careful with your
commit message width. It needs to fit within 80 columns even with the
indentation that git log applies (I had to edit it manually this time).

Johan
