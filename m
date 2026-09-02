Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F8247280
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357664; cv=pass; b=dv7ru2OkPagpDtHF3wV+e58PxDM0cU+FpfRHei23mLHgLaetlIP+G4lrHPwSOTYnpKd00jfwQqa5SfyIMoIsL8njdZM78zdSYAVCM4he4C7WetRyqNRxBIcv4zLzZputD7lV4yj6V05vvAVbRyqjsz/GlZZgyxGpAVeI2fXB/fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357664; c=relaxed/simple;
	bh=13eXiadm3DRzQBlWqIFmfnknITG5D9T6dF/zFRkb9KU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o08WX/UttKU/LqBIbHDvG53xHbfCPJcbzUx3QS+6p6DxCTfZId8T3VI0ZSdlj2a2bspY61Ke5FQUTfWLtiaTurfciFQ5oFqffVmZXbdE0cqrKWQF+tI9Gus/R6umTouQrwNJjR/I8hvk5tfJXpR57b2MakW6KIzuNPHywYwttis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/gX84hz; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/gX84hz"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66f883abfdcso1221800d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 07:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788357661; cv=none;
        d=google.com; s=arc-20260327;
        b=YIH9U/Gdzgz9AQhpp0PV+LlQz0qJV6dUpjKacSKb21zwNJv+UXz09/cV5N/dXle/lx
         vWODvG69LPnzYM9pF+o4m8d1nlbCWO1qVeLLogsOsQljHnVB3wEnuv/53S/cSqEQVzxH
         1EtjdINmLPwF2braA9jKA+kczt+TAQkKnxXj1+p81CJXU5sY8NdaVMPOcwmJv6NfdOU0
         y3YaRB25cRRwLHMB9SsiLDlfH+KICLP/z6z4RNf3pUZTNaB8lLRDSGGXCDNrNfF2cmrY
         iiZ+HkPDuwRau2mz3brABqzzP0tyaOGdN9AztLBkYeUhyLAo4V3dS0ok4b9FmzU18G4j
         TgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=45ceB+KqJ1OusQIjk9MQr4WAjodYbVVY9fXljaQUNU4=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=SI4CAWr1LG6/HChrspXsika5HzcxsRZz4tpExXCu0KzILMP7aDYx+J19IztmG6ooJV
         WZmLPw0KA2FqmzFAXKI2j77fdFKP2lSgP7RQXd/uvrNAIDsbRHoe8duW4TKdkIeIQ5mk
         KFVtDMEGfoDK3+hcR2cFvOZgwVGYVpi38wXuInHa3JRKjoGwzdnIXbIVVLo71v+I56WF
         eZ1QIiee4KrmC+JQd47j4D7b2slrbuzUnxsCnTKf+MqPZ0R1PNbm50vZykYU+f3bvRwc
         v9iCUA6fw6fu2xtreaSwNNh0zIN47Q+04jvnDC/6B1cq7GUyuBcFfmnQkAgmcCQ8r3N0
         wUJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357661; x=1788962461; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=45ceB+KqJ1OusQIjk9MQr4WAjodYbVVY9fXljaQUNU4=;
        b=G/gX84hz3vZru7/yfudQn6JmdVLBx93j2TxZMdwE9zm+EUAbA3HQDnkcOztXbeWqfg
         2u62MwqUcYch1vs0hqsq5LqYyXTcG2YNxG8p4aYHVWcNmMbOjV2O3Lrkidcmu43N7QVM
         6Ms+5XDhcIg4Y0/qRYCTqfIUagw8o49qleWw6w1HV3vybQS88RjgcnI14QMCB9NwjX7Q
         cyfE5pEefumHNp9ThELk3uVoaitrm5dorjpTWUbGHTGVh8WGlLK8NcM8k/4LmaMuNVCv
         pTR/xYY/YSsql8YwAT5eVJa9vD2ldxgEgdtpO2Yojat+AP/fQj2JsI86do+qb3dku+VN
         sBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357661; x=1788962461;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45ceB+KqJ1OusQIjk9MQr4WAjodYbVVY9fXljaQUNU4=;
        b=TUKQ2LleuutIe15GwQ9R3eFuS2k6rjzzfMobgVShd3FF8VSZJpMkGjRsNQmU+w5aEE
         7n5KERGdIzsi0S3Npj74K2kd0k7+8qbCRmIhVCQS2U3P/dsBz8E66Ew14wZt+JqNdVxW
         chZQTM6e1SUylcxTiktkJMpmq36D3EPytRGId6zB/Uq9Vkr3KJu1qxn5PW14RccMo244
         lGvZW+dQuBYLupQocUgtabCiCpKw0lQ/fr4FLdFYQc6E7aGCrAsw4cuwMNQ54YLlLWjU
         Xbd4DdjutRBzp81vOEVGHk3Q5j043pUQrITaOsXx8oBHASo0sO/eZsV7fXG7VKwcf6xZ
         pLaQ==
X-Gm-Message-State: AFuF++lMB//YDWhKbHbZm1p3aK+VG/KB/jA9SRUdRg07pQenxipvQmZb
	HlvsPr/5oQUk/GhezccN1oPy4PetAp0RhD8ooBFAMUt6nADmAyua1KAvxqdPlE9OiMTUYylPm13
	Fmc+4EfikB+pQhIIrhAqMBVWgT25r00Mq9TdptMM=
X-Gm-Gg: AYBFou0leitNxVwkO1nxqAe0KAVvEEAQNPCHthVSU04lmgUiIP25SMqWgWvEJBcgQqP
	MlQCBl17mT/ZOpxTKOIXfRGBemEbKGa7ufn4QE8U5f/nar0DioZJMFLzSyjczZuxT7TUhKMzTDL
	qCQF1FZaqRmmELlmiMlg7fPElnySqdPTxzv6kMgQWKt183LEeYOElCe3L9H3TH0Z8EdXa54Mzth
	mcadhR+YBlgKh5eaKHBFM89ocWYnnwZBy4/ELSR9eemaoPKQP8ggBaLPxdZWDGUKtWjG8UtYGyv
	QUlyn/maUeZ2xj05MGcgZaQclSQ3RFdgoZZxY7S+Bmln3ntVOWWo9R3C+NFw8mqzrgSR+QHqXpx
	IfnpUv9pP5POHwa0cAjXSpNE4rHrEn2nY6Tc=
X-Received: by 2002:a53:b710:0:b0:66e:3d51:1e86 with SMTP id
 956f58d0204a3-66f9bba355emr1277280d50.14.1788357660594; Wed, 02 Sep 2026
 07:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicolas Thibert <nithibert@gmail.com>
Date: Wed, 2 Sep 2026 16:00:48 +0200
X-Gm-Features: AcwNN1XGKoiCKR4Lep-ccQhwCvBUz3cWff_B_G9oGF7m76rET2Z-_za4RgZAVSg
Message-ID: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
Subject: [PATCH BlueZ] adapter/advertising: fix mgmt endian bug
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several places in adapter.c and advertising.c write a native-endian
value directly into a __le16/__le32 field of an mgmt command struct,
skipping the htobs()/htobl() conversion used everywhere else in this
codebase for the same purpose. This is a no-op on little-endian hosts
(where htobs()/htobl() are themselves no-ops), which is why it has
gone unnoticed, but corrupts the value on big-endian hosts.

Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
sends key_count=2 (2 blocked keys), which the kernel's
__le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
0x0200) since the wire bytes were never actually swapped to little-
endian on the way out -- producing "expected 8706 bytes, got 36
bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
dmesg/bluetoothd logs.

add_advertising()'s cp->duration and refresh_extended_adv()'s
cp.duration/cp.min_interval/cp.max_interval have the identical bug. It
is inert with bluetoothctl's default (0) duration/interval values (0
byte-swapped is still 0), but A/B tested live (patch removed vs.
applied, bluetoothctl's advertise submenu "interval 100 100" set
explicitly) confirms this is not just a theoretical correctness fix:
with the bug present, the device stops being discoverable by a real
BLE scanner the moment a non-default interval is requested, and
becomes discoverable again immediately once patched. Any application
that sets an explicit advertising interval or duration hits this.
---
src/adapter.c     |  5 +++--
src/advertising.c |  6 +++---
2 files changed, 6 insertions(+), 5 deletions(-)

--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9938,10 +9938,11 @@ static bool set_blocked_keys(struct btd_
sizeof(blocked_keys)] = { 0 };
struct mgmt_cp_set_blocked_keys *cp =
(struct mgmt_cp_set_blocked_keys *)buffer;
+     const uint16_t key_count = ARRAY_SIZE(blocked_keys);
int i;

-     cp->key_count = ARRAY_SIZE(blocked_keys);
-     for (i = 0; i < cp->key_count; ++i) {
+     cp->key_count = htobs(key_count);
+     for (i = 0; i < key_count; ++i) {
cp->keys[i].type = blocked_keys[i].type;
memcpy(cp->keys[i].val, blocked_keys[i].val,
sizeof(cp->keys[i].val));
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -995,7 +995,7 @@ static int refresh_legacy_adv(struct btd

cp->flags = htobl(flags);
cp->instance = client->instance;
-     cp->duration = client->duration;
+     cp->duration = htobs(client->duration);
cp->adv_data_len = adv_data_len;
cp->scan_rsp_len = scan_rsp_len;
memcpy(cp->data, adv_data, adv_data_len);
@@ -1046,13 +1046,13 @@ static int refresh_extended_adv(struct b
*/
if (client->duration) {
-             cp.duration = client->duration;
+             cp.duration = htobs(client->duration);
flags |= MGMT_ADV_PARAM_DURATION;
}

if (client->min_interval && client->max_interval) {
-             cp.min_interval = client->min_interval;
-             cp.max_interval = client->max_interval;
+             cp.min_interval = htobl(client->min_interval);
+             cp.max_interval = htobl(client->max_interval);
flags |= MGMT_ADV_PARAM_INTERVALS;
}

--
2.34.1
