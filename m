Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jun 2011 16:37:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Chen Ganir <chen.ganir@ti.com>
Subject: Re: [PATCH] Fixed wrong AVCTP response to unregistered PID
Message-ID: <20110628133716.GA28752@dell.ger.corp.intel.com>
References: <1309260521-9943-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309260521-9943-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Jun 28, 2011, chen.ganir@gmail.com wrote:
> AVCTP response to unregistered PID should consist only from the first
> 3 octets of the AVCTP header, without any additional frame data (Fix
> for PTS certification issue)
> ---
>  audio/control.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

This doesn't apply to upstream git, and in fact upstream already has a
fix for this.

Johan
