Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160E37B41E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578688; cv=none; b=k5oWF94DbfffQqjpYU3jddEhLklUF+0nxI0+J7L8xRfDzklfjBggjOK0ppNtk0ZqzKsztAM6oz6ypJ4Zc+ULWLO3KNLkONWgys53fL8yYUQgnvLN07dPDJKwjX+ov8eq5E3ETknAnn2n0qpsSnqc1qf136Dg0SYeGvZeIsOh4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578688; c=relaxed/simple;
	bh=y8KOy0gnR7nEz1IW5kgmmJqLFc6K3U/dg0UlWa/5LmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUCl+Su89me1K66hx8cMVj/hc1EzOvu5HyTYZKxBVDNYI8+yjCj+UzRNTQjqauIwfI3fvrmAxYNuKgBgVDbT39KVqGfDp0AQIm1bFfdK22Qjodt2K7Oo1Tjje0DHABBmHWz/hjfk0ZoNsxnEZZ++SICZ78WK2m9VxwDogsqNfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcfQarLv; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcfQarLv"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so707203e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777578686; x=1778183486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz5d1K0+N/iEOCpnTqNWkWT12IlVW5Ump/6T7HT9SF4=;
        b=AcfQarLvv3SnY5XNntIdRVFe5oiWzY2+dgM2pSwEzwgUjQlgKHCH2SK9Ov0kP4OVCh
         3xejrnopJaz7U0WEWMV8y8faH+p8ubID3XUG7pS5k8dRA83fl/ZXzDS82aDaOxx7yoSf
         z307qvT6HD2IOP4EXNhAQrEkKByKRymmnBxxLK22dD30vJUQb44E4MMc9vc4Hu+lg8tD
         wfog0oe2xVesrIxsPDY9EMGeSCXBe5XZ7+JkP4y2pIjstztrNJ3mENkOEV5KUOpCcyyC
         Zt0Uvo8fWM8zXfpY2jJU6DqhnbwxrpyyVXaWNpgyf4nlOEVCPP1cBjuFYpAC4NuAXalB
         ZKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578686; x=1778183486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yz5d1K0+N/iEOCpnTqNWkWT12IlVW5Ump/6T7HT9SF4=;
        b=oF8IEKuBiqQrGiiWtpj0m67Oyenqg0ZdVbJUpvfD/z4oyMhg5egnBgtjUhVsOGuJ7G
         bTfTIZA8Q3IidGqZEF6PZfVAy3v8Hw1JlBNtq31E/D+WiL7fU4P54wNohifxLo/QJhIA
         OniSJsvqdD5vOyDkbAY4b5cfZg3EV0NCOYhIfQEJ/igqnnk6Rg7UZk1aaZaHzwsm8Lo8
         O+UVwiHLBRiyYUGRKXfy52y+2QIwlP+cgSUQoa/9pg4y3C8x577/X3OI0FaxNxVP6eP+
         n9mxWI4Sbi3+HBzrBbErImz5hiOffRwaJxtabjN8EoIzfdmVaRJoOvTy2aFpaWlIn3hI
         tz8w==
X-Gm-Message-State: AOJu0Yyr+BMKTOXit+3OTZreViXK3zfvNjmufYJQ64M8RXT+V8zgBYID
	7JHrJ4rieJM1Z82qIoVuACzRkcLchrF659KqRotXgMUj/gpWCiIsLzXIfIhskgrO
X-Gm-Gg: AeBDieskh3FJXNkPmdzRbbaYUUZ6pfJDuYmPWClOCftz3lT0ZCOLvv6UagwYT+Dhrnq
	inE2FjVTkNN9PzkpxCBSnMxvfax13Y41U8p1xUZY3YeaV+4KAxJK5DW/7Nnpe2xwwqt/UhGdX1g
	5ZGudWZRjMwFfh+eNxKFxuzxh9Di3eQ3Vxs9/y1lbTrCncYfN/OZs8DXDRi6sHbEKOSsWF6XeDf
	ItrcqBQtumsRZ58WaeJk87VEbYHLAkziyuBmbBdh7TJLZSQux9lUQtUjbGycgcD8iS/OHqBiZYx
	IXOqlGM6VS05unB8gDvY0rCXCKI0X+KJ6iO9lBXqcR+Bjdj35drVQRa8TMx3IkAtzI9mY03s6pP
	Ue40jywj1AtLOSeLKDCaflzAP9tmFZM7GOqymVJvElxwdTT5NqLTI/sGHgMfyZk2wkAQqUIQVoF
	44CMnpkv+lkFs2mq2Smj3EDI1MMkaNFak2f52ctoJK6Juqj2ob2dJpZtSOqQt4FKTz0vYd9KPbJ
	8k17WsoKXKs6ZtRrG6ny/AsaHgo
X-Received: by 2002:a05:6102:80a2:b0:5ff:d434:b507 with SMTP id ada2fe7eead31-62ad415eff8mr2824535137.17.1777578685635;
        Thu, 30 Apr 2026 12:51:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce0902d6dsm406045241.6.2026.04.30.12.51.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:51:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor: Add decoding support for HIDS 1.1 flags and attributes
Date: Thu, 30 Apr 2026 15:51:14 -0400
Message-ID: <20260430195114.608794-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430195114.608794-1-luiz.dentz@gmail.com>
References: <20260430195114.608794-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for HIDS 1.1 SCI flags and attributes:

> LE-ACL: Handle 2048 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4
        Handle: 0x0021 Type: HID Information (0x2a4a)
        Value[4]:
        11 01 00 0f                                      ....
            bcdHID: 0x0111
            bCountryCode: 0x00
            Flags: 0x0f
            RemoteWake (0x01)
            NormallyConnectable (0x02)
            SCI Supported (0x04)
            SCI Low Power Mode Supported (0x08)
< LE-ACL: Handle 2048 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003d Type: HID SCI Information (0x2c3a)
> LE-ACL: Handle 2048 flags 0x02 dlen 19
      ATT: Read Response (0x0b) len 14
        Handle: 0x003d Type: HID SCI Information (0x2c3a)
        Value[14]:
        08 02 0a 00 14 00 0a 00 08 00 08 00 08 00        ..............
            Minimum Supported Connection Interval: 1.000 ms (0x08)
            Number of Supported Subgroups: 2
              Minimum Connection Interval[0]: 1.250 ms (0x000a)
              Maximum Connection Interval[0]: 2.500 ms (0x0014)
              Connection Interval Stride[0]: 1.250 ms (0x000a)
              Minimum Connection Interval[1]: 1.000 ms (0x0008)
              Maximum Connection Interval[1]: 1.000 ms (0x0008)
              Connection Interval Stride[1]: 1.000 ms (0x0008)
< LE-ACL: Handle 2048 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003f Type: HID SCI Mode (0x2c39)
> LE-ACL: Handle 2048 flags 0x02 dlen 6
      ATT: Read Response (0x0b) len 1
        Handle: 0x003f Type: HID SCI Mode (0x2c39)
        Value[1]:
        00                                               .
            Mode: None (0x00)
---
 monitor/att.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/main.conf |   2 +-
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index e8e0d499a826..03d46634fe17 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4522,8 +4522,10 @@ static void ras_data_overwritten_notify(const struct l2cap_frame *frame)
 					ras_data_overwritten_notify)
 
 static const struct bitfield_data hog_info_flags[] = {
-	{  0, "RemoteWake (0x01)"		},
-	{  1, "NormallyConnectable (0x02)"	},
+	{  0, "RemoteWake (0x01)"			},
+	{  1, "NormallyConnectable (0x02)"		},
+	{  2, "SCI Supported (0x04)"			},
+	{  3, "SCI Low Power Mode Supported (0x08)"	},
 	{ }
 };
 
@@ -4598,9 +4600,116 @@ done:
 		print_hex_field("  Data", frame->data, frame->size);
 }
 
+static void print_sci_mode(const struct l2cap_frame *frame)
+{
+	uint8_t mode;
+
+	if (!l2cap_frame_get_u8((void *)frame, &mode)) {
+		print_text(COLOR_ERROR, "    Mode: invalid size");
+		goto done;
+	}
+
+	switch (mode) {
+	case 0x00:
+		print_field("    Mode: None (0x00)");
+		break;
+	case 0x02:
+		print_field("    Mode:  SCI Default Mode (0x02)");
+		break;
+	case 0x03:
+		print_field("    Mode:  SCI Fast Mode (0x03)");
+		break;
+	case 0x04:
+		print_field("    Mode:  SCI Low Power Mode (0x04)");
+		break;
+	case 0x05:
+		print_field("    Mode:  SCI Full Range Mode (0x04)");
+		break;
+	default:
+		print_field("    Mode:  Reserved (0x%2.2x)", mode);
+		break;
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void hog_sci_mode_read(const struct l2cap_frame *frame)
+{
+	print_sci_mode(frame);
+}
+
+static void hog_sci_mode_notify(const struct l2cap_frame *frame)
+{
+	print_sci_mode(frame);
+}
+
+static void hog_sci_info_read(const struct l2cap_frame *frame)
+{
+	uint8_t min_conn_interval;
+	uint8_t num_grps;
+	uint8_t i;
+
+	if (!l2cap_frame_get_u8((void *)frame, &min_conn_interval)) {
+		print_text(COLOR_ERROR, "    Minimum Supported Connection "
+				"Interval: invalid size");
+		goto done;
+	}
+
+	print_field("    Minimum Supported Connection Interval: %.3f ms "
+		    "(0x%2.2x) ", min_conn_interval * 0.125, min_conn_interval);
+
+	if (!l2cap_frame_get_u8((void *)frame, &num_grps)) {
+		print_text(COLOR_ERROR, "    Number of Supported Subgroups: "
+				"invalid size");
+		goto done;
+	}
+
+	print_field("    Number of Supported Subgroups: %d", num_grps);
+
+	for (i = 0; i < num_grps; i++) {
+		uint16_t min, max, stride;
+
+		if (!l2cap_frame_get_le16((void *)frame, &min)) {
+			print_text(COLOR_ERROR, "    group[%u]: Minimum "
+					"Connection Interval: invalid size",
+					i);
+			goto done;
+		}
+
+		if (!l2cap_frame_get_le16((void *)frame, &max)) {
+			print_text(COLOR_ERROR, "    group[%u]: Maximum "
+					"Connection Interval: invalid size",
+					i);
+			goto done;
+		}
+
+		if (!l2cap_frame_get_le16((void *)frame, &stride)) {
+			print_text(COLOR_ERROR, "    group[%u]: Connection "
+					"Interval Stride: invalid size",
+					i);
+			goto done;
+		}
+
+		print_field("      Minimum Connection Interval[%u]: %.3f ms "
+				"(0x%4.4x)", i, min * 0.125, min);
+		print_field("      Maximum Connection Interval[%u]: %.3f ms "
+				"(0x%4.4x)", i, max * 0.125, max);
+		print_field("      Connection Interval Stride[%u]: %.3f ms "
+				"(0x%4.4x)", i, stride * 0.125, stride);
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
 #define HIDS \
 	GATT_HANDLER(0x2a4a, hog_info_read, NULL, NULL), \
-	GATT_HANDLER(0x2a4c, NULL, hog_cp_write, NULL)
+	GATT_HANDLER(0x2a4c, NULL, hog_cp_write, NULL), \
+	GATT_HANDLER(0x2c39, hog_sci_mode_read, NULL, hog_sci_mode_notify), \
+	GATT_HANDLER(0x2c3a, hog_sci_info_read, NULL, NULL)
 
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
diff --git a/src/main.conf b/src/main.conf
index 5846ef92d98d..39584e225c38 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -289,7 +289,7 @@
 # Export claimed services by plugins
 # Possible values: no, read-only, read-write
 # Default: read-only
-#ExportClaimedServices = read-only
+ExportClaimedServices = read-write
 
 # Security level:
 # Sets security level of ATT channel, setting security anything other than
-- 
2.53.0

