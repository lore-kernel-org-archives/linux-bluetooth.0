Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 00:04:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Add device type to identify LE, BR/EDR or dual
 mode devices
Message-ID: <20101207220435.GB30099@jh-x301>
References: <AANLkTinFBtVhu0j6xcHsH6XQZM8J-UeHSG2fOJJ-otcJ@mail.gmail.com>
 <1291757440-15217-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291757440-15217-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Dec 07, 2010, Claudio Takahasi wrote:
> If EIR Flags field is sent in the advertising data, it can be used
> to detect the operation mode. If the remote device is dual mode,
> GAP operation mode defines that it shall follow the connectable
> mode for BR/EDR and non-connectable mode for LE. This patch forces
> service discovery protocol prior to Discover All Primary Services.
> ---
>  src/adapter.c |   55 +++++++++++++++++++++++++++++++++++++++----------------
>  src/adapter.h |    3 ---
>  src/device.c  |   12 ++++++------
>  src/device.h  |   11 +++++++++--
>  4 files changed, 54 insertions(+), 27 deletions(-)

Thanks for these updates. I've now pushed all five patches (v2 of 1-3)
upstream.

Johan
