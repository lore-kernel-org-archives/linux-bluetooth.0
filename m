Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 2 Apr 2016 10:48:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input/hog: Fix crash if uhid is not enabled
Message-ID: <20160402074819.GA30119@t440s.P-661HNU-F1>
References: <1459540709-2058-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459540709-2058-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Apr 01, 2016, Szymon Janc wrote:
> If /dev/uhid is not present bt_hog_new_default() returns NULL.
> This was resulting in NULL pointer dereference in attio_connected_cb.
> ---
>  profiles/input/hog.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
