Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Mar 2014 10:32:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [PATCH BlueZ v1 02/15] gatt: Add helper for creating GATT
 characteristics
Message-ID: <20140313083204.GB8329@localhost.P-661HNU-F1>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394641631-1534-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394641631-1534-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Mar 12, 2014, Claudio Takahasi wrote:
> --- a/src/gatt.c
> +++ b/src/gatt.c
> @@ -40,6 +40,9 @@
>  static const bt_uuid_t primary_uuid  = { .type = BT_UUID16,
>  					.value.u16 = GATT_PRIM_SVC_UUID };
>  
> +static const bt_uuid_t chr_uuid = { .type = BT_UUID16,
> +					.value.u16 = GATT_CHARAC_UUID };
> +
>  struct btd_attribute {
>  	uint16_t handle;
>  	bt_uuid_t type;
> @@ -50,6 +53,11 @@ struct btd_attribute {
>  static GList *local_attribute_db;
>  static uint16_t next_handle = 0x0001;
>  
> +static inline void put_le16(uint16_t val, void *dst)
> +{
> +	put_unaligned(cpu_to_le16(val), (uint16_t *) dst);
> +}

This helper should go to shared/util.h

Johan
