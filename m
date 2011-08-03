Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 12:37:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/5] Add Get/Set Property for Link Loss
Message-ID: <20110803093758.GB31600@dell>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 26, 2011, Claudio Takahasi wrote:
> Dependency: "[PATCH] Proximity Monitor implementation (for testing)"
> sent from Anderson Lizardo. Small conflict in proximity/manager.c
> 
> The following patches implement Get/SetProperty for LinkLossAlertLevel
> in the Proximity Monitor. Contains D-Bus methods/signals implementation
> without remote comunication, alert level characteristic value is not
> being written yet.
> 
> Bruna Moreira (1):
>   Add load/store functions for Alert Level
> 
> Sheldon Demario (4):
>   Add set Link Loss Alert Level
>   Add get Link Loss Alert Level
>   Emit a signal when Link Loss Alert Level changes
>   Use device object path on Proximity Monitor
> 
>  proximity/manager.c |   11 +---
>  proximity/monitor.c |  190 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  proximity/monitor.h |    4 +-
>  3 files changed, 177 insertions(+), 28 deletions(-)

This patch-set has also been applied. Thanks.

Johan
