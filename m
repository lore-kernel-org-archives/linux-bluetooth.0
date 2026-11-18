Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011304;
	b=B9D8GMOZMaDUK18RnGa/MPnpWxtM0de77WWol7sDi67jboy6xSpUK+fc1aAvFxYlyaqQ
	 eG4KcAIYVVnDp8UmUQN1vZl6NSfAKj+BB83J784XhQI+2p6KRpZTIv4/gxiyHrppICSYA
	 41T60UWxe4xRK+ekMAp2H16VsPDQflp2Iet9Acn4kAHkgiK+neE8dqjo54NNHnTH18Uww
	 W63nLOFe6HyLcQrnBeCystXIuoxiDHI9SA+If5+m2YtefwmHkgfdsDhiCFkSXf+Wy4KuL
	 kH4PkZNnjvFKnFRHJuoi0sFWnPkxRnjBSsKdkAlKksIR5kerq08D/Nx9B7EHQiP6i9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lZ6AShP0Kspp5d6dcxp75J7eB0btS6RfbY3iToflvaI=;
	b=OQYvIO1gcArXgpIxwD6sDpdLnthgBY5HqCjwYlSIlGvd8I/qHvk9CJfmhtZteccXtq6o
	 OPrSsnoxxwfh+Qvphrb7mO1jNKw4pdvk22+Z2Ue9VkKUO8iHUfvbcw1s/2yk5Dm7JxFmJ
	 UU5RgUHH2tO9o0fDrC5HJq9HzQFPO4XtenBbChoxfL6F6xJr1dPIoXQ3Ww4GUWDaaNIgY
	 xtw0//zC6LWvQOTbQ09L4m4P16kCAvXfcwjY5AabRU1MCgAhyTMjevmLq7VD37/Uag0LU
	 jC7aohzC5YIEL0Nnzk/nAlH1PJWGQPG0CacS4u1t7MpSz+GqIy+1xBLSjko9i5JSfxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYcFPjTn;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3A60A2603
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBF3A60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYcFPjTn
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so686929f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011301; x=1795616101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZ6AShP0Kspp5d6dcxp75J7eB0btS6RfbY3iToflvaI=;
        b=DYcFPjTn91S+MDJF/rob3MeBQB3vm1V0q08ESwvAmmGNywcq1zavAGqhXyrzQE1dyH
         C4XYb0bvySI13jwG79JgIuN46la42f7nXkc3m9A+rpH3AuOR+dj8b1BzgbHC+VBf7sjN
         w4/xTTHfFgtGSZmRPP7ZaOEH0eDe/SYti21AftCX86MlSUhdiDIRl3V0EM+Z4DFqqt11
         STICT6mzKuao6TDWPhE2r0y4jjiq0AXYxhPiWfvXM8GsIAtWR/ayLHjG2ADShBfQDeD3
         PedFIwQ+8cBuFYc1OuqATMYguUi8VtBB2dQp3lcjgh2Ik7sH+/b4gLLC9l3LkG1GyzzV
         RX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011301; x=1795616101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZ6AShP0Kspp5d6dcxp75J7eB0btS6RfbY3iToflvaI=;
        b=D4BFo9ijotGWyKkr4Xtrzziy7UhZ5micPOxUDlHhbRgi4OUDcHKc8tX85pNfciMK6T
         m38+2d8hfXBXP59VBXNkIzmL9rviLnuu5Tb3Cp4y4kePA+JTgCvRbF2b6h5SZuIycfBy
         5r5YiyvUT5v93Qb2bJEaHfbhLtkLoZL5HeSDqjvAB7T+jjNy55OHoOS6s5V2q8FEwGOR
         dIAxrQBjPcnLv0oJzY1vPE0phYy98u6pdWJhkwIPkR0ORPmxTKumtsX+VR9YN3EmMg8C
         1vlGoQhM6htzgYDlthHs9XcUQCf/GjBaQc061I0AxHKsy1g+MzBcL79RJbyMGIQVwcNK
         ssEg==
X-Gm-Message-State: APuU4Z9Fr7KOIL9zdYmzFAakqFWskf+8eJUeKFMG0s7FHg4DVRfPLuV6
	p4dJ9B6/oiNBKSVCg/jkx6LNwwrFC8g0dIhDCFeJLwj7e8rscOi7LqSpT6uBnFhqw0I=
X-Gm-Gg: AYBFou22gse26WsWTvvoiDh76Xd+qJNJE2hNLnX6kYUEacSK+hVIwdVjot8Q4405Jof
	PHgWC+e+HusKVFbFpB4kE2S40y350MqKztOqC6g+3K946fFepJgeI0tvqAF5OFB1a0HHcM3N5+U
	KE9G2nM2POmz0TIolg7KqNZeBx1HsmdKkptbjrUQOfKoqX6LMQhiaR33WaY6tFfaSeZgiik/FEO
	bNnpxos+SSidW380GfiUrjQCvCD7fycHkFJjx2ZTVE5k3IyI3RnIPGqbThWMDjjGuyHD4ykffYu
	0mDNkPaLfeIsXme0U0VE5C1dCM8Oo+l4bw/Xv1g6oLUVm0dMrPd4+G7dSqhWalynlKJV+rrE/f2
	K21Nn3cQPkR6ux0roCHAPPk7SUjTm/2ZAP45jZvizBIBq2i0ERj/Q06EEP6Xppx9N2klEeE/OKM
	lzlH54FipIQ/pruDlgW9m/r7vC3id8gvyj5lbotU/jXsHzxG66zQKqZBE3fvuzI0ThQBf5/qsXX
	J04nSmK3iPd4pTrGOBZq/b++7s4Lwg6uXAnrD4lJbka2/bL6I1tOBWYIb50vtPWMKF9YauHRaGu
	PIwfvirzrxQcl7NOg1mBM2zS0Cvlj4eCy2qQFqbXecwFAurrAM8p
X-Received: by 2002:a05:600c:1f84:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4bb7da236c3mr49491265e9.24.1795011301069;
        Wed, 18 Nov 2026 06:15:01 -0800 (PST)
Received: from localhost.localdomain ([197.119.251.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e588884sm20894275e9.2.2026.11.18.06.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:15:00 -0800 (PST)
From: AuthenticSm1les <khidarlaminehamdi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: AuthenticSm1les <khidarlaminehamdi@gmail.com>
Subject: [PATCH BlueZ 1/2] profile: Add paired_only flag
Date: Wed, 18 Nov 2026 17:14:37 +0300
Message-ID: <20261118141438.308232-2-khidarlaminehamdi@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118141438.308232-1-khidarlaminehamdi@gmail.com>
References: <20261118141438.308232-1-khidarlaminehamdi@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some profiles talk to remote services that need an encrypted link.
When an unpaired device connects to us, for example a phone checking a
GATT advertisement, those profiles still get probed, their reads fail
with Insufficient Authentication and bt_att bumps the security level.
The phone then pops up a pairing request the user never asked for.

Add a paired_only flag to btd_profile. service_accept() skips such
profiles unless the device is paired, on either bearer, or bonding.
device_bonding_complete() accepts them once pairing is done, so there
is no need to reconnect.
---
 src/device.c  | 29 +++++++++++++++++++++++++++++
 src/profile.h |  7 +++++++
 src/service.c | 13 +++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/src/device.c b/src/device.c
index 36a980d1e..9b410a913 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4922,6 +4922,28 @@ static void device_accept_gatt_profiles(struct btd_device *device)
 	g_slist_free(services);
 }
 
+static void device_accept_paired_only_profiles(struct btd_device *device)
+{
+	GSList *l;
+	bool initiator = btd_device_is_initiator(device);
+	GSList *services;
+
+	if (!device->client)
+		return;
+
+	services = g_slist_copy(device->services);
+	services = btd_profile_sort_list(services, get_service_profile, NULL);
+
+	for (l = services; l != NULL; l = g_slist_next(l)) {
+		struct btd_service *service = l->data;
+
+		if (btd_service_get_profile(service)->paired_only)
+			service_accept(service, initiator);
+	}
+
+	g_slist_free(services);
+}
+
 static void device_remove_gatt_service(struct btd_device *device,
 						struct gatt_db_attribute *attr)
 {
@@ -7582,6 +7604,13 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	device_set_paired(device, bdaddr_type);
 
+	/* Profiles that require pairing were turned away while unpaired.
+	 * They are GATT based, so start them once the LE services are known,
+	 * whichever bearer the pairing was done on.
+	 */
+	if (device->le_state.svc_resolved)
+		device_accept_paired_only_profiles(device);
+
 	/* If services are already resolved just reply to the pairing
 	 * request
 	 */
diff --git a/src/profile.h b/src/profile.h
index 270f09ea2..add55fdef 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -61,6 +61,13 @@ struct btd_profile {
 	 */
 	bool testing;
 
+	/* Indicates the profile shall only be accepted on devices that are
+	 * paired or being paired. Use it for profiles whose remote service
+	 * requires an encrypted link, so that a peer that connects to us
+	 * unpaired is not prompted to pair by our attempts to read it.
+	 */
+	bool paired_only;
+
 	/* Indicates the profile should be ordered after profiles providing
 	 * these remote uuids when connecting. The callback function is called
 	 * when all uuids have finished connecting (successfully or not).
diff --git a/src/service.c b/src/service.c
index 8301b1ead..6b35a407c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -301,6 +301,19 @@ int service_accept(struct btd_service *service, bool initiator)
 		return -ECONNABORTED;
 	}
 
+	/* Pairing on either bearer counts: the user chose to pair the device,
+	 * so a missing LE key may be completed when the profile needs it.
+	 */
+	if (service->profile->paired_only &&
+			!device_is_paired(service->device, BDADDR_BREDR) &&
+			!device_is_paired(service->device,
+				btd_device_get_bdaddr_type(service->device)) &&
+			!device_is_bonding(service->device, NULL)) {
+		DBG("%s requires pairing: not accepting yet",
+						service->profile->name);
+		return -ECONNREFUSED;
+	}
+
 	service->initiator = initiator;
 	add_depends(service);
 
-- 
2.56.1

