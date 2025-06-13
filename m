Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053E2E11B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834738; cv=none; b=MFUVyf5ldjENol5UWrWc1sdwqATnHFxD3tOK9GhOjjCYgu7z2pP48EkQl8gAfaUXcOI2s3wr1yj2cibsx+m9PnN3aPkq+mKnXkaRxQsyTYbJZOXwG37xbd1ptRbuzpfV4Z1MsCZHW0cd+ABgZzPpRKDdQsGcjoYaaChU/KuY/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834738; c=relaxed/simple;
	bh=4hipMal1+fxcdsKHSlHnecU+VDyLGQMrt5rmaBCJdiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FzhVOaFWdRsgHJxufKXpK40pOL32mg06PtxQuSDrVWDBsFH0vlwhgciLNDSEFRO6ghXzfgC+yTaCbsPgUgF7LXGWVgFk/wuQfFyulvrSRrSZiAXO571eHp3yg3fBHtBeAyBnPdY55C7BeThLDCqtO3toZ8O5CRcGVnoHqKwvWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tnw4snI+; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnw4snI+"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87ec4ec218fso445386241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834734; x=1750439534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nh1qZHWUVj2G4iL9X6OIkGR7ZVMgS+cqB0Ge0ckhKCU=;
        b=Tnw4snI+2CQBsC7q9RFeewQNgWlE9+POvoooXKD8ZvLqNkSeD2j8p4tySE4xpxItMN
         AfCOwEdVgjOLDOj+5hyjS24JCSUhC/oT4zd1fJkraNWFkoEprNS4T+4L/+WJ1iaHNgO1
         kWHHX087Q9YSHCS5VSAdH8JeNy03j/uQ8dp6HtQDP80W0ckJyFq5boIe/IVlLJPz0o5B
         1OwJIBopQL/Us7ruDk9Cf1yijbV7dMiwdSpR8f5EZiEkJHFKJCMj0pv37/KdWXt13voW
         TFDGIIv4axBmJdznf5W1Lrd/itnONRHt8ABJRjdEMRtp0vheDykhzhM2fBcaco2y/Jqr
         FDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834734; x=1750439534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh1qZHWUVj2G4iL9X6OIkGR7ZVMgS+cqB0Ge0ckhKCU=;
        b=Z05rW+MSniYPz5jwiNPMuZ9fyaNjy7cYK/Vb2i10/hqUNXhwVqwscF6jPkBA3vqbKW
         lV5vjkG0I6LdZfYGRTHtuevURZueOj9x+d+dB5T5O2A33laEcewIr8ZiquGBSHqeI7fs
         HH7nTGftDMjOSOBY5aeDthF104rg1K68UvqA7n9ONCgO00we35iMJrukg3X38fPd/XA4
         wOBYOmLj2xQ3En+FmMEdPuKqApp6RNCfz5A91WuQmMXlKWPsco+5FXy96wa7WNz6e7LK
         xQsTlYeZiLycyW41IWYk5jMc83Y41dOTh3Ic2ZT3lTWOA0Tye+e95B14fBUG3JXzpNK3
         7y1Q==
X-Gm-Message-State: AOJu0Yyuxj+QhKew1PA6M05Fe9WywqZhIEwNdSVrG0sWzdcM8Bk0l3rb
	g+S9V6kBcgNx+0c98z7lKy4hifhPTaEoCCubP2C13P7b5RoNgY9z73h9PA7Yq+fHuNs=
X-Gm-Gg: ASbGncvnFIUc7UakPLAFutVimujsY1gLWs00IyPhV5h0rdofqcPOOAFoqOVw5r//O68
	XfQAtV2A9zrapIS1iIvGOVqTwHC2zV1b0+Fw/W1Hu25lD890SAeR+iscJ+6tm4qdgkxI4MKAnYv
	PL5KiWfz8XK+5tK1IEkLf4Ls0aq9tK8BqYWVU1CKqAAEiewFkaEWka4J9WVosx1skXj3Q0YeDJU
	775jU013GZHWU1MkCuPWuJZQkZQC/G3wrC76TEqlfiT4LPAXjtdDWWkcWo7FPc1AV+gz0xbwrCH
	m1P1NRFim2LacbRZEZNOyOKmHSuqB2wHyEHgJJK1fmosHygXJlUko6evj30kRAYPdJTAXlbhImO
	MOK0XVNQqIvbB4yp1PyebgpsBHcGiM7Q=
X-Google-Smtp-Source: AGHT+IF1/ilIIK23oAvS77NEpNj8FU9cJ3a0eZIqysjAbPrDLZ12Ue8qtkekNCJoCAq0ztFXDegqaw==
X-Received: by 2002:a05:6122:458c:b0:530:6bcb:c97f with SMTP id 71dfb90a1353d-53149cc29efmr358881e0c.8.1749834733579;
        Fri, 13 Jun 2025 10:12:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5313e028c88sm303013e0c.32.2025.06.13.10.12.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:12:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Add prompt to enter metadata for custom presets
Date: Fri, 13 Jun 2025 13:12:09 -0400
Message-ID: <20250613171209.2108815-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When adding a custom preset prompt the user to enter metadata for it
e.g.:

[bluetoothctl]> endpoint.presets 00002bcb-0000-1000-8000-00805f9b34fb 0x06 custom
[Codec] Enter frequency (Khz): **
[Codec] Enter frame duration (ms): *
[Codec] Enter channel allocation: *
[Codec] Enter frame length: **
[Metadata] Enter Metadata (value/no): <len> <type> <value...>
---
 client/player.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 0314cd303e79..2702ea54247b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3900,6 +3900,24 @@ fail:
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void custom_metadata(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	struct iovec *meta = (void *)&p->meta;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		goto done;
+
+	meta->iov_base = str2bytearray((void *)input, &meta->iov_len);
+	if (!meta->iov_base) {
+		bt_shell_printf("Invalid metadata %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+done:
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void custom_delay(const char *input, void *user_data)
 {
 	struct codec_preset *p = user_data;
@@ -3916,7 +3934,8 @@ static void custom_delay(const char *input, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	bt_shell_prompt_input("Metadata", "Enter Metadata (value/no):",
+				custom_metadata, user_data);
 }
 
 static void custom_latency(const char *input, void *user_data)
-- 
2.49.0

