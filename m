Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 16:42:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] android/hid: Fix not cleanup properly after
 disconnect
Message-ID: <20131030144252.GA4076@x220.p-661hnu-f1>
References: <1383143094-21262-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383143094-21262-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 30, 2013, Luiz Augusto von Dentz wrote:
> If the device is disconnected it should be removed from the list of
> connected devices and free its data.
> ---
> v2: Keep call to g_io_channel_shutdown

Applied. Thanks.

Johan
