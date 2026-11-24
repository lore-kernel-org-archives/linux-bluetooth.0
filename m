Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520387;
	b=4L5jc2O5fwY3cAvxP/vnFhJgcI2H6/6yoovcB48e4z4M1YUZrl/J2LNlqkauF6NT7CGs
	 9qivB5LA4ut+4qd7TegBfc3s4aChYezl0BM1x+kh1EzCT5ik8QEinZdNYP5OD//t4SUNP
	 bV9fuXJE/GdoA4DanFrYB3OZH5O9FqAmQeFlctXAo7zCbVrJiQQXo0SGDrewtApIQTT4t
	 5b0bimDaiKkmvBQV9s9S0HxjUzMr5lMxqOTv78DRoH8Hbw9m/zmfzDKFrxHEi6JdnB1Z3
	 o2xG/SQP/nQESUh2S8lTc8OzSP15XnIH0JqBRs9L7zd5Ctp3lHZEhavQmrCX8zweWCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JqGqtOvly3sZRihfxsc94FyRjgbsolpXsfWFSPg896I=;
	b=aQFnVgWClcFgBQ7ddhEUATROibcBmC8X6pDzV5IzaqLB2YrgmS1pEk6I2hUT5rJDGf/6
	 KTbgyfK71HmcwaLkY1hnWcAatkrKvC2SqjsBDxOrk2P4A7b6LRraYRl/CQ2eIKXL8J+/L
	 r/R6f6mk9XXb04ZCBxmY5xm/Sz+Ma0o93J+REvYekn/vPW43TVLFaUVe7p7yDF3qf6d4/
	 nkdPpf946Wq4gjXJj6/Um3bJCwZkljmWCP/fJJfpchdnblWZmSCv/4tZ5PSmBK82nHVNc
	 fpHsWdMb1CjCAYKdCDvXdJ7ThKedlaf/TWbh1dB/uZbHqRWn57Abc5rWm/idd20Uy0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Jdm6ptVP;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E91606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E91606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Jdm6ptVP
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so42322155e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795520384; x=1796125184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JqGqtOvly3sZRihfxsc94FyRjgbsolpXsfWFSPg896I=;
        b=Jdm6ptVPBcL++SjZoiiKUVTNtxI+3hhcIusYu+ZkNVm7ANRPloJuXH9sW5efjoO+Vf
         7OO98ZaA9adDPJlJqCej9aDGD2ll+S2DbnWzgV8YcLo8M1fBh96y+zo6phoNXnpeHAOd
         F3n3eHwxxEgHdKVqHcn5pvbbuC5BZzy5EeQ8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520384; x=1796125184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JqGqtOvly3sZRihfxsc94FyRjgbsolpXsfWFSPg896I=;
        b=amAJG4DoDRcWuownnt3Iux5l3fH/ezbO3BTap+VFO1wpJaZYgy2H9cWqg57vVznArz
         /A7Gpu2h0wis6V8QETQfV8n2RQWhJTcLTb7BBCFE1bS8PmpimASHqpwUOH0L6JoJwstM
         /5TnL+L+2dTPNJehXZkN8FEUy/6s0FJfAJ2BiF5alZH1BbwTa6GmPVpOQ99LhrRG3/eP
         0WNwv7/sgNcK0s2js+7+x7WOEMsM2DyahK7XFhDyTFzW0atXq2bYTzyWjBA67x7f2N20
         MTkQ2JDde3lHIrnT6iq7gwzdFYNO87wYnQCv+tUg/eKbA2M0me/ub7zipXvWiUQamcbz
         E9cg==
X-Gm-Message-State: APuU4Z/QvWwToSqLw/gc5iZnWbs3eXbQ/Ai3WAq/uv3WX+n9hmhplQQ0
	k9yZ3m45fujzGfKP4kf81uYYXFNDUao13utIdr75f83sixSksS+5F2vnjEeaps7fhPYkTX5jG02
	dkQWQ
X-Gm-Gg: AZFdTZfp/QOoblFG2odl0KpRnkNphKrK0Z51etYeAddBmAea8IXdNGjKPM/SKAE8V3d
	YacPCvBrZgr47TZ1LONUjW5O2j71NquHqDXjp0yOVLQg4R+4ZN9D5R7Q6oHtAL6xnN6IYl/mIP/
	atlMTi25CEI/lkvaxwob/EfAV3CdWUrAi+h4RbVo+AwwD3qI5eZBt+ucBFS2C9T3D90e0UJA9VZ
	lPV/2YfROdJ1Vt3xd27viQCtVz+kMdfNXCvq6VTKiGNVSC9848qPPFs5UCuqsYUmMhkidG0UpMe
	zTWROaJHCNoTEQN46Q8KNacxFN7bkVKonhUZVfKnHyOG8DOL6kLjSt0LZd7ooafK7a2n1MeBJ2y
	TxbftH+eB+/9KLMlTHt9kMkBuC/y8XbmG3BQ6qg9tvH9iagf1b3UO6sg10XJtxuw3+5k4RxtSeC
	7EwkcnLFpAbp0S4Qa4Pt8hp9nwYuEwaUYrxLYik9gQW3Ujnj7wDP8p5YFYC9fAR1DWEK/AzwemF
	DvEIr4YuZJIVOu5E6xP2o/3Hr1zNKOgHweuioneNpVBVrmkLOCBbNDy1Q0al/aMTAPYubsO3AwY
	J9cS4ayFnISZqzKbYdnCwAoI66BcYTIf4k0WegYP2Y3n0lsMfo8=
X-Received: by 2002:a05:600c:46d3:b0:4a3:12fb:1ee7 with SMTP id 5b1f17b1804b1-4bb88812c9dmr297512725e9.25.1795520384483;
        Tue, 24 Nov 2026 03:39:44 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm264905335e9.4.2026.11.24.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:39:44 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: Don't announce a broadcast from an NRPA
Date: Tue, 24 Nov 2026 12:39:37 +0100
Message-ID: <20261124113937.1695751-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

MGMT Add Extended Advertising Parameters sets an advertising set up
before its data is known, and the set becomes periodic only in
hci_start_per_adv_sync(), when a broadcast ISO socket is connected on
it. Until then a set without the connectable flag, on an adapter that is
not connectable and has privacy off, gets a non-resolvable private
address. If its data carries a Broadcast Audio Announcement, the
broadcast is announced from that address, and the set is moved to the
identity address when its periodic advertising starts:

< HCI Command: LE Set Extended Advertising Parameters        3.162678
        Handle: 0x02
        Properties: 0x0000
        Own address type: Random (0x01)
< HCI Command: LE Set Advertising Set Random Address         3.164952
        Advertising random address: 21:3E:30:B7:DE:A4 (Non-Resolvable)
< HCI Command: LE Set Extended Advertising Data              4.161538
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 11645491 (0xb1b233)
< HCI Command: LE Set Extended Advertising Enable            4.164125
        Extended advertising: Enabled (0x01)
< HCI Command: LE Set Extended Advertising Enable           11.280146
        Extended advertising: Disabled (0x00)
< HCI Command: LE Set Extended Advertising Parameters       11.282026
        Own address type: Public (0x00)
< HCI Command: LE Set Extended Advertising Enable           11.284922
        Extended advertising: Enabled (0x01)
< HCI Command: LE Set Periodic Advertising Enable           11.291942
        Periodic advertising: Enabled (0x01)

The address the broadcast is first announced from never carries the
periodic advertising. A scanner listed Broadcast ID 0xb1b233 under
21:3E:30:B7:DE:A4 before the socket was connected, and under the
controller's public address in a scan started after it.

The commit in Fixes stopped giving a periodic set a non-resolvable
address, but it looks only at adv->periodic. Treat a set whose data
carries a Broadcast Audio Announcement as a broadcast set too, and set
it up again in Add Extended Advertising Data, because its parameters
were sent before the data was known. With this change LE Set Extended
Advertising Parameters is sent a second time, with Own address type
Public, before the set is first enabled, and the scanner lists the
Broadcast ID only under the public address.

The address of other sets does not change: an NRPA is only asked for
when neither the set's flag nor the adapter's setting makes it
connectable, and a set that uses a resolvable private address gets that
first.

Steps to reproduce, on an nRF54L15 with Zephyr 4.5.0's open link layer
as hci1 (public address F4:26:7C:31:12:69) and BlueZ 5.87, with privacy
off and the adapter not connectable ("btmgmt info" lists neither):

 1. btmon -i hci1 -w FILE
 2. In one "btmgmt --index 1" session, a second apart:
      add-ext-adv-params -r 0xa0 -x 0xf0 -P 2M 2
      add-ext-adv-data -d 0616521833b2b1 2
 3. About 7 s later, a broadcast ISO socket on advertising set 2:
      isotest -i hci1 -q -s 00:00:00:00:00:00 -B 16_2_1 -G 0 -T 2

A Realtek RTL8763EFL next to it scanned for broadcast sources, 10 s from
before step 2 and again from 2 s after step 3.

Fixes: 03ddb4ac2514 ("Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
Changes in v2:
- no code change
- reworded git description
- steps to reproduce added

 net/bluetooth/hci_sync.c | 12 ++++++++++--
 net/bluetooth/mgmt.c     | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 25ab26c2fbf8..de6b479a7cd4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1487,7 +1487,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
-	bool connectable, require_privacy;
+	bool connectable, periodic, require_privacy;
 	u32 flags;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -1522,6 +1522,14 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 	flags = hci_adv_instance_flags(hdev, instance);
 
+	/* A set with a Broadcast Audio Announcement is a broadcast source even
+	 * before its PA starts.
+	 */
+	periodic = adv && (adv->periodic ||
+			   eir_get_service_data(adv->adv_data,
+						adv->adv_data_len, 0x1852,
+						NULL));
+
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting,
 	 * unless the instance carries periodic advertising, which can only be
@@ -1540,7 +1548,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * advertising is used and it is not periodic.
 	 * In that case it is fine to use a non-resolvable private address.
 	 */
-	require_privacy = !connectable && !(adv && adv->periodic);
+	require_privacy = !connectable && !periodic;
 
 	err = hci_get_random_address(hdev, require_privacy,
 				     adv_use_rpa(hdev, flags), adv,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5f32860782d..edfbdf2942f7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9646,6 +9646,20 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 	int err;
 
 	if (ext_adv_capable(hdev)) {
+		struct adv_info *adv;
+		bool bcast;
+
+		/* The parameters were set before the data was known */
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, cp->instance);
+		bcast = adv && !adv->periodic &&
+			eir_get_service_data(adv->adv_data, adv->adv_data_len,
+					     0x1852, NULL);
+		hci_dev_unlock(hdev);
+
+		if (bcast)
+			return hci_start_ext_adv_sync(hdev, cp->instance);
+
 		err = hci_update_adv_data_sync(hdev, cp->instance);
 		if (err)
 			return err;

base-commit: 62fd917f6d2df1a399a453138c2b7cbd563f8f95
-- 
2.43.0

