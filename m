Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Nov 2010 22:11:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash after simultaneous authentication requests
Message-ID: <20101125201156.GA31596@jh-x301>
References: <1290679615-26273-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290679615-26273-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Nov 25, 2010, Rafal Michalski wrote:
> Previously simultaneous authentication requests to the same device caused
> bluetoothd crash. Now if ongoing authentication occurs error is returned,
> preventing from simultaneous requests to the same device.
> ---
>  src/device.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
