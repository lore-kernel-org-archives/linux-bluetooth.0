Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Nov 2011 12:01:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix response on AT+CHLD=0 in maemo6
Message-ID: <20111102100114.GB2326@fusion.localdomain>
References: <1320223817-7391-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320223817-7391-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Nov 02, 2011, Dmitriy Paliy wrote:
> Currently, +CIEV indicator after AT+CHLD=0 command for one active call,
> one held call, one incoming call scenario is incorrect. callheld=2
> according to HFP 1.5 spec., p.70, means 'Call on hold, no active call'.
> Hence, value 2 cannot be provided in +CIEV if there is an active call.
> ---
>  audio/telephony-maemo6.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
