Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2015 10:36:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] emulator/bthost: Add support for setting custom ADV
 data
Message-ID: <20150517073650.GA28324@t440s.P-661HNU-F1>
References: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431600630-8568-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, May 14, 2015, Szymon Janc wrote:
> This allows to set any ADV data and not just flags.
> ---
>  android/tester-main.c | 13 +++++++++++--
>  emulator/bthost.c     | 35 +++++++++++++++++------------------
>  emulator/bthost.h     |  5 +++--
>  tools/l2cap-tester.c  |  2 +-
>  tools/mgmt-tester.c   |  2 +-
>  tools/smp-tester.c    |  2 +-
>  6 files changed, 34 insertions(+), 25 deletions(-)

All three patches have been applied. Thanks.

Johan
