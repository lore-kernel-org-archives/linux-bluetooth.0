Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Oct 2012 16:45:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib: Get address type using gatt_get_address()
Message-ID: <20121002134536.GA22185@x220>
References: <1349182220-525-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349182220-525-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 02, 2012, Anderson Lizardo wrote:
> This avoids a separate call to device_get_addr_type().
> ---
>  attrib/client.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied. Thanks.

Johan
