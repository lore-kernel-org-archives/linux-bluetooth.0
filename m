Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 10:08:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix EIR parsing in evt_le_advertising_report_dump
Message-ID: <20111010070811.GA4094@fusion.localdomain>
References: <1317768907-24106-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317768907-24106-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Oct 04, 2011, Andre Guedes wrote:
> Only the first EIR data structure from the LE advertising report
> event is dumped. This patch fix this, so all EIR data structure
> present in that event is dumped.
> ---
>  parser/hci.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
