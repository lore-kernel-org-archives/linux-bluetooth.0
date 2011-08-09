Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 10:24:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/11] Immediate Alert patches
Message-ID: <20110809072426.GB14581@dell>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Aug 08, 2011, Claudio Takahasi wrote:
> Dependency: none. RSSI threshold monitor patches are not required for
> this patch series.
> 
> Implementation of D-Bus properties and GATT/ATT operations related to
> alert level of the Immediate alert service.
> 
> Bruna Moreira (1):
>   Add read remote Tx Power
> 
> Claudio Takahasi (10):
>   Add Immediate Alert handle discovery
>   Write Immediate Alert if necessary
>   Emit PropertyChanged after writting alert
>   Write Immediate Alert after discovering handle
>   Request connection when writting Immediate alert
>   Reset Immediate Alert after 5 seconds
>   Reset the Immediate Alert at disconnection
>   Set default value for ImmediateAlertLevel
>   Write Immediate Alert if connected
>   Fix wrong alert value for ImmediateAlertLevel
> 
>  proximity/monitor.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 199 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
