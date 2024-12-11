Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A282594AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944940; cv=none; b=HQEEyzKuFWSFuUg3Fhj4JT3+q9x2+SX0XHa/CejoRxYgTSAKHzHITtyx89TyKw8jP76coTPXUxDn6YPvrrFYheOmRpNcVtusA/FDHE/oUY3xcjqI766lMxygOW4RY5zOOcv6oo08dHcMi7vgT/GoEZ7R58Bitn1gOx94gSvdfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944940; c=relaxed/simple;
	bh=NkHwhTQVsWlUvY+IwnwCmvlSKp8pl4GaWsxQO9T5sGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrB/fpQD/eWdxVp8lBbTRmGY6LdFz8Z0JkBFPAwADi+gG1pqt3uAulFJmPKbWRye5exMi5aAhRHy6tOa5k3vkPUwN5yyRqV+npO+KDOybWJDLKRzNI34POFavCd/LDnwVBhcTN3bfa9ZuD3bOqnyVrqOggROOrGgQfmejklwnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYtLWWXU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYtLWWXU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6efeb120f4dso42584807b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944935; x=1734549735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvFMf69g5E11A9KLuAVexmIpwevquHnCDH9IZeC7pNc=;
        b=IYtLWWXUCB0sMHbqFYarAxVDwxH3ypV/NfhPlQQxTqHU3PDUo9UOUG48WWqS11To1B
         qnJUEO836M6JdL29mE1W0mWBcl9I9q2rNJjvFl24JvNvduKMlncItpVeKqQ1ghYC7Ani
         HVKC6ha8PWRfhRXOT3+rO3LuajNFlX0IFt+pLCgpKoUZaK5W6PhdXS+QQAPRD65SbqIm
         EUf5NnbbpWkCPSO9zorHhD2EOVrn+DMdbyH7opvCvm51YGL42J6K/bE0CJgHEnPfJ15G
         yTRNOzHB1aZ51ZUgURI9kQ5zTRRiuWwWI5QTpPsFYLLH88SdCHU+RXMzIGavv7TLf2h2
         wJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944935; x=1734549735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvFMf69g5E11A9KLuAVexmIpwevquHnCDH9IZeC7pNc=;
        b=MdUpgnFEkDdl3MXiKmpyWJ0uetvqFmFg9liH0FLhjjra7kX6E/LkykAmTl3OHHZAl3
         rK9K+QAE9OTxTTLGH/bgUYh4rt69I/j65Fd5K52VXK9OxlF4+QWhFn88KiVI5MV6JmZL
         oLBNlFGG9HzHNeazzmr4EwqztZRm6mFuhPofucDO4G1IIBJCvAplFH3i3zkGmif0ARk8
         aj+59bFsEQTFZ5GWxSaXXR7C0vSFmy95pGPmkLmI+Ai5TdJprCJHWK7czTQQHMf6fg4N
         Q5anVOjuExHtd/7GAnI/oiRkoA/ET0A7dtU/nKM88wM7nr3VmwRzXnWtfS3ZviUMsSyZ
         HFMQ==
X-Gm-Message-State: AOJu0YyH0HGLFLhFI/1hQ8O7xTI+wxkmT/D/1s3v/gbOE9Oqz1Ox4hP+
	J/7t9jxoy6weitognI6POru9C8WAF07RuRdYlHzxOWXHUpsXPmo4xUcBUQ==
X-Gm-Gg: ASbGncsgwR5fO1GVXorHFpeJge/i/xytkqDHL5BYX2mpkaSyOy1aD2eHRzoXFpkDpMr
	fBCENLpvEynqO87GCZmTNIRU2UdSHJOglQRRnoWU3A9KNa3ce78WpwvAH2awY7aHo0E4YFlKZ4Q
	NJZ+LPw3PFKyFao8f04jMuaaOrdSnDgvl8+PgzTQ9anU5WLHjlD66PLPRwRJaxKnSfCGcUFHBAb
	sc8ZGOprcVMyWzdW7kAAZ77PWOZKEr1VFXocNNIclq//yh8mC7IGr5+H2qJVGfFoxnZDSmyJ7RT
	YWO03RXFbIdCc4mnCmlX7V8kSw==
X-Google-Smtp-Source: AGHT+IFwDu8z1gKpUlBDZUlj4/ATzeGCqH/nBfTgDuo/Hj8kPwy1UInsQoS/cJkfC8AnKdj9FmfaBg==
X-Received: by 2002:a05:690c:dd4:b0:6ef:69c4:4dac with SMTP id 00721157ae682-6f19e4f3f86mr7729637b3.15.1733944934308;
        Wed, 11 Dec 2024 11:22:14 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14ce8be30sm3670077b3.79.2024.12.11.11.22.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] bluetoothctl: Update documentation to use '>' as prompt end marker
Date: Wed, 11 Dec 2024 14:22:07 -0500
Message-ID: <20241211192210.1864347-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of '#' with '>' as prompt end marker since the
former is used to describe comments on the script which might be
confused with prompt.
---
 client/bluetoothctl-admin.rst     |   6 +-
 client/bluetoothctl-advertise.rst |  38 ++++----
 client/bluetoothctl-assistant.rst |   4 +-
 client/bluetoothctl-endpoint.rst  | 136 ++++++++++++++--------------
 client/bluetoothctl-gatt.rst      |  42 ++++-----
 client/bluetoothctl-mgmt.rst      | 146 +++++++++++++++---------------
 client/bluetoothctl-monitor.rst   |  16 ++--
 client/bluetoothctl-player.rst    |  38 ++++----
 client/bluetoothctl-scan.rst      |  20 ++--
 client/bluetoothctl-transport.rst |  18 ++--
 client/bluetoothctl.rst           |  48 +++++-----
 11 files changed, 256 insertions(+), 256 deletions(-)

diff --git a/client/bluetoothctl-admin.rst b/client/bluetoothctl-admin.rst
index 774af0530e45..fcc0d35c918f 100644
--- a/client/bluetoothctl-admin.rst
+++ b/client/bluetoothctl-admin.rst
@@ -26,9 +26,9 @@ allow
 
 Allow service UUIDs and block rest of them.
 
-:Usage: **# allow [clear/uuid1 uuid2 ...]**
-:Example: **# allow 0x1101 0x1102 0x1103**
-:Example: **# allow clear**
+:Usage: **> allow [clear/uuid1 uuid2 ...]**
+:Example: **> allow 0x1101 0x1102 0x1103**
+:Example: **> allow clear**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-advertise.rst
index 4b56324813ba..226ec6605372 100644
--- a/client/bluetoothctl-advertise.rst
+++ b/client/bluetoothctl-advertise.rst
@@ -26,17 +26,17 @@ uuids
 
 Set/Get advertise uuids.
 
-:Usage: **# uuids [all/uuid1 uuid2 ...]**
-:Example: **# uuids 0x1234**
-:Example: **# uuids 0x12345678**
-:Example: **# uuids 90f95193-35de-4306-a6e9-699328f15059**
+:Usage: **> uuids [all/uuid1 uuid2 ...]**
+:Example: **> uuids 0x1234**
+:Example: **> uuids 0x12345678**
+:Example: **> uuids 90f95193-35de-4306-a6e9-699328f15059**
 
 service
 -------
 
 Set/Get advertise service data.
 
-:Usage: **# service [uuid] [data=xx xx ...]**
+:Usage: **> service [uuid] [data=xx xx ...]**
 
 manufacturer
 ------------
@@ -50,7 +50,7 @@ maximum has been exceeded so you  may receive an error from bluetoothd that it
 "Failed to register advertisement" which means you need to reduce your
 manufacturer data length.
 
-:Usage: **# manufacturer [id] [data=xx xx ...]**
+:Usage: **> manufacturer [id] [data=xx xx ...]**
 
 data
 ----
@@ -68,8 +68,8 @@ You can modify the advertising data while it is advertising.
 
 To get the currently set data use the command data without any arguments.
 
-:Usage: **# data [type] [data=xx xx ...]**
-:Example: **# data 0x0C 01 0x0F 13**
+:Usage: **> data [type] [data=xx xx ...]**
+:Example: **> data 0x0C 01 0x0F 13**
 
 discoverable
 ------------
@@ -85,7 +85,7 @@ will be ignored.
 
 Entering the command by itself will show the status of the setting
 
-:Usage: **# discoverable [on/off]**
+:Usage: **> discoverable [on/off]**
 
 discoverable-timeout
 --------------------
@@ -101,7 +101,7 @@ discoverable [on] must be set to use this feature.
 
 Entering the command by itself will show the current value set.
 
-:Usage: **# discoverable-timeout [seconds]**
+:Usage: **> discoverable-timeout [seconds]**
 
 tx-power
 --------
@@ -119,7 +119,7 @@ This feature can be modified while advertising.
 
 Entering the command by itself will show the current value set.
 
-:Usage: **# tx-power [on/off] [power]**
+:Usage: **> tx-power [on/off] [power]**
 
 name
 ----
@@ -133,15 +133,15 @@ If the string is too big to fit into the packet it will be truncated.
 It will either advertise as a complete local name or if it has to be truncated
 then a shortened local name.
 
-:Usage: **# name [on/off/name]**
-:Example: **# name "0123456789abcdef0123456789abcdef"**
+:Usage: **> name [on/off/name]**
+:Example: **> name "0123456789abcdef0123456789abcdef"**
 
 appearance
 ----------
 
 Configure custom appearance to be advertised.
 
-:Usage: **# appearance [on/off/value]**
+:Usage: **> appearance [on/off/value]**
 
 duration
 --------
@@ -172,21 +172,21 @@ The advertising interval is determined by the advertising parameters that are
 set for each Instance. The advertising interval is the maximum of the
 advertising intervals set for each Instance.
 
-:Usage: **# duration [seconds]**
+:Usage: **> duration [seconds]**
 
 timeout
 -------
 
 Set/Get advertise timeout.
 
-:Usage: **# timeout [seconds]**
+:Usage: **> timeout [seconds]**
 
 secondary
 ---------
 
 Set/Get advertise secondary channel.
 
-:Usage: **# secondary [1M/2M/Coded]**
+:Usage: **> secondary [1M/2M/Coded]**
 
 interval
 --------
@@ -213,7 +213,7 @@ set for each Instance.
 The advertising interval is the maximum of the advertising intervals set for
 each Instance.
 
-:Usage: **# interval [milliseconds]**
+:Usage: **> interval [milliseconds]**
 
 clear
 -----
@@ -226,7 +226,7 @@ If you want to change the advertise configuration while advertising you must
 first clear the advertise configuration and then set the new advertise
 configuration.
 
-:Usage: **# clear [uuids/service/manufacturer/config-name...]**
+:Usage: **> clear [uuids/service/manufacturer/config-name...]**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
index fb8c3a0d803f..643476b8c922 100644
--- a/client/bluetoothctl-assistant.rst
+++ b/client/bluetoothctl-assistant.rst
@@ -51,8 +51,8 @@ If the auto value is chosen when prompted for the Broadcast
 Code, a zero filled array will be sent to the peer. Otherwise,
 the string entered by the user will be sent as an array of bytes.
 
-:Usage: **# push <assistant>**
-:Example: | **# push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+:Usage: **> push <assistant>**
+:Example: | **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
           | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
           | **[Assistant] Enter Broadcast Code (auto/value): Borne House**
 
diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpoint.rst
index d13f37cd97e9..a9e973eb0ce3 100644
--- a/client/bluetoothctl-endpoint.rst
+++ b/client/bluetoothctl-endpoint.rst
@@ -26,52 +26,52 @@ list
 
 List available endpoints.
 
-:Usage: **# list [local]**
+:Usage: **> list [local]**
 
 show
 ----
 
 Endpoint information.
 
-:Usage: **# show [endpoint]**
+:Usage: **> show [endpoint]**
 
 register
 --------
 
 Register Endpoint.
 
-:Usage: **# register <UUID> <codec[:company]> [capabilities...]**
+:Usage: **> register <UUID> <codec[:company]> [capabilities...]**
 :Example LC3 BAP source:
-	 | **#endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
-	 | **#Auto Accept (yes/no):** y
-	 | **#Max Transports (auto/value):** a
-	 | **#Locations:** a
-	 | **#Supported Context (value):** 3
-	 | **#Context (value):** 3
-	 | **#CIG (auto/value):** a
-	 | **#CIS (auto/value):** a
+	 | **>endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
+	 | **>Auto Accept (yes/no):** y
+	 | **>Max Transports (auto/value):** a
+	 | **>Locations:** a
+	 | **>Supported Context (value):** 3
+	 | **>Context (value):** 3
+	 | **>CIG (auto/value):** a
+	 | **>CIS (auto/value):** a
 :Example LC3 BAP sink with extra capabilities:
-	 | **#endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
-	 | **#Enter Metadata (value/no):** n
-	 | **#Auto Accept (yes/no):** y
-	 | **#Max Transports (auto/value):** a
-	 | **#Locations:** a
-	 | **#Supported Context (value):** 3
-	 | **#Context (value):** 3
-	 | **#CIG (auto/value):** a
-	 | **#CIS (auto/value):** a
+	 | **>endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
+	 | **>Enter Metadata (value/no):** n
+	 | **>Auto Accept (yes/no):** y
+	 | **>Max Transports (auto/value):** a
+	 | **>Locations:** a
+	 | **>Supported Context (value):** 3
+	 | **>Context (value):** 3
+	 | **>CIG (auto/value):** a
+	 | **>CIS (auto/value):** a
 :Example LC3 BAP Broadcast source:
-	 | **#endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06**
-	 | **#Auto Accept (yes/no):** y
-	 | **#Max Transports (auto/value):** a
-	 | **#Locations:** 3
-	 | **#Supported Context (value):** 1
+	 | **>endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06**
+	 | **>Auto Accept (yes/no):** y
+	 | **>Max Transports (auto/value):** a
+	 | **>Locations:** 3
+	 | **>Supported Context (value):** 1
 :Example LC3 BAP Broadcast sink:
-	 | **#endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06**
-	 | **#Auto Accept (yes/no):** y
-	 | **#Max Transports (auto/value):** a
-	 | **#Locations:** 3
-	 | **#Supported Context (value):** 1
+	 | **>endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06**
+	 | **>Auto Accept (yes/no):** y
+	 | **>Max Transports (auto/value):** a
+	 | **>Locations:** 3
+	 | **>Supported Context (value):** 1
 
 Note:
 
@@ -85,7 +85,7 @@ unregister
 
 Unregister Endpoint.
 
-:Usage: **# unregister <UUID/object>**
+:Usage: **> unregister <UUID/object>**
 
 Note:
 
@@ -97,7 +97,7 @@ config
 
 Configure Endpoint.
 
-:Usage: **# config <endpoint> <local endpoint> [preset]**
+:Usage: **> config <endpoint> <local endpoint> [preset]**
 
 Note:
 
@@ -109,54 +109,54 @@ presets
 
 List available presets.
 
-:Usage: **# presets <endpoint>/<UUID> [codec[:company]] [preset] [codec config] [metadata]**
+:Usage: **> presets <endpoint>/<UUID> [codec[:company]] [preset] [codec config] [metadata]**
 :Example using endpoint:
-	  | **#presets /local/endpoint/ep0 32_1_1**
-	  | **#presets /local/endpoint/ep0**
+	  | **>presets /local/endpoint/ep0 32_1_1**
+	  | **>presets /local/endpoint/ep0**
 	  | Preset 32_1_1
-	  | Configuration.#0: len 0x02 type 0x01
+	  | Configuration.**>0: len 0x02 type 0x01
           | Configuration.Sampling Frequency: 32 Khz (0x06)
-          | Configuration.#1: len 0x02 type 0x02
+          | Configuration.**>1: len 0x02 type 0x02
           | Configuration.Frame Duration: 7.5 ms (0x00)
-          | Configuration.#2: len 0x03 type 0x04
+          | Configuration.**>2: len 0x03 type 0x04
           | Configuration.Frame Length: 60 (0x003c)
 :Example using UUID:
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 32_1_1**
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 32_1_1**
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
 	  | ...
 	  | ***32_1_1**
 :Example setting up LC3 custom preset:
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom**
-	  | **#[Codec] Enter frequency (Khz):** 48
-	  | **#[Codec] Enter frame duration (ms):** 10
-	  | **#[Codec] Enter channel allocation:** 3
-	  | **#[Codec] Enter frame length:** 100
-	  | **#[QoS] Enter Target Latency (Low, Balance, High):** Low
-	  | **#[QoS] Enter SDU Interval (us):** 1000
-	  | **#[QoS] Enter Framing (Unframed, Framed):** Unframed
-	  | **#[QoS] Enter PHY (1M, 2M):** 2M
-	  | **#[QoS] Enter Max SDU:** 200
-	  | **#[QoS] Enter RTN:** 3
-	  | **#[QoS] Enter Max Transport Latency (ms):** 10
-	  | **#[QoS] Enter Presentation Delay (us):** 20000
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom**
+	  | **>[Codec] Enter frequency (Khz):** 48
+	  | **>[Codec] Enter frame duration (ms):** 10
+	  | **>[Codec] Enter channel allocation:** 3
+	  | **>[Codec] Enter frame length:** 100
+	  | **>[QoS] Enter Target Latency (Low, Balance, High):** Low
+	  | **>[QoS] Enter SDU Interval (us):** 1000
+	  | **>[QoS] Enter Framing (Unframed, Framed):** Unframed
+	  | **>[QoS] Enter PHY (1M, 2M):** 2M
+	  | **>[QoS] Enter Max SDU:** 200
+	  | **>[QoS] Enter RTN:** 3
+	  | **>[QoS] Enter Max Transport Latency (ms):** 10
+	  | **>[QoS] Enter Presentation Delay (us):** 20000
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
 	  | ...
 	  | ***custom**
 :Example setting up LC3 custom preset with extra configuration:
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom "0x03 0xe8 0x00 0x00 0x02 0xe9 0x00"**
-	  | **#[Codec] Enter frequency (Khz):** 48
-	  | **#[Codec] Enter frame duration (ms):** 10
-	  | **#[Codec] Enter channel allocation:** 3
-	  | **#[Codec] Enter frame length:** 100
-	  | **#[QoS] Enter Target Latency (Low, Balance, High):** Low
-	  | **#[QoS] Enter SDU Interval (us):** 1000
-	  | **#[QoS] Enter Framing (Unframed, Framed):** Unframed
-	  | **#[QoS] Enter PHY (1M, 2M):** 2M
-	  | **#[QoS] Enter Max SDU:** 200
-	  | **#[QoS] Enter RTN:** 3
-	  | **#[QoS] Enter Max Transport Latency (ms):** 10
-	  | **#[QoS] Enter Presentation Delay (us):** 20000
-	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom "0x03 0xe8 0x00 0x00 0x02 0xe9 0x00"**
+	  | **>[Codec] Enter frequency (Khz):** 48
+	  | **>[Codec] Enter frame duration (ms):** 10
+	  | **>[Codec] Enter channel allocation:** 3
+	  | **>[Codec] Enter frame length:** 100
+	  | **>[QoS] Enter Target Latency (Low, Balance, High):** Low
+	  | **>[QoS] Enter SDU Interval (us):** 1000
+	  | **>[QoS] Enter Framing (Unframed, Framed):** Unframed
+	  | **>[QoS] Enter PHY (1M, 2M):** 2M
+	  | **>[QoS] Enter Max SDU:** 200
+	  | **>[QoS] Enter RTN:** 3
+	  | **>[QoS] Enter Max Transport Latency (ms):** 10
+	  | **>[QoS] Enter Presentation Delay (us):** 20000
+	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
 	  | ...
 	  | ***custom**
 
diff --git a/client/bluetoothctl-gatt.rst b/client/bluetoothctl-gatt.rst
index 2a239beca83e..8a157021043f 100644
--- a/client/bluetoothctl-gatt.rst
+++ b/client/bluetoothctl-gatt.rst
@@ -27,147 +27,147 @@ list-attributes
 
 List attributes.
 
-:Usage: **# list-attributes <attribute/UUID>**
+:Usage: **> list-attributes <attribute/UUID>**
 
 select-attribute
 ----------------
 
 Select attribute.
 
-:Usage: **# select-attribute <attribute/UUID>**
+:Usage: **> select-attribute <attribute/UUID>**
 
 attribute-info
 --------------
 
 Select attribute.
 
-:Usage: **# attribute-info [attribute/UUID]**
+:Usage: **> attribute-info [attribute/UUID]**
 
 read
 ----
 
 Read attribute value.
 
-:Usage: **# read [offset]**
+:Usage: **> read [offset]**
 
 write
 -----
 
 Write attribute value.
 
-:Usage: **# write <data=xx xx ...> [offset] [type]**
+:Usage: **> write <data=xx xx ...> [offset] [type]**
 
 acquire-write
 -------------
 
 Acquire Write file descriptor.
 
-:Usage: **# acquire-write**
+:Usage: **> acquire-write**
 
 release-write
 -------------
 
 Release Write file descriptor.
 
-:Usage: **# release-write**
+:Usage: **> release-write**
 
 acquire-notify
 --------------
 
 Acquire Notify file descriptor.
 
-:Usage: **# acquire-notify**
+:Usage: **> acquire-notify**
 
 release-notify
 --------------
 
 Release Notify file descriptor.
 
-:Usage: **# release-notify**
+:Usage: **> release-notify**
 
 notify
 ------
 
 Notify attribute value.
 
-:Usage: **# notify <on/off>**
+:Usage: **> notify <on/off>**
 
 clone
 -----
 
 Clone a device or attribute.
 
-:Usage: **# clone [dev/attribute/UUID]**
+:Usage: **> clone [dev/attribute/UUID]**
 
 register-application
 --------------------
 
 Register application.
 
-:Usage: **# register-application [UUID ...]**
+:Usage: **> register-application [UUID ...]**
 
 unregister-application
 ----------------------
 
 Unregister application
 
-:Usage: **# unregister-application**
+:Usage: **> unregister-application**
 
 register-service
 ----------------
 
 Register application service.
 
-:Usage: **# register-service <UUID> [handle]**
+:Usage: **> register-service <UUID> [handle]**
 
 unregister-service
 ------------------
 
 Unregister application service
 
-:Usage: **# unregister-service <UUID/object>**
+:Usage: **> unregister-service <UUID/object>**
 
 register-includes
 -----------------
 
 Register as Included service.
 
-:Usage: **#r egister-includes <UUID> [handle]**
+:Usage: **>r egister-includes <UUID> [handle]**
 
 unregister-includes
 -------------------
 
 Unregister Included service.
 
-:Usage: **# unregister-includes <Service-UUID><Inc-UUID>**
+:Usage: **> unregister-includes <Service-UUID><Inc-UUID>**
 
 register-characteristic
 -----------------------
 
 Register service characteristic.
 
-:Usage: **# register-characteristic <UUID> <Flags=read,write,notify...> [handle]**
+:Usage: **> register-characteristic <UUID> <Flags=read,write,notify...> [handle]**
 
 unregister-characteristic
 -------------------------
 
 Unregister service characteristic.
 
-:Usage: **# unregister-characteristic <UUID/object>**
+:Usage: **> unregister-characteristic <UUID/object>**
 
 register-descriptor
 -------------------
 
 Register characteristic descriptor.
 
-:Usage: **# register-descriptor <UUID> <Flags=read,write...> [handle]**
+:Usage: **> register-descriptor <UUID> <Flags=read,write...> [handle]**
 
 unregister-descriptor
 ---------------------
 
 Unregister characteristic descriptor.
 
-:Usage: **# unregister-descriptor <UUID/object>**
+:Usage: **> unregister-descriptor <UUID/object>**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-mgmt.rst b/client/bluetoothctl-mgmt.rst
index 4baed6480c14..b82141206f57 100644
--- a/client/bluetoothctl-mgmt.rst
+++ b/client/bluetoothctl-mgmt.rst
@@ -26,217 +26,217 @@ select
 
 Select a different index
 
-:Usage: **# select <index>**
+:Usage: **> select <index>**
 
 revision
 --------
 
 Get the MGMT Revision
 
-:Usage: **# revision**
+:Usage: **> revision**
 
 commands
 --------
 
 List supported commands
 
-:Usage: **# commands**
+:Usage: **> commands**
 
 config
 ------
 
 Show configuration info
 
-:Usage: **# config**
+:Usage: **> config**
 
 info
 ----
 
 Show controller info
 
-:Usage: **# info**
+:Usage: **> info**
 
 extinfo
 -------
 
 Show extended controller info
 
-:Usage: **# extinfo**
+:Usage: **> extinfo**
 
 auto-power
 ----------
 
 Power all available features
 
-:Usage: **# auto-power**
+:Usage: **> auto-power**
 
 power
 -----
 
 Toggle powered state
 
-:Usage: **# power <on/off>**
+:Usage: **> power <on/off>**
 
 discov
 ------
 
 Toggle discoverable state
 
-:Usage: **# discov <yes/no/limited> [timeout]**
+:Usage: **> discov <yes/no/limited> [timeout]**
 
 connectable
 -----------
 
 Toggle connectable state
 
-:Usage: **# connectable <on/off>**
+:Usage: **> connectable <on/off>**
 
 fast-conn
 ---------
 
 Toggle fast connectable state
 
-:Usage: **# fast-conn <on/off>**
+:Usage: **> fast-conn <on/off>**
 
 bondable
 --------
 
 Toggle bondable state
 
-:Usage: **# bondable <on/off>**
+:Usage: **> bondable <on/off>**
 
 pairable
 --------
 
 Toggle bondable state
 
-:Usage: **# pairable <on/off>**
+:Usage: **> pairable <on/off>**
 
 linksec
 -------
 
 Toggle link level security
 
-:Usage: **# linksec <on/off>**
+:Usage: **> linksec <on/off>**
 
 ssp
 ---
 
 Toggle SSP mode
 
-:Usage: **# spp <on/off>**
+:Usage: **> spp <on/off>**
 
 sc
 --
 
 Toggle SC support
 
-:Usage: **# sc <on/off/only>**
+:Usage: **> sc <on/off/only>**
 
 hs
 --
 
 Toggle HS support
 
-:Usage: **# hs <on/off>**
+:Usage: **> hs <on/off>**
 
 le
 --
 
 Toggle LE support
 
-:Usage: **# le <on/off>**
+:Usage: **> le <on/off>**
 
 advertising
 -----------
 
 Toggle LE advertising
 
-:Usage: **# advertise <on/off>**
+:Usage: **> advertise <on/off>**
 
 bredr
 -----
 
 Toggle BR/EDR support
 
-:Usage: **# bredr <on/off>**
+:Usage: **> bredr <on/off>**
 
 privacy
 -------
 
 Toggle privacy support
 
-:Usage: **# privacy <on/off> [irk]**
+:Usage: **> privacy <on/off> [irk]**
 
 class
 -----
 
 Set device major/minor class
 
-:Usage: **# class <major> <minor>**
+:Usage: **> class <major> <minor>**
 
 disconnect
 ----------
 
 Disconnect device
 
-:Usage: **# disconnect [-t type] <remote address>**
+:Usage: **> disconnect [-t type] <remote address>**
 
 con
 ---
 
 List connections
 
-:Usage: **# con**
+:Usage: **> con**
 
 find
 ----
 
 Discover nearby devices
 
-:Usage: **# find [-l|-b] [-L]**
+:Usage: **> find [-l|-b] [-L]**
 
 find-service
 ------------
 
 Discover nearby service
 
-:Usage: **# find-service [-u UUID] [-r RSSI_Threshold] [-l|-b]**
+:Usage: **> find-service [-u UUID] [-r RSSI_Threshold] [-l|-b]**
 
 stop-find
 ---------
 
 Stop discovery
 
-:Usage: **# stop-find [-l|-b]**
+:Usage: **> stop-find [-l|-b]**
 
 name
 ----
 
 Set local name
 
-:Usage: **# name <name> [shortname]**
+:Usage: **> name <name> [shortname]**
 
 pair
 ----
 
 Pair with a remote device
 
-:Usage: **# pair [-c cap] [-t type] <remote address>**
+:Usage: **> pair [-c cap] [-t type] <remote address>**
 
 cancelpair
 ----------
 
 Cancel pairing
 
-:Usage: **# cancelpair [-t type] <remote address>**
+:Usage: **> cancelpair [-t type] <remote address>**
 
 unpair
 ------
 
 Unpair device
 
-:Usage: **# unpair [-t type] <remote address>**
+:Usage: **> unpair [-t type] <remote address>**
 
 keys
 ----
@@ -250,63 +250,63 @@ ltks
 
 Load Long Term Keys
 
-:Usage: **# ltks**
+:Usage: **> ltks**
 
 irks
 ----
 
 Load Identity Resolving Keys
 
-:Usage: **# irks [--local index] [--file file path]**
+:Usage: **> irks [--local index] [--file file path]**
 
 block
 -----
 
 Block Device
 
-:Usage: **# block [-t type] <remote address>**
+:Usage: **> block [-t type] <remote address>**
 
 unblock
 -------
 
 Unblock Device
 
-:Usage: **# unblock [-t type] <remote address>**
+:Usage: **> unblock [-t type] <remote address>**
 
 add-uuid
 --------
 
 Add UUID
 
-:Usage: **# add-uuid <UUID> <service class hint>**
+:Usage: **> add-uuid <UUID> <service class hint>**
 
 rm-uuid
 -------
 
 Remove UUID
 
-:Usage: **# rm-uuid <UUID>**
+:Usage: **> rm-uuid <UUID>**
 
 clr-uuids
 ---------
 
 Clear UUIDs
 
-:Usage: **# clear-uuids**
+:Usage: **> clear-uuids**
 
 local-oob
 ---------
 
 Local OOB data
 
-:Usage: **# local-oob**
+:Usage: **> local-oob**
 
 remote-oob
 ----------
 
 Remote OOB data
 
-:Usage: **# remote-oob [-t <addr_type>] [-r <rand192>] [-h <hash192>]
+:Usage: **> remote-oob [-t <addr_type>] [-r <rand192>] [-h <hash192>]
 	[-R <rand256>] [-H <hash256>] <addr>**
 
 did
@@ -314,161 +314,161 @@ did
 
 Set Device ID
 
-:Usage: **# did <source>:<vendor>:<product>:<version>**
+:Usage: **> did <source>:<vendor>:<product>:<version>**
 
 static-addr
 -----------
 
 Set static address
 
-:Usage: **# static-addr <address>**
+:Usage: **> static-addr <address>**
 
 public-addr
 -----------
 
 Set public address
 
-:Usage: **# public-addr <address>**
+:Usage: **> public-addr <address>**
 
 ext-config
 ----------
 
 External configuration
 
-:Usage: **# ext-config <on/off>**
+:Usage: **> ext-config <on/off>**
 
 debug-keys
 ----------
 
 Toggle debug keys
 
-:Usage: **# debug-keys <on/off>**
+:Usage: **> debug-keys <on/off>**
 
 conn-info
 ---------
 
 Get connection information
 
-:Usage: **# conn-info [-t type] <remote address>**
+:Usage: **> conn-info [-t type] <remote address>**
 
 io-cap
 ------
 
 Set IO Capability
 
-:Usage: **# io-cap <cap>**
+:Usage: **> io-cap <cap>**
 
 scan-params
 -----------
 
 Set Scan Parameters
 
-:Usage: **# scan-params <interval> <window>**
+:Usage: **> scan-params <interval> <window>**
 
 get-clock
 ---------
 
 Get Clock Information
 
-:Usage: **# get-clock [address]**
+:Usage: **> get-clock [address]**
 
 add-device
 ----------
 
 Add Device
 
-:Usage: **# add-device [-a action] [-t type] <address>**
+:Usage: **> add-device [-a action] [-t type] <address>**
 
 del-device
 ----------
 
 Remove Device
 
-:Usage: **# del-device [-t type] <address>**
+:Usage: **> del-device [-t type] <address>**
 
 clr-devices
 -----------
 
 Clear Devices
 
-:Usage: **# clr-devices**
+:Usage: **> clr-devices**
 
 bredr-oob
 ---------
 
 Local OOB data (BR/EDR)
 
-:Usage: **# bredr-oob**
+:Usage: **> bredr-oob**
 
 le-oob
 ------
 
 Local OOB data (LE)
 
-:Usage: **# le-oob**
+:Usage: **> le-oob**
 
 advinfo
 -------
 
 Show advertising features
 
-:Usage: **# advinfo**
+:Usage: **> advinfo**
 
 advsize
 -------
 
 Show advertising size info
 
-:Usage: **# advsize [options] <instance_id>**
+:Usage: **> advsize [options] <instance_id>**
 
 add-adv
 -------
 
 Add advertising instance
 
-:Usage: **# add-adv [options] <instance_id>**
+:Usage: **> add-adv [options] <instance_id>**
 
 rm-adv
 ------
 
 Remove advertising instance
 
-:Usage: **# rm-adv <instance_id>**
+:Usage: **> rm-adv <instance_id>**
 
 clr-adv
 -------
 
 Clear advertising instances
 
-:Usage: **# clr-adv**
+:Usage: **> clr-adv**
 
 add-ext-adv-params
 ------------------
 
 Add extended advertising params
 
-:Usage: **# add-ext-adv-parms [options] <instance_id>**
+:Usage: **> add-ext-adv-parms [options] <instance_id>**
 
 add-ext-adv-data
 ----------------
 
 Add extended advertising data
 
-:Usage: **# add-ext-adv-data [options] <instance_id>**
+:Usage: **> add-ext-adv-data [options] <instance_id>**
 
 appearance
 ----------
 
 Set appearance
 
-:Usage: **# appearance <appearance>**
+:Usage: **> appearance <appearance>**
 
 phy
 ---
 
 Get/Set PHY Configuration
 
-:Usage: **# phy [LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] [LECODEDTX] [LECODEDRX]
+:Usage: **> phy [LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] [LECODEDTX] [LECODEDRX]
 	[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT][EDR2M1SLOT] [EDR2M3SLOT]
 	[EDR2M5SLOT][EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]**
 
@@ -477,63 +477,63 @@ wbs
 
 Toggle Wideband-Speech support
 
-:Usage: **# wbs <on/off>**
+:Usage: **> wbs <on/off>**
 
 secinfo
 -------
 
 Show security information
 
-:Usage: **# secinfo**
+:Usage: **> secinfo**
 
 expinfo
 -------
 
 Show experimental features
 
-:Usage: **# expinfo**
+:Usage: **> expinfo**
 
 exp-debug
 ---------
 
 Set debug feature
 
-:Usage: **# exp-debug <on/off>**
+:Usage: **> exp-debug <on/off>**
 
 exp-privacy
 -----------
 
 Set LL privacy feature
 
-:Usage: **# exp-privacy <on/off>**
+:Usage: **> exp-privacy <on/off>**
 
 exp-quality
 -----------
 
 Set bluetooth quality report feature
 
-:Usage: **# exp-quality <on/off>**
+:Usage: **> exp-quality <on/off>**
 
 exp-offload
 -----------
 
 Toggle codec support
 
-:Usage: **# exp-offload <on/off>**
+:Usage: **> exp-offload <on/off>**
 
 read-sysconfig
 --------------
 
 Read System Configuration
 
-:Usage: **# read-sysconfig**
+:Usage: **> read-sysconfig**
 
 set-sysconfig
 -------------
 
 Set System Configuration
 
-:Usage: **# set-sysconfig <-v|-h> [options...]**
+:Usage: **> set-sysconfig <-v|-h> [options...]**
 
 get-flags
 ---------
@@ -546,7 +546,7 @@ set-flags
 
 Set device flags
 
-:Usage: **# set-flags [-f flags] [-t type] <address>**
+:Usage: **> set-flags [-f flags] [-t type] <address>**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-monitor.rst b/client/bluetoothctl-monitor.rst
index 2357a56ace36..98b49dc22eb9 100644
--- a/client/bluetoothctl-monitor.rst
+++ b/client/bluetoothctl-monitor.rst
@@ -26,56 +26,56 @@ set-rssi-threshold
 
 Set RSSI threshold parameter
 
-:Usage: **# set-rssi-threshold <low_threshold> <high_threshold>**
+:Usage: **> set-rssi-threshold <low_threshold> <high_threshold>**
 
 set-rssi-timeout
 ----------------
 
 Set RSSI timeout parameter
 
-:Usage: **# set-rssi-timeout <low_timeout> <high_timeout>**
+:Usage: **> set-rssi-timeout <low_timeout> <high_timeout>**
 
 set-rssi-sampling-period
 -------------------------
 
 Set RSSI sampling period parameter
 
-:Usage: **# set-rssi-timeout <low_timeout> <high_timeout>**
+:Usage: **> set-rssi-timeout <low_timeout> <high_timeout>**
 
 add-or-pattern
 --------------
 
 Register 'or pattern' type monitor with the specified RSSI parameters
 
-:Usage: **# add-or-pattern [patterns=pattern1 pattern2 ...]**
+:Usage: **> add-or-pattern [patterns=pattern1 pattern2 ...]**
 
 get-pattern
 -----------
 
 Get advertisement monitor
 
-:Usage: **# get-pattern <monitor-id/all>**
+:Usage: **> get-pattern <monitor-id/all>**
 
 remove-pattern
 --------------
 
 Remove advertisement monitor
 
-:Usage: **# remove-pattern <monitor-id/all>**
+:Usage: **> remove-pattern <monitor-id/all>**
 
 get-supported-info
 ------------------
 
 Get advertisement manager supported features and supported monitor types
 
-:Usage: **# get-supported-info**
+:Usage: **> get-supported-info**
 
 print-usage
 -----------
 
 Print the command usage
 
-:Usage: **# print-usage <add-or-pattern>**
+:Usage: **> print-usage <add-or-pattern>**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-player.rst b/client/bluetoothctl-player.rst
index e45e61a1c5e3..0c446de6ab82 100644
--- a/client/bluetoothctl-player.rst
+++ b/client/bluetoothctl-player.rst
@@ -26,133 +26,133 @@ list
 
 List available players.
 
-:Usage: **# list**
+:Usage: **> list**
 
 show
 ----
 
 Show player information.
 
-:Usage: **# show [player]**
+:Usage: **> show [player]**
 
 select
 ------
 
 Select default player.
 
-:Usage: **# select <player>**
+:Usage: **> select <player>**
 
 play
 ----
 
 Start playback.
 
-:Usage: **# play [item]**
+:Usage: **> play [item]**
 
 pause
 -----
 
 Pause playback.
 
-:Usage: **# pause**
+:Usage: **> pause**
 
 stop
 ----
 
 Stop playback.
 
-:Usage: **# stop**
+:Usage: **> stop**
 
 next
 ----
 
 Jump to next item.
 
-:Usage: **# next**
+:Usage: **> next**
 
 previous
 --------
 
 Jump to previous item.
 
-:Usage: **# previous**
+:Usage: **> previous**
 
 fast-forward
 ------------
 
 Fast forward playback.
 
-:Usage: **# fast-forward**
+:Usage: **> fast-forward**
 
 rewind
 ------
 
 Rewind playback.
 
-:Usage: **# rewind**
+:Usage: **> rewind**
 
 equalizer
 ---------
 
 Enable/Disable equalizer.
 
-:Usage: **# equalizer <on/off>**
+:Usage: **> equalizer <on/off>**
 
 repeat
 ------
 
 Set repeat mode.
 
-:Usage: **# repeat <singletrack/alltrack/group/off>**
+:Usage: **> repeat <singletrack/alltrack/group/off>**
 
 shuffle
 -------
 
 Set shuffle mode.
 
-:Usage: **# shuffle <alltracks/group/off>**
+:Usage: **> shuffle <alltracks/group/off>**
 
 scan
 ----
 
 Set scan mode.
 
-:Usage: **# scan <alltracks/group/off>**
+:Usage: **> scan <alltracks/group/off>**
 
 change-folder
 -------------
 
 Change current folder.
 
-:Usage: **# change-folder <item>**
+:Usage: **> change-folder <item>**
 
 list-items
 ----------
 
 List items of current folder.
 
-:Usage: **# list-items [start] [end]**
+:Usage: **> list-items [start] [end]**
 
 search
 ------
 
 Search items containing string.
 
-:Usage: **# search <string>**
+:Usage: **> search <string>**
 
 queue
 -----
 
 Add item to playlist queue.
 
-:Usage: **# queue <item>**
+:Usage: **> queue <item>**
 
 show-item
 ---------
 
 Show item information.
 
-:Usage: **# show-item <item>**
+:Usage: **> show-item <item>**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
index 54ea2e8fe8e5..23e0637fce55 100644
--- a/client/bluetoothctl-scan.rst
+++ b/client/bluetoothctl-scan.rst
@@ -26,7 +26,7 @@ uuids
 
 Set/Get UUIDs filter.
 
-:Usage: **# uuids [all/uuid1 uuid2 ...]**
+:Usage: **> uuids [all/uuid1 uuid2 ...]**
 
 rssi
 ----
@@ -40,8 +40,8 @@ The value is in dBm.
 If one or more discovery filters have been set, the RSSI delta-threshold imposed
 by starting discovery by default will not be applied.
 
-:Usage: **# rssi [rssi]**
-:Example: **# rssi -60**
+:Usage: **> rssi [rssi]**
+:Example: **> rssi -60**
 
 pathloss
 --------
@@ -54,8 +54,8 @@ The value is in dB.
 If one or more discovery filters have been set, the RSSI delta-threshold
 imposed by starting discovery by default will not be applied.
 
-:Usage: **# pathloss [pathloss]**
-:Example: **# pathloss 4**
+:Usage: **> pathloss [pathloss]**
+:Example: **> pathloss 4**
 
 transport
 ---------
@@ -78,7 +78,7 @@ an org.bluez.Error.Failed error will be returned.
 If "auto" transport is requested, the scan will use LE, BREDR, or both,
 depending on what's currently enabled on the controller.
 
-:Usage: **# transport [auto/bredr/le]**
+:Usage: **> transport [auto/bredr/le]**
 
 duplicate-data
 --------------
@@ -90,7 +90,7 @@ Disables duplicate detection of advertisement data.
 When enabled, PropertiesChanged signals will be generated for ManufacturerData
 and ServiceData every time they are discovered.
 
-:Usage: **# duplicate-data [on/off]**
+:Usage: **> duplicate-data [on/off]**
 
 discoverable
 ------------
@@ -102,7 +102,7 @@ Makes the adapter discoverable while discovering.
 If the adapter is already discoverable, setting this filter won't have any
 effect.
 
-:Usage: **# discoverable [on/off]**
+:Usage: **> discoverable [on/off]**
 
 pattern
 -------
@@ -119,7 +119,7 @@ When set, it disregards device discoverable flags.
        set any pattern, as it works as a logical OR. Also, setting an empty
        string "" pattern will match any device found.
 
-:Usage: **# pattern [value]**
+:Usage: **> pattern [value]**
 
 
 clear
@@ -127,7 +127,7 @@ clear
 
 Clears discovery filter.
 
-:Usage: **# clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]**
+:Usage: **> clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-transport.rst
index 96156a8cf87b..c7a57716f7be 100644
--- a/client/bluetoothctl-transport.rst
+++ b/client/bluetoothctl-transport.rst
@@ -26,21 +26,21 @@ list
 
 List available transports.
 
-:Usage: **# list**
+:Usage: **> list**
 
 show
 ----
 
 Show transport information.
 
-:Usage: **# show [transport]**
+:Usage: **> show [transport]**
 
 acquire
 -------
 
 Acquire transport.
 
-:Usage: **# acquire <transport> [transport1...]**
+:Usage: **> acquire <transport> [transport1...]**
 
 Note:
 
@@ -53,7 +53,7 @@ select
 Select transport. For transports created on a Broadcast Sink device only. This moves
 the transport to the "broadcasting" state, pending acquire.
 
-:Usage: **# select <transport> [transport1...]**
+:Usage: **> select <transport> [transport1...]**
 
 Note:
 If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
@@ -67,7 +67,7 @@ the transport to the "idle" state, pending release by the audio server. If the t
 was acquired by bluetoothctl it can be released straight away, without having to be
 unselected.
 
-:Usage: **# unselect <transport> [transport1...]**
+:Usage: **> unselect <transport> [transport1...]**
 
 Note:
 If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
@@ -78,7 +78,7 @@ release
 
 Release transport.
 
-:Usage: **# release <transport> [transport1...]**
+:Usage: **> release <transport> [transport1...]**
 
 Note:
 
@@ -89,21 +89,21 @@ send
 
 Send contents of a file.
 
-:Usage: **# send <transport> <filename>**
+:Usage: **> send <transport> <filename>**
 
 receive
 -------
 
 Get/Set file to receive.
 
-:Usage: **# receive <transport> [filename]**
+:Usage: **> receive <transport> [filename]**
 
 volume
 ------
 
 Get/Set transport volume.
 
-:Usage: **# volume <transport> [value]**
+:Usage: **> volume <transport> [value]**
 
 RESOURCES
 =========
diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
index 7454c1d085f8..b6c2efa351d8 100644
--- a/client/bluetoothctl.rst
+++ b/client/bluetoothctl.rst
@@ -47,42 +47,42 @@ list
 
 List available controllers.
 
-:Usage: **# list**
+:Usage: **> list**
 
 show
 ----
 
 Controller information.
 
-:Usage: **# show [ctrl]**
+:Usage: **> show [ctrl]**
 
 select
 ------
 
 Select default controller.
 
-:Usage: **# select <ctrl>**
+:Usage: **> select <ctrl>**
 
 devices
 -------
 
 List available devices, with an optional property as the filter.
 
-:Usage: **# devices [Paired/Bonded/Trusted/Connected]**
+:Usage: **> devices [Paired/Bonded/Trusted/Connected]**
 
 system-alias
 ------------
 
 Set controller alias.
 
-:Usage: **# system-alias <name>**
+:Usage: **> system-alias <name>**
 
 reset-alias
 -----------
 
 Reset controller alias.
 
-:Usage: **# reset-alias**
+:Usage: **> reset-alias**
 
 power
 -----
@@ -92,7 +92,7 @@ Set controller power.
 When the controller is powered off, the USB port the controller is attached to
 is put into a suspend state.
 
-:Usage: **# power <on/off>**
+:Usage: **> power <on/off>**
 
 advertise
 ---------
@@ -108,14 +108,14 @@ device).
 A device can advertise if it initiated the connection to another advertising
 device.
 
-:Usage: **# advertise <on/off/type>**
+:Usage: **> advertise <on/off/type>**
 
 set-alias
 ---------
 
 Set device alias.
 
-:Usage: **# set-alias <alias>**
+:Usage: **> set-alias <alias>**
 
 scan
 ----
@@ -140,7 +140,7 @@ Note the following when scanning:
   - Device objects found during a scan session will only be persisted if they
     are connected/paired otherwise they are removed after some time.
 
-:Usage: **# scan <on/off/bredr/le>**
+:Usage: **> scan <on/off/bredr/le>**
 
 pair
 ----
@@ -161,7 +161,7 @@ connection before pairing.
 Before pairing the agent must be selected to choose the authentication
 mechanism.
 
-:Usage: **# pair <dev>**
+:Usage: **> pair <dev>**
 
 pairable
 --------
@@ -171,7 +171,7 @@ Set controller pairable mode.
 This enables/disables pairing. If pairing is disabled then the controller will
 not accept any pairing requests.
 
-:Usage: **# pairable <on/off>**
+:Usage: **> pairable <on/off>**
 
 discoverable
 ------------
@@ -188,7 +188,7 @@ requests.
 It will use a random address if supported by the controller. The length of time
 "discoverable on" is valid is determined by discoverable-timeout command.
 
-:Usage: **# discoverable <on/off>**
+:Usage: **> discoverable <on/off>**
 
 discoverable-timeout
 --------------------
@@ -197,7 +197,7 @@ Set discoverable timeout.
 
 The time in seconds that "discoverable on" is valid.
 
-:Usage: **# discoverable-timeout [value]**
+:Usage: **> discoverable-timeout [value]**
 
 agent
 -----
@@ -210,7 +210,7 @@ for pairing and allows you to choose the IO capabilities of the controller.
 The valid agent capabilities are: DisplayOnly, DisplayYesNo, KeyboardDisplay,
 KeyboardOnly, NoInputNoOutput.
 
-:Usage: **# agent <on/off/capability>**
+:Usage: **> agent <on/off/capability>**
 
 default-agent
 -------------
@@ -219,41 +219,41 @@ Set current agent as the default one.
 
 After selecting the agent this will make it the default agent.
 
-:Usage: **# default-agent**
+:Usage: **> default-agent**
 
 trust
 -----
 
 Trust device.
 
-:Usage: **# trust <dev>**
+:Usage: **> trust <dev>**
 
 untrust
 -------
 
 Untrust device.
 
-:Usage: **# untrust <dev>**
+:Usage: **> untrust <dev>**
 
 block
 -----
 
 Block device.
 
-:Usage: **# block <dev>**
+:Usage: **> block <dev>**
 
 unblock
 -------
 Unblock device
 
-:Usage: **# unblock <dev>**
+:Usage: **> unblock <dev>**
 
 remove
 ------
 
 Remove device.
 
-:Usage: **# remove <dev>**
+:Usage: **> remove <dev>**
 
 connect
 -------
@@ -269,7 +269,7 @@ If no advertising report is received before the timeout a
 le-connection-abort-by-local error will be issued. In that case either try
 again to connect assuming the device is advertising.
 
-:Usage: **# connect <dev>**
+:Usage: **> connect <dev>**
 
 disconnect
 ----------
@@ -279,14 +279,14 @@ Disconnect device.
 For LE when disconnecting from an active connection the device address is not
 needed.
 
-:Usage: **# disconnect <dev>**
+:Usage: **> disconnect <dev>**
 
 info
 ----
 
 Device information.
 
-:Usage: **# info <dev>**
+:Usage: **> info <dev>**
 
 
 Advertise Submenu
-- 
2.47.1

