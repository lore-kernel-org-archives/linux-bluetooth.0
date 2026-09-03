Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE012372ECF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423303; cv=none; b=ae1EIS3dOV4VQC7+gYnckDvu6suq+eR2oyUWr7H9WiV/n1gLnjZ4H4TFbjoRlv3XClibLuZP3l81gTaS9LUYUKnQDI/0GgoyEdlvDoXm8o9UkLtbTPgqGFsXcKou9Nefc0qsm58JCguUJDqhYkY0YDKyhJB0MuNSXxxsDXt12og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423303; c=relaxed/simple;
	bh=JfX2RBcjgynaTzCjzbTtx0rTYbWRZp8Ti+QP9Q0IIPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/Vpxxd1Y9RCUHy9a8HEqirNO0fAKyFcLnbR0fXKG3LsrBoMs+lQR5bLV4ri/qkWNb47YmFjECH/xiIEKDI920R8wf2IB/eFvGYn54/+FN4pIEz9Xgor5CWZAQgSoI+p147cO5ttRljahxaQEEzoOf+C2+FiorTo2enBQ4kFsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F7E53EE33;
	Thu,  3 Sep 2026 08:14:57 +0000 (UTC)
Message-ID: <1e1f579d1776b7a137524793d6c0be5277170908.camel@hadess.net>
Subject: Re: [PATCH BlueZ] adapter/advertising: fix mgmt endian bug
From: Bastien Nocera <hadess@hadess.net>
To: Nicolas Thibert <nithibert@gmail.com>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 10:14:56 +0200
In-Reply-To: <CAKA8V_-yO_9hma4fFkSnUpMBMcLP8iHWjfVSjQe-eu+w+FDh_Q@mail.gmail.com>
References: 
	<CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
	 <CABBYNZJTMW_Dg5bpZ9PPitgCOZJ5uKWM_ru9MT1utUcz4uxDaw@mail.gmail.com>
	 <CAKA8V_8B-qfv0OytdvtppF7zSF4j=jJWSERvUbV6dC7Fus9NRA@mail.gmail.com>
	 <CAKA8V_-yO_9hma4fFkSnUpMBMcLP8iHWjfVSjQe-eu+w+FDh_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTEZ9wXwy2ZUctBCDtfNSfxgGQXnk9jgJ1+BLCRomvCK28C2tscuTlcT4aQh51pgUAdE1FqkV/XAcvCKeLNOOX3jeai02pN+tKXNcK4reCX7vjppqht8WH6sGXhIQQ60FVGIVkVKygPmcvUKVg4c2O0YCAXCWCjVk6m0ceDNXGfpw3KBnuZu3UJRMAljrIG4CNcO59jr3NdbvR/TAlxypRq6FAIw7pJWTg/kb5Pe0bPFM7bk56n3OOS3sVbLIsHn0fLhAcV/n6oNo44w+OqIRNqjMhGLV1pjyCB2U61dScX6M8BT1L9eZXix+d4bahBMfk9yaKnRtBxY+uSRDzG4HbKDZSqgD4/b81QXm7wg+eo4bURya5EOlUH5VyjaRyceLoAg9G7MMbrpNKxRxJwhgoqswh8UT5RFVa3kJ+p+QFc9CuOYna5iDcFw55zj66p0OGtazx8AdFtWq8VMgREgJED7oNza5hDWe2aLmczgsYSKo93YcSHbdmPgX8WPedDtblYkbmhAkYdA4tfKEGJ8/ZMOmPchK+3JzOnE3cpeRKZvU/g7rDrNSNEm/CzzLpNvQr/eT2txWzo4T9MJEP2uuzrfL0NYzgYS3TSEGeb3REKYpQdXmFpJ31dKaNezXiEnuFCRKmeYW+HjPD8K0s9sZsQQ0IwnX3CmBjoZBtaQy+AYag
X-GND-State: clean

Hello Nicolas,

I think you'll want to double-check your setup for sending bluez
patches, as there were multiple problems with it.

The canonical documentation for sending patches to kernel mailing-lists
is here:
https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html

1) The subject prefix mentions BlueZ (good) but not v2
2) The "---" in your message will make git stop trying to process the
rest of the mail, so your commit message and patch will be dropped
3) version changelog should go below the "---" that's below the commit
message, this will be dropped by git so that the changelog only appears
on the mailing-list, not in the git repo.
4) your mail client (or website) mangled the patch

Best solution is either to figure out how to set up "git-send-email" or
use a desktop mail client that can take patches without modifying them
(I know that in Evolution, you can drag'n'drop .patch files on the
drafts folder, and set the whole text to "preformatted")

Cheers

On Thu, 2026-09-03 at 09:27 +0200, Nicolas Thibert wrote:
> Hi Luiz it seems the patch didnt apply correctly, here is a corrected
> version
> Regards
> Nicolas
>=20
> ---
> Several places in adapter.c and advertising.c write a native-endian
> value directly into a __le16/__le32 field of an mgmt command struct,
> skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
> else in this codebase for the same purpose. This is a no-op on
> little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
> no-ops), which is why it has gone unnoticed, but corrupts the value
> on
> big-endian hosts.
>=20
> Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
> sends key_count=3D2 (2 blocked keys), which the kernel's
> __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> 0x0200) since the wire bytes were never actually swapped to little-
> endian on the way out -- producing "expected 8706 bytes, got 36
> bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> dmesg/bluetoothd logs.
>=20
> add_advertising()'s cp->duration and refresh_extended_adv()'s
> cp.duration/cp.min_interval/cp.max_interval have the identical bug.
> It
> is inert with bluetoothctl's default (0) duration/interval values (0
> byte-swapped is still 0), but A/B tested live (patch removed vs.
> applied, bluetoothctl's advertise submenu "interval 100 100" set
> explicitly) confirms this is not just a theoretical correctness fix:
> with the bug present, the device stops being discoverable by a real
> BLE scanner the moment a non-default interval is requested, and
> becomes discoverable again immediately once patched. Any application
> that sets an explicit advertising interval or duration hits this.
>=20
> v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
> requested by Luiz. Retested live on the same MIPS big-endian board
> (blocked keys + explicit advertising interval): behaves identically
> to the v1 fix, no regressions.
> ---
> src/adapter.c=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
> src/advertising.c | 8 ++++----
> 2 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/adapter.c b/src/adapter.c
> index 7390ceeee..edbdb53b5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -10219,10 +10219,11 @@ static bool set_blocked_keys(struct
> btd_adapter *adapter)
> sizeof(blocked_keys)] =3D { 0 };
> struct mgmt_cp_set_blocked_keys *cp =3D
> (struct mgmt_cp_set_blocked_keys *)buffer;
> +=C2=A0=C2=A0=C2=A0=C2=A0 const uint16_t key_count =3D ARRAY_SIZE(blocked=
_keys);
> int i;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D ARRAY_SIZE(blocked_keys);
> -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < cp->key_count; ++i) {
> +=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D cpu_to_le16(key_count);
> +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < key_count; ++i) {
> cp->keys[i].type =3D blocked_keys[i].type;
> memcpy(cp->keys[i].val, blocked_keys[i].val,
> sizeof(cp->keys[i].val));
> diff --git a/src/advertising.c b/src/advertising.c
> index 1ed09c902..3f70fb4e9 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1042,7 +1042,7 @@ static int refresh_legacy_adv(struct
> btd_adv_client *client,
>=20
> cp->flags =3D htobl(flags);
> cp->instance =3D client->instance;
> -=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D client->duration;
> +=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D cpu_to_le16(client->duration);
> cp->adv_data_len =3D adv_data_len;
> cp->scan_rsp_len =3D scan_rsp_len;
> memcpy(cp->data, adv_data, adv_data_len);
> @@ -1093,13 +1093,13 @@ static int refresh_extended_adv(struct
> btd_adv_client *client,
> */
>=20
> if (client->duration) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.duration =3D client->duration;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.duration =3D cpu_to_le16(client->duration);
> flags |=3D MGMT_ADV_PARAM_DURATION;
> }
>=20
> if (client->min_interval && client->max_interval) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.min_interval =3D client->min_interval;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.max_interval =3D client->max_interval;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.min_interval =3D cpu_to_le32(client->min_interval);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cp.max_interval =3D cpu_to_le32(client->max_interval);
> flags |=3D MGMT_ADV_PARAM_INTERVALS;
> }
>=20
> --
> 2.34.1
>=20
> Le mer. 2 sept. 2026 =C3=A0 18:07, Nicolas Thibert <nithibert@gmail.com> =
a
> =C3=A9crit :
> >=20
> > Hi Luiz,
> > Ty for your answer, here is a correction
> > Regards,
> > Nicolas
> >=20
> > Several places in adapter.c and advertising.c write a native-endian
> > value directly into a __le16/__le32 field of an mgmt command
> > struct,
> > skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
> > else in this codebase for the same purpose. This is a no-op on
> > little-endian hosts (where cpu_to_le16()/cpu_to_le32() are
> > themselves
> > no-ops), which is why it has gone unnoticed, but corrupts the value
> > on
> > big-endian hosts.
> >=20
> > Confirmed live on MIPS big-endian (OpenWrt/ath79):
> > set_blocked_keys()
> > sends key_count=3D2 (2 blocked keys), which the kernel's
> > __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> > 0x0200) since the wire bytes were never actually swapped to little-
> > endian on the way out -- producing "expected 8706 bytes, got 36
> > bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> > dmesg/bluetoothd logs.
> >=20
> > add_advertising()'s cp->duration and refresh_extended_adv()'s
> > cp.duration/cp.min_interval/cp.max_interval have the identical bug.
> > It
> > is inert with bluetoothctl's default (0) duration/interval values
> > (0
> > byte-swapped is still 0), but A/B tested live (patch removed vs.
> > applied, bluetoothctl's advertise submenu "interval 100 100" set
> > explicitly) confirms this is not just a theoretical correctness
> > fix:
> > with the bug present, the device stops being discoverable by a real
> > BLE scanner the moment a non-default interval is requested, and
> > becomes discoverable again immediately once patched. Any
> > application
> > that sets an explicit advertising interval or duration hits this.
> >=20
> > v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
> > requested by Luiz. Retested live on the same MIPS big-endian board
> > (blocked keys + explicit advertising interval): behaves identically
> > to the v1 fix, no regressions.
> > ---
> > src/adapter.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > src/advertising.c |=C2=A0 6 +++---
> > 2 files changed, 6 insertions(+), 5 deletions(-)
> >=20
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
> > sizeof(blocked_keys)] =3D { 0 };
> > struct mgmt_cp_set_blocked_keys *cp =3D
> > (struct mgmt_cp_set_blocked_keys *)buffer;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const uint16_t key_count =3D ARRAY_SIZE(block=
ed_keys);
> > int i;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D ARRAY_SIZE(blocked_keys);
> > -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < cp->key_count; ++i) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D cpu_to_le16(key_count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < key_count; ++i) {
> > cp->keys[i].type =3D blocked_keys[i].type;
> > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > sizeof(cp->keys[i].val));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < key_count; ++i) {
> > cp->keys[i].type =3D blocked_keys[i].type;
> > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > sizeof(cp->keys[i].val));
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > sizeof(cp->keys[i].val));
> > --- a/src/advertising.c
> > +++ b/src/advertising.c
> > @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
> >=20
> > cp->flags =3D htobl(flags);
> > cp->instance =3D client->instance;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D client->duration;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D cpu_to_le16(client->duration=
);
> > cp->adv_data_len =3D adv_data_len;
> > cp->scan_rsp_len =3D scan_rsp_len;
> > memcpy(cp->data, adv_data, adv_data_len);
> > @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
> > */
> >=20
> > if (client->duration) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.duration =3D client->duration;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.duration =3D cpu_to_le16(client->duration);
> > flags |=3D MGMT_ADV_PARAM_DURATION;
> > }
> >=20
> > if (client->min_interval && client->max_interval) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.min_interval =3D client->min_interval;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.max_interval =3D client->max_interval;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.min_interval =3D cpu_to_le32(client->min_interval);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cp.max_interval =3D cpu_to_le32(client->max_interval);
> > flags |=3D MGMT_ADV_PARAM_INTERVALS;
> > }
> >=20
> > --
> > 2.34.1
> >=20
> > Le mer. 2 sept. 2026 =C3=A0 16:21, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> a =C3=A9crit :
> > >=20
> > > Hi Nicolas,
> > >=20
> > > On Wed, Sep 2, 2026 at 10:19=E2=80=AFAM Nicolas Thibert
> > > <nithibert@gmail.com> wrote:
> > > >=20
> > > > Several places in adapter.c and advertising.c write a native-
> > > > endian
> > > > value directly into a __le16/__le32 field of an mgmt command
> > > > struct,
> > > > skipping the htobs()/htobl() conversion used everywhere else in
> > > > this
> > > > codebase for the same purpose. This is a no-op on little-endian
> > > > hosts
> > > > (where htobs()/htobl() are themselves no-ops), which is why it
> > > > has
> > > > gone unnoticed, but corrupts the value on big-endian hosts.
> > > >=20
> > > > Confirmed live on MIPS big-endian (OpenWrt/ath79):
> > > > set_blocked_keys()
> > > > sends key_count=3D2 (2 blocked keys), which the kernel's
> > > > __le16_to_cpu() correctly interprets as 512 (0x0002 byte-
> > > > swapped is
> > > > 0x0200) since the wire bytes were never actually swapped to
> > > > little-
> > > > endian on the way out -- producing "expected 8706 bytes, got 36
> > > > bytes" / "Failed to set blocked keys: Invalid Parameters"
> > > > errors in
> > > > dmesg/bluetoothd logs.
> > > >=20
> > > > add_advertising()'s cp->duration and refresh_extended_adv()'s
> > > > cp.duration/cp.min_interval/cp.max_interval have the identical
> > > > bug. It
> > > > is inert with bluetoothctl's default (0) duration/interval
> > > > values (0
> > > > byte-swapped is still 0), but A/B tested live (patch removed
> > > > vs.
> > > > applied, bluetoothctl's advertise submenu "interval 100 100"
> > > > set
> > > > explicitly) confirms this is not just a theoretical correctness
> > > > fix:
> > > > with the bug present, the device stops being discoverable by a
> > > > real
> > > > BLE scanner the moment a non-default interval is requested, and
> > > > becomes discoverable again immediately once patched. Any
> > > > application
> > > > that sets an explicit advertising interval or duration hits
> > > > this.
> > > > ---
> > > > src/adapter.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > > > src/advertising.c |=C2=A0 6 +++---
> > > > 2 files changed, 6 insertions(+), 5 deletions(-)
> > > >=20
> > > > --- a/src/adapter.c
> > > > +++ b/src/adapter.c
> > > > @@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct
> > > > btd_
> > > > sizeof(blocked_keys)] =3D { 0 };
> > > > struct mgmt_cp_set_blocked_keys *cp =3D
> > > > (struct mgmt_cp_set_blocked_keys *)buffer;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 const uint16_t key_count =3D ARRAY_SIZE(b=
locked_keys);
> > > > int i;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D ARRAY_SIZE(blocked_keys=
);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < cp->key_count; ++i) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 cp->key_count =3D htobs(key_count);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < key_count; ++i) {
> > > > cp->keys[i].type =3D blocked_keys[i].type;
> > > > memcpy(cp->keys[i].val, blocked_keys[i].val,
> > > > sizeof(cp->keys[i].val));
> > > > --- a/src/advertising.c
> > > > +++ b/src/advertising.c
> > > > @@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd
> > > >=20
> > > > cp->flags =3D htobl(flags);
> > > > cp->instance =3D client->instance;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D client->duration;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 cp->duration =3D htobs(client->duration);
> > > > cp->adv_data_len =3D adv_data_len;
> > > > cp->scan_rsp_len =3D scan_rsp_len;
> > > > memcpy(cp->data, adv_data, adv_data_len);
> > > > @@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct
> > > > b
> > > > */
> > > > if (client->duration) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.duration =3D client->duration;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.duration =3D htobs(client->duration);
> > > > flags |=3D MGMT_ADV_PARAM_DURATION;
> > > > }
> > > >=20
> > > > if (client->min_interval && client->max_interval) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.min_interval =3D client->min_interval;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.max_interval =3D client->max_interval;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.min_interval =3D htobl(client->min_interval);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cp.max_interval =3D htobl(client->max_interval);
> > >=20
> > > Use cpu_to_le** instead of htobl.
> > >=20
> > > > flags |=3D MGMT_ADV_PARAM_INTERVALS;
> > > > }
> > > >=20
> > > > --
> > > > 2.34.1
> > > >=20
> > >=20
> > >=20
> > > --
> > > Luiz Augusto von Dentz
