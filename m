Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 16:22:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix remove device alias when bonding deleted
Message-ID: <20110614132204.GA6542@dell.ger.corp.intel.com>
References: <1308051014-23998-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308051014-23998-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Jun 14, 2011, Dmitriy Paliy wrote:
> Device alias is removed together with bonding information, such that
> new pairing does not reuse old name. This is useful in cases when
> name of paired device was changed after it was ones deleted.
> ---
>  src/device.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
