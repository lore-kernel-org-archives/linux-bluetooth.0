Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 17:36:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Set primary services before probing
Message-ID: <20110714143641.GA26341@dell.ger.corp.intel.com>
References: <1310497809-19636-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310497809-19636-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Jul 12, 2011, Claudio Takahasi wrote:
> Fix accessing primary services data in the probing function of GATT
> based plugins.
> ---
>  src/adapter.c |    6 ++++--
>  src/device.c  |    9 ++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
