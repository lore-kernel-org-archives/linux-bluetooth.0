Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 17:58:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Fix sending unneeded property change signals
Message-ID: <20140321155850.GA1986@t440s.P-661HNU-F1>
References: <1395414394-32126-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395414394-32126-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Mar 21, 2014, Szymon Janc wrote:
> Send property change for Modalias only if it changed. This fix sending
> multiple unneeded property change events during discovery.
> ---
>  src/device.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied. Thanks.

Johan
