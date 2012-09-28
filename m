Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:17:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 2/2] hog: Add support for multiple instances
Message-ID: <20120928111719.GF14450@x220>
References: <1348083222-15294-1-git-send-email-claudio.takahasi@openbossa.org>
 <1348083222-15294-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348083222-15294-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Sep 19, 2012, Claudio Takahasi wrote:
> This patch adds support for multiple HID services instances exposed by
> the same remote device.
> ---
> 
>  *** Apply after "[PATCH BlueZ v2 0/6] HoG Suspend/Resume" series
> 
>  profiles/input/hog_device.c  | 90 +++++++++++---------------------------------
>  profiles/input/hog_device.h  |  3 +-
>  profiles/input/hog_manager.c | 41 ++++++++++++--------
>  3 files changed, 48 insertions(+), 86 deletions(-)

Patch 1/2 has been applied but this 2/2 doesn't apply even though I did
already push the HoG Suspend/Resume patches upstream. Please fix and
resend.

Johan
