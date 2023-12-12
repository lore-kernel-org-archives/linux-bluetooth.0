Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WJcCUD9"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA1CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 03:06:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so62855137b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702379179; x=1702983979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6MWd+a3oSvTRyqPTXg6u2wnuEIU0sLzdumg8H9kynqA=;
        b=3WJcCUD9Mwgi4gnK3vDkIIgpvXpfEwcbDxWJFYzuVjiQaVYaaJZMELC9yNuQiJ+TBu
         g9oUrk0nDLTF3QrSsYA4Aho3ugFWZ43hD23hAdRVDqCVL1ylEIn2/AL7RAg3sQcxKuuF
         ppCunqYz8LqU5b2OoVReAACLmkdnpahy3kHy025U5VfkeduglAYvXEXHl4mjualzT4LK
         Gfzw7cRyK1kQPTLaL4wH/7P3Ep/oeHJHglDYOW0jDmpgN7HgbX7IgioPLUkCU43mDGV6
         lGOVUPW5QIz08OX5q8rsG1nFKNPL8Xe3foCAD3JlT4upC1o5/qZoR7eWekpy3jy8aiAC
         B39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379179; x=1702983979;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MWd+a3oSvTRyqPTXg6u2wnuEIU0sLzdumg8H9kynqA=;
        b=Pxunq21jN9eXvhEW6ZckBX69csFbtlAeTEaJRF4CMm8E4WgB1cdbGLZKVuXLNdYK1U
         jY2TiL0QlCeSZFAzNbGWacN/8EzgvB7opTPujo/e85beoyTXakIZk2Ei5MzVMLpgrGgn
         1UsJMCumqAoNDIJhNlEsDPhb72MPkZ63PEUZ0eUu56CmqUKBQeDH/0x5B2vgBwXMjJ5t
         eBXt/tVpsb24opbhbtQKsWN0X+IsyLssWcwP1rMIihUWjsKX3r1Q1yWVFIxJJiiGoLzr
         nSEKnpsluJQRck0sNjc/UGG1xl1kpKKAWa9ahJGi2CSXvLyTJpyMaeD6qFtaYhf7DgfA
         tyDg==
X-Gm-Message-State: AOJu0YyCCCYWnWRVIIGIN+4g+Hud1byflOQUAVGxhfs/1SSreR47hBU6
	NyERCoRO2KiMpydmrWM49eviah0fL6ujRMZqP3XcOl01Os2k1NgcZfebRMvvs6PWHd+a+yzWipT
	h8XWAgp3f1VexUqtHyENiI1hR0tHLvQGHrWs+Os/W4A505auSyxTqQ8WtMLDDr6oAlS2KAh3vNT
	gq
X-Google-Smtp-Source: AGHT+IFJ4NbPy0dSu+8/sEof8TY3BUvGgwEkdzWO3Zd0KM/J1jMZTxGcEUKojDwB9ci+I8ERevgyqvyN/7vB
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:554d:7ebb:c4c9:f004])
 (user=apusaka job=sendgmr) by 2002:a05:690c:d0e:b0:5d3:9222:a83e with SMTP id
 cn14-20020a05690c0d0e00b005d39222a83emr62568ywb.10.1702379178697; Tue, 12 Dec
 2023 03:06:18 -0800 (PST)
Date: Tue, 12 Dec 2023 19:05:31 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212190531.BlueZ.1.Ia938c97b56083995e9f6bbba445a01b4cb4de0c9@changeid>
Subject: [BlueZ PATCH] monitor: add Qualcomm and Mediatek MSFT opcodes
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Hsin-chen Chuang <chharry@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

Qualcomm and Mediatek has 0xfd70 and 0xfd30 for their MSFT opcodes,
respectively.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Hsin-chen Chuang <chharry@google.com>

---

 monitor/packet.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b06f8a5d38..42e711cafa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4286,10 +4286,26 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				 */
 				index_list[index].msft_opcode = 0xFC1E;
 				break;
+			case 29:
+				/*
+				 * Qualcomm controllers that support the
+				 * Microsoft vendor extensions are using
+				 * 0xFD70 for VsMsftOpCode.
+				 */
+				index_list[index].msft_opcode = 0xFD70;
+				break;
+			case 70:
+				/*
+				 * Mediatek controllers that support the
+				 * Microsoft vendor extensions are using
+				 * 0xFD30 for VsMsftOpCode.
+				 */
+				index_list[index].msft_opcode = 0xFD30;
+				break;
 			case 93:
 				/*
 				 * Realtek controllers that support the
-				 * Microsoft vendor extenions are using
+				 * Microsoft vendor extensions are using
 				 * 0xFCF0 for VsMsftOpCode.
 				 */
 				index_list[index].msft_opcode = 0xFCF0;
@@ -4298,7 +4314,7 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 				/*
 				 * Emulator controllers use Linux Foundation as
 				 * manufacturer and support the
-				 * Microsoft vendor extenions using
+				 * Microsoft vendor extensions using
 				 * 0xFC1E for VsMsftOpCode.
 				 */
 				index_list[index].msft_opcode = 0xFC1E;
-- 
2.43.0.472.g3155946c3a-goog

