Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jan 2012 21:41:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add missing "Legacy" property for LE devices
Message-ID: <20120112194155.GC7453@fusion.localdomain>
References: <1326394781-465-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326394781-465-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 12, 2012, Anderson Lizardo wrote:
> Some UIs may assume that a device lacking the Legacy property is
> pre 2.1. To be more consistent with BR/EDR devices, always set Legacy
> property explicitly to False. This makes these UIs not ask for a PIN
> code when doing Just Works pairing for LE devices.
> ---
>  src/adapter.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
