Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 May 2013 14:57:58 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] lib: Fix sdp_seq_alloc_with_length accessing
 invalid index/memory
Message-ID: <20130523215758.GA31190@x220.psav.com>
References: <1369335672-9156-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369335672-9156-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 23, 2013, Luiz Augusto von Dentz wrote:
> The sequence itself is not an index of dtds, values, lengths, thats why
> SDP_SEQ8 is used directly as dtd, so accessing length[i] is always off
> by one.
> 
> Furthermore the length is not really used by sdp_data_alloc_with_length
> when the dtd is SDP_SEQ8 which is probably why it doesn't crash.
> ---
> v2: Fix length typo and add more clear description why this is currently
> not causing a crash.
> 
>  lib/sdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
