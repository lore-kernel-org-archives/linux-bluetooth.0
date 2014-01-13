Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jan 2014 10:48:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: Fix build error in seq2bseq
Message-ID: <20140113084845.GE27885@x220.p-661hnu-f1>
References: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1389600554-20669-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jan 13, 2014, Szymon Janc wrote:
> Don't ignore return value of write. This fix following build error on
> Ubuntu:
> 
> tools/seq2bseq.c: In function ‘convert_line’:
> tools/seq2bseq.c:52:8: error: ignoring return value of ‘write’,
>      declared with attribute warn_unused_result [-Werror=unused-result]
>    write(fd, &val, 1);
> ---
>  tools/seq2bseq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
