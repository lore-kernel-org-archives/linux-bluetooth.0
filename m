Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1279814780-29673-3-git-send-email-ingas@codeaurora.org>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
	<1279814780-29673-3-git-send-email-ingas@codeaurora.org>
Date: Tue, 27 Jul 2010 21:25:02 +0300
Message-ID: <AANLkTi=nW-E8S3ccyutn_LYafmhSXiGY62PVZJ6L2QnX@mail.gmail.com>
Subject: Re: [PATCH 2/5] Support for adding UUID128 to extended inquiry
	response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 22, 2010 at 7:06 PM, Inga Stotland <ingas@codeaurora.org> wrote=
:
> ---
> =A0src/sdpd-service.c | =A0108 ++++++++++++++++++++++++++++++++++++++++++=
++--------
> =A01 files changed, 92 insertions(+), 16 deletions(-)
>
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index cdbb4f4..1314ada 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -49,6 +49,8 @@
> =A0#include "manager.h"
> =A0#include "adapter.h"
>
> +#define SIZEOF_UUID128 16
> +
> =A0static sdp_record_t *server =3D NULL;
>
> =A0static uint16_t did_vendor =3D 0x0000;
> @@ -174,41 +176,103 @@ static void update_svclass_list(const bdaddr_t *sr=
c)
>
> =A0}
>
> +static void eir_generate_uuid128(sdp_list_t *list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 uint8_t *ptr, uint16_t *eir_len)
> +{
> + =A0 =A0 =A0 int i, k, index =3D 0;
> + =A0 =A0 =A0 uint16_t len =3D *eir_len;
> + =A0 =A0 =A0 uint8_t *uuid128;
> + =A0 =A0 =A0 gboolean truncated =3D FALSE;
> +
> + =A0 =A0 =A0 /* Store UUID128 in place, skip 2 bytes to insert type and =
length later */
> + =A0 =A0 =A0 uuid128 =3D ptr + 2;
> +
> + =A0 =A0 =A0 for (; list; list =3D list->next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdp_record_t *rec =3D (sdp_record_t *) list=
->data;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rec->svclass.type !=3D SDP_UUID128)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop if not enough space to put next UUI=
D128 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((len + 2 + SIZEOF_UUID128) > EIR_DATA_L=
ENGTH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 truncated =3D TRUE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for duplicates, EIR data is Little=
 Endian */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < index; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (k =3D 0; k < SIZEOF_UU=
ID128; k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uuid128=
[i*SIZEOF_UUID128 + k] !=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rec->svclass.value.uuid128.data[SIZEOF_UUID128 - k])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D SIZEOF_UUID128=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < index)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR data is Little Endian */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (k =3D 0; k < SIZEOF_UUID128; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uuid128[index*SIZEOF_UUID12=
8 + k] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rec->svclas=
s.value.uuid128.data[SIZEOF_UUID128 - 1 - k];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len +=3D SIZEOF_UUID128;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 index++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (index > 0 || truncated) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data length */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[0] =3D (index * SIZEOF_UUID128) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data type */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D (truncated) ? EIR_UUID128_SOME :=
 EIR_UUID128_ALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *eir_len =3D len;
> + =A0 =A0 =A0 }
> +}
> +

I think you should probably split this in two parts, first update with
the cleanups and then add the code to handle uuid 128.

> =A0void create_ext_inquiry_response(const char *name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0int8_t tx_power, sdp_list_t *services,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0uint8_t *data)
> =A0{
> =A0 =A0 =A0 =A0sdp_list_t *list =3D services;
> =A0 =A0 =A0 =A0uint8_t *ptr =3D data;
> - =A0 =A0 =A0 uint16_t uuid[24];
> + =A0 =A0 =A0 uint16_t eir_len =3D 0;
> + =A0 =A0 =A0 uint16_t uuid16[EIR_DATA_LENGTH/2];
> =A0 =A0 =A0 =A0int i, index =3D 0;
> + =A0 =A0 =A0 gboolean truncated =3D FALSE;
>
> =A0 =A0 =A0 =A0if (name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int len =3D strlen(name);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data type */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (len > 48) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D 48;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D 0x08;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D EIR_NAME_SHORT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D 0x09;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D EIR_NAME_COMPLET=
E;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data length */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptr[0] =3D len + 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(ptr + 2, name, len);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr +=3D len + 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_len +=3D (len + 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr +=3D (len + 2);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (tx_power !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D 2;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D 0x0a;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D EIR_TX_POWER;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (uint8_t) tx_power;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_len +=3D 3;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (did_vendor !=3D 0x0000) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint16_t source =3D 0x0002;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D 9;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D 0x10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D EIR_DEVICE_ID;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (source & 0x00ff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (source & 0xff00) >> 8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (did_vendor & 0x00ff);
> @@ -217,10 +281,10 @@ void create_ext_inquiry_response(const char *name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (did_product & 0xff00) >> 8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (did_version & 0x00ff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ptr++ =3D (did_version & 0xff00) >> 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_len +=3D 10;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ptr[1] =3D 0x03;
> -
> + =A0 =A0 =A0 /* Group all UUID16 types */
> =A0 =A0 =A0 =A0for (; list; list =3D list->next) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdp_record_t *rec =3D (sdp_record_t *) lis=
t->data;
>
> @@ -233,30 +297,42 @@ void create_ext_inquiry_response(const char *name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rec->svclass.value.uuid16 =3D=3D PNP_I=
NFO_SVCLASS_ID)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (index > 23) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D 0x02;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop if not enough space to put next UUI=
D16 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((eir_len + 2 + sizeof(uint16_t)) > EIR_=
DATA_LENGTH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 truncated =3D TRUE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check for duplicates */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < index; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uuid[i] =3D=3D rec->svc=
lass.value.uuid16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uuid16[i] =3D=3D rec->s=
vclass.value.uuid16)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D index - 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i < index)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 uuid[index++] =3D rec->svclass.value.uuid16=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uuid16[index++] =3D rec->svclass.value.uuid=
16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_len +=3D sizeof(uint16_t);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (index > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[0] =3D (index * 2) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data length */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[0] =3D (index * sizeof(uint16_t)) + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* EIR Data type */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ptr[1] =3D (truncated) ? EIR_UUID16_SOME : =
EIR_UUID16_ALL;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptr +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_len +=3D 2;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < index; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D (uuid[i] & 0x00f=
f);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D (uuid[i] & 0xff0=
0) >> 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D (uuid16[i] & 0x0=
0ff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ptr++ =3D (uuid16[i] & 0xf=
f00) >> 8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Group all UUID128 types */
> + =A0 =A0 =A0 if (eir_len <=3D EIR_DATA_LENGTH - 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eir_generate_uuid128(services, ptr, &eir_le=
n);
> =A0}
>
> =A0void register_public_browse_group(void)
> --
> 1.7.1

Also this checks for duplicates looks suspicious, does it really need
to check that in place and every time, I think it might be more
efficient if we do that before generating the EIR data avoiding
comparing data with different endianess or maybe it just make more
sense to not allow duplicates in the database then we don't have to do
this at all.

--=20
Luiz Augusto von Dentz
Computer Engineer
