Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 13:39:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Subject: Re: [PATCH] network: Check full BNEP UUID
Message-ID: <20120815103912.GA26379@x220>
References: <1343380000-24935-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <1343380000-24935-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jul 27, 2012, Par-Gunnar Hjalmdahl wrote:
> This patch fixes an issue where only the 2 bytes containing
> the service ID was checked from the BNEP UUID.
> Fixes behavior for BT testcases TP/PAN/MISC/UUID/BV-01-C &
> TP/PAN/MISC/UUID/BV-02-C.
> ---
>  profiles/network/server.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 480c7e2..15ea1cb 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -54,6 +54,11 @@
>  #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer"
>  #define SETUP_TIMEOUT		1
>  
> +static uint128_t bluetooth_base_uuid = {
> +	.data = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB}
> +};
> +
>  /* Pending Authorization */
>  struct network_session {
>  	bdaddr_t	dst;		/* Remote Bluetooth Address */
> @@ -313,6 +318,22 @@ static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
>  		break;
>  	case 4: /* UUID32 */
>  	case 16: /* UUID128 */
> +		/*
> +		 * Check that the bytes in the UUID, except the service ID itself, are
> +		 * correct. The service ID is checked in bnep_setup_chk().
> +		 */
> +		if (memcmp(dest, bluetooth_base_uuid.data, 2))
> +			return BNEP_CONN_INVALID_DST;
> +		if (memcmp(source, bluetooth_base_uuid.data, 2))
> +			return BNEP_CONN_INVALID_SRC;
> +
> +		if (req->uuid_size == 16) {
> +			if (memcmp(&dest[4], &bluetooth_base_uuid.data[4], 12))
> +				return BNEP_CONN_INVALID_DST;
> +			if (memcmp(&source[4], &bluetooth_base_uuid.data[4], 12))
> +				return BNEP_CONN_INVALID_SRC;
> +		}
> +
>  		*dst_role = bt_get_be32(dest);
>  		*src_role = bt_get_be32(source);
>  		break;

There are a couple of things that bug me a bit with this patch. One is
the re-definition of bluetooth_base_uuid which really should only exist
in one central place (lib/uuid.c). Another is the way the code logic
goes. It seems you want to test for two things:

	1) That the UUID is a Bluetooth UUID. This is the memcmp with
	the last 12 bytes of the Bluetooth base UUID for the UUID128
	case. 16 and 32 bit values are already implicitly assumed to be
	Bluetooth UUIDs as they don't contain any information to reveal
	this as such.

	2) That the (now determined) Bluetooth UUID has a value less
	than or equal to 0xffff. This is quite awkwardly tested for by
	comparing with the two first bytes from bluetooth_base_uuid,
	which are both zeros. Based on your code comment it sounds like
	this test should really be covered by bnep_setup_chk().

If you really want to have the "<= 0xffff" test be in bnep_setup_decode
then I'd propose something like the attached patch. However, testing for
the exact value of the Bluetooth UUID (once the UUID has been determined
to be a Bluetooth UUID) seems like the task of bnep_setup_chk from the
way you've laid out the functions.

Johan

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-network-Check-full-BNEP-UUID.patch"

>From 52fd85377f6784d69beec0ec7911bdf4b9621077 Mon Sep 17 00:00:00 2001
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Date: Fri, 27 Jul 2012 11:06:40 +0200
Subject: [PATCH] network: Check full BNEP UUID

This patch fixes an issue where only the 2 bytes containing the service
ID was checked from the BNEP UUID. Fixes behavior for BT test cases
TP/PAN/MISC/UUID/BV-01-C & TP/PAN/MISC/UUID/BV-02-C.
---
 profiles/network/server.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 480c7e2..8ae608c 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -301,7 +301,10 @@ static uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role)
 static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
 				uint16_t *dst_role, uint16_t *src_role)
 {
+	const uint8_t bt_base[] = { 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
+				0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB };
 	uint8_t *dest, *source;
+	uint32_t val;
 
 	dest = req->service;
 	source = req->service + req->uuid_size;
@@ -311,10 +314,27 @@ static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
 		*dst_role = bt_get_be16(dest);
 		*src_role = bt_get_be16(source);
 		break;
-	case 4: /* UUID32 */
 	case 16: /* UUID128 */
-		*dst_role = bt_get_be32(dest);
-		*src_role = bt_get_be32(source);
+		/* Check that the bytes in the UUID, except the service ID
+		 * itself, are correct. The service ID is checked in
+		 * bnep_setup_chk(). */
+		if (memcmp(&dest[4], bt_base, sizeof(bt_base)) != 0)
+			return BNEP_CONN_INVALID_DST;
+		if (memcmp(&source[4], bt_base, sizeof(bt_base)) != 0)
+			return BNEP_CONN_INVALID_SRC;
+
+		/* Intentional no-break */
+
+	case 4: /* UUID32 */
+		val = bt_get_be32(dest);
+		if (val > 0xffff)
+			return BNEP_CONN_INVALID_DST;
+		*dst_role = val;
+
+		val = bt_get_be32(source);
+		if (val > 0xffff)
+			return BNEP_CONN_INVALID_SRC;
+		*src_role = val;
 		break;
 	default:
 		return BNEP_CONN_INVALID_SVC;
-- 
1.7.11.2


--HcAYCG3uE/tztfnV--
