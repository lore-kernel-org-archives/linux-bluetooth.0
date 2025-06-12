Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E455D8F0
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706273; cv=none; b=tOa+xNBZeyv2d4IwT7cSQovjD+172bjHaeqgx7/GMZVjPRySvlSkv49XInBMfH4p6zaAMb9ksUFkPc7VaNtmub+mYtqMcU+YKkzccDXb4MYKvjn9Fhj9bOKBblZkC5LY7Cr5H93IhMjWLcramuzErRWMFca17HQpehnKHVHBaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706273; c=relaxed/simple;
	bh=EH/e+1FJmLDc+hHPwDqZ24UWpU7yHrTYv0euXtIpWjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFjrWeRDWeUszOZTu5DcVXXjbET7QZophtEfEka5VuuuVYnTmvb1a4gEJ9GYuc/G3nw7LaWW1crP7PmE7xoEOrNiu5Y+Z7A2ErRlUFQlKPuQ/08WdPl5RiFX7Dg+q/4UEwea63TPXupng/ljkiwX7ObCNsFQqZgYTbJN0OIHAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfs8bqNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfs8bqNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A916AC4CEF0;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749706272;
	bh=EH/e+1FJmLDc+hHPwDqZ24UWpU7yHrTYv0euXtIpWjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wfs8bqNZYHBtNdInG1JRBkALQtebbD9/9X3lxLcC+d5l2hH8wqeiAHa/Gb4YkpDJa
	 FHycgfh5mdbcJ88A+pDZ0wBDP4pP9dOLTOe95V2lWkhMG8JXgw9sr+wqxVfWZ/C/oF
	 Lp+z3zl5dVkJiOmwE1tuOiEupwVeEAvaQ5jzSiGPjFiYhrMhd4tThN0cAjFCz2mV/M
	 JYUpX+Y219ccVPCaPyASLvuOyqrqkF0GAYMIZhB9kLC9q+TOrfK9nfDhDMkfIB773v
	 WTB8uldsZEh2Ng6tVd28pVz9G1cbjvGhAZHSEcmUxOWC8f3mGZk3GQPvFsW4ORTa4U
	 SPcwV9RIcrzHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95593C71143;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 12 Jun 2025 13:31:01 +0800
Subject: [PATCH BlueZ bluez v2 1/2] bass: support for encrypted broadcast
 source
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-bass_for_encrypted_broadcast_source-v2-1-9128a437b595@amlogic.com>
References: <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
In-Reply-To: <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749706270; l=4089;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=36IF3yHfNGi+hL/23frckyJt3atf6LiHIzylP6zBnO0=;
 b=3WetBxxu3oobYucZklNimsKCA3dR2R2OqxWtzWpV/cxeFc8Nor2qZAkRKRaXl15ipyeDaSu6J
 uC/JgXY44buBpSxy4D5JO4Ww1ruh3HZ2eWDTC5xJq1ge17V/MatG2AN
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

If the BIS is encrypted as indicated in the BIG Info Report, the
broadcast code needs to be requested from the Assistant.

step 1: Broadcast_Code required
  > HCI Event: LE Meta Event (0x3e) plen 20                 #631 [hci0] 27.176606
        LE Broadcast Isochronous Group Info Advertising Report (0x22)
          Sync Handle: 0x0000
          Number BIS: 2
          NSE: 8
          ISO Interval: 20.00 msec (0x0010)
          BN: 2
          PTO: 2
          IRC: 2
          Maximum PDU: 60
          SDU Interval: 10000 us (0x002710)
          Maximum SDU: 60
          PHY: LE 2M (0x02)
          Framing: Unframed (0x00)
          Encryption: 0x01
  < ACL Data TX: Handle 16 flags 0x00 dlen 44               #633 [hci0] 27.184478
        ATT: Handle Value Notification (0x1b) len 39
          Handle: 0x005f Type: Broadcast Receive State (0x2bc8)
            Data[37]: 01016698a411bb13019f103b02010100000000110d03506978656c20395f32303938020502
            Source_ID: 1
            Source_Address_Type: 1
            Source_Address: 13:BB:11:A4:98:66
            Source_Adv_SID: 1
            Broadcast_ID: 0x3b109f
            PA_Sync_State: Synchronized to PA
            BIG_Encryption: Broadcast_Code required
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata: #0: len 0x0d type 0x03
              Metadata:   50 69 78 65 6c 20 39 5f 32 30 39 38              Pixel 9_2098
              Metadata: #1: len 0x02 type 0x05
              Metadata:   02
  > ACL Data RX: Handle 16 flags 0x02 dlen 25               #636 [hci0] 27.455744
        ATT: Write Command (0x52) len 20
          Handle: 0x0065 Type: Broadcast Audio Scan Control Point (0x2bc7)
            Data[18]: 04013a4931614b3a2b7c4b7431722b666724
              Opcode: Set Broadcast_Code (0x04)
              Source_ID: 1
              Broadcast_Code[16]: 3a4931614b3a2b7c4b7431722b666724

step 2: Set Broadcast Code when BIG Create Sync
  < HCI Command: LE Broadcast Isoc.. (0x08|0x006b) plen 26  #641 [hci0] 27.669211
          BIG Handle: 0x00
          BIG Sync Handle: 0x0000
          Encryption: Encrypted (0x01)
          Broadcast Code[16]: 3a4931614b3a2b7c4b7431722b666724
          Maximum Number Subevents: 0x00
          Timeout: 20000 ms (0x07d0)
          Number of BIS: 2
          BIS ID: 0x01
          BIS ID: 0x02

Fixes: https://github.com/bluez/bluez/issues/1306
---
 profiles/audio/bass.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index b27a3fc12..2cda00b69 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -427,13 +427,45 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static void bass_req_bcode_cb(void *user_data, int err)
+{
+	struct bass_setup *setup = user_data;
+
+	if (!err) {
+		if (asprintf(&setup->path, "%s/bis%d",
+			device_get_path(setup->dg->device),
+			setup->bis) < 0)
+			return;
+
+		bt_bap_stream_set_user_data(setup->stream, setup->path);
+
+		bt_bap_stream_config(setup->stream, &setup->qos,
+				setup->config, NULL, NULL);
+		bt_bap_stream_metadata(setup->stream, setup->meta,
+				NULL, NULL);
+	}
+}
+
 static void setup_configure_stream(struct bass_setup *setup)
 {
+	uint8_t empty_bcode[BT_BASS_BCAST_CODE_SIZE] = {0};
+
 	setup->stream = bt_bap_stream_new(setup->dg->bap, setup->lpac, NULL,
 					&setup->qos, setup->config);
 	if (!setup->stream)
 		return;
 
+	/* Before configuring the stream, check whether it is encrypted.
+	 * If so, request the broadcast code from the client.
+	 */
+	if ((setup->qos.bcast.encryption) &&
+	    (!memcmp(setup->qos.bcast.bcode->iov_base,
+		     empty_bcode,
+		     sizeof(empty_bcode)))) {
+		bass_req_bcode(setup->stream, bass_req_bcode_cb, setup, NULL);
+		return;
+	}
+
 	if (asprintf(&setup->path, "%s/bis%d",
 			device_get_path(setup->dg->device),
 			setup->bis) < 0)

-- 
2.42.0


