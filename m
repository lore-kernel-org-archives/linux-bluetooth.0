Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:11:04 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Set security level to MEDIUM for mcap instances
 created from HDP plugin
Message-ID: <20110323131104.GC7124@jh-x301>
References: <1300882066-7273-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300882066-7273-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 23, 2011, Santiago Carot-Nemesio wrote:
> Some health devices without IO capabilities can't connect to mcap
> instances when security level is set to HIGH. This patch enables
> above devices to connect to Health instances avoiding the MITM
> problem.
> ---
>  health/hdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
