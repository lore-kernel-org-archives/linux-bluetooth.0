Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 11:58:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH] input: Disconnect SDP before connecting HID if
 HIDSDPDisable is set
Message-ID: <20120413085810.GA10234@x220.ger.corp.intel.com>
References: <1334242354-10942-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334242354-10942-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Apr 12, 2012, Szymon Janc wrote:
> If remote HID device has HIDSDPDisable attribute present and set to
> true host should disconnect SDP channel before connecting HID control
> channel. Such devices multiplex resources between SDP and HID L2CAP
> channels and will reject connection to HID control channel if SDP
> channel is already connected.
> ---
>  input/device.c   |   25 +++++++++++++++++++++----
>  input/device.h   |    2 +-
>  input/manager.c  |    4 ++--
>  src/sdp-client.c |   21 ++++++++++++++++++++-
>  src/sdp-client.h |    1 +
>  5 files changed, 45 insertions(+), 8 deletions(-)

The patch looks good but could you please split it up so that the
sdp-client changes are in its own patch. Thanks.

Johan
