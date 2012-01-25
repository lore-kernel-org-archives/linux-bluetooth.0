Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327485790-26249-4-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
	<1327485790-26249-2-git-send-email-sancane@gmail.com>
	<1327485790-26249-3-git-send-email-sancane@gmail.com>
	<1327485790-26249-4-git-send-email-sancane@gmail.com>
Date: Wed, 25 Jan 2012 07:01:46 -0400
Message-ID: <CAJdJm_OK8Xg-BaJsYzJRZP46fQN4vDTTZO6vo9dFMNpwbeHozw@mail.gmail.com>
Subject: Re: [PATCH 3/8] gatt-service: Provide service uuid in
 attrib_db_find_avail function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Jan 25, 2012 at 6:03 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> @@ -436,8 +440,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
>        int len;
>
>        btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
> -
> -       start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
> +       bt_uuid128_create(&uuid, prim_weight_uuid_btorder);
> +       start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
>        if (start_handle == 0) {
>                error("Not enough free handles to register service");
>                return;

This is still not right. bt_uuid128_create() should receive a
uint128_t in *host* order. In other words, you need to do:

uint128_t prim_weight_uuid;
...
btoh128(&prim_weight_uuid_btorder, &prim_weight_uuid);
bt_uuid128_create(&uuid, prim_weight_uuid);
...

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
