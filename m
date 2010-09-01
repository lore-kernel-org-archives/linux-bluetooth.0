Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Sep 2010 11:26:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Changes in Health API
Message-ID: <20100901082609.GA4042@jh-x301>
References: <1283326953-2207-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283326953-2207-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 01, 2010, Santiago Carot-Nemesio wrote:
> Connections are made directly to a device and bluetoothd daemon
> guess the PSM connection and the MDEPID based on the data get
> from the SDP record.
> 
> Also a property that indicates the first realiable channel is
> added to the HealthDevice object.
> ---
>  doc/health-api.txt |  119 +++++++++++++++++++++++-----------------------------
>  1 files changed, 53 insertions(+), 66 deletions(-)

Thanks. The patch is now upstream.

Johan
