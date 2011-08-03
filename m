Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 12:38:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/6] Proximity configs and LinkLoss alert write
Message-ID: <20110803093848.GC31600@dell>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
 <1311864173-16118-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311864173-16118-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 28, 2011, Claudio Takahasi wrote:
> Dependency: "[PATCH BlueZ 0/5] Add Get/Set Property for Link Loss"
> 
> Changes from the last series: ref counting inside Proximity Monitor based
> on the feedbacks/comments in the ML.
> 
> The following patches implement the configuration file to allow
> disabling Proximity Monitor services and Find Me. First patch using
> attio connection callback registration mechanism to write Link Loss
> Alert level.
> 
> Anderson Lizardo (1):
>   Proximity Monitor: Write Alert Level to Reporter
> 
> Claudio Takahasi (5):
>   Add Tx Power and Immediate Alert UUID
>   Add config file for proximity monitor
>   Match probed UUIDs and enabled services
>   Return an error if LinkLoss is disabled
>   Return LinkLossAlertLevel if enabled
> 
>  Makefile.am              |    4 +-
>  proximity/main.c         |   30 ++++++++++++-
>  proximity/manager.c      |   52 ++++++++++++++++++++--
>  proximity/manager.h      |    2 +-
>  proximity/monitor.c      |  109 ++++++++++++++++++++++++++++++++++++++++++++-
>  proximity/monitor.h      |    9 +++-
>  proximity/proximity.conf |    9 ++++
>  7 files changed, 202 insertions(+), 13 deletions(-)
>  create mode 100644 proximity/proximity.conf

This patch-set has also been applied. Thanks.

Johan
