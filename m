Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Feb 2011 16:58:28 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v3 3/3] Bluetooth: Validate data size before accessing
 mgmt commands
Message-ID: <20110227195828.GD2166@joana>
References: <1298657149-3091-1-git-send-email-szymon.janc@tieto.com>
 <1298657149-3091-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298657149-3091-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-02-25 19:05:49 +0100]:

> Crafted (too small) data buffer could result in reading data outside of buffer.
> Validate buffer size and return EINVAL if size is wrong.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)

All 3 patches are applied now, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
