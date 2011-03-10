Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 15:42:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Fix unloading of adapter drivers
Message-ID: <20110310134204.GA22155@jh-x301>
References: <1299759009-17407-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299759009-17407-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 10, 2011, Szymon Janc wrote:
> Call driver remove callback only if corresponding probe succeed.
> ---
>  src/adapter.c |   41 +++++++++++++++++++++++++----------------
>  1 files changed, 25 insertions(+), 16 deletions(-)

The patch looks ok'ish, but don't you have to update the
btd_unregister_adapter_driver function too? (so it also removes
potential entries in the loaded_drivers list)

Johan
