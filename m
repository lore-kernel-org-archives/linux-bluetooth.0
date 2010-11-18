Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 16:44:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Emit "DeviceFound" signal for LE devices
Message-ID: <20101118144403.GB7811@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
 <1290009593-13658-3-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290009593-13658-3-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Nov 17, 2010, Bruna Moreira wrote:
> The adapter_emit_device_found() function was modified to emit
> DeviceFound signal for LE devices as well.
> ---
>  src/adapter.c |   30 +++++++++++++++++++++++++-----
>  1 files changed, 25 insertions(+), 5 deletions(-)

This patch has also been pushed upstream. Thanks.

Johan
