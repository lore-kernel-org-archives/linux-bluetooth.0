Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76632E732
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728953; cv=none; b=Kr1wzb1t7ZxgggfeYnSDfyJM99tgxd1AN1NC6MIIFR9E1ir8G/XYJn4tEN2oa4uNDFOfqWFotlCXH4mvvsQZD7dtNRiU/lUkzIUU33lk7DUIx6sHa8VdLGBNYYsnlrbQHohBRKJtoWlDIbnAMdJphPvBKnxk/FC4kU03kSHFF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728953; c=relaxed/simple;
	bh=/3xD+6EEOWulTyGJ8GCptKW3dXZyWSUDNwkHZ3pNghs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0WgMe/qKEwdu6PYEAXCCTQb7x7eZNJ6zYmNVJ7HYmV4Y+yTi+rBtQ6CpPRHsiRVaa+kr0bw5KVoSfNIwsqioQWdSLFqzxAQbhjCHE3Yumfmd9NxQZ4YyJKzwKjlMFqCSQ7bgtNj+witq04cI+ckhGKnBDlbrullAOHLqkeDSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBLD0Hku; arc=none smtp.client-ip=209.85.217.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBLD0Hku"
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-5f55e83e065so567168137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728951; x=1770333751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr7d5d65b7EDPWFCjdEzfhWK3rFnTyaLwdT6HXfxsZ8=;
        b=lBLD0HkuG9bxPBT8iYnAeoJDGQPPVyGQ61c+jsICn+b4w1UcCZPAgNIFLhpRCgGZ/A
         HBcfTlHsDnNlNGJ1e+MK5NAUPmF2mSdEXvd5Ct1Vpv+QL26NQ8C5zmAofKisMXKJDI8f
         kLB8frkQC81FytvSdMoPtOrWuNHfzKRxlxiJ7tgoBS0vUVsZfK4kYEcUJ2SuKFrgxH63
         Pjr8L3aQl4P0deY7iz63PeWLD4cBibOE0M7iaG4vrvUgDN4vcEZFdfPLvZk6P41yo8m1
         X4LJseAgjoZ/2WAruYtP/e0U4jmo9+kwZQkMgv8J9kE80hy5zQRIkLuNABJrJzNcBhw0
         Kg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728951; x=1770333751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kr7d5d65b7EDPWFCjdEzfhWK3rFnTyaLwdT6HXfxsZ8=;
        b=eKh6w4Noo3wKiKWwC45w4UzVkLM53oDNMvHJv0np3IC4YdQI29i7ty6i4wRiDWuRSF
         CPyV65Uk2600faJMkmaEglCGS+xqX599awo4QfCle5Qk18nGSsnvd4K7b4ZjsS4m6U0l
         rvrzh1f3ZagVXD2dt4ibu3mIlPu6HquM/ydFEuYtqJw9KqQVqANhUI6E+NwYM7ibTOFR
         L+7oJi7Ao4JFposyNfJaoF8qRGsAOY9E8c/x+uCRAivQQq0hBdUdASbcH1SaRT5YSgLK
         UJrxs7AZ3a8FbdVna6q01Q+q76jykIL12ZVKMGHxhWtyAoPLh9PfNEgwYOxmfMaFtKaF
         Ql+A==
X-Gm-Message-State: AOJu0YyRmx+YrTFNC3HqVteAzJdPVrSZL4JEC6wh5/jAtrq37B5R5EXP
	xPTSvCHnCZXMzWhK6vVw60KIg0BH5BNELm/2QLWpR2pQCzVJlWbGFxxIWZhCXGdpy4o=
X-Gm-Gg: AZuq6aL6UAZXu3bGYOclLbpu35lXy7cqFlhGanYfx0I+tV+ELI8/P32F/qD0l/Nwjkt
	TZuCAD6W5E033e/yuKOGzBfOKWqyWLu9QfM45Wl5Msq+gjhiCvIylmDyKXzDQm+CCLsdbaviUlc
	z5cooOmwsJdO8cjBijlG7P5jPRqLEw/Ee18mIfcfGJN1iqgKIKIiHNUAoKTnpkdScek6oDbkrZh
	4povEgzuu/4ENmN4fyrgtFWlbiVxqVcNx0YlxcDuBglSA0UTdeGBY6Yj6CitCTMohqtrB2MdYaK
	BWyv3ZkK/hwgKHLpI28RQLbaGVbBloH+2QhJ9j+hq04CdUeDCrluB7Ps1hxX2o/k6DqEZ8L6uWW
	nzGBrFmFSiCo8se8weyOYDYzBS9yuuATDKYydNXNu4w/0XZ8PDhTeJ6huHND3obrDaLpnLTGdni
	E12HgQ3sP9G2vvCVYl+rrfPeJrnPx19iuMEY9+CciY40FRFLwOPlXSfh6we7gZPdzbUpMAUVRGH
	d7kAQ==
X-Received: by 2002:a05:6102:d86:b0:5ef:b3fa:c89a with SMTP id ada2fe7eead31-5f8e26ffc83mr339053137.32.1769728950763;
        Thu, 29 Jan 2026 15:22:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 13/15] doc/bluetoothctl-scan: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:52 -0500
Message-ID: <20260129232201.1049568-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive parameter documentation for all scan filter commands
including uuids, rssi, pathloss, transport, duplicate-data, discoverable,
pattern, auto-connect and clear options. Documents filter parameters
and threshold values for device discovery.
---
 doc/bluetoothctl-scan.rst | 120 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-scan.rst b/doc/bluetoothctl-scan.rst
index cee255131622..29fa67514479 100644
--- a/doc/bluetoothctl-scan.rst
+++ b/doc/bluetoothctl-scan.rst
@@ -27,6 +27,23 @@ uuids
 Set/Get UUIDs filter.
 
 :Usage: **> uuids [all/uuid1 uuid2 ...]**
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
@@ -41,7 +58,19 @@ If one or more discovery filters have been set, the RSSI delta-threshold imposed
 by starting discovery by default will not be applied.
 
 :Usage: **> rssi [rssi]**
-:Example: **> rssi -60**
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
@@ -55,7 +84,19 @@ If one or more discovery filters have been set, the RSSI delta-threshold
 imposed by starting discovery by default will not be applied.
 
 :Usage: **> pathloss [pathloss]**
-:Example: **> pathloss 4**
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
@@ -79,6 +120,15 @@ If "auto" transport is requested, the scan will use LE, BREDR, or both,
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
@@ -91,6 +141,13 @@ When enabled, PropertiesChanged signals will be generated for ManufacturerData
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
@@ -103,6 +160,13 @@ If the adapter is already discoverable, setting this filter won't have any
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
@@ -120,7 +184,21 @@ When set, it disregards device discoverable flags.
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
@@ -131,13 +209,47 @@ Connect to discovered devices automatically if pattern filter has been set and
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

