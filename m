Received: from www316.your-server.de (www316.your-server.de [88.198.220.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881E1C84DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.220.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944306; cv=none; b=qiCzMEvwXeXMqFmuszSXw8Au6SecFYmEHCF4ZYFkO5Oq8N6W+daVJt2j/D/bVoftY9y/jkoWRVtUQwZ7EdRPr1JG0hglb1CnqW+u3GYdgYGGSIK33KF0I7cdfrst9AMNGq9eiJEgmdK4UIrMIr8ciRgU8hafsEMdVptKWArh5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944306; c=relaxed/simple;
	bh=0Q5l+5KpjZRHR9H+U/04oen5u4zcDp+lSPzHQ/sVV3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o8ciWXukAG1huFFkMunSYMGyVSFGdhsT9uk2rinxAZ1ytRogUzVxS5snnXaKkd8/+d66AndtfzBY732OlAymv00HfkmDbRB4Q0XcaDePNHw0oBOEL4On3H/ZlLB12kJoW2DfJYFfLc6+CuGX7gomPXvfn5jOtsdKPs4UobMV3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dylanvanassche.be; spf=pass smtp.mailfrom=dylanvanassche.be; dkim=pass (2048-bit key) header.d=dylanvanassche.be header.i=@dylanvanassche.be header.b=ti0XOV+C; arc=none smtp.client-ip=88.198.220.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dylanvanassche.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dylanvanassche.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dylanvanassche.be header.i=@dylanvanassche.be header.b="ti0XOV+C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dylanvanassche.be; s=default2306; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/EQKPOdhbqdjuKqDeWcSVADrafUnimy6j+x4PGHRwpc=; b=ti0XOV+CapljCw89fZt56Cr3u8
	49oBjOU7AFUwLaGqQRRAHysTvFSixSYdFahGaEldXrg1BUQy2AdaYG8zUaOvoQtXHPLBVYCc/IEj8
	1Zm/iqbMc5HXpInXqko94vNTYBDr/OCHh/2IX0QRGwD0nYIaCtjyx0/mOaehdXAtOvNfm/agwIuyx
	H4CANfN8LT8MiMsW0559qnJKCxkkWIvH3WDnMdaC0rMXcWlpk2wa4Rqb+qFRMT+JTj9LCOP2wP1nT
	fVWkXtAcqxNtT6BKiorztUDT+etAjH23HaYfB6/KWsXdMMpjGMly08UZpoKv6hJ70uPTycpTUHsNo
	o01EtX/A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www316.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <me@dylanvanassche.be>)
	id 1tt0sk-000OCn-1e;
	Fri, 14 Mar 2025 09:59:06 +0100
Received: from [94.224.88.199] (helo=[192.168.1.141])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <me@dylanvanassche.be>)
	id 1tt0sk-000DyA-1u;
	Fri, 14 Mar 2025 09:59:06 +0100
Message-ID: <c7e5fe5a-834d-4baf-81a9-17fd85a14780@dylanvanassche.be>
Date: Fri, 14 Mar 2025 09:59:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QCA9377-3] How to Enable Bluetooth HFP on BlueZ 5.56?
To: Jeonghum Joh <oosaprogrammer@gmail.com>, linux-bluetooth@vger.kernel.org
References: <CALYKT1guG+x7v6ojLvS+AZ-u_EO0uxycBLsUi9FnfAETdpQ6aA@mail.gmail.com>
Content-Language: en-US
From: Dylan Van Assche <me@dylanvanassche.be>
In-Reply-To: <CALYKT1guG+x7v6ojLvS+AZ-u_EO0uxycBLsUi9FnfAETdpQ6aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: me@dylanvanassche.be
X-Virus-Scanned: Clear (ClamAV 1.0.7/27576/Thu Mar 13 09:48:52 2025)

Hi,

Make sure that some KConfigs are set as module and not as builtin:

- BT_RFCOMM (needed for HFP, RFCOMM is used for AT commands)
- BT_BNEP (if you want Bluetooth ethernet networking)

Seeing your logs, it seems this is already the case, but worth to check.
Only when the RFCOMM part is properly started, HFP AG profile will show 
up in BlueZ with Qualcomm Bluetooth chips, as seen in 
https://gitlab.com/sdm845-mainline/linux/-/merge_requests/38.

I am also interested in this, because I was able to make the HFP AG 
profile show up, but never got audio out of it.

Kind regards,
Dylan Van Assche

On 14/03/2025 09:49, Jeonghum Joh wrote:
> Hello Linux Bluetooth Community,
>
> I am working with the Fn-Link 8223A-SR (QCA9377-3 / QCA1023-0)
> Bluetooth module and attempting to enable the Bluetooth Hands-Free
> Profile (HFP) so that my device can function as an HFP Audio Gateway
> (AG). However, I have encountered issues and would appreciate
> guidance.
>
> System Information:
> Module: Fn-Link 8223A-SR (QCA9377-3 / QCA1023-0)
> Bluetooth Daemon: 5.56
> BlueZ Version: 5.56 (Built from bluez5_utils in Buildroot)
> Kernel Version: Linux buildroot 5.15.112 #1 SMP PREEMPT Fri Mar 14
> 14:59:53 KST 2025 aarch64 GNU/Linux
> Audio Interface: The Bluetooth module firmware is configured to use
> I2S instead of PCM.
> I2S Wiring: The I2S interface is not yet connected to an external IC.
> Goal: I want to connect a Bluetooth hands-free device (e.g., earbuds)
> to my system via HFP and use it as an audio capture microphone. The
> expected flow is:
>
> The Bluetooth hands-free device encodes audio in CVSD/mSBC and
> transmits it over HFP.
> The Bluetooth module receives the encoded data, decodes it in
> hardware, and outputs PCM audio via its I2S interface.
>
> Steps I Took to Enable HFP AG
>
> 1. Enabled audio-related features in BlueZ:
>
> --- a/ambalink/buildroot/package/bluez5_utils/bluez5_utils.mk
> +++ b/ambalink/buildroot/package/bluez5_utils/bluez5_utils.mk
> @@ -13,6 +13,9 @@ BLUEZ5_UTILS_LICENSE = GPLv2+, LGPLv2.1+
>   BLUEZ5_UTILS_LICENSE_FILES = COPYING COPYING.LIB
>
>   BLUEZ5_UTILS_CONF_OPTS =       \
> +       --enable-audio          \
> +       --enable-handsfree      \
> +       --enable-debug          \
>           --enable-tools          \
>           --enable-library        \
>
> 2. Started bluetoothd with the following options:
>
> /usr/libexec/bluetooth/bluetoothd -C --plugin=audio --noplugin=sap
> --compat --experimental -d
>
> 3. Updated main.conf:
>
> [General]
> ControllerMode = dual
> Class = 0x200404
> AutoEnable = true
>
> Issue: HFP AG is Not Enabled
> After setting up the system, I expected to see the following when
> running bluetoothctl show:
>
> 1. UUID for HFP AG should appear:
> UUID: Handsfree Audio Gateway (0000111f-0000-1000-8000-00805f9b34fb)
>
> 2. Device class should be set correctly:
> Class: 0x200404
>
> However, the actual output is:
> / # bluetoothctl show
> Controller 64:82:14:C6:BF:21 (public)
>          Name: model-name BF21
>          Alias: model-name BF21
>          Class: 0x00000404
>          Powered: yes
>          Discoverable: no
>          DiscoverableTimeout: 0x00015180
>          Pairable: yes
>          UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>          UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>          UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>          Modalias: usb:v1D6Bp0246d0538
>          Discovering: no
>          Roles: central
>          Roles: peripheral
>
> Problems Observed:
> 1. The UUID for HFP AG (0000111f-0000-1000-8000-00805f9b34fb) is missing.
> 2. The Device Class is incorrect (0x00000404 instead of 0x200404).
>
> Logs:
> I have attached logs at the bottom of this email from:
> - bluetoothd startup
> - Linux system boot logs (including Bluetooth-related messages)
>
> Questions:
> 1. How can I enable Bluetooth HFP AG properly?
>   - Have I missed any essential configuration steps?
>   - Are there any additional BlueZ patches or settings required for this module?
>
> 2. Why did my attempt to enable HFP AG fail?
>   - Given my setup, what could be preventing the UUID from being registered?
>   - Does my approach align with BlueZ’s expected HFP AG configuration?
>
> Any insights or guidance would be greatly appreciated.
>
> Best regards,
> Jeonghum
>
>
>
> - bluetoothd startup
>
> Device setup complete
> [   16.664959] Bluetooth: hci0: ROME setup
> [   16.670308] Bluetooth: hci0: setting up ROME/QCA6390
> [   16.675334] Bluetooth: hci0: Set UART speed to 115200
> mount -o rbind /pref/MISC/bluetooth/ /tmp/lib/bluetooth/
> # BT_DISCOVERABLE_TIMEOUT = 86400
> /usr/libexec/bluetooth/bluetoothd -C --plugin=audio --noplugin=sap
> --compat --experimental -d
> Jan  1 00:00:16 buildroot daemon.info bluetoothd[297]: Bluetooth daemon 5.56
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() parsing /tmp/bluetooth/main.conf
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() discovto=86400
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “AlwaysPairable”
> in group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “PairableTimeout”
> in group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “Privacy” in
> group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key
> “JustWorksRepairing” in group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key
> “TemporaryTimeout” in group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() name=model-name BF21
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() class=0x200404
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “DeviceID” in
> group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key
> “ReverseServiceDiscovery” in group “General”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() ControllerMode=dual
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “Cache” in group
> “GATT”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “KeySize” in
> group “GATT”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “ExchangeMTU” in
> group “GATT”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “Channels” in
> group “GATT”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “SessionMode” in
> group “AVDTP”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_config() Key file does not have key “StreamMode” in
> group “AVDTP”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “PageScanType” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]: [   16.988455]
> Bluetooth: hci0: QCA Product ID   :0x00000008
> src/main.c:parse[   16.994613] Bluetooth: hci0: QCA SOC Version  :0x00000023
> _mode_config() K[   17.001392] Bluetooth: hci0: QCA ROM Version  :0x00000302
> ey file does not[   17.008187] Bluetooth: hci0: QCA Patch Version:0x000003e8
>   have key “PageScanInterval” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “PageScanWindow” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “InquiryScanType” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “InquiryScanInterval” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “InquiryScanWindow” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “LinkSupervisionTimeout” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “PageTimeout” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “MinSniffInterval” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key
> “MaxSniffInterval” in group “BR”
> Jan  1 00:00:16 buildroot daemon.debug bluetoothd[297]:
> src/main.c:parse_mode_config() Key file does not have key “MJJJJJJJan
> 1 00:00:16 buildroot daemon.debug bluetoothd[297]: src/add
> Jan  1 00:00:16 buildroot daemon.info bluetoothd[297]:Jan  1 00:00:16
> buildroot daemon.deJJJhciconfig hci0 up
> Jan  1 00:00:16 buildroot daemoJan  1Jan  JJan  1 00:00:17 buildroot
> daemon.debug bluetoothd[299]: src/adapter.c:index_added() index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:reset_adv_monitors() sending remove Adv Monitor command
> with handle 0
> Jan  1 00:00:17 buildroot da[   17.179133] Bluetooth: hci0: unexpected
> event for opcode 0x2008
> emon.debug bluetoothd[299]: src/adapter.c:btd_adapter_new() System
> name: model-name BF21
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:btd_adapter_new() Major class: 4
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:btd_adapter_new() Minor class: 1
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d0538
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:btd_adapter_new() Discoverable timeout: 86400 seconds
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:index_added() sending read info command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:reset_adv_monitors_complete() Removed all Adv Monitors
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:read_info_complete() index 0 status 0x00
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:clear_uuids() sending clear uuids command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:clear_devices() sending clear devices command for index
> 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:set_mode() sending set mode command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:set_mode() sending set mode command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:set_mode() sending set mode command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:set_privacy() sending set privacy command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:set_privacy() setting privacy mode 0x00 for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/gatt-database.c:btd_gatt_database_new() GATT Manager registered
> for adapter: /org/bluez/hci0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:adapter_service_add() /org/bluez/hci0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Adding record with handle
> 0x10001
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00000007-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00000100-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00001002-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00001800-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:adapter_service_insert() /org/bluez/hci0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:add_uuid() sending add uuid command for index 0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:adapter_service_add() /org/bluez/hci0
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Adding record with handle
> 0x10002
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00000007-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00000100-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_server() Record pattern UUID
> 00001002-0000-1000-8000-00805f9
> Jan  1 00:00:17 buildroot daemon.debug bluetoothd[299]:
> src/sdpd-service.c:add_record_to_seJJJan  1 00:00:17 buildroJan  1
> 00:00:17 buildroot daemon.debJan  1 00JJJan  1 00:00:17 build4
> Jan  1 00:00:19 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:new_settings_callback() Settings: 0x000002d3
> Jan  1 00:00:19 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:settings_changed() Changed settings: 0x00000001
> Jan  1 00:00:19 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:settings_changed() Pending settings: 0x00000000
> Jan  1 00:00:19 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
> Jan  1 00:00:19 buildroot daemon.debug bluetoothd[299]:
> src/adapter.c:trigger_passive_scanning()
> DEFAULT_SSID = model-name
> READ_BT_NAME = 'model-name BF21'
> READ_BT_NAME2 = model-name
> BT_NAME_AND_MAC_NUM = model-name BF21
> Jan  1 00:00:19 buildroot daemon.info : starting pid 323, tty '': '-/bin/sh'
>
>
> - Linux system boot logs (including Bluetooth-related messages)
>
> [    0.000000] Linux version 5.15.112 (desktop-name)
> (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile
> Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, 5
> [    0.000000] Machine model: Company device_ours Board
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x00000000dfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000004ffff]
> [    0.000000]   node   0: [mem 0x00000000b8800000-0x00000000dfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000dfffffff]
> [    0.000000] On node 0, zone DMA: 493488 pages in unavailable ranges
> [    0.000000] On node 0, zone DMA: 131072 pages in unavailable ranges
> [    0.000000] cma: Reserved 16 MiB at 0x00000000db000000
> [    0.000000] percpu: Embedded 17 pages/cpu s29656 r8192 d31784 u69632
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: detected: Hardware dirty bit management
> [    0.000000] CPU features: detected: Spectre-v4
> [    0.000000] CPU features: detected: Spectre-BHB
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 159342
> [    0.000000] Kernel command line: ubi.mtd=5 root=ubi0:linux
> rootfstype=ubifs console=ttyS4 nosmp maxcpus=0
> [    0.000000] Dentry cache hash table entries: 131072 (order: 8,
> 1048576 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288
> bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 566908K/647488K available (7296K kernel code,
> 724K rwdata, 1920K rodata, 1216K init, 241K bss, 64196K reserved,
> 16384K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 100 jiffies.
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000000] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> every 4398046511100ns
> [    0.000114] Console: colour dummy device 80x25
> [    0.000167] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 100.00 BogoMIPS (lpj=50000)
> [    0.000175] pid_max: default: 32768 minimum: 301
> [    0.000243] Mount-cache hash table entries: 2048 (order: 2, 16384
> bytes, linear)
> [    0.000255] Mountpoint-cache hash table entries: 2048 (order: 2,
> 16384 bytes, linear)
> [    0.001039] rcu: Hierarchical SRCU implementation.
> [    0.001380] smp: Bringing up secondary CPUs ...
> [    0.001385] smp: Brought up 1 node, 1 CPU
> [    0.001389] SMP: Total of 1 processors activated.
> [    0.001394] CPU features: detected: 32-bit EL0 Support
> [    0.001398] CPU features: detected: Data cache clean to the PoU not
> required for I/D coherence
> [    0.001401] CPU features: detected: Common not Private translations
> [    0.001404] CPU features: detected: CRC32 instructions
> [    0.001408] CPU features: detected: RCpc load-acquire (LDAPR)
> [    0.001411] CPU features: detected: LSE atomic instructions
> [    0.001414] CPU features: detected: Privileged Access Never
> [    0.001417] CPU features: detected: RAS Extension Support
> [    0.001420] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
> [    0.015649] CPU: All CPU(s) started at EL1
> [    0.015902] alternatives: patching kernel code
> [    0.017553] devtmpfs: initialized
> [    0.022825] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.022849] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
> [    0.023961] pinctrl core: initialized pinctrl subsystem
> [    0.024543] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.025797] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> [    0.025859] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for
> atomic allocations
> [    0.025904] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for
> atomic allocations
> [    0.026496] ASID allocator initialised with 65536 entries
> [    0.027467] ambalink ppm2 memory (rtos region): 0x00050000 -
> 0xb8000000 (0xffffff8000050000)
> [    0.027504] ambalink shm (shared memory): 0xb8000000 - 0xb8800000
> (0xffffff80b8000000)
> [    0.030546] aipc_spin_lock_setup: aipc_slock@0xffffff80b8446000
> [    0.030701] ambarella-pinctrl 20e4013000.pinctrl: Supplier pinctrl
> driver registered
> [    0.035260] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.035267] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
> [    0.035270] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.035273] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
> [    0.035721] cryptd: max_cpu_qlen set to 1000
> [    0.036657] Can not get amb,mtx_remote2
> [    0.036662] aipc_mutex_of_init: aipc_mutex@0xffffff80b8447000
> [    0.037074] Bluetooth: Core ver 2.22
> [    0.037088] NET: Registered PF_BLUETOOTH protocol family
> [    0.037091] Bluetooth: HCI device and connection manager initialized
> [    0.037096] Bluetooth: HCI socket layer initialized
> [    0.037100] Bluetooth: L2CAP socket layer initialized
> [    0.037107] Bluetooth: SCO socket layer initialized
> [    0.037419] clocksource: Switched to clocksource arch_sys_counter
> [    0.039316] NET: Registered PF_INET protocol family
> [    0.039444] IP idents hash table entries: 16384 (order: 5, 131072
> bytes, linear)
> [    0.039922] tcp_listen_portaddr_hash hash table entries: 512
> (order: 1, 8192 bytes, linear)
> [    0.039940] Table-perturb hash table entries: 65536 (order: 6,
> 262144 bytes, linear)
> [    0.039945] TCP established hash table entries: 8192 (order: 4,
> 65536 bytes, linear)
> [    0.039999] TCP bind hash table entries: 8192 (order: 5, 131072
> bytes, linear)
> [    0.040094] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.040203] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    0.040224] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
> [    0.040286] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.040548] RPC: Registered named UNIX socket transport module.
> [    0.040554] RPC: Registered udp transport module.
> [    0.040556] RPC: Registered tcp transport module.
> [    0.040558] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.042572] Initialise system trusted keyrings
> [    0.042639] workingset: timestamp_bits=62 max_order=18 bucket_order=0
> [    0.044018] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.066396] Key type asymmetric registered
> [    0.066402] Asymmetric key parser 'x509' registered
> [    0.066439] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 252)
> [    0.066444] io scheduler mq-deadline registered
> [    0.066447] io scheduler kyber registered
> [    0.066593] PPM: init with major = 251.
> [    0.067957] 20e0017000.uart: ttyS1 at MMIO 0x20e0017000 (irq = 29,
> base_baud = 1500000) is a ambuart
> [    0.067967] No device available for serial console
> [    0.068155] 20e001a000.uart: ttyS4 at MMIO 0x20e001a000 (irq = 30,
> base_baud = 1500000) is a ambuart
> [    0.752373] printk: console [ttyS4] enabled
> [    0.757256] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.763647]  ram0: unable to read partition table
> [    0.768402] brd: module loaded
> [    0.773282] loop: module loaded
> [    0.776480] Supplier read-only mtdblock
> [    0.781120] ambarella-nand 20e0002000.nand: in ecc-[8]bit mode
> [    0.787057] nand: device found, Manufacturer ID: 0xef, Chip ID: 0xba
> [    0.793441] nand: Winbond W25N04KWxIR SPINAND 4Gb 1.8V 8-bit
> [    0.799118] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 128
> [    0.806803] nand: NAND_ECC_ENGINE_TYPE_NONE selected by board
> driver. This is not recommended!
> [    0.815713] Bad block table found at page 262080, version 0x01
> [    0.821852] Bad block table found at page 262016, version 0x01
> [    0.827877] 12 fixed-partitions partitions found on MTD device amba_nand
> [    0.834600] Creating 12 MTD partitions on "amba_nand":
> [    0.839752] 0x000000020000-0x000000040000 : "USER_PTB"
> [    0.848522] 0x0000002a0000-0x000001ba0000 : "SYS_SW"
> [    0.854209] 0x000001ba0000-0x0000033a0000 : "SECURE"
> [    0.859953] 0x0000033a0000-0x0000083a0000 : "SYS_DATA"
> [    0.865566] 0x0000083a0000-0x0000092a0000 : "LINUX_Kernel"
> [    0.871422] 0x0000092a0000-0x00000cea0000 : "LINUX_RFS"
> [    0.877075] 0x00000cea0000-0x00000cec0000 : "LINUX_HIBER_IMG"
> [    0.883389] 0x00000cec0000-0x00000dc40000 : "VIDEO_REC_IDX"
> [    0.889582] 0x00000dc40000-0x00000dfc0000 : "CALIB"
> [    0.894806] 0x00000dfc0000-0x00000e180000 : "USER_SETTING"
> [    0.900651] 0x00000e180000-0x00000fb00000 : "DRIVE_A"
> [    0.906116] 0x00000fb00000-0x00000fb20000 : "XTB"
> [    0.913448] Bluetooth: HCI UART driver ver 2.3
> [    0.917916] Bluetooth: HCI UART protocol H4 registered
> [    0.923082] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [    0.929372] Bluetooth: HCI UART protocol QCA registered
> [    0.934632] hid: raw HID events driver (C) Jiri Kosina
> [    0.939858] ambarella-rproc ambalink:ambarella-rproc:
> ambarella_rproc_probe device registered
> [    0.948522] remoteproc remoteproc0: ambarella is available
> [    0.954063] remoteproc remoteproc0: powering up ambarella
> [    0.959489] remoteproc remoteproc0: Booting fw image ambadummy, size 0
> [    0.966270] virtio_rpmsg_bus virtio0: rpmsg host is online
> [    0.971792] virtio_rpmsg_bus virtio0: creating channel
> AmbaRpdev_CLK addr 0x400
> [    0.979150]  remoteproc0#vdev0buffer: registered virtio0 (type 7)
> [    0.985339] remoteproc remoteproc0: remote processor ambarella is now up
> [    0.992073] virtio_rpmsg_bus virtio0: creating channel aipc_vfs addr 0x401
> [    0.999189] Initializing XFRM netlink socket
> [    1.003535] NET: Registered PF_PACKET protocol family
> [    1.008605] virtio_rpmsg_bus virtio0: creating channel link_ctrl addr 0x402
> [    1.016213] Bluetooth: RFCOMM TTY layer initialized
> [    1.021166] virtio_rpmsg_bus virtio0: creating channel aipc_rpc addr 0x403
> [    1.028092] Bluetooth: RFCOMM socket layer initialized
> [    1.033300] Bluetooth: RFCOMM ver 1.11
> [    1.037063] virtio_rpmsg_bus virtio0: creating channel echo_cortex addr 0x404
> [    1.044225] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    1.049654] virtio_rpmsg_bus virtio0: Bind driver/device named as echo_cortex
> [    1.056824] Bluetooth: BNEP filters: protocol multicast
> [    1.062069] Bluetooth: BNEP socket layer initialized
> [    1.067056] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    1.072994] Bluetooth: HIDP socket layer initialized
> [    1.078041] Key type dns_resolver registered
> [    1.082693] Loading compiled-in X.509 certificates
> [    1.095173] ubi0: attaching mtd5
> [    1.179937] ubi0: scanning is finished
> [    1.202160] ubi0: volume 0 ("linux") re-sized from 353 to 396 LEBs
> [    1.208617] ubi0: attached mtd5 (name "LINUX_RFS", size 60 MiB)
> [    1.214564] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 bytes
> [    1.221461] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2048
> [    1.228270] ubi0: VID header offset: 2048 (aligned 2048), data offset: 4096
> [    1.235256] ubi0: good PEBs: 480, bad PEBs: 0, corrupted PEBs: 0
> [    1.241280] ubi0: user volume: 1, internal volumes: 1, max. volumes
> count: 128
> [    1.248524] ubi0: max/mean erase counter: 1/0, WL threshold: 4096,
> image sequence number: 366362264
> [    1.257601] ubi0: available PEBs: 0, total reserved PEBs: 480, PEBs
> reserved for bad PEB handling: 80
> [    1.266856] ubi0: background thread "ubi_bgt0d" started, PID 111
> [    1.273001] cfg80211: Loading compiled-in X.509 certificates for
> regulatory database
> [    1.282307] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    1.289108] platform regulatory.0: Direct firmware load for
> regulatory.db failed with error -2
> [    1.298062] cfg80211: failed to load regulatory.db
> [    1.303529] UBIFS (ubi0:0): Mounting in unauthenticated mode
> [    1.376308] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0,
> name "linux", R/O mode
> [    1.384570] UBIFS (ubi0:0): LEB size: 126976 bytes (124 KiB),
> min./max. I/O unit sizes: 2048 bytes/2048 bytes
> [    1.394543] UBIFS (ubi0:0): FS size: 48885760 bytes (46 MiB, 385
> LEBs), max 2047 LEBs, journal size 9023488 bytes (8 MiB, 72 LEBs)
> [    1.406345] UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
> [    1.412214] UBIFS (ubi0:0): media format: w4/r0 (latest is w5/r0),
> UUID 250336EB-AC22-4E1C-AF6C-4B424924E6D5, small LPT model
> [    1.442378] VFS: Mounted root (ubifs filesystem) readonly on device 0:18.
> [    1.468023] devtmpfs: mounted
> [    1.471807] Freeing unused kernel memory: 1216K
> [    1.476454] Run /sbin/init as init process
> Running sysctl: OK
> Starting mdev... OK
> Starting system message bus: [    2.016935] random: dbus-uuidgen:
> uninitialized urandom read (12 bytes read)
> [    2.032559] random: dbus-uuidgen: uninitialized urandom read (8 bytes read)
> Could not create /var/lib/dbus/machine-id.VuMBEEBF: No such file or directory
> [    2.067643] random: dbus-daemon: uninitialized urandom read (12 bytes read)
> done
> Starting network...
> Starting sntp:
> S48sntp is BLOCKED temporarily
> Starting nginx...
> binder2 15 linux_util_svc
> cat: /proc/ambarella/board_info: No such file or directory
> Jan  1 00:00:02 buildroot syslog.info syslogd started: BusyBox v1.35.0
> modprobe ambacv is BLOCKED temporarily
> net.core.wmem_max = 491520
> vm.vfs_cache_pressure = 1000
> Starting vsftpd: OK
> net.core.wmem_default = 4194304
> t gpio 63 sw out1
> [    2.423661] sdhci: Secure Digital Host Controller Interface driver
> [    2.429904] sdhci: Copyright(c) Pierre Ossman
> [    2.435486] sdhci-pltfm: SDHCI platform and OF driver helper
> [    2.473330] mmc0: SDHCI controller on 20e0004000.sdmmc1
> [20e0004000.sdmmc1] using ADMA
> [    2.504243] mmc0: queuing unknown CIS tuple 0x01 [d9 01 ff] (3 bytes)
> [    2.519161] mmc0: queuing unknown CIS tuple 0x1a [01 01 00 02 07] (5 bytes)
> [    2.529606] mmc0: queuing unknown CIS tuple 0x1b [c1 41 30 30 ff ff
> 32 00] (8 bytes)
> [    2.538077] mmc0: queuing unknown CIS tuple 0x14 [] (0 bytes)
> [    2.546599] mmc0: new high speed SDIO card at address 0001
> [    2.805979] wlan: loading out-of-tree module taints kernel.
> [    2.838186] wlan: loading driver v4.5.25.62
> [    2.842678] hifDeviceInserted: Dumping clocks (50000000,50000000)
> [    2.848840] HIFDumpCCCR
> [    2.848856] 0(43)
> [    2.851423] 1(3)
> [    2.853456] 2(0)
> [    2.855390] 3(0)
> [    2.857323] 4(0)
> [    2.859255] 5(0)
> [    2.861187] 6(0)
> [    2.863119] 7(6)
> [    2.865051] 8(17)
> [    2.866986] 9(0)
> [    2.869006] A(10)
> [    2.870938] B(0)
> [    2.872957] C(0)
> [    2.874889] D(0)
> [    2.876822] E(0)
> [    2.878829] F(0)
> [    2.880910] 10(0)
> [    2.882856] 11(0)
> [    2.884878] 12(1)
> [    2.886897] 13(3)
> [    2.888916] 14(7)
> [    2.890936] 15(37)
> [    2.892955] 16(1)
> [    2.895054]
> [    3.092193] ol_download_firmware: chip_id:0x5020001 board_id:0x0
> [    3.098378] ar6k_wlan mmc0:0001:1: Direct firmware load for
> bdwlan30.b00 failed with error -2
> [    3.106940] __ol_transfer_bin_file: Failed to get bdwlan30.b00:-2
> [    3.113054] __ol_transfer_bin_file: Trying to load default bdwlan30.bin
> [    3.120329] Board extended Data download address: 0x0
> [    3.139493] __ol_transfer_bin_file: Loading setup file qsetup30.bin
> [    3.145851] ar6k_wlan mmc0:0001:1: Direct firmware load for
> qsetup30.bin failed with error -2
> [    3.154416] __ol_transfer_bin_file: Failed to get qsetup30.bin:-2
> [    3.387459] random: crng init done
> [    3.390902] random: 1 urandom warning(s) missed due to ratelimiting
> [    3.458574] R0: wlan: [236:E :SAP] dfs_init_radar_filters[217]:
> Unknown dfs domain 0
> [    3.466723] Target Ready! : transmit resources : 3 size:1792,
> MaxMsgsPerHTCBundle = 32
> [    3.543893] ar6k_wlan mmc0:0001:1: Direct firmware load for
> wlan/wlan_mac.bin failed with error -2
> [    3.554138] target uses HTT version 3.60; host uses 3.28
> [    3.559512] *** Warning: host/target HTT versions are different,
> though compatible!
> [    3.571934] DEBUGFS PEER MAC = 0x66:0x82:0x14:0x4b:0xbf:0x20
> [    3.572709] Host SW:4.5.25.62, FW:0.0.0.157, HW:QCA93x7_REV1_1
> [    3.594030] ENTER sme_set_btc_coex_dutycycle = 30
> [    3.594038] ENTER sme_set_btc_coex_dutycycle =30
> [    3.603739] ath_hif_sdio: HIF (Atheros/multi-bss)
> [    3.618146] wlan: driver loaded in 780000
> S92bootdone is running...
> t gpio 61 sw out1
>
> ######################### /usr/local/share/script/bt_start.sh stated........
> DEFAULT_SSID = model-name
> CONFIG_BT_SETUP is 'custom' ....
> BT device name (from bt.conf): model-name BF21
> /usr/sbin/btmgmt
> /usr/sbin/btgatt-server
> qca_soc_init: Rome Version (0x03020023)
>
