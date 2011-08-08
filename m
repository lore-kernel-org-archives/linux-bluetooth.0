Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 13:21:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] Add Proximity Monitor properties
Message-ID: <20110808102148.GA14171@dell>
References: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 03, 2011, Claudio Takahasi wrote:
> Proximity API simplification patch is now upstream. The following patches
> are implementing get properties(ImmediateAlertLevel and SignalLevel) and
> set property(ImmediateAlertLevel).
> 
> ImmediateAlertLevel will be used by Path Loss and Find Me. SignalLevel is
> emitted by Proximity Monitor when Path Loss enabled and tracking the RSSI
> threshold alerts.
> 
> Claudio Takahasi (3):
>   Add set Immediate Alert for Proximity Monitor
>   Add get Immediate Alert for Proximity Monitor
>   Add get Path Loss RSSI signal level
> 
>  proximity/monitor.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 49 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
