Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 18:27:33 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add management command for Secure Connection
 Only Mode
Message-ID: <20140202022733.GF5133@x220.p-661hnu-f1>
References: <1391275197-5060-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391275197-5060-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 01, 2014, Marcel Holtmann wrote:
> With support for Secure Connections it is possible to switch the
> controller into a mode that is called Secure Connections Only. In
> this mode only security level 4 connections are allowed (with the
> exception of security level 0 approved services).
> 
> This patch just introduces the management command and setting of the
> right internal flags to enable this mode. It does not yet enforce it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
