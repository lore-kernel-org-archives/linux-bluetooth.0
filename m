Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Aug 2012 20:46:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 0/4] GATT & ATT cleanups
Message-ID: <20120820174621.GB3976@x220.P-661HNU-F1>
References: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Aug 20, 2012, Claudio Takahasi wrote:
> Minor GATT & ATT cleanups. Requires: "[PATCH BlueZ v0 00/10] GATT
> plugin: Service Changed and MTU exchange"
> 
> Claudio Takahasi (4):
>   att: Add Find Info Response Format constants
>   att: Replace ATT magic number
>   gatt: Return not found if characteritics is empty
>   gatt: Don't raise error if declaration was found
> 
>  attrib/att.h                       |    4 ++++
>  attrib/gatt.c                      |    7 ++++---
>  profiles/gatt/gas.c                |    2 +-
>  profiles/input/hog_device.c        |    2 +-
>  profiles/thermometer/thermometer.c |    2 +-
>  5 files changed, 11 insertions(+), 6 deletions(-)

All patches in this set have been applied. Thanks.

Johan
