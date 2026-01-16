Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B712F3618
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590695; cv=none; b=RI5MO0fvSGd1QUw4bLHeGMwrmXk4VWmtkfvDIqezj8UuDIbZ3F22YW6NpBA28ODCu4SLesX0/sLZ1EdHlllT8XQ59VkA8kRV95+SfUPTabevEbmFOWqA0C5PRE1xOM6coXORIGHnrBGy21VaDCIv/BiIUhawuOgD+UsA01H2nUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590695; c=relaxed/simple;
	bh=pSBXse7HYfH0RYP482tD85YWsrjRvrbKOpjAn8ZSwT8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RPVbM9GZYCabCbqHnbj0YZtTq8aIjy+iX6cEqHRQa1+bPG0Sj+m2zFM50wPT2WHnkgcTWASUZbN6C7b50beHsi5DPH8CpTSg2VDCN0sENpvQGdQUCzxIs9dAhOa8q7RnEEm6oKfldqQYMht4AFwFwjKTj32TJWXPxRQkgoq9/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN2Y0V4U; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN2Y0V4U"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5f16fbbdf98so790346137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768590692; x=1769195492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdBDMILOUtttgNT1jQaX0jgcP+s66wBFOzds+C4MRQw=;
        b=FN2Y0V4UMPn+BFO1Z3jO1WwahJdpmZ9R70lvYDpCu9CnOFJbvWIcp7JpSrEESH2Mr/
         ysKmbE67l+CqapXXHLd3KVpJ4mLtRNaoTs4tIABw38O4MfLKCtlTyKKCoyNul98fXHW4
         mGo35981abzHhxnGOn1Mds2RejX5UTBu1KYtsQ+r/CvNfAIfdZ+GKGQHXzzJPnXx56Qi
         KTlAaZVqt8gblsqPPzsp1ES/rID0Of4v3jv8KB2cU7cpPqPZEozN5jmR6lTSCnKgtUj9
         oHYdeTS0rbZwvhGoqDkGjb1IHXJVf/cOdgWVdKozYK32UtscNGEJ+LMo3mWl9WxHIaps
         fWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768590692; x=1769195492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdBDMILOUtttgNT1jQaX0jgcP+s66wBFOzds+C4MRQw=;
        b=pEccw0utA9Kx9+uaWgS+L+eDgLNhTrdOWxdcohSAvehdmrbx5uGOlu2Pj97rjZWftD
         KOQVT5nyQw2URApjN8knMdWzq9U9G+qsTn8aGR70GzYCaQaaGteePyv+0gqGFQBeSsMm
         GOwvPShCBJEPCqel5/fPZNIjMTFPRZYr9dNx5Ai0OsPK69/mzMhjMpWVzVt8gTcdq9Qv
         QDvolnVK8sBAYfm8utX+ceQ5f07fh4y1h7aqzPqnTP7O/kzL7YMe6Kmb9XwKLtM6xiWG
         2HYEx9P5+ectFIrJUm9KO3dFTJjSs3CDjx7VEchqMLkhA3Ml3gn7DC0Ms3a+CP9LpmSK
         cwtg==
X-Gm-Message-State: AOJu0Yws+/++rv2getN+9ehKxJvsaA4AH6XkXDFspqhabnaIHF5tQMJs
	6F9qcpa13MlVZcnGcLtEoThzEWLZ69IFfKtqJKkFEb997z8RdLhRT9QojtyIIela
X-Gm-Gg: AY/fxX6aV8UnPyRJUqre8k1QdjLxd294a0stQFY5mCY9pxv6/t9qMXGJWYjpAYKQUIe
	lPRsepubJ3QgTjkcbAqY0112bXGrWcVwghW2w3OE0hZQwDyKEOd6PpePHGQPDiYOl0tzu5EZVaE
	sIcPJNp+EUOueznunNzkXIHzzTTBE3DW1olrCLe703MX7NDCkU85O752X4W3pgQG8s11MWUZ6h4
	yej5A4v+BPy+21122JnUvDHuVDsGmrhdqXs8bhlANeuXCgv5dIcFXtYduwtMqpbek866nSVgfLY
	FDUx/qh7e777Fo/Y39QjH/VgJk0DOHevxnikDFyKb0E1w17Qkyh8KfPLsiz2oqoIfYp+nkb9gvJ
	bjecSd0T7RNK7EG/BAepW2WkgepJ5GfYp5vcmL1mDAAhSXQpEsFmEs3r2GqUiTvmETQw8wpYYOl
	XXM3Nf++2gsk4atw83vkz/S0hBln6sjVIuC89//K7sv9NuzJMrXKFEaGu6799roJLwPqsimTgWF
	mSOIFyER00qFrrG
X-Received: by 2002:a05:6102:6c7:b0:5df:b3ed:2c8b with SMTP id ada2fe7eead31-5f1a55d79ccmr1207260137.38.1768590691738;
        Fri, 16 Jan 2026 11:11:31 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6772b70sm1134125137.0.2026.01.16.11.11.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:11:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/util: Add missing entries to bt_appear_to_str
Date: Fri, 16 Jan 2026 14:11:20 -0500
Message-ID: <20260116191120.1768270-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing entries to appearance_table to it can properly
decode appearance values as found in:

https://bitbucket.org/bluetooth-SIG/public/src/main/assigned_numbers/core/appearance_values.yaml
---
 src/shared/util.c | 403 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 349 insertions(+), 54 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index fabe4283094b..6f7ce0a25928 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1753,65 +1753,360 @@ const char *bt_uuidstr_to_str(const char *uuid)
 	return bt_uuid32_to_str(val);
 }
 
+#define BT_APPEAR(_cat, _subcat, _str) \
+	{ \
+		.val = (((_cat) << 6) | ((_subcat) & 0x3F)), \
+		.generic = ((_subcat) == 0), \
+		.str = (_str) \
+	}
+
 static const struct {
 	uint16_t val;
 	bool generic;
 	const char *str;
 } appearance_table[] = {
-	{    0, true,  "Unknown"		},
-	{   64, true,  "Phone"			},
-	{  128, true,  "Computer"		},
-	{  192, true,  "Watch"			},
-	{  193, false, "Sports Watch"		},
-	{  256, true,  "Clock"			},
-	{  320, true,  "Display"		},
-	{  384, true,  "Remote Control"		},
-	{  448, true,  "Eye-glasses"		},
-	{  512, true,  "Tag"			},
-	{  576, true,  "Keyring"		},
-	{  640, true,  "Media Player"		},
-	{  704, true,  "Barcode Scanner"	},
-	{  768, true,  "Thermometer"		},
-	{  769, false, "Thermometer: Ear"	},
-	{  832, true,  "Heart Rate Sensor"	},
-	{  833, false, "Heart Rate Belt"	},
-	{  896, true,  "Blood Pressure"		},
-	{  897, false, "Blood Pressure: Arm"	},
-	{  898, false, "Blood Pressure: Wrist"	},
-	{  960, true,  "Human Interface Device"	},
-	{  961, false, "Keyboard"		},
-	{  962, false, "Mouse"			},
-	{  963, false, "Joystick"		},
-	{  964, false, "Gamepad"		},
-	{  965, false, "Digitizer Tablet"	},
-	{  966, false, "Card Reader"		},
-	{  967, false, "Digital Pen"		},
-	{  968, false, "Barcode Scanner"	},
-	{ 1024, true,  "Glucose Meter"		},
-	{ 1088, true,  "Running Walking Sensor"			},
-	{ 1089, false, "Running Walking Sensor: In-Shoe"	},
-	{ 1090, false, "Running Walking Sensor: On-Shoe"	},
-	{ 1091, false, "Running Walking Sensor: On-Hip"		},
-	{ 1152, true,  "Cycling"				},
-	{ 1153, false, "Cycling: Cycling Computer"		},
-	{ 1154, false, "Cycling: Speed Sensor"			},
-	{ 1155, false, "Cycling: Cadence Sensor"		},
-	{ 1156, false, "Cycling: Power Sensor"			},
-	{ 1157, false, "Cycling: Speed and Cadence Sensor"	},
-	{ 1216, true,  "Undefined"				},
-
-	{ 3136, true,  "Pulse Oximeter"				},
-	{ 3137, false, "Pulse Oximeter: Fingertip"		},
-	{ 3138, false, "Pulse Oximeter: Wrist Worn"		},
-	{ 3200, true,  "Weight Scale"				},
-	{ 3264, true,  "Undefined"				},
-
-	{ 5184, true,  "Outdoor Sports Activity"		},
-	{ 5185, false, "Location Display Device"		},
-	{ 5186, false, "Location and Navigation Display Device"	},
-	{ 5187, false, "Location Pod"				},
-	{ 5188, false, "Location and Navigation Pod"		},
-	{ 5248, true,  "Undefined"				},
+	BT_APPEAR(0x0000, 0x00, "Unknown"),
+	BT_APPEAR(0x0001, 0x00, "Phone"),
+	BT_APPEAR(0x0002, 0x00, "Computer"),
+	BT_APPEAR(0x0002, 0x01, "Desktop Workstation"),
+	BT_APPEAR(0x0002, 0x02, "Server-class Computer"),
+	BT_APPEAR(0x0002, 0x03, "Laptop"),
+	BT_APPEAR(0x0002, 0x04, "Handheld PC/PDA (clamshell)"),
+	BT_APPEAR(0x0002, 0x05, "Palm-size PC/PDA"),
+	BT_APPEAR(0x0002, 0x06, "Wearable computer (watch size)"),
+	BT_APPEAR(0x0002, 0x07, "Tablet"),
+	BT_APPEAR(0x0002, 0x08, "Docking Station"),
+	BT_APPEAR(0x0002, 0x09, "All in One"),
+	BT_APPEAR(0x0002, 0x0A, "Blade Server"),
+	BT_APPEAR(0x0002, 0x0B, "Convertible"),
+	BT_APPEAR(0x0002, 0x0C, "Detachable"),
+	BT_APPEAR(0x0002, 0x0D, "IoT Gateway"),
+	BT_APPEAR(0x0002, 0x0E, "Mini PC"),
+	BT_APPEAR(0x0002, 0x0F, "Stick PC"),
+	BT_APPEAR(0x0003, 0x00, "Watch"),
+	BT_APPEAR(0x0003, 0x01, "Sports Watch"),
+	BT_APPEAR(0x0003, 0x02, "Smartwatch"),
+	BT_APPEAR(0x0004, 0x00, "Clock"),
+	BT_APPEAR(0x0005, 0x00, "Display"),
+	BT_APPEAR(0x0006, 0x00, "Remote Control"),
+	BT_APPEAR(0x0007, 0x00, "Eye-glasses"),
+	BT_APPEAR(0x0008, 0x00, "Tag"),
+	BT_APPEAR(0x0009, 0x00, "Keyring"),
+	BT_APPEAR(0x000A, 0x00, "Media Player"),
+	BT_APPEAR(0x000B, 0x00, "Barcode Scanner"),
+	BT_APPEAR(0x000C, 0x00, "Thermometer"),
+	BT_APPEAR(0x000C, 0x01, "Ear Thermometer"),
+	BT_APPEAR(0x000D, 0x00, "Heart Rate Sensor"),
+	BT_APPEAR(0x000D, 0x01, "Heart Rate Belt"),
+	BT_APPEAR(0x000E, 0x00, "Blood Pressure"),
+	BT_APPEAR(0x000E, 0x01, "Arm Blood Pressure"),
+	BT_APPEAR(0x000E, 0x02, "Wrist Blood Pressure"),
+	BT_APPEAR(0x000F, 0x00, "Human Interface Device"),
+	BT_APPEAR(0x000F, 0x01, "Keyboard"),
+	BT_APPEAR(0x000F, 0x02, "Mouse"),
+	BT_APPEAR(0x000F, 0x03, "Joystick"),
+	BT_APPEAR(0x000F, 0x04, "Gamepad"),
+	BT_APPEAR(0x000F, 0x05, "Digitizer Tablet"),
+	BT_APPEAR(0x000F, 0x06, "Card Reader"),
+	BT_APPEAR(0x000F, 0x07, "Digital Pen"),
+	BT_APPEAR(0x000F, 0x08, "Barcode Scanner"),
+	BT_APPEAR(0x000F, 0x09, "Touchpad"),
+	BT_APPEAR(0x000F, 0x0A, "Presentation Remote"),
+	BT_APPEAR(0x0010, 0x00, "Glucose Meter"),
+	BT_APPEAR(0x0011, 0x00, "Running Walking Sensor"),
+	BT_APPEAR(0x0011, 0x01, "In-Shoe Running Walking Sensor"),
+	BT_APPEAR(0x0011, 0x02, "On-Shoe Running Walking Sensor"),
+	BT_APPEAR(0x0011, 0x03, "On-Hip Running Walking Sensor"),
+	BT_APPEAR(0x0012, 0x00, "Cycling"),
+	BT_APPEAR(0x0012, 0x01, "Cycling Computer"),
+	BT_APPEAR(0x0012, 0x02, "Speed Sensor"),
+	BT_APPEAR(0x0012, 0x03, "Cadence Sensor"),
+	BT_APPEAR(0x0012, 0x04, "Power Sensor"),
+	BT_APPEAR(0x0012, 0x05, "Speed and Cadence Sensor"),
+	BT_APPEAR(0x0013, 0x00, "Control Device"),
+	BT_APPEAR(0x0013, 0x01, "Switch"),
+	BT_APPEAR(0x0013, 0x02, "Multi-switch"),
+	BT_APPEAR(0x0013, 0x03, "Button"),
+	BT_APPEAR(0x0013, 0x04, "Slider"),
+	BT_APPEAR(0x0013, 0x05, "Rotary Switch"),
+	BT_APPEAR(0x0013, 0x06, "Touch Panel"),
+	BT_APPEAR(0x0013, 0x07, "Single Switch"),
+	BT_APPEAR(0x0013, 0x08, "Double Switch"),
+	BT_APPEAR(0x0013, 0x09, "Triple Switch"),
+	BT_APPEAR(0x0013, 0x0A, "Battery Switch"),
+	BT_APPEAR(0x0013, 0x0B, "Energy Harvesting Switch"),
+	BT_APPEAR(0x0013, 0x0C, "Push Button"),
+	BT_APPEAR(0x0013, 0x0D, "Dial"),
+	BT_APPEAR(0x0014, 0x00, "Network Device"),
+	BT_APPEAR(0x0014, 0x01, "Access Point"),
+	BT_APPEAR(0x0014, 0x02, "Mesh Device"),
+	BT_APPEAR(0x0014, 0x03, "Mesh Network Proxy"),
+	BT_APPEAR(0x0015, 0x00, "Sensor"),
+	BT_APPEAR(0x0015, 0x01, "Motion Sensor"),
+	BT_APPEAR(0x0015, 0x02, "Air quality Sensor"),
+	BT_APPEAR(0x0015, 0x03, "Temperature Sensor"),
+	BT_APPEAR(0x0015, 0x04, "Humidity Sensor"),
+	BT_APPEAR(0x0015, 0x05, "Leak Sensor"),
+	BT_APPEAR(0x0015, 0x06, "Smoke Sensor"),
+	BT_APPEAR(0x0015, 0x07, "Occupancy Sensor"),
+	BT_APPEAR(0x0015, 0x08, "Contact Sensor"),
+	BT_APPEAR(0x0015, 0x09, "Carbon Monoxide Sensor"),
+	BT_APPEAR(0x0015, 0x0A, "Carbon Dioxide Sensor"),
+	BT_APPEAR(0x0015, 0x0B, "Ambient Light Sensor"),
+	BT_APPEAR(0x0015, 0x0C, "Energy Sensor"),
+	BT_APPEAR(0x0015, 0x0D, "Color Light Sensor"),
+	BT_APPEAR(0x0015, 0x0E, "Rain Sensor"),
+	BT_APPEAR(0x0015, 0x0F, "Fire Sensor"),
+	BT_APPEAR(0x0015, 0x10, "Wind Sensor"),
+	BT_APPEAR(0x0015, 0x11, "Proximity Sensor"),
+	BT_APPEAR(0x0015, 0x12, "Multi-Sensor"),
+	BT_APPEAR(0x0015, 0x13, "Flush Mounted Sensor"),
+	BT_APPEAR(0x0015, 0x14, "Ceiling Mounted Sensor"),
+	BT_APPEAR(0x0015, 0x15, "Wall Mounted Sensor"),
+	BT_APPEAR(0x0015, 0x16, "Multisensor"),
+	BT_APPEAR(0x0015, 0x17, "Energy Meter"),
+	BT_APPEAR(0x0015, 0x18, "Flame Detector"),
+	BT_APPEAR(0x0015, 0x19, "Vehicle Tire Pressure Sensor"),
+	BT_APPEAR(0x0016, 0x00, "Light Fixtures"),
+	BT_APPEAR(0x0016, 0x01, "Wall Light"),
+	BT_APPEAR(0x0016, 0x02, "Ceiling Light"),
+	BT_APPEAR(0x0016, 0x03, "Floor Light"),
+	BT_APPEAR(0x0016, 0x04, "Cabinet Light"),
+	BT_APPEAR(0x0016, 0x05, "Desk Light"),
+	BT_APPEAR(0x0016, 0x06, "Troffer Light"),
+	BT_APPEAR(0x0016, 0x07, "Pendant Light"),
+	BT_APPEAR(0x0016, 0x08, "In-ground Light"),
+	BT_APPEAR(0x0016, 0x09, "Flood Light"),
+	BT_APPEAR(0x0016, 0x0A, "Underwater Light"),
+	BT_APPEAR(0x0016, 0x0B, "Bollard with Light"),
+	BT_APPEAR(0x0016, 0x0C, "Pathway Light"),
+	BT_APPEAR(0x0016, 0x0D, "Garden Light"),
+	BT_APPEAR(0x0016, 0x0E, "Pole-top Light"),
+	BT_APPEAR(0x0016, 0x0F, "Spotlight"),
+	BT_APPEAR(0x0016, 0x10, "Linear Light"),
+	BT_APPEAR(0x0016, 0x11, "Street Light"),
+	BT_APPEAR(0x0016, 0x12, "Shelves Light"),
+	BT_APPEAR(0x0016, 0x13, "Bay Light"),
+	BT_APPEAR(0x0016, 0x14, "Emergency Exit Light"),
+	BT_APPEAR(0x0016, 0x15, "Light Controller"),
+	BT_APPEAR(0x0016, 0x16, "Light Driver"),
+	BT_APPEAR(0x0016, 0x17, "Bulb"),
+	BT_APPEAR(0x0016, 0x18, "Low-bay Light"),
+	BT_APPEAR(0x0016, 0x19, "High-bay Light"),
+	BT_APPEAR(0x0017, 0x00, "Fan"),
+	BT_APPEAR(0x0017, 0x01, "Ceiling Fan"),
+	BT_APPEAR(0x0017, 0x02, "Axial Fan"),
+	BT_APPEAR(0x0017, 0x03, "Exhaust Fan"),
+	BT_APPEAR(0x0017, 0x04, "Pedestal Fan"),
+	BT_APPEAR(0x0017, 0x05, "Desk Fan"),
+	BT_APPEAR(0x0017, 0x06, "Wall Fan"),
+	BT_APPEAR(0x0018, 0x00, "HVAC"),
+	BT_APPEAR(0x0018, 0x01, "Thermostat"),
+	BT_APPEAR(0x0018, 0x02, "Humidifier"),
+	BT_APPEAR(0x0018, 0x03, "De-humidifier"),
+	BT_APPEAR(0x0018, 0x04, "Heater"),
+	BT_APPEAR(0x0018, 0x05, "Radiator"),
+	BT_APPEAR(0x0018, 0x06, "Boiler"),
+	BT_APPEAR(0x0018, 0x07, "Heat Pump"),
+	BT_APPEAR(0x0018, 0x08, "Infrared Heater"),
+	BT_APPEAR(0x0018, 0x09, "Radiant Panel Heater"),
+	BT_APPEAR(0x0018, 0x0A, "Fan Heater"),
+	BT_APPEAR(0x0018, 0x0B, "Air Curtain"),
+	BT_APPEAR(0x0019, 0x00, "Air Conditioning"),
+	BT_APPEAR(0x001A, 0x00, "Humidifier"),
+	BT_APPEAR(0x001B, 0x00, "Heating"),
+	BT_APPEAR(0x001B, 0x01, "Radiator"),
+	BT_APPEAR(0x001B, 0x02, "Boiler"),
+	BT_APPEAR(0x001B, 0x03, "Heat Pump"),
+	BT_APPEAR(0x001B, 0x04, "Infrared Heater"),
+	BT_APPEAR(0x001B, 0x05, "Radiant Panel Heater"),
+	BT_APPEAR(0x001B, 0x06, "Fan Heater"),
+	BT_APPEAR(0x001B, 0x07, "Air Curtain"),
+	BT_APPEAR(0x001C, 0x00, "Access Control"),
+	BT_APPEAR(0x001C, 0x01, "Access Door"),
+	BT_APPEAR(0x001C, 0x02, "Garage Door"),
+	BT_APPEAR(0x001C, 0x03, "Emergency Exit Door"),
+	BT_APPEAR(0x001C, 0x04, "Access Lock"),
+	BT_APPEAR(0x001C, 0x05, "Elevator"),
+	BT_APPEAR(0x001C, 0x06, "Window"),
+	BT_APPEAR(0x001C, 0x07, "Entrance Gate"),
+	BT_APPEAR(0x001C, 0x08, "Door Lock"),
+	BT_APPEAR(0x001C, 0x09, "Locker"),
+	BT_APPEAR(0x001D, 0x00, "Motorized Device"),
+	BT_APPEAR(0x001D, 0x01, "Motorized Gate"),
+	BT_APPEAR(0x001D, 0x02, "Awning"),
+	BT_APPEAR(0x001D, 0x03, "Blinds or Shades"),
+	BT_APPEAR(0x001D, 0x04, "Curtains"),
+	BT_APPEAR(0x001D, 0x05, "Screen"),
+	BT_APPEAR(0x001E, 0x00, "Power Device"),
+	BT_APPEAR(0x001E, 0x01, "Power Outlet"),
+	BT_APPEAR(0x001E, 0x02, "Power Strip"),
+	BT_APPEAR(0x001E, 0x03, "Plug"),
+	BT_APPEAR(0x001E, 0x04, "Power Supply"),
+	BT_APPEAR(0x001E, 0x05, "LED Driver"),
+	BT_APPEAR(0x001E, 0x06, "Fluorescent Lamp Gear"),
+	BT_APPEAR(0x001E, 0x07, "HID Lamp Gear"),
+	BT_APPEAR(0x001E, 0x08, "Charge Case"),
+	BT_APPEAR(0x001E, 0x09, "Power Bank"),
+	BT_APPEAR(0x001F, 0x00, "Light Source"),
+	BT_APPEAR(0x001F, 0x01, "Incandescent Light Bulb"),
+	BT_APPEAR(0x001F, 0x02, "LED Lamp"),
+	BT_APPEAR(0x001F, 0x03, "HID Lamp"),
+	BT_APPEAR(0x001F, 0x04, "Fluorescent Lamp"),
+	BT_APPEAR(0x001F, 0x05, "LED Array"),
+	BT_APPEAR(0x001F, 0x06, "Multi-Color LED Array"),
+	BT_APPEAR(0x001F, 0x07, "Low voltage halogen"),
+	BT_APPEAR(0x001F, 0x08, "Organic light emitting diode (OLED)"),
+	BT_APPEAR(0x0020, 0x00, "Window Covering"),
+	BT_APPEAR(0x0020, 0x01, "Window Shades"),
+	BT_APPEAR(0x0020, 0x02, "Window Blinds"),
+	BT_APPEAR(0x0020, 0x03, "Window Awning"),
+	BT_APPEAR(0x0020, 0x04, "Window Curtain"),
+	BT_APPEAR(0x0020, 0x05, "Exterior Shutter"),
+	BT_APPEAR(0x0020, 0x06, "Exterior Screen"),
+	BT_APPEAR(0x0021, 0x00, "Audio Sink"),
+	BT_APPEAR(0x0021, 0x01, "Standalone Speaker"),
+	BT_APPEAR(0x0021, 0x02, "Soundbar"),
+	BT_APPEAR(0x0021, 0x03, "Bookshelf Speaker"),
+	BT_APPEAR(0x0021, 0x04, "Standmounted Speaker"),
+	BT_APPEAR(0x0021, 0x05, "Speakerphone"),
+	BT_APPEAR(0x0022, 0x00, "Audio Source"),
+	BT_APPEAR(0x0022, 0x01, "Microphone"),
+	BT_APPEAR(0x0022, 0x02, "Alarm"),
+	BT_APPEAR(0x0022, 0x03, "Bell"),
+	BT_APPEAR(0x0022, 0x04, "Horn"),
+	BT_APPEAR(0x0022, 0x05, "Broadcasting Device"),
+	BT_APPEAR(0x0022, 0x06, "Service Desk"),
+	BT_APPEAR(0x0022, 0x07, "Kiosk"),
+	BT_APPEAR(0x0022, 0x08, "Broadcasting Room"),
+	BT_APPEAR(0x0022, 0x09, "Auditorium"),
+	BT_APPEAR(0x0023, 0x00, "Motorized Vehicle"),
+	BT_APPEAR(0x0023, 0x01, "Car"),
+	BT_APPEAR(0x0023, 0x02, "Large Goods Vehicle"),
+	BT_APPEAR(0x0023, 0x03, "2-Wheeled Vehicle"),
+	BT_APPEAR(0x0023, 0x04, "Motorbike"),
+	BT_APPEAR(0x0023, 0x05, "Scooter"),
+	BT_APPEAR(0x0023, 0x06, "Moped"),
+	BT_APPEAR(0x0023, 0x07, "3-Wheeled Vehicle"),
+	BT_APPEAR(0x0023, 0x08, "Light Vehicle"),
+	BT_APPEAR(0x0023, 0x09, "Quad Bike"),
+	BT_APPEAR(0x0023, 0x0A, "Minibus"),
+	BT_APPEAR(0x0023, 0x0B, "Bus"),
+	BT_APPEAR(0x0023, 0x0C, "Trolley"),
+	BT_APPEAR(0x0023, 0x0D, "Agricultural Vehicle"),
+	BT_APPEAR(0x0023, 0x0E, "Camper / Caravan"),
+	BT_APPEAR(0x0023, 0x0F, "Recreational Vehicle / Motor Home"),
+	BT_APPEAR(0x0024, 0x00, "Domestic Appliance"),
+	BT_APPEAR(0x0024, 0x01, "Refrigerator"),
+	BT_APPEAR(0x0024, 0x02, "Freezer"),
+	BT_APPEAR(0x0024, 0x03, "Oven"),
+	BT_APPEAR(0x0024, 0x04, "Microwave"),
+	BT_APPEAR(0x0024, 0x05, "Toaster"),
+	BT_APPEAR(0x0024, 0x06, "Washing Machine"),
+	BT_APPEAR(0x0024, 0x07, "Dryer"),
+	BT_APPEAR(0x0024, 0x08, "Coffee maker"),
+	BT_APPEAR(0x0024, 0x09, "Clothes iron"),
+	BT_APPEAR(0x0024, 0x0A, "Curling iron"),
+	BT_APPEAR(0x0024, 0x0B, "Hair dryer"),
+	BT_APPEAR(0x0024, 0x0C, "Vacuum cleaner"),
+	BT_APPEAR(0x0024, 0x0D, "Robotic vacuum cleaner"),
+	BT_APPEAR(0x0024, 0x0E, "Rice cooker"),
+	BT_APPEAR(0x0024, 0x0F, "Clothes steamer"),
+	BT_APPEAR(0x0025, 0x00, "Wearable Audio Device"),
+	BT_APPEAR(0x0025, 0x01, "Earbud"),
+	BT_APPEAR(0x0025, 0x02, "Headset"),
+	BT_APPEAR(0x0025, 0x03, "Headphones"),
+	BT_APPEAR(0x0025, 0x04, "Neck Band"),
+	BT_APPEAR(0x0025, 0x05, "Left Earbud"),
+	BT_APPEAR(0x0025, 0x06, "Right Earbud"),
+	BT_APPEAR(0x0026, 0x00, "Aircraft"),
+	BT_APPEAR(0x0026, 0x01, "Light Aircraft"),
+	BT_APPEAR(0x0026, 0x02, "Microlight"),
+	BT_APPEAR(0x0026, 0x03, "Paraglider"),
+	BT_APPEAR(0x0026, 0x04, "Large Passenger Aircraft"),
+	BT_APPEAR(0x0027, 0x00, "AV Equipment"),
+	BT_APPEAR(0x0027, 0x01, "Amplifier"),
+	BT_APPEAR(0x0027, 0x02, "Receiver"),
+	BT_APPEAR(0x0027, 0x03, "Radio"),
+	BT_APPEAR(0x0027, 0x04, "Tuner"),
+	BT_APPEAR(0x0027, 0x05, "Turntable"),
+	BT_APPEAR(0x0027, 0x06, "CD Player"),
+	BT_APPEAR(0x0027, 0x07, "DVD Player"),
+	BT_APPEAR(0x0027, 0x08, "Bluray Player"),
+	BT_APPEAR(0x0027, 0x09, "Optical Disc Player"),
+	BT_APPEAR(0x0027, 0x0A, "Set-Top Box"),
+	BT_APPEAR(0x0028, 0x00, "Display Equipment"),
+	BT_APPEAR(0x0028, 0x01, "Television"),
+	BT_APPEAR(0x0028, 0x02, "Monitor"),
+	BT_APPEAR(0x0028, 0x03, "Projector"),
+	BT_APPEAR(0x0029, 0x00, "Hearing aid"),
+	BT_APPEAR(0x0029, 0x01, "In-ear hearing aid"),
+	BT_APPEAR(0x0029, 0x02, "Behind-ear hearing aid"),
+	BT_APPEAR(0x0029, 0x03, "Cochlear Implant"),
+	BT_APPEAR(0x002A, 0x00, "Gaming"),
+	BT_APPEAR(0x002A, 0x01, "Home Video Game Console"),
+	BT_APPEAR(0x002A, 0x02, "Portable handheld console"),
+	BT_APPEAR(0x002B, 0x00, "Signage"),
+	BT_APPEAR(0x002B, 0x01, "Digital Signage"),
+	BT_APPEAR(0x002B, 0x02, "Electronic Label"),
+	BT_APPEAR(0x0031, 0x00, "Pulse Oximeter"),
+	BT_APPEAR(0x0031, 0x01, "Fingertip Pulse Oximeter"),
+	BT_APPEAR(0x0031, 0x02, "Wrist Worn Pulse Oximeter"),
+	BT_APPEAR(0x0032, 0x00, "Weight Scale"),
+	BT_APPEAR(0x0033, 0x00, "Personal Mobility Device"),
+	BT_APPEAR(0x0033, 0x01, "Powered Wheelchair"),
+	BT_APPEAR(0x0033, 0x02, "Mobility Scooter"),
+	BT_APPEAR(0x0034, 0x00, "Continuous Glucose Monitor"),
+	BT_APPEAR(0x0035, 0x00, "Insulin Pump"),
+	BT_APPEAR(0x0035, 0x01, "Insulin Pump, durable pump"),
+	BT_APPEAR(0x0035, 0x04, "Insulin Pump, patch pump"),
+	BT_APPEAR(0x0035, 0x08, "Insulin Pen"),
+	BT_APPEAR(0x0036, 0x00, "Medication Delivery"),
+	BT_APPEAR(0x0037, 0x00, "Spirometer"),
+	BT_APPEAR(0x0037, 0x01, "Handheld Spirometer"),
+	BT_APPEAR(0x0051, 0x00, "Outdoor Sports Activity"),
+	BT_APPEAR(0x0051, 0x01, "Location Display"),
+	BT_APPEAR(0x0051, 0x02, "Location and Navigation Display"),
+	BT_APPEAR(0x0051, 0x03, "Location Pod"),
+	BT_APPEAR(0x0051, 0x04, "Location and Navigation Pod"),
+	BT_APPEAR(0x0052, 0x00, "Industrial Measurement Device"),
+	BT_APPEAR(0x0052, 0x01, "Torque Testing Device"),
+	BT_APPEAR(0x0052, 0x02, "Caliper"),
+	BT_APPEAR(0x0052, 0x03, "Dial Indicator"),
+	BT_APPEAR(0x0052, 0x04, "Micrometer"),
+	BT_APPEAR(0x0052, 0x05, "Height Gauge"),
+	BT_APPEAR(0x0052, 0x06, "Force Gauge"),
+	BT_APPEAR(0x0053, 0x00, "Industrial Tools"),
+	BT_APPEAR(0x0053, 0x01, "Machine Tool Holder"),
+	BT_APPEAR(0x0053, 0x02, "Generic Clamping Device"),
+	BT_APPEAR(0x0053, 0x03, "Clamping Jaws/Jaw Chuck"),
+	BT_APPEAR(0x0053, 0x04, "Clamping (Collet) Chuck"),
+	BT_APPEAR(0x0053, 0x05, "Clamping Mandrel"),
+	BT_APPEAR(0x0053, 0x06, "Vise"),
+	BT_APPEAR(0x0053, 0x07, "Zero-Point Clamping System"),
+	BT_APPEAR(0x0053, 0x08, "Torque Wrench"),
+	BT_APPEAR(0x0053, 0x09, "Torque Screwdriver"),
+	BT_APPEAR(0x0054, 0x00, "Cookware Device"),
+	BT_APPEAR(0x0054, 0x01, "Pot and Jugs"),
+	BT_APPEAR(0x0054, 0x02, "Pressure Cooker"),
+	BT_APPEAR(0x0054, 0x03, "Slow Cooker"),
+	BT_APPEAR(0x0054, 0x04, "Steam Cooker"),
+	BT_APPEAR(0x0054, 0x05, "Saucepan"),
+	BT_APPEAR(0x0054, 0x06, "Frying Pan"),
+	BT_APPEAR(0x0054, 0x07, "Casserole"),
+	BT_APPEAR(0x0054, 0x08, "Dutch Oven"),
+	BT_APPEAR(0x0054, 0x09, "Grill Pan/Raclette Grill/Griddle Pan"),
+	BT_APPEAR(0x0054, 0x0A, "Braising Pan"),
+	BT_APPEAR(0x0054, 0x0B, "Wok Pan"),
+	BT_APPEAR(0x0054, 0x0C, "Paella Pan"),
+	BT_APPEAR(0x0054, 0x0D, "Crepe Pan"),
+	BT_APPEAR(0x0054, 0x0E, "Tagine"),
+	BT_APPEAR(0x0054, 0x0F, "Fondue"),
+	BT_APPEAR(0x0054, 0x10, "Lid"),
+	BT_APPEAR(0x0054, 0x11, "Wired Probe"),
+	BT_APPEAR(0x0054, 0x12, "Wireless Probe"),
+	BT_APPEAR(0x0054, 0x13, "Baking Molds"),
+	BT_APPEAR(0x0054, 0x14, "Baking Tray"),
 	{ }
 };
 
-- 
2.52.0

