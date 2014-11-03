Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 16:04:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mgmt-tester: Fix expected response for invalid start
 discovery tests
Message-ID: <20141103140424.GB9985@t440s.lan>
References: <1415020884-9069-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415020884-9069-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 03, 2014, Szymon Janc wrote:
> According to Management Interface API 'Start Discovery' command should
> generate a Command Complete event on failure.
> ---
>  tools/mgmt-tester.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied. Thanks.

Johan
