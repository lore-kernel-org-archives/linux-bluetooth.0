Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 12:31:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/8] audio: Fix handling of a2dp start indication
Message-ID: <20120615093142.GB28900@x220>
References: <1339747468-31639-1-git-send-email-luiz.dentz@gmail.com>
 <1339747468-31639-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339747468-31639-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 15, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Only process callbacks if avdtp_start was sent, otherwise it may cancel
> setup callbacks that were registere via g_idle_add.
> ---
>  audio/a2dp.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

This doesn't apply. After what tree exactly have you been testing this:

Applying: audio: Fix handling of a2dp start indication
error: patch failed: audio/a2dp.c:2142
error: audio/a2dp.c: patch does not apply

Johan
