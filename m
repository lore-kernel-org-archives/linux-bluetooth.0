Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 16:35:44 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Cleanup of device class update signal
Message-ID: <20110519233544.GC4016@dell.ger.corp.intel.com>
References: <1305814620-8649-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305814620-8649-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, May 19, 2011, Sheldon Demario wrote:
> Adds a new device function to address the PropertyChanged
> signal when the device's class changes. event.c file should
> avoid sending signals that belongs to device objects.
> ---
>  src/device.c |    8 ++++++++
>  src/device.h |    1 +
>  src/event.c  |    9 ++-------
>  3 files changed, 11 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
