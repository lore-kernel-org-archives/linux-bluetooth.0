Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Mar 2015 10:10:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Add simple version of Read Advertising
 Features command
Message-ID: <20150315081000.GC27545@t440s.P-661HNU-F1>
References: <1426391605-20983-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426391605-20983-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 14, 2015, Marcel Holtmann wrote:
> This adds support for the simplest possible version of Read Advertising
> Features management command. It allows basic testing of the interface.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 11 +++++++++++
>  net/bluetooth/mgmt.c         | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
