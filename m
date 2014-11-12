Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Nov 2014 11:25:02 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 05/11] shared/gatt-server: Implement "Read Blob"
 request.
Message-ID: <20141112092500.GB10185@aemeltch-MOBL1>
References: <1415639247-14320-1-git-send-email-armansito@chromium.org>
 <1415639247-14320-6-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415639247-14320-6-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Nov 10, 2014 at 09:07:21AM -0800, Arman Uguray wrote:
> This patch implements the "Read Blob" request for the GATT server role.
> ---
>  src/shared/gatt-server.c | 100 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 15 deletions(-)
> 

...

> +static void read_blob_cb(uint8_t opcode, const void *pdu,
> +					uint16_t length, void *user_data)
> +{
> +	struct bt_gatt_server *server = user_data;
> +	uint16_t handle, offset;
> +
> +	if (length != 4) {
> +		uint8_t pdu[4];

Can we avoid shadowing variables without any need?
This unfortunately became common practice for gatt code.

Best regards 
Andrei Emeltchenko 

