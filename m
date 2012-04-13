Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 13:29:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH v3 2/2] input: Disconnect SDP before connecting HID if
 HIDSDPDisable is set
Message-ID: <20120413102948.GA18914@x220.ger.corp.intel.com>
References: <1334311903-7218-1-git-send-email-szymon.janc@tieto.com>
 <1334311903-7218-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334311903-7218-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Apr 13, 2012, Szymon Janc wrote:
> If remote HID device has HIDSDPDisable attribute present and set to
> true host should disconnect SDP channel before connecting HID control
> channel. Such devices multiplex resources between SDP and HID L2CAP
> channels and will reject connection to HID control channel if SDP
> channel is already connected.
> ---
>  input/device.c  |   25 +++++++++++++++++++++----
>  input/device.h  |    2 +-
>  input/manager.c |    4 ++--
>  3 files changed, 24 insertions(+), 7 deletions(-)

Both patches have been applied. Thanks.

Johan
