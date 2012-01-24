Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327403188-21981-4-git-send-email-sancane@gmail.com>
References: <1327403188-21981-1-git-send-email-sancane@gmail.com>
	<1327403188-21981-2-git-send-email-sancane@gmail.com>
	<1327403188-21981-3-git-send-email-sancane@gmail.com>
	<1327403188-21981-4-git-send-email-sancane@gmail.com>
Date: Tue, 24 Jan 2012 08:18:27 -0400
Message-ID: <CAJdJm_PeBExYR-J73p9AKO=W5n3f=sQvKUHNpmi5OQE-SQOF5w@mail.gmail.com>
Subject: Re: [PATCH 3/8] gatt-service: Provide service uuid in
 attrib_db_find_avail function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 24, 2012 at 7:06 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> We need to provide the service uuid because of GATT server should group
> 16-bit uuid services together and 128-bit uuid services together,
> (Bluetooth 4.0, Vol 3, Part G, 3.1).
> ---
>  attrib/gatt-service.c  |    2 +-
>  plugins/gatt-example.c |   16 ++++++++++------
>  proximity/reporter.c   |    9 ++++++---
>  src/attrib-server.c    |    3 ++-
>  src/attrib-server.h    |    3 ++-
>  5 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
> index d00adb0..b27e525 100644
> --- a/attrib/gatt-service.c
> +++ b/attrib/gatt-service.c
> @@ -436,8 +440,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
>        int len;
>
>        btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
> -
> -       start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
> +       bt_uuid128_create(&uuid, char_weight_uuid_btorder);
> +       start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
>        if (start_handle == 0) {
>                error("Not enough free handles to register service");
>                return;

This is wrong. You are using a *characteristic* UUID as a service
UUID. This example weight service is 16-bit, but it is has one 128-bit
characteristic.

BTW, 16-bit vs. 128-bit characteristic grouping is optional as per
page 1897 (section 3.3.1 "Characteristic Declaration").

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
