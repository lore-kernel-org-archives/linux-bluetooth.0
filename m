Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80333986D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464867; cv=none; b=l1EfOEpTK6RekRpsY38bmJxAhdXSU+mGblrvoCrX6gPRBJ5uFrwBLfMTc9CA7IUdpEncfObBvsOTjqCK5P+XW/t5nigvaIF5XML4w1G+5YJd9JVlKP2WWU8yi55IjFMV8dJZwsEzvLxW++AgUVr7QA67xNS2/EYyMOeRh41ZRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464867; c=relaxed/simple;
	bh=Y1K4Dj0vpOJlYOVfe/urQnWPo6jge1rPD3y7TOdo1k4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw5QndYutT+Sr5CRCeGfWLW96hPVud90ZTU1flVELWzp5uz/0wj+u1qfn0u4UYLEUAOMvJgARMj6n9LdUJ0hmAaB9ygU0kDeokn+gTXGnuQIJW6qPK9c45fTzqZoZIwyxElSOscH4f53nNozm0jxVSoskSyK8GrfRk4KOM2bYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDU015vm; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDU015vm"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5675d609621so219978e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464864; x=1775069664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4oEavAdkD+gYhOeFg7b0IR4YeK3Zzr0KsC+busvX0c=;
        b=DDU015vmSsvGLRRmmFtjMYQ8Ar4qdhCZIgKqd6fZPiZq0yDSa0405e7eMZw+ZN/S5G
         J+o2BKvtBDK2wzeNFOr90FCb9eHKDfdjs+Th7vU3tRGK1L3Fe7imhld+5WTG6yALI8Zo
         17KaToHlbVAFlyQhIls1KZ4NUEHZQ3Uo7IOVRrfCqrXyUncafpr44mmvsaqcyuXhgDkD
         fuGoQr/2ZtaRfXKCUk97PyJA1MnTfvTOoVfeqUVMr4Pqqkvq9A25SB77mtWHFV3DczHm
         We1PKUfutuwDdd4jTneiuvlPT5fUDF05ufQVyvgehIyaohKf0zn/Doc/vpXwLdg+T5Po
         jG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464864; x=1775069664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4oEavAdkD+gYhOeFg7b0IR4YeK3Zzr0KsC+busvX0c=;
        b=TuYTm8qU937FNx3hwl0BFxxyahqlqQtHAmUoAosDc2ZflHYFZ3FPv837ZiBqPdsYoR
         cKUihhNfm1KGJbM6inuvV8S1AzhS7ihVyzGNQw0se3V54mWekZXWZbI/L7BdHnqBEB2Z
         mF9GzacsLSjSmTIt7bwyYzShKlSgu2XtZZHJ+q9/tFC+Jl9QHXeiDll5GqhsiUOUK2o8
         vgaABUh3cpJ5QUPdOoqkP6jE4wv/T2DTaPv/aPvYW7xctFuk0MkVfCToF9M5jW75ccf2
         NPaRS98fQlVAAIRb9kTDiepmEESxrmUM7mdMmgeyNAdfFr9QvYZgvEHzImmg1rb6SVU3
         9vEQ==
X-Gm-Message-State: AOJu0Yyvw3azkBGcuCuG+FyWuJdSrimnq7AgSS3rVO4zknUHf/q22MBH
	sL/z7SB3nvBMX0hf9/tTEgvil0s2gNWUOeeIJvM7JSzjCt6qEfR53+EGkgzDkJL8
X-Gm-Gg: ATEYQzy40Rq+Cm9AdDD7YeWQYqnrDYDQ350CFlZGVVRtJ7gUy0R/SbkbO/Z0KkbeT5R
	5saOYFLeFGQAOSETyezFi5W2awa3lHsntiecxGbJUQi+Gj5NTwFnNFvVWhEXexKNuyEjZEY0zjn
	v0xP4gS4PSXw8pVyyo6Pcql05xml/TCQ+7IuNRIuqjAf6KceGhtWT/OaXX91paQIfYS7civEnw6
	IXcZG8p7CmLOHaqlbJ763y/K3G7enV1nkw8rvmVLrkQoibdhGJWX9+a20m7J6e6EY2DqJPtCq81
	0uLqt7XW7RdByqh9Hi3lDQZmP+K4nzTgVaxLbNBAQaj5JVMy8J5ZuOXl+RDC5Zu1n4W0U4U4CLd
	65j/jRAbJ7SlVw8qE7Uncb5XSoVV4jTfKXXoSx25eHUVGZ9Pt8lND42UVZs0P5lWVs0HUymt9Ma
	R++Dwxb1PQTH27dHWCV5ziKbptCVfYCqgIduEmTCB4iAuV3LIU/17K+7yHAzA/R8W2OjaQUeIhf
	5gyEhQgmk2vA9BR1w==
X-Received: by 2002:a05:6122:1353:b0:56c:db9e:7d04 with SMTP id 71dfb90a1353d-56d220a4cc0mr2545378e0c.10.1774464864162;
        Wed, 25 Mar 2026 11:54:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/9] doc/btmon: Add HCI initialization sequence documentation
Date: Wed, 25 Mar 2026 14:54:03 -0400
Message-ID: <20260325185406.568078-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325185406.568078-1-luiz.dentz@gmail.com>
References: <20260325185406.568078-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the multi-stage HCI controller initialization performed by
the kernel (net/bluetooth/hci_sync.c). The four stages cover reset
and identity, capability discovery, event mask configuration, and
final setup. This helps trace readers distinguish normal init traffic
from application-level issues.
---
 Makefile.am            |   2 +
 doc/btmon-hci-init.rst | 363 +++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst          |   2 +
 3 files changed, 367 insertions(+)
 create mode 100644 doc/btmon-hci-init.rst

diff --git a/Makefile.am b/Makefile.am
index a8473127cf66..e67a1f5c81e9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -550,6 +550,8 @@ EXTRA_DIST += doc/btmon-gatt.rst
 
 EXTRA_DIST += doc/btmon-connections.rst
 
+EXTRA_DIST += doc/btmon-hci-init.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
diff --git a/doc/btmon-hci-init.rst b/doc/btmon-hci-init.rst
new file mode 100644
index 000000000000..9890df7c38af
--- /dev/null
+++ b/doc/btmon-hci-init.rst
@@ -0,0 +1,363 @@
+.. This file is included by btmon.rst.
+
+HCI INITIALIZATION SEQUENCE
+============================
+
+Every btsnoop trace that captures controller startup begins with a
+dense block of HCI commands and events. This is the kernel's
+Bluetooth subsystem initializing the controller through a multi-stage
+sequence defined in ``net/bluetooth/hci_sync.c``. Understanding this
+sequence helps distinguish normal initialization traffic from
+application-level issues.
+
+Overview
+--------
+
+The kernel initializes a Bluetooth controller in four stages after
+opening the HCI device. Each stage sends a batch of HCI commands and
+waits for their completion before proceeding to the next. The full
+call chain is::
+
+    hci_power_on_sync
+      └─ hci_dev_open_sync
+           └─ hci_dev_init_sync
+                ├─ hci_dev_setup_sync     (driver setup + quirks)
+                └─ hci_init_sync
+                     ├─ Stage 1: Reset + identity
+                     ├─ Stage 2: Capabilities + buffer sizes
+                     ├─ Stage 3: Event masks + policy
+                     └─ Stage 4: Final configuration
+
+After all four stages complete, a post-init phase
+(``hci_powered_update_sync``) configures runtime parameters like
+SSP, advertising, and scan settings.
+
+For unconfigured devices (e.g. controllers that need firmware or a
+BD address programmed), only a minimal **Stage 0** runs to identify
+the hardware.
+
+Stage 0: Reset and Basic Identity (Unconfigured Only)
+-----------------------------------------------------
+
+This stage runs only for unconfigured controllers that need setup
+before full initialization.
+
+**Commands sent:**
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Reset``
+     - Reset the controller (skipped if ``RESET_ON_CLOSE`` quirk)
+   * - ``HCI_Read_Local_Version_Information``
+     - Read hardware/firmware version
+   * - ``HCI_Read_BD_ADDR``
+     - Read the controller's Bluetooth address
+
+Stage 1: Reset and Read Local Features
+---------------------------------------
+
+Resets the controller and reads core identity and capability
+information.
+
+**Commands sent:**
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Reset``
+     - Reset the controller
+   * - ``HCI_Read_Local_Supported_Features``
+     - Read LMP feature bitmask (BR/EDR, LE, SSP, etc.)
+   * - ``HCI_Read_Local_Version_Information``
+     - Read HCI version, LMP version, manufacturer
+   * - ``HCI_Read_BD_ADDR``
+     - Read the public Bluetooth address
+
+Stage 2: Read Capabilities and Setup
+-------------------------------------
+
+Reads detailed capabilities, enables core features, and reads buffer
+sizes. This stage has three phases: common commands, BR/EDR-specific
+commands, and LE-specific commands.
+
+Common Commands
+~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Read_Local_Supported_Commands``
+     - Read the supported command bitmask (HCI 1.2+)
+   * - ``HCI_Write_Simple_Pairing_Mode`` (enable)
+     - Enable SSP if supported and configured
+   * - ``HCI_Write_Extended_Inquiry_Response`` (clear)
+     - Clear EIR data when SSP is disabled
+   * - ``HCI_Write_Inquiry_Mode``
+     - Set inquiry mode (RSSI or Extended, based on features)
+   * - ``HCI_Read_Inquiry_Response_Transmit_Power_Level``
+     - Read inquiry TX power if supported
+   * - ``HCI_Read_Local_Extended_Features`` (page 1)
+     - Read extended feature page 1 (SSP host, LE host, etc.)
+   * - ``HCI_Write_Authentication_Enable``
+     - Sync authentication state with ``LINK_SECURITY`` flag
+
+BR/EDR Commands (if BR/EDR capable)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Read_Buffer_Size``
+     - Read ACL/SCO buffer sizes and count
+   * - ``HCI_Read_Class_of_Device``
+     - Read current device class
+   * - ``HCI_Read_Local_Name``
+     - Read the stored local name
+   * - ``HCI_Read_Voice_Setting``
+     - Read SCO voice setting (if supported)
+   * - ``HCI_Read_Number_of_Supported_IAC``
+     - Read number of supported inquiry access codes
+   * - ``HCI_Read_Current_IAC_LAP``
+     - Read current IAC LAP values
+   * - ``HCI_Set_Event_Filter`` (clear all)
+     - Clear any stored event filters
+   * - ``HCI_Write_Connection_Accept_Timeout``
+     - Set connection accept timeout (~20 seconds)
+   * - ``HCI_Write_Synchronous_Flow_Control_Enable``
+     - Enable SCO flow control if supported
+
+LE Commands (if LE capable)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``LE_Read_Local_Supported_Features``
+     - Read LE feature bitmask
+   * - ``LE_Read_All_Local_Supported_Features``
+     - Read extended LE features (if supported)
+   * - ``LE_Read_Buffer_Size`` [v2] or [v1]
+     - Read LE ACL (and ISO) buffer sizes; v2 used when ISO capable
+   * - ``LE_Read_Supported_States``
+     - Read the LE state combination table
+
+Stage 3: Event Masks, Link Policy, and Features
+------------------------------------------------
+
+Configures which events the controller should report, sets link
+policy, and reads extended feature pages. This is the longest stage.
+
+Event Masks and Link Policy
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Set_Event_Mask``
+     - Configure the main event mask based on controller capabilities
+   * - ``HCI_Read_Stored_Link_Key``
+     - Read all stored link keys
+   * - ``HCI_Write_Default_Link_Policy_Settings``
+     - Enable role switch, hold, sniff, park based on LMP features
+   * - ``HCI_Read_Page_Scan_Activity``
+     - Read page scan interval and window
+   * - ``HCI_Read_Default_Erroneous_Data_Reporting``
+     - Read error data reporting state (for wideband speech)
+   * - ``HCI_Read_Page_Scan_Type``
+     - Read page scan type (standard or interlaced)
+   * - ``HCI_Read_Local_Extended_Features`` (pages 2..N)
+     - Read all remaining extended feature pages
+
+**Event mask details:** For dual-mode controllers the kernel enables
+events for inquiry results (RSSI and extended), SSP (IO capability,
+user confirmation, passkey), synchronous connections, sniff
+subrating, encryption refresh, link supervision, and LE meta-events.
+For LE-only controllers a minimal mask covers only command
+completion, hardware errors, disconnection, and encryption changes.
+
+LE Event Mask and Capabilities
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``LE_Set_Event_Mask``
+     - Configure which LE sub-events are reported
+   * - ``LE_Read_Advertising_Channel_Tx_Power``
+     - Read advertising TX power (legacy advertising only)
+   * - ``LE_Read_Transmit_Power``
+     - Read min/max transmit power range
+   * - ``LE_Read_Accept_List_Size``
+     - Read filter accept list capacity
+   * - ``LE_Clear_Accept_List``
+     - Clear the filter accept list
+   * - ``LE_Read_Resolving_List_Size``
+     - Read resolving list capacity (LL Privacy)
+   * - ``LE_Clear_Resolving_List``
+     - Clear the resolving list
+   * - ``LE_Set_Resolvable_Private_Address_Timeout``
+     - Set RPA rotation timeout
+   * - ``LE_Read_Maximum_Data_Length``
+     - Read max TX/RX octets and time (Data Length Extension)
+   * - ``LE_Read_Suggested_Default_Data_Length``
+     - Read current default data length
+   * - ``LE_Read_Number_of_Supported_Advertising_Sets``
+     - Read extended advertising set capacity
+   * - ``HCI_Write_LE_Host_Supported``
+     - Notify controller of host LE support (dual-mode only)
+   * - ``LE_Set_Host_Feature``
+     - Enable CIS Central (bit 32) and/or Channel Sounding (bit 47)
+
+**LE event mask details:** The kernel enables LE sub-events based on
+features: connection complete (enhanced if available), advertising
+reports (extended if available), long term key request, connection
+parameter request, data length change, PHY update, channel selection
+algorithm, periodic advertising events, CIS established/request (if
+CIS capable), BIG create/sync/info (if BIS capable), and channel
+sounding events (if CS capable).
+
+Stage 4: Final Configuration
+-----------------------------
+
+Performs final setup: deletes stale keys, sets event mask page 2,
+reads codec information, enables Secure Connections, and configures
+LE data length and PHY defaults.
+
+Keys, Codecs, and Secure Connections
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``HCI_Delete_Stored_Link_Key`` (all)
+     - Delete all stored link keys from controller
+   * - ``HCI_Set_Event_Mask_Page_2``
+     - Enable page 2 events (authenticated payload timeout, etc.)
+   * - ``HCI_Read_Local_Supported_Codecs`` [v2] or [v1]
+     - Read supported codec IDs; v2 includes transport type info
+   * - ``HCI_Read_Local_Pairing_Options``
+     - Read default pairing options (max encryption key size)
+   * - ``HCI_Get_MWS_Transport_Layer_Configuration``
+     - Read MWS coexistence config if supported
+   * - ``HCI_Read_Synchronization_Train_Parameters``
+     - Read sync train params (Connectionless Peripheral Broadcast)
+   * - ``HCI_Write_Secure_Connections_Support`` (enable)
+     - Enable Secure Connections if SSP active
+   * - ``HCI_Write_Default_Erroneous_Data_Reporting``
+     - Enable/disable based on wideband speech setting
+
+LE Data Length and PHY Defaults
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - HCI Command
+     - Purpose
+   * - ``LE_Write_Suggested_Default_Data_Length``
+     - Set default TX octets/time for new connections
+   * - ``LE_Set_Default_PHY``
+     - Set preferred PHY (1M always; 2M and Coded if supported)
+
+Post-Initialization
+-------------------
+
+After the four stages complete, ``hci_powered_update_sync`` runs to
+apply runtime configuration:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - Action
+     - Purpose
+   * - ``HCI_Write_Simple_Pairing_Mode``
+     - Re-enable SSP + Secure Connections if configured
+   * - ``HCI_Write_LE_Host_Supported``
+     - Sync LE host support state
+   * - LE advertising setup
+     - Configure advertising parameters and data
+   * - ``HCI_Write_Authentication_Enable``
+     - Sync authentication enable state
+   * - Scan/class/name/EIR updates
+     - Configure page scan, device class, local name, EIR data
+   * - ``LE_Set_Random_Address``
+     - Set static random address if no public address
+
+Reading the Init Sequence in a Trace
+-------------------------------------
+
+When examining a btsnoop trace, the initialization block is the
+first thing after the controller is opened. A typical dual-mode
+controller trace starts with::
+
+    < HCI Command: Reset
+    > HCI Event: Command Complete (Reset)
+    < HCI Command: Read Local Supported Features
+    > HCI Event: Command Complete (Read Local Supported Features)
+    < HCI Command: Read Local Version Information
+    > HCI Event: Command Complete (Read Local Version Information)
+    < HCI Command: Read BD ADDR
+    > HCI Event: Command Complete (Read BD ADDR)
+    ... [Stage 2-4 commands follow]
+
+**Key things to look for:**
+
+- **Missing commands**: If expected commands are absent, the
+  controller may not support the corresponding feature. For example,
+  no ``LE_Read_Buffer_Size`` means the controller is BR/EDR only.
+
+- **Command failures**: A ``Status`` other than ``0x00`` in a Command
+  Complete event during init usually indicates a broken controller or
+  unsupported feature. The kernel handles most gracefully, but
+  persistent errors may prevent the adapter from functioning.
+
+- **Buffer sizes**: The values returned by ``Read_Buffer_Size`` and
+  ``LE_Read_Buffer_Size`` determine how many in-flight packets the
+  controller can hold. Small buffer counts can cause throughput
+  issues.
+
+- **Feature bits**: The ``Read_Local_Supported_Features`` response
+  reveals what the controller supports (LE, SSP, eSCO, etc.). Cross
+  reference with the commands that follow — the kernel only sends
+  commands for features the controller reports supporting.
+
+- **Event mask**: The ``Set_Event_Mask`` command shows exactly which
+  events the host wants to receive. If an expected event never
+  appears in the trace, check whether it was enabled in the mask.
+
+- **LE-only controllers**: These skip all BR/EDR commands
+  (``Read_Buffer_Size``, ``Read_Local_Name``, link policy, etc.) and
+  use a minimal event mask. The trace will be noticeably shorter.
+
+- **Vendor commands**: Some controllers (Intel, Broadcom, Qualcomm,
+  Realtek, MediaTek) insert vendor-specific HCI commands between
+  stages for firmware download, configuration, or patch application.
+  These appear as opcode groups ``0x3F`` (vendor) and are
+  driver-specific.
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 9cf1464eae63..6ecadf3f260d 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -755,6 +755,8 @@ Errors often cascade across layers. Common patterns:
 PROTOCOL FLOWS
 ===============
 
+.. include:: btmon-hci-init.rst
+
 .. include:: btmon-connections.rst
 
 .. include:: btmon-gatt.rst
-- 
2.53.0

