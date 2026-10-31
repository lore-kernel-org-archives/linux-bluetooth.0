Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448997;
	b=EZA2ss4llImTI/PI3jFYjEGYcE9yfF3ay6x7v9HFmBcPo1Tty8JwAhQk250gOjJsTgs/
	 zfA/4a+VKSO1Ys8jl8tYXXLld+s3oReT76Il/BkzO7g5qDgofO3EmsWdB6HVMdvrCwMGb
	 lCxD2fTztP4Sx3pPSzajc1+tRPdAUN2S442gD2ITVSPN4gY8ni11cGPeaFxisflndc5AA
	 2c4kPoT/YxI8+NZlpflfkTyPJHOkqbhQup7i/i7XsqC3uNjqFGXxkPyed3XwLlI4gpDYa
	 xxQ/Mpzf6jmhPuKR4NSSQmg561T8A8eBuncbjsbTU7Has/zLtkrlV4Jcgo/O3SBNyHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448997;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLV1w/mZ/bi98b2YU13ym/X0d8CvSInaPBvgVi0L4lU=;
	b=rAZLYQtUx1egJMDOETKWYJ4ltxn4ZyQhWEgRi2ljJP55pqAKUol/mHO3qo+IWt0iII+/
	 0pVcSNqHCxi72mCD1ZV5Z58frioQzds4xytQLYQuMHKc5WG21PSP5jvNEHafQS7nfxu5F
	 ryQv0W/D9PZoWECOHdws46NWT0MtFgZPsuLLRZ9vgpjBh/Tyw8sGh06H1kVpHFmfLs2Y2
	 B7dprjawDs+tf/L9LO1nSj2IRQRLWT0bFk5ADzcdHnCwA7/vDsOqbeRrzvhlNwq9cMuSk
	 HkvSqiJ7rOtg8itZweAoqb+CP3yeNkIjzl/bL22gnL4q2WEVDFPcdMO71a68cXP8Zyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAxNuyzJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80E606A31E;
	Sat, 31 Oct 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAxNuyzJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793448996;
	b=mzdBfldj+WufwaDSPULVVDCqowxiy4d22dk1YiXNOFoAcaFRAebJb3Ol/+YFodJVZtlS
	 nBGXppGHjKurZPUkQrPaXEQ5qeaX4oczKvuykR/FWF3IpPvJkrQfWsuEO9fydG2Gfn3S8
	 LD05SA87rxs5k85jNJd+chvDQATSqxGfxd9CzLlAv/uhVeh7Xs/IX/XxEgUq4yF9nSMNI
	 n8m1Ez/BB5rcBAxyA79VoRT36s9/lQCy7hsLrL5eduoBoAuWlr7hdN7u6KEz+Xc/aLCmU
	 ogwxOnkxfVC01ZWxr+AnP+k9PhhEMgOQTqvQg9tdv2aOSnDziQMDo5URQ/BKR0dSzeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793448996;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uLV1w/mZ/bi98b2YU13ym/X0d8CvSInaPBvgVi0L4lU=;
	b=eWtwkvPnjqlG+RF8ZdR6sWcme6C+YlzbY8e9iv1ACszVVI8LrBcvm0ZPucPTbbSTwB75
	 X2uVErFBgnE571usvQEEcCmEtG3aLJMXWfqfsG4An3fu7ZiAy0LZU7TJ4xgblhFH1jFiT
	 aa6t/4d2OdwiNryC2rXc2p3FlbWFushtWthKUcvk9KhXhcq00Y7Jj8liblOQUbNcmxGIF
	 wWpVF8boEP8c/7F8uL4XWRH6jgqWRH6ltJQbk73j8Sk13SBBdw50VoOcCvO51n7mnDtcP
	 Ylx1DYT3UqUWLlk7yvMkx+wOcvD2Kfijahk701dUJhIHmH+E2Ob7k+Gqu8EW5sZmtzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C40AE1F00A02;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793448996;
	bh=uLV1w/mZ/bi98b2YU13ym/X0d8CvSInaPBvgVi0L4lU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dAxNuyzJU8ti58l7LAoP9dDFn8Th6zAejiJBOLuhxH9tlihId5HsYCs/kGRJhGrBK
	 2J6bQvp8zcRoOnmegENGEQFaM6uShy7zNKnNv98LwwlYbDZ+YHTNXca0J6LPFc/fY4
	 ZRf0BmmT7H9SFwg7XmiTkfGdMf6pjvBofw/OkjPluveU+DaM/z0URcCQrg9vC8k/Yf
	 /KLnYYuB8wScmsqXFl8Tb1e4ebTkLfDDRuUwY0+nXbnTQw6j1t/aRdPDzj3AHWl7Cs
	 mUahL1bD0PbdcfWegWl45AovzJZX+PcgUKPMsPTtq1I8ABnJqbyUZl1EwlXCbeH/jS
	 2L2TfOITjpjMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4080D45EC4;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
From: Ernesto Salvetti via B4 Relay <devnull+ernesto.salvetti.tambosi.tn.it@kernel.org>
Date: Sat, 31 Oct 2026 13:16:16 +0100
Subject: [PATCH 2/3] Bluetooth: hci_event: Don't drop LE link on busy
 remote features read
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-barrot-le-fixes-v1-v1-2-30e2089882bf@tambosi.tn.it>
References: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
In-Reply-To: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793448994; l=2905;
 i=ernesto.salvetti@tambosi.tn.it; s=20261031; h=from:subject:message-id;
 bh=6FdY8h7nVU+wFr+FiHP6cSyVDh7scpK0ylbnj6iZsko=;
 b=tUJGdwui4lzAnNP7rki57kfX9oOJP+yIJAevYn7KjYyzMYMJDQdduIdo6Kp6evFa3q13RXsqa
 sHxzsBFuYU7Ds/MvGo1PJukA93IVvNObJJDDMQD6z5x9rsR5nbQQrPV
X-Developer-Key: i=ernesto.salvetti@tambosi.tn.it; a=ed25519;
 pk=OLNiuyRbYD4dcNYoAvM99nt/1KZTKeM316r91BCQDUs=
X-Endpoint-Received: by B4 Relay for
 ernesto.salvetti@tambosi.tn.it/20261031 with auth_id=1370
X-Original-From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
Reply-To: ernesto.salvetti@tambosi.tn.it
Content-Transfer-Encoding: 7bit

From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>

Right after an outgoing LE connection is established, the Barrot
controller in the UGREEN Bluetooth 5.4 dongle (33fa:0010) rejects
LE Read Remote Used Features with Controller Busy. The error is passed
to hci_connect_cfm(), the pairing attempt fails and the link is torn
down right away, so no LE device can be paired or connected:

  > HCI Event: LE Meta Event (0x3e) plen 19
        LE Connection Complete (0x01)
          Status: Success (0x00)
          Handle: 65
          Role: Central (0x00)
  < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
          Handle: 65
  > HCI Event: Command Status (0x0f) plen 4
        LE Read Remote Used Features (0x08|0x0016) ncmd 1
          Status: Controller Busy (0x3a)
  @ MGMT Event: Command Complete (0x0001) plen 10
        Pair Device (0x0019) plen 7
          Status: Busy (0x0a)
  < HCI Command: Disconnect (0x01|0x0006) plen 3
          Reason: Remote User Terminated Connection (0x13)

The controller does not send an LE Read Remote Features Complete event
later on either.

The remote features are not needed to use the connection; the stack
already continues without them when a peripheral gets Unsupported
Remote Feature. Do the same for Controller Busy and move the connection
to the connected state.

With this an Xbox Wireless Controller pairs over LE Secure Connections
and works as HID device.

Assisted-by: LLM
Signed-off-by: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 74b96941ad11..7da40b84c198 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -726,6 +726,7 @@ enum {
 #define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1a
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
+#define HCI_ERROR_CONTROLLER_BUSY	0x3a
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
 #define HCI_ERROR_CANCELLED_BY_HOST	0x44
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d05934fef4d9..fcbd1807e2f3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3026,6 +3026,17 @@ static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
 			status = 0x00;
 		}
 
+		/* Some controllers reject the command with Controller Busy
+		 * right after the connection has been established. The
+		 * remote features are not required to use the connection,
+		 * so continue without them instead of dropping it.
+		 */
+		if (status == HCI_ERROR_CONTROLLER_BUSY) {
+			bt_dev_warn(hdev, "Remote features busy, continuing without them");
+			conn->state = BT_CONNECTED;
+			status = 0x00;
+		}
+
 		hci_connect_cfm(conn, status);
 	}
 

-- 
2.53.0.697.g625c4fb2daa


