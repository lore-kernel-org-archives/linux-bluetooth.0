Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A72E888A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801973; cv=none; b=eaR5ezYNFX9aO/ClmgTmn2g7PIJpdtSyUS8Ap/4UghrKIcA7yk9PcxNW/xZSjOtu47B+nknB02rtst+vrylUZAhhczOWmIel8nSxMgMrmFGjxhgPowrcOLuLQSyYnUOdyWZvm7fYDk/bKHKK7q7ZQaGTNF+O8NjXEDeQwHabiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801973; c=relaxed/simple;
	bh=wXGfvDBeVo1/31Pd4aLZILFgdgo83C4NyxVPOsaO9Yg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UUONdFqlIRRVvM6rlhuzHp+vw6lJELb3pYC3fSG+B1d7tEbqgGC7POMhXpfhcG2S4MLBncbzJ/pgKFdWakeb3gssNyxH+RwDV//QpjrfcVoFJoqdefi8Ae0QqCfre36xa69UWraDAyEaya/9sKT4pcSQ//SV/Xoqr14/7jjnttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBTVKpGj; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBTVKpGj"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-566390e7db3so1920814e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801970; x=1770406770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkK7QoBmjPqM3gwlgEIhkiPN0j3LE7vpi4vGzVCiYuo=;
        b=ZBTVKpGjyTYbVJZn6AixdzsWUMJjVHiQmpsn7uh1sarPS5HTZGyY1uYoyrooJNxPWY
         H/Kj4ybKuYFBzEY2tyMKF8FAlJXF5RKO5MUp/cyabrvk37wGQNlw2hb9zRYSpz8VzJKF
         J7+wZ2JOlT/GtDqvDgxbzd8cAuCW3b7szxKGHJV7EWKCdCi3vgKsl6GLASr7WRNpx18U
         tLMSAGRXykrUSW4QH7/PZhBC9WYa07J8iX3aY6dUUYBUBoI7FeV7v5l+8CvPGgJ4rNgN
         V0M2KnzzKKG7NqF5E01axdk0KL6eVas+Mfi+n9e5QDyI6t6Z0Cg4lchvSKk5fKS5p4lC
         M4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801970; x=1770406770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkK7QoBmjPqM3gwlgEIhkiPN0j3LE7vpi4vGzVCiYuo=;
        b=RQZVcrGt/E17aokU9TxAwcPPD+mZvsAY29D0a/s47RNUlB7W1GyEN05EFWx4VDYRmq
         SrObKNGXOo9JeS1uMd+8b/CmSNrtuA5t7sqQFv9PVctQquwKZEuY9GdAXge1zOWD7DhT
         +zFJBQ7GgVldoYjASsB681GGG2IaSG8einawS3EDcvUB8AVy98Zn5j61/w1QpAz0wd9V
         icdrZto0Sox9iZGQGIB+oyRDSXOgwlnyHbbCdtQbdGPLWTfGNCgCwQ9V0rzO2D0MIJF/
         8Xlt29Ex5pBURRvi42z1ZWGWGDfxWQWqwjdfwejKpCYUZvn8d/y93BRE825gR6RQeRo1
         BYgw==
X-Gm-Message-State: AOJu0YzxyslSst6vgiR5Ns1j1ZKNy/gQNoFZQuWudDT18ei02pvJGbX4
	JYdnDrE+5Xbl/5weVbrkTAoquSUKhw8pS9QZ9DWTnxQFs4aDNdrj/pSlwvsmcrp/
X-Gm-Gg: AZuq6aLL/+xNHd+VtB8j37SnVmQml8MokRx8d3xbdQrSA3ADYyV6354ZkgjU7a6ifyr
	sUw7WHUeyGuPiPcAu85nykFTMEIv9Ex8DbtExy21mh1T23R22Hx8TsgRdN6fyO5FHbmCKLlqhwq
	CWkpImrynuCKkRwiz/NqHHeCWPFJzjCqbJvjZcO45Syfpam4qysbGX3N8SWwf5O4h5c9gZmtscd
	SV9bSqQvn50XtPrP7WfaiDfyZfihRqmDobQDq7Fhs5PcVQs2prx6iBVG+3ND2ditOyWQo1kPgHG
	uMPrEChksphZAqvc2rU4uEQuKariq62iHwdcqqlTH7V9KJK92MxxKLQ/TiyiD8f1VxlNOhvqhhe
	OLhUZJHGphSvtH53kqzDUGAuQM4RJYVZXzExEiEY1Zr1owQFyLHva5k7CcsEv8CL4YxA3YyaAL6
	1cTHPG1G9YgsoL/bMIxKQ4AmNwY/aHrwN7di6vl9g15RBKucx6tzSyXaNT+5M2m+WHQlO/bEeDn
	3NBYg==
X-Received: by 2002:a05:6122:32cc:b0:566:9f8a:4a01 with SMTP id 71dfb90a1353d-566a0042615mr1197879e0c.8.1769801970474;
        Fri, 30 Jan 2026 11:39:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 00/35] doc: Add cross-references between bluetoothctl and D-Bus API documentation
Date: Fri, 30 Jan 2026 14:38:42 -0500
Message-ID: <20260130193921.1273263-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch series enhances the BlueZ documentation by adding cross-references
between bluetoothctl command documentation and D-Bus API documentation:

- bluetoothctl docs: Add :Uses: fields linking each command to its
  corresponding D-Bus interface method(s)

- D-Bus API docs: Add :Used by: fields linking interfaces to bluetoothctl
  man pages, and Examples sections showing the corresponding bluetoothctl
  command usage for each D-Bus method

This makes it easier for users to:
1. Find the D-Bus API behind a bluetoothctl command
2. Discover bluetoothctl commands for a given D-Bus interface
3. Understand the relationship between CLI and programmatic interfaces

Luiz Augusto von Dentz (35):
  doc/bluetoothctl: Add :Uses: fields and document arguments
  doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments
  doc/bluetoothctl-admin: Add :Uses: fields and document arguments
  doc/bluetoothctl-advertise: Add :Uses: fields and document arguments
  doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
  doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
  doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
  doc/bluetoothctl-gatt: Add :Uses: fields and document arguments
  doc/bluetoothctl-hci: Add :Uses: fields and document arguments
  doc/bluetoothctl-le: Add :Uses: fields and document arguments
  doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
  doc/bluetoothctl-player: Add :Uses: fields and document arguments
  doc/bluetoothctl-scan: Add :Uses: fields and document arguments
  doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
  doc/bluetoothctl-transport: Add :Uses: fields and document arguments
  doc/org.bluez.Adapter: Add Used by reference and Examples
  doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
  doc/org.bluez.AdminPolicyStatus: Add Used by reference
  doc/org.bluez.AdvertisementMonitor: Add Used by reference
  doc/org.bluez.AdvertisementMonitorManager: Add Used by reference
  doc/org.bluez.AgentManager: Add Used by reference and Examples
  doc/org.bluez.Call: Add Used by reference and Examples
  doc/org.bluez.Device: Add Used by reference and Examples
  doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
  doc/org.bluez.GattDescriptor: Add Used by reference
  doc/org.bluez.GattManager: Add Used by reference and Examples
  doc/org.bluez.GattService: Add Used by reference
  doc/org.bluez.LEAdvertisement: Add Used by reference
  doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples
  doc/org.bluez.Media: Add Used by reference
  doc/org.bluez.MediaAssistant: Add Used by reference and Examples
  doc/org.bluez.MediaEndpoint: Add Used by reference
  doc/org.bluez.MediaPlayer: Add Used by reference and Examples
  doc/org.bluez.MediaTransport: Add Used by reference and Examples
  doc/org.bluez.Telephony: Add Used by reference and Examples

 doc/bluetoothctl-admin.rst                    |  28 +-
 doc/bluetoothctl-advertise.rst                | 356 ++++++++-
 doc/bluetoothctl-assistant.rst                |  24 +-
 doc/bluetoothctl-bredr.rst                    |  25 +-
 doc/bluetoothctl-endpoint.rst                 | 217 +++--
 doc/bluetoothctl-gatt.rst                     | 249 +++++-
 doc/bluetoothctl-hci.rst                      | 112 ++-
 doc/bluetoothctl-le.rst                       |  26 +-
 doc/bluetoothctl-mgmt.rst                     | 743 +++++++++++++++++-
 doc/bluetoothctl-monitor.rst                  |  79 +-
 doc/bluetoothctl-player.rst                   | 118 +++
 doc/bluetoothctl-scan.rst                     | 126 ++-
 doc/bluetoothctl-telephony.rst                |  75 +-
 doc/bluetoothctl-transport.rst                |  78 +-
 doc/bluetoothctl.rst                          | 250 +++++-
 doc/org.bluez.Adapter.rst                     |   9 +
 doc/org.bluez.AdminPolicySet.rst              |   5 +
 doc/org.bluez.AdminPolicyStatus.rst           |   1 +
 doc/org.bluez.AdvertisementMonitor.rst        |   1 +
 doc/org.bluez.AdvertisementMonitorManager.rst |   1 +
 doc/org.bluez.AgentManager.rst                |   9 +
 doc/org.bluez.Call.rst                        |   9 +
 doc/org.bluez.Device.rst                      |  13 +
 doc/org.bluez.GattCharacteristic.rst          |  21 +
 doc/org.bluez.GattDescriptor.rst              |   1 +
 doc/org.bluez.GattManager.rst                 |   9 +
 doc/org.bluez.GattService.rst                 |   1 +
 doc/org.bluez.LEAdvertisement.rst             |   1 +
 doc/org.bluez.LEAdvertisingManager.rst        |   5 +
 doc/org.bluez.Media.rst                       |   1 +
 doc/org.bluez.MediaAssistant.rst              |   5 +
 doc/org.bluez.MediaEndpoint.rst               |   1 +
 doc/org.bluez.MediaPlayer.rst                 |  29 +
 doc/org.bluez.MediaTransport.rst              |  17 +
 doc/org.bluez.Telephony.rst                   |   9 +
 35 files changed, 2494 insertions(+), 160 deletions(-)

-- 
2.52.0

