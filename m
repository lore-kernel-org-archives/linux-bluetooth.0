Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Dec 2010 00:02:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Keep found LE device list to use when creating a device
Message-ID: <20101229220201.GB20485@jh-x301>
References: <1293657922-17173-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293657922-17173-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 29, 2010, Claudio Takahasi wrote:
> Found devices list should be used to identify device types when
> CreateDevice or CreatePairedDevice are called. During the device
> creation the selected device will be classified as LE device if
> it belongs to the device found list and if the Flags AD type
> matches the GAP requirements. BR/EDR devices don't need to be
> tracked since the default remote device type is Basic Rate.
> ---
>  src/adapter.c |   39 +++++++++++++++++++++++++++++++++------
>  1 files changed, 33 insertions(+), 6 deletions(-)

This patch has also been pushed upstream. Thanks.

Johan
