Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <977231783.859501433995777721.JavaMail.weblogic@epmlwas05b>
References: <977231783.859501433995777721.JavaMail.weblogic@epmlwas05b>
Date: Thu, 11 Jun 2015 12:54:48 +0300
Message-ID: <CABBYNZK1R6SuXu9wa02kPNB3_=epTCbiXfGvEJDAN5Ck8RY9HQ@mail.gmail.com>
Subject: Re: Fwd: Fwd: [PATCH 1/1] shared/gatt-client: Fix the "Find
 Information req" error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: nagaraj.dr@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nagaraj,

On Thu, Jun 11, 2015 at 7:09 AM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> ping
>
> ------- Original Message -------
> Sender : Nagaraj D R Lead Engineer/SRI-Bangalore-System & Connectivity/Samsung Electronics
> Date : May 15, 2015 11:50 (GMT+05:30)
> Title : Fwd: [PATCH 1/1] shared/gatt-client: Fix the "Find Information req" error
>
> ping
>
> ------- Original Message -------
> Sender : Nagaraj D R Lead Engineer/SRI-Bangalore-System & Connectivity/Samsung Electronics
> Date : May 13, 2015 17:05 (GMT+05:30)
> Title : [PATCH 1/1] shared/gatt-client: Fix the "Find Information req" error
>
> From: "nagaraj.dr"
>
> characteristic descriptor is searched b/w the
> characteristic "value_handle + 1" and
> characteristic "end_handle" using "Find Information req"
>
> if remote device had declared the characteristic value_handle
> at 0XFFFF (which also means there is no characteristic descriptors),then
> present code would make start_handle has 0X0000(because of 16 bit
> integer overflow) for "Find Information req"
>
> desc_start = chrc_data->value_handle + 1;
>
> Consequence:  Below request will be sent,
>         ATT: Find Information req (0x04)
>         start 0x0000, end 0xffff
>
>         and below will be the proper response from the remote device
>         ATT: Error (0x01)
>         Error: Invalid handle (1)
>         Find Information req (0x04) on handle 0x0000
> ---
> src/shared/gatt-client.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 7bc3b71..9b944ee 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -601,13 +601,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
> chrc_data->value_handle)
> goto failed;

Actually this check should happen in
gatt_db_service_insert_characteristic which is probably creating
something with handle 0 in the database which is wrong, actually
perhaps it should just fail to create a characteristic in 0xffff,
characteristics shall always have a value descriptor:

3.3.2 Characteristic Value Declaration
The Characteristic Value declaration contains the value of the
characteristic. It
is the first Attribute after the characteristic declaration. All characteristic
definitions shall have a Characteristic Value declaration.

So I would suggest something like this:

iff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5e1537e..7f863ef 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -706,6 +706,18 @@ service_insert_characteristic(struct
gatt_db_service *service,
        if (handle && handle <= service->attributes[0]->handle)
                return NULL;

+       /*
+        * It is not possible to allocate last handle for a Characteristic
+        * since it would not have space for its value:
+        * 3.3.2 Characteristic Value Declaration
+        * The Characteristic Value declaration contains the value of the
+        * characteristic. It is the first Attribute after the characteristic
+        * declaration. All characteristic definitions shall have a
+        * Characteristic Value declaration.
+        */
+       if (handle == UINT16_MAX)
+               return NULL;
+
        i = get_attribute_index(service, 1);
        if (!i)
                return NULL;

-- 
Luiz Augusto von Dentz
