Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017123026F
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031766; cv=none; b=uHE6QdRbRBPOMV4Zf5LwAiDi3nYlLj8NKuHbokEZCYXLqDBUcGET2nRYUMqBeM/yyDM75sDozrr85JAGRgKkSrsCWqEr/8krwFVVHFudhGKdHcTL24RvvR2JGjrc7iLsGETmWIgmUIXP3xnhZvj/F4peB15AUOFrjG7pBhAkk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031766; c=relaxed/simple;
	bh=Rc+SHY7Z1M4ofX2/Mj+DzzDEsNfQAVDSqKgxqwhWqmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F47/v5ytjj2nYPHeNCcwYONRNXOo7Vl/EkHlF12ygOaM+v/l2ULyJF7m8RTIXkT+cUctqdhnfXiwMYuFyP4ZxdsSbUU8YE8hkz2/LJ94KqtmJX8J4bcNcPwrk20Fm0RdvONrs5xfW7B5UsK2F/6+GlgYA0OW3nDTYEU/901EHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9tJWRnX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9tJWRnX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7430e27b2so809408266b.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741031762; x=1741636562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZzPbQ/HOtPJDPxObezspGi43r6GifuOI1CD1QQ2B8o=;
        b=b9tJWRnXS8RKJzRCBXyMuZE1/YdeG134OaBklCibyv+Ga6YD5o1Uc9GcbzZBVLu1ys
         jR7wpBm+Zfv2pvITvqeJhaBMywHcZjtltlZgiEXx1/FyEh/sLX5TejfuDNMLZEvR/1e2
         LpEwGR8Dxxd1+m4lbLTtBRSHTpnyf/qACGLNvioLimt2pa5vG7ils3tx6sR0QaENTzbX
         J36N2xSqwMbJi0CX09j4DYwWXqvmPlrv7YYel2LGkXU8+rZ2YNtPlnCdB5v384qILkon
         yJ9swz5EeYwl+DkywhUb83AAzS8wAMuAbqK+TTZRkWYkDwCARylIkVsuMFxQGx4GE7PA
         gt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031762; x=1741636562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZzPbQ/HOtPJDPxObezspGi43r6GifuOI1CD1QQ2B8o=;
        b=toNJoXHKfEkGZME/YwMydTZq/f9C7q6TxI5oPS1d/eiW0dpd57dEoLFDIJboDZ7cSt
         GpB0TqA+hk4WAjJiH4ezLO9IL/36XRFuPMCsWB+l7nh5+6QjPp+nyJbzf4GxKOiaYWT3
         b8woAJ8VNShv1wRfu8h8jr7HyN+ENYhdirlp4OO1sFxsrypLG9DABPkXFRkW979o9RHu
         NEQiNwRTGXRi8hjLGZGs40/eZkKoyeGhxd4QCfygh1uhBG+HLyjALOmEzjy7kMsacDlu
         T8MM3DmBAfifA2GL4/FNbitbkidOVlsOQybN/CMo72DcaOW6MtJK1LtZ/+GLFoo+ladK
         KSMA==
X-Gm-Message-State: AOJu0Ywb3m3MrMHS/FdxbG8SyIs3LEj4ELolkCDUb3lpiLbZP277+2if
	emmGcEf6+q/wSUqUN8CP1lnObpH4OUlgxMzdr5z7ENZLaM6FdMUs/7KHcRSCTgI=
X-Gm-Gg: ASbGncv2GGjrD7FRwKe+avq/qvI20PZk82/YxtGOvj/5MuPH036lCY51HYvE+lRY3Ht
	/Xp90bn+0faeL5UuDO64rL8IrI3DihcPAkhBWTI/m7HcPkGZptvSgernVMks9ODMhWBoO+F1JPj
	31g31zVdSUdTaq0JVSYvhaAyXjvX1fxJN6bu/hluAAqRRKiPWuskSg2hIZtn8jMaHn5qDNxKUJ3
	N0g/TZtVK9PQxBHJTU9JI72D7gtzu1bFfSLerEnjRtvDwUldBPbMVmVdtVI5xRFzn2VhGgJyi60
	MwGtUdUKAnicHvZDI9NYV6YDcllGfnH7neTF5AzZJYyZxZucnfvfKdE1adAlb3PlvsmMPDNysME
	ce0JCJHt1aC/nDZtOkZmRZkU5dV2zGSm3TLYhrw==
X-Google-Smtp-Source: AGHT+IHAebBEv1wpnJOpH1EeFyyIv8Ot4YEaix/eHDkenBBbmFmF9FVC+c7+08Z/ZEYWlo3fRidTPQ==
X-Received: by 2002:a17:907:9449:b0:abb:db78:a25d with SMTP id a640c23a62f3a-abf25fc4942mr1480860666b.14.1741031761784;
        Mon, 03 Mar 2025 11:56:01 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac00b19ae66sm198289766b.121.2025.03.03.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:56:01 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] doc: Fix typo in the copyright header
Date: Mon,  3 Mar 2025 20:55:57 +0100
Message-Id: <20250303195557.31190-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/bluetoothctl-admin.rst     | 2 +-
 client/bluetoothctl-advertise.rst | 2 +-
 client/bluetoothctl-assistant.rst | 2 +-
 client/bluetoothctl-endpoint.rst  | 2 +-
 client/bluetoothctl-gatt.rst      | 2 +-
 client/bluetoothctl-hci.rst       | 2 +-
 client/bluetoothctl-mgmt.rst      | 2 +-
 client/bluetoothctl-monitor.rst   | 3 +--
 client/bluetoothctl-player.rst    | 2 +-
 client/bluetoothctl-scan.rst      | 2 +-
 client/bluetoothctl-transport.rst | 4 ++--
 doc/hci.rst                       | 2 +-
 doc/l2cap.rst                     | 2 +-
 doc/rfcomm.rst                    | 2 +-
 mesh/bluetooth-meshd.rst.in       | 2 +-
 monitor/btmon.rst                 | 2 +-
 src/bluetoothd.rst.in             | 2 +-
 tools/bdaddr.rst                  | 2 +-
 tools/btattach.rst                | 2 +-
 tools/btmgmt.rst                  | 2 +-
 tools/ciptool.rst                 | 2 +-
 tools/hciattach.rst               | 2 +-
 tools/hciconfig.rst               | 2 +-
 tools/hcidump.rst                 | 2 +-
 tools/hcitool.rst                 | 2 +-
 tools/hid2hci.rst                 | 2 +-
 tools/isotest.rst                 | 2 +-
 tools/l2ping.rst                  | 2 +-
 tools/rctest.rst                  | 2 +-
 tools/rfcomm.rst                  | 2 +-
 tools/sdptool.rst                 | 2 +-
 31 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/client/bluetoothctl-admin.rst b/client/bluetoothctl-admin.rst
index fcc0d35c9..b0f7f94c1 100644
--- a/client/bluetoothctl-admin.rst
+++ b/client/bluetoothctl-admin.rst
@@ -7,7 +7,7 @@ Admin Policy Submenu
 --------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-advertise.rst
index 52422bc35..b1a950409 100644
--- a/client/bluetoothctl-advertise.rst
+++ b/client/bluetoothctl-advertise.rst
@@ -7,7 +7,7 @@ Advertise Submenu
 -----------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
index 643476b8c..ea094f444 100644
--- a/client/bluetoothctl-assistant.rst
+++ b/client/bluetoothctl-assistant.rst
@@ -7,7 +7,7 @@ Assistant Submenu
 -----------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: August 2024
 :Manual section: 1
diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpoint.rst
index a9e973eb0..b7ecd9624 100644
--- a/client/bluetoothctl-endpoint.rst
+++ b/client/bluetoothctl-endpoint.rst
@@ -7,7 +7,7 @@ Endpoint Submenu
 ----------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
diff --git a/client/bluetoothctl-gatt.rst b/client/bluetoothctl-gatt.rst
index 8a1570210..b2f45d56c 100644
--- a/client/bluetoothctl-gatt.rst
+++ b/client/bluetoothctl-gatt.rst
@@ -7,7 +7,7 @@ Generic Attribute Submenu
 -------------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
diff --git a/client/bluetoothctl-hci.rst b/client/bluetoothctl-hci.rst
index 200276317..70aa5e7af 100644
--- a/client/bluetoothctl-hci.rst
+++ b/client/bluetoothctl-hci.rst
@@ -7,7 +7,7 @@ HCI Submenu
 -----------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: December 2024
 :Manual section: 1
diff --git a/client/bluetoothctl-mgmt.rst b/client/bluetoothctl-mgmt.rst
index b82141206..cf252f3a5 100644
--- a/client/bluetoothctl-mgmt.rst
+++ b/client/bluetoothctl-mgmt.rst
@@ -7,7 +7,7 @@ Management Submenu
 ------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: July 2023
 :Manual section: 1
diff --git a/client/bluetoothctl-monitor.rst b/client/bluetoothctl-monitor.rst
index 98b49dc22..1e2bfeecc 100644
--- a/client/bluetoothctl-monitor.rst
+++ b/client/bluetoothctl-monitor.rst
@@ -7,7 +7,7 @@ Monitor Submenu
 ---------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: July 2023
 :Manual section: 1
@@ -86,4 +86,3 @@ REPORTING BUGS
 ==============
 
 linux-bluetooth@vger.kernel.org
-
diff --git a/client/bluetoothctl-player.rst b/client/bluetoothctl-player.rst
index 0c446de6a..1c5d436b3 100644
--- a/client/bluetoothctl-player.rst
+++ b/client/bluetoothctl-player.rst
@@ -7,7 +7,7 @@ Media Player Submenu
 --------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
index 23e0637fc..b4b831592 100644
--- a/client/bluetoothctl-scan.rst
+++ b/client/bluetoothctl-scan.rst
@@ -7,7 +7,7 @@ Scan Submenu
 ------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: July 2023
 :Manual section: 1
diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-transport.rst
index 39b7fad2b..77d8457a5 100644
--- a/client/bluetoothctl-transport.rst
+++ b/client/bluetoothctl-transport.rst
@@ -7,7 +7,7 @@ Media Transport Submenu
 -----------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2022
 :Manual section: 1
@@ -71,7 +71,7 @@ Once a transport is selected, the audio server will automatically acquire.
 unselect
 --------
 
-Unelect transport. For transports created on a Broadcast Sink device only. This moves
+Unselect transport. For transports created on a Broadcast Sink device only. This moves
 the transport to the "idle" state, pending release by the audio server. If the transport
 was acquired by bluetoothctl it can be released straight away, without having to be
 unselected.
diff --git a/doc/hci.rst b/doc/hci.rst
index d7f192a27..f28684655 100644
--- a/doc/hci.rst
+++ b/doc/hci.rst
@@ -7,7 +7,7 @@ Bluetooth HCI protocol
 ----------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: October 2024
 :Manual section: 7
diff --git a/doc/l2cap.rst b/doc/l2cap.rst
index f90f88222..a71bd4bdf 100644
--- a/doc/l2cap.rst
+++ b/doc/l2cap.rst
@@ -7,7 +7,7 @@ L2CAP protocol
 --------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: May 2024
 :Manual section: 7
diff --git a/doc/rfcomm.rst b/doc/rfcomm.rst
index b20c7544b..735e0f819 100644
--- a/doc/rfcomm.rst
+++ b/doc/rfcomm.rst
@@ -7,7 +7,7 @@ RFCOMM protocol
 ---------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: May 2024
 :Manual section: 7
diff --git a/mesh/bluetooth-meshd.rst.in b/mesh/bluetooth-meshd.rst.in
index 761536711..042d9b77d 100644
--- a/mesh/bluetooth-meshd.rst.in
+++ b/mesh/bluetooth-meshd.rst.in
@@ -7,7 +7,7 @@ Bluetooth Mesh daemon
 ---------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: March 2021
 :Manual section: 8
diff --git a/monitor/btmon.rst b/monitor/btmon.rst
index 82f9381c1..31970d4fb 100644
--- a/monitor/btmon.rst
+++ b/monitor/btmon.rst
@@ -8,7 +8,7 @@ Bluetooth monitor
 
 :Authors: - Marcel Holtmann <marcel@holtmann.org>
           - Tedd Ho-Jeong An <tedd.an@intel.com>
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Version: BlueZ
 :Date: April 2021
diff --git a/src/bluetoothd.rst.in b/src/bluetoothd.rst.in
index 0b998f621..b677b805f 100644
--- a/src/bluetoothd.rst.in
+++ b/src/bluetoothd.rst.in
@@ -10,7 +10,7 @@ Bluetooth daemon
           - Philipp Matthias Hahn
           - Fredrik Noring
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: March, 2004
 :Manual section: 8
diff --git a/tools/bdaddr.rst b/tools/bdaddr.rst
index a84950bc3..2190b9d0e 100644
--- a/tools/bdaddr.rst
+++ b/tools/bdaddr.rst
@@ -9,7 +9,7 @@ Utility for changing the Bluetooth device address
 :Authors: - Marcel Holtmann <marcel@holtmann.org>
           - Adam Laurie <adam@algroup.co.uk>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Sep 27, 2005
 :Manual section: 1
diff --git a/tools/btattach.rst b/tools/btattach.rst
index 787d5c49e..e51772ea4 100644
--- a/tools/btattach.rst
+++ b/tools/btattach.rst
@@ -7,7 +7,7 @@ Attach serial devices to BlueZ stack
 ------------------------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: November 2015
 :Manual section: 1
diff --git a/tools/btmgmt.rst b/tools/btmgmt.rst
index 0159ee128..c5b1402a7 100644
--- a/tools/btmgmt.rst
+++ b/tools/btmgmt.rst
@@ -7,7 +7,7 @@ interactive bluetooth management tool
 -------------------------------------
 
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: July 2023
 :Manual section: 1
diff --git a/tools/ciptool.rst b/tools/ciptool.rst
index bd7112f08..87487b7cc 100644
--- a/tools/ciptool.rst
+++ b/tools/ciptool.rst
@@ -8,7 +8,7 @@ Bluetooth Common ISDN Access Profile (CIP)
 
 :Author: Marcel Holtmann <marcel@holtmann.org>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: June 3, 2003
 :Manual section: 1
diff --git a/tools/hciattach.rst b/tools/hciattach.rst
index d3eb7ef66..98777b10c 100644
--- a/tools/hciattach.rst
+++ b/tools/hciattach.rst
@@ -9,7 +9,7 @@ attach serial devices via UART HCI to BlueZ stack
 :Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
           - Nils Faerber <nils@kernelconcepts.de>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Jan 22, 2002
 :Manual section: 1
diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
index 2d56eeb41..992aafd93 100644
--- a/tools/hciconfig.rst
+++ b/tools/hciconfig.rst
@@ -10,7 +10,7 @@ Configure Bluetooth devices
           - Marcel Holtmann <marcel@holtmann.org>
           - Fabrizio Gennari <fabrizio.gennari@philips.com>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Nov 11, 2002
 :Manual section: 1
diff --git a/tools/hcidump.rst b/tools/hcidump.rst
index c5d2866da..4d7bc989d 100644
--- a/tools/hcidump.rst
+++ b/tools/hcidump.rst
@@ -10,7 +10,7 @@ Parse HCI data
           - Marcel Holtmann <marcel@holtmann.org>
           - Fabrizio Gennari <fabrizio.gennari@philips.com>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Nov 12, 2002
 :Manual section: 1
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
index 88b1263c5..6878bd865 100644
--- a/tools/hcitool.rst
+++ b/tools/hcitool.rst
@@ -10,7 +10,7 @@ Configure Bluetooth connections
           - Marcel Holtmann <marcel@holtmann.org>
           - Fabrizio Gennari <fabrizio.gennari@philips.com>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Nov 12, 2002
 :Manual section: 1
diff --git a/tools/hid2hci.rst b/tools/hid2hci.rst
index 6aa31154e..ef0a0b7b5 100644
--- a/tools/hid2hci.rst
+++ b/tools/hid2hci.rst
@@ -8,7 +8,7 @@ Bluetooth HID to HCI mode switching utility
 
 :Author: Marcel Holtmann <marcel@holtmann.org>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: May 15, 2009
 :Manual section: 1
diff --git a/tools/isotest.rst b/tools/isotest.rst
index fc5b3c56f..44c40f535 100644
--- a/tools/isotest.rst
+++ b/tools/isotest.rst
@@ -8,7 +8,7 @@ ISO testing
 
 :Authors: - Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: May 4, 2022
 :Manual section: 1
diff --git a/tools/l2ping.rst b/tools/l2ping.rst
index 5076b7abf..e653f38ee 100644
--- a/tools/l2ping.rst
+++ b/tools/l2ping.rst
@@ -11,7 +11,7 @@ Send L2CAP echo request and receive answer
           - Nils Faerber <nils@kernelconcepts.de>
           - Adam Laurie <adam@algroup.co.uk>.
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Jan 22, 2002
 :Manual section: 1
diff --git a/tools/rctest.rst b/tools/rctest.rst
index 0e78e09af..0dfdad116 100644
--- a/tools/rctest.rst
+++ b/tools/rctest.rst
@@ -10,7 +10,7 @@ RFCOMM testing
           - Marcel Holtmann <marcel@holtmann.org>
           - Filippo Giunchedi <filippo@debian.org>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: Jul 6, 2009
 :Manual section: 1
diff --git a/tools/rfcomm.rst b/tools/rfcomm.rst
index cd5daa674..c23dcf2b5 100644
--- a/tools/rfcomm.rst
+++ b/tools/rfcomm.rst
@@ -8,7 +8,7 @@ RFCOMM configuration utility
 
 :Author: Marcel Holtmann <marcel@holtmann.org>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Date: April 28, 2002
 :Manual section: 1
diff --git a/tools/sdptool.rst b/tools/sdptool.rst
index a4f416cd3..602d7f580 100644
--- a/tools/sdptool.rst
+++ b/tools/sdptool.rst
@@ -9,7 +9,7 @@ control and interrogate SDP servers
 :Authors: - Maxim Krasnyansky <maxk@qualcomm.com>
           - Edd Dumbill <ejad@debian.org>
 :Version: BlueZ
-:Copyright: Free use of this software is granted under ther terms of the GNU
+:Copyright: Free use of this software is granted under the terms of the GNU
             Lesser General Public Licenses (LGPL).
 :Manual section: 1
 :Manual group: Linux System Administration
-- 
2.39.5

