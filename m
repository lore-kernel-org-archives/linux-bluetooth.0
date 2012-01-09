Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jan 2012 14:53:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] Remove PulseAudio plugin leftover
Message-ID: <20120109125330.GA19918@x220.ger.corp.intel.com>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Dec 30, 2011, Anderson Lizardo wrote:
> The .c file and the configure check were not being used anywhere.
> ---
>  acinclude.m4                  |    6 ------
>  audio/module-bluetooth-sink.c |   39 ---------------------------------------
>  2 files changed, 0 insertions(+), 45 deletions(-)
>  delete mode 100644 audio/module-bluetooth-sink.c

Patches 1, 2 and 4 have been applied. Thanks.

Johan
