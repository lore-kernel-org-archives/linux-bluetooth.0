Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D02FB093
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810581; cv=none; b=aETuuxSUoM5phMPbBbOj+eqDlIxY+EO3frCHQNuTRV7fEVHoYvWUYTtC0L5FCcSUT1m5OFRa55cx0WOXWfNJyiKnQtDN2UCC7RhnsnaYx3jDyx2I35LxwIhoblW8/5ZwBAs6x1TKo4Ui/jKW/yfJbjXd34bJb/6Fwvi4LZdLy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810581; c=relaxed/simple;
	bh=rUE5HZgo1c2zzKWDGgWnOkHm5Ox6izAIHvkfveqplpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StvH1Q/ye4DBYyuRdRNBPAHrszUFNxxS3pQLnVGFJYQ1GZynRxxVPo1IRWiN8U0qihf9M4nce3L2R4JAxzr1lYp1czEONyCapHu57kiDxtjr04YtBnfSAamXcV5h74V69wRuAmSPWL/sM/jnmxvg4NZtlre5f51ORiP/t421KiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0rHiDUM; arc=none smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0rHiDUM"
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-5f53021703aso845671137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810578; x=1770415378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IfTXbPMbgVtzF/gDYXEBrFe5L1j4eJB2s2bTx/9zE4=;
        b=L0rHiDUMV9dcM4CwAGdHO4o1b1cUvXUC1u0JE4Xc9cm+YYrk7Pk3s6TP9XOPXOeJrk
         mr31RHGm8HmJkvOELMlEmw8YDuTVOO6he+EIZRPshf1eqa0RrN2h7JFsUqUzmfg1Jed1
         MisdJmHTx6RLY5Ktexx6AR+CIgb+gu11/k58GVNGLpgdwYjVXPa020mOfabJVjt9dK/i
         NqSi8gE7qgBchhiPfeIYT7fzlhDBkejP0B9eQiRpLO7O7tg402iscujTJJrtMUM4/gxe
         6yJLzF6vqOOyiMOSJMK5UlFy+p1L3RVsWpWUyqSIOJ/o7YS0abHf6fDFvh4O8eKrTP0x
         Vt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810578; x=1770415378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IfTXbPMbgVtzF/gDYXEBrFe5L1j4eJB2s2bTx/9zE4=;
        b=GVXdzxaEi1QXdLJcJtEG2zkkvbS9A9fYKmFwXs54dz8HXXNcrfBxoGeGcQ7qwp8yIx
         W6bH6WspciYqsHAS6JyY8yOiXCM12Fss7a9Tz7pccogd2YhyNkji10qviGUve+/kTtf2
         XKjStB1wTx20C/Y4inipQFs6urCjBMeXBjQesP9cIQ0WPfWn+fFvs8bSleZpkpip+kur
         m7bn6I4mP0IIgn8OsOpKaJ2HsmozrumaEMeoOCR72GkLV0NGMZkjX6+4cmH0kkZewTMB
         mdXwFARPHZ6rOQeSRefLiDMgtKRI34j+w1jPHgDQ9J+qSfU7hMP3E6Wq8lE8IxEv0bYx
         1qXg==
X-Gm-Message-State: AOJu0YxUJtETt+iY8f1qEOtMMgjm1Ak7hD535FNj+EBYrxAd+7QO9IXC
	2u0CE3Fk1FdBQvsk7+orXINAoVDIi/0zwJA0gFtCnkpGbQe3Hkxp540nhiKDX83u
X-Gm-Gg: AZuq6aJl16Hq1xJQBSFs9TrZv5fveZQ8K1Ijz5MOol6NF3KMq8As8MG3IXrdxhZ5UFc
	XOmAZ93UigQ7/pApDI5YzJsXvBm8XEcGwGdm5Fv1lIWlRjmDrvY8EXFVMgTzIgGM5wEM8nZWTRx
	VBKxooFyZfujEWFkjzc29w1S0RSIq4Jo3ZwyDGdDGHcN5XG6NaRBuhDGY3a7NulTNYCPeOqGWiG
	876z0wx0+LebUq7nWRI6jTpPh6BBBEMwU4jExe6RdRRVnP8MnCH3+50Kve3tGoLr3LnSd7DsO/M
	6Qpe2tIdRuYH85yg0SXmGOjnC+KQLNssj6W5jm0sTLzKcvk/pm4oAqowhhANWNro8e4hy0haEZ/
	EbQlJoJlNVVlnzyaUMdWwQQpVuyvsm9/fNEer8OW75Tb1a9ZVNFqgxKSBBEv28ZrWBxjsIKkKjo
	t5/RtjJLbP8mj0n/2cpKOlDWIU8NFdzo0h1h3zSFZqDPCBKJ4ofiOzGpfDByXs94VvuK3OJeQYd
	PCYsixBPJ+BXT6r
X-Received: by 2002:a05:6102:3e89:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f8e26860f1mr1496739137.38.1769810576670;
        Fri, 30 Jan 2026 14:02:56 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 13/37] doc/bluetoothctl-scan: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:04 -0500
Message-ID: <20260130220229.1346261-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-scan.rst | 126 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-scan.rst b/doc/bluetoothctl-scan.rst
index cee255131622..16b4d08daddf 100644
--- a/doc/bluetoothctl-scan.rst
+++ b/doc/bluetoothctl-scan.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [scan.commands]
 
+This submenu configures discovery filters using **org.bluez.Adapter(5)**
+method **SetDiscoveryFilter**.
+
 Scan Commands
 =============
 
@@ -27,6 +30,24 @@ uuids
 Set/Get UUIDs filter.
 
 :Usage: **> uuids [all/uuid1 uuid2 ...]**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **UUIDs**
+:[all/uuid1 uuid2 ...]: List of UUIDs to filter for during scanning (default: none, use "all" to scan for any UUID)
+:Example Show current UUID filter settings:
+	| **> uuids**
+:Example Filter for Generic Access service only:
+	| **> uuids 0x1800**
+:Example Filter for Battery service only:
+	| **> uuids 0x180F**
+:Example Filter for Generic Access and Battery services:
+	| **> uuids 0x1800 0x180F**
+:Example Filter for Device Info, Battery, and Environmental Sensing:
+	| **> uuids 0x180A 0x180F 0x181A**
+:Example Filter for Generic Access using full UUID:
+	| **> uuids 00001800-0000-1000-8000-00805f9b34fb**
+:Example Filter using mixed short and long forms:
+	| **> uuids 00001800-0000-1000-8000-00805f9b34fb 0000180f-0000-1000-8000-00805f9b34fb**
+:Example Remove UUID filtering (scan for all devices):
+	| **> uuids all**
 
 rssi
 ----
@@ -41,7 +62,20 @@ If one or more discovery filters have been set, the RSSI delta-threshold imposed
 by starting discovery by default will not be applied.
 
 :Usage: **> rssi [rssi]**
-:Example: **> rssi -60**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **RSSI**
+:[rssi]: Minimum RSSI threshold value in dBm (optional, shows current if omitted)
+:Example Show current RSSI filter setting:
+	| **> rssi**
+:Example Only report devices with RSSI ≥ -60 dBm (close range):
+	| **> rssi -60**
+:Example Report devices with RSSI ≥ -80 dBm (medium range):
+	| **> rssi -80**
+:Example Report devices with RSSI ≥ -90 dBm (extended range):
+	| **> rssi -90**
+:Example Report only very close devices (RSSI ≥ -40 dBm):
+	| **> rssi -40**
+:Example Report devices with very weak signals (maximum sensitivity):
+	| **> rssi -100**
 
 pathloss
 --------
@@ -55,7 +89,20 @@ If one or more discovery filters have been set, the RSSI delta-threshold
 imposed by starting discovery by default will not be applied.
 
 :Usage: **> pathloss [pathloss]**
-:Example: **> pathloss 4**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **Pathloss**
+:[pathloss]: Maximum pathloss threshold value in dB (optional, shows current if omitted)
+:Example Show current pathloss filter setting:
+	| **> pathloss**
+:Example Report devices with maximum 4 dB pathloss (very close):
+	| **> pathloss 4**
+:Example Report devices with maximum 10 dB pathloss (close range):
+	| **> pathloss 10**
+:Example Report devices with maximum 20 dB pathloss (medium range):
+	| **> pathloss 20**
+:Example Report devices with maximum 30 dB pathloss (extended range):
+	| **> pathloss 30**
+:Example Report devices with maximum 50 dB pathloss (maximum range):
+	| **> pathloss 50**
 
 transport
 ---------
@@ -79,6 +126,15 @@ If "auto" transport is requested, the scan will use LE, BREDR, or both,
 depending on what's currently enabled on the controller.
 
 :Usage: **> transport [auto/bredr/le]**
+:[auto/bredr/le]: Transport type for scanning (optional, shows current if omitted)
+:Example Show current transport filter setting:
+	| **> transport**
+:Example Use automatic transport selection (LE + BR/EDR):
+	| **> transport auto**
+:Example Scan only Low Energy devices:
+	| **> transport le**
+:Example Scan only BR/EDR (Classic Bluetooth) devices:
+	| **> transport bredr**
 
 duplicate-data
 --------------
@@ -91,6 +147,13 @@ When enabled, PropertiesChanged signals will be generated for ManufacturerData
 and ServiceData every time they are discovered.
 
 :Usage: **> duplicate-data [on/off]**
+:[on/off]: Enable or disable duplicate advertisement data reporting (optional, shows current if omitted)
+:Example Show current duplicate data filter setting:
+	| **> duplicate-data**
+:Example Enable reporting of duplicate advertisement data:
+	| **> duplicate-data on**
+:Example Disable duplicate data reporting (filter duplicates):
+	| **> duplicate-data off**
 
 discoverable
 ------------
@@ -103,6 +166,13 @@ If the adapter is already discoverable, setting this filter won't have any
 effect.
 
 :Usage: **> discoverable [on/off]**
+:[on/off]: Make adapter discoverable during scanning (optional, shows current if omitted)
+:Example Show current discoverable filter setting:
+	| **> discoverable**
+:Example Make adapter discoverable during scanning:
+	| **> discoverable on**
+:Example Keep adapter non-discoverable during scanning:
+	| **> discoverable off**
 
 pattern
 -------
@@ -120,7 +190,21 @@ When set, it disregards device discoverable flags.
        string "" pattern will match any device found.
 
 :Usage: **> pattern [value]**
-
+:[value]: Pattern to match device address prefix or name (optional, shows current if omitted)
+:Example Show current pattern filter setting:
+	| **> pattern**
+:Example Discover devices with "Samsung" in the name:
+	| **> pattern Samsung**
+:Example Discover devices with "iPhone" in the name:
+	| **> pattern iPhone**
+:Example Discover devices with "Headphones" in the name:
+	| **> pattern Headphones**
+:Example Discover devices with addresses starting with 00:11:22:
+	| **> pattern 00:11:22**
+:Example Discover devices with addresses starting with AA:BB:CC:
+	| **> pattern AA:BB:CC**
+:Example Clear pattern filter (match any device):
+	| **> pattern ""**
 
 auto-connect
 ------------
@@ -131,13 +215,47 @@ Connect to discovered devices automatically if pattern filter has been set and
 it matches the device address or name and the device is connectable.
 
 :Usage: **> auto-connect [on/off]**
+:[on/off]: Automatically connect to discovered devices matching pattern filter (optional, shows current if omitted)
+:Example Show current auto-connect filter setting:
+	| **> auto-connect**
+:Example Enable automatic connection to matching devices:
+	| **> auto-connect on**
+:Example Disable automatic connection (manual connection required):
+	| **> auto-connect off**
 
 clear
 -----
 
 Clears discovery filter.
 
-:Usage: **> clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]**
+:Usage: **> clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern/auto-connect]**
+:[uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern/auto-connect]: Specific filter(s) to clear (optional, clears all if omitted)
+:Example Clear all discovery filters:
+	| **> clear**
+:Example Clear only UUID filter:
+	| **> clear uuids**
+:Example Clear only RSSI filter:
+	| **> clear rssi**
+:Example Clear only pathloss filter:
+	| **> clear pathloss**
+:Example Clear only transport filter:
+	| **> clear transport**
+:Example Clear only duplicate data filter:
+	| **> clear duplicate-data**
+:Example Clear only discoverable filter:
+	| **> clear discoverable**
+:Example Clear only pattern filter:
+	| **> clear pattern**
+:Example Clear only auto-connect filter:
+	| **> clear auto-connect**
+:Example Clear UUID and RSSI filters:
+	| **> clear uuids rssi**
+:Example Clear transport and pattern filters:
+	| **> clear transport pattern**
+:Example Clear pattern and auto-connect filters:
+	| **> clear pattern auto-connect**
+:Example Clear RSSI, pathloss, and discoverable filters:
+	| **> clear rssi pathloss discoverable**
 
 RESOURCES
 =========
-- 
2.52.0

