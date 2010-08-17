Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 17:30:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH v2 1/2] Bluetooth: Option to enable power management
 from host
Message-ID: <20100817143043.GA19862@jh-x301>
References: <1281681408-27376-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281681408-27376-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 13, 2010, Suraj Sumangala wrote:
> This provides a new option for hciattach to enable hardware specific
> power management from host.
> This option by default will be disabled for existing devices
> ---
>  tools/hciattach.8 |   13 ++++++++
>  tools/hciattach.c |   88 ++++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 76 insertions(+), 25 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
