Received: from send78.i.mail.ru (send78.i.mail.ru [89.221.237.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC7238166
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782023945; cv=none; b=B5NlB4PPP40+mGwlr15u/j56ONAjfkZQOBrTQGmqTkcpKdS5XSHdli3xjGUoKiKgD6+0vGg8+nLMMuGb684UC9PXeJ/Is6HC6f99ZW12xKlqUfF7ZaZ2N+We6QGTppdTMskvTY50j6Xt0zcNR/CbVc8e9AMKl9PHLVqtIjCtfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782023945; c=relaxed/simple;
	bh=eKFKrCL9F9/M5ykwFmEHMxqadkcy+kGVFy+wVDsHSN8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gMHWOnkykx/L7ZfeHUNrF19x/1JH9ke10OYaHBY7OkrRI6hQfoa51XY2+1l21ed36FIg/FWhwny28FWMlQi/F1DamVI6XPUf8EqeGyKUjy/LJ5CzAUK0SXPglzZyCS8BM3+V+yyjXhhBBa4JWCb35nNnXEHpj4niYRSVKKMmZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=vc10T96E; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Q7OhhUlo; arc=none smtp.client-ip=89.221.237.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="vc10T96E";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="Q7OhhUlo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=7FN0+16XR591R/Dgjxy3qrqLABHVPhHWpsFbNRTqBQ0=; t=1782023941; x=1782113941; 
	b=vc10T96EAD9zF3qNW7BaE5tSumqTkTMXQykmyHh7sFqxluelkBU2mD3SV8Jr9W0gD9qjUVFjMlR
	4dC9eG85ybdbs6PhwfOs3B9r9tAIFkzXPC/C2lug2HDlfXNhamSAUpiBHZHEeFHa4ZlgdDQjhwJBM
	X+EcnehGI8xAZHA6zxYFEQ6/zkVP6iQ5Fa/9x7pYK2tlWTJu0JcRJcttK9HiRAkpr966D2PCmNLFL
	/SWeVEoCQvMe+P7d6gDmzoDnF6NVEBi3tpKeUiDMXccr/HfTArBfx0XAn0ENA/sSWJjrwo6z9LvT7
	JFxijzUsqyCFWmWwbrTseDr5q/xXI8XOevcw==;
Received: from [10.113.20.255] (port=56546 helo=send150.i.mail.ru)
	by exim-fallback-5669b6bd5-sq2xl with esmtp (envelope-from <michail383krasnov@mail.ru>)
	id 1wbBax-0000000016k-0Nhw
	for linux-bluetooth@vger.kernel.org; Sun, 21 Jun 2026 09:23:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=7FN0+16XR591R/Dgjxy3qrqLABHVPhHWpsFbNRTqBQ0=; t=1782023031; x=1782113031; 
	b=Q7OhhUlojms+PAKu+GlD4EUtl5ttKiw/2gG1Q0XUuR5uAY3qbAxVmxDzMvcJrxDFkTtLk/no3p+
	ePNHa8sqkHeGcbYfCGMX9oiOepjLCCJRMMZUdZgxUMAzLaMy9+bKRQkb9a/8Zd8fzVrUaLR7znLQ4
	Gokbrqp6YAm0Xpi31ejPZ+OuwKDRk9A8EHtp+hYDHSNxbycY0va6F2qbFpAaQroX7bG19V8oG9Qfb
	cxgZUOOzHxISwGfUrVTCEdljyg8ZkoZHqn9ttuIwgpwIP0iOh6CRpe3/36bWXzL/ewevhM56LJLdu
	w0I/LuKyuMbbagrji90r+8wVFC2EXEh3fO5Q==;
Received: by exim-smtp-795d79b7fd-c9cqw with esmtpa (envelope-from <michail383krasnov@mail.ru>)
	id 1wbBan-00000000Uas-3hCB
	for linux-bluetooth@vger.kernel.org; Sun, 21 Jun 2026 09:23:42 +0300
Message-ID: <b2bc01ba-edc8-4e73-9358-a3bf1d7c569d@mail.ru>
Date: Sun, 21 Jun 2026 09:23:40 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Misha <michail383krasnov@mail.ru>
Subject: RTL8852BE (0bda:b853) Bluetooth initialization fails with -16 on
 ThinkBook 14+ 2026
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9F376AF9AFA680DB16C5143E7575324C7E67C2D68F5207CC6182A05F53808504042149D99A29E24A33DE06ABAFEAF670583E4978649692250F94841430BA858B866F2506D529139D3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F2919D563845004AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375669C89CB82897FCFF9B50556BA62923AA2E4E0F72B953D9D23992D52C914707C428EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C08794E14F7ADDB10D8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B625DC386152A6764ACC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22492314289C3A426D3676E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B35401D2C5D22D6C43AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4933F735096452955E3BA6625F88748EAEFC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A559391CEC141A24645002B1117B3ED696937040485A3428AB406406D89DD9EB8A823CB91A9FED034534781492E4B8EEAD39B22F2BA948E1C8C79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659F83C8B0D49021E21889F96FB0D60E4AA5519FBE8638C5E52422521312BCABCDA1D34539A7B42DA16B8341EE9D5BE9A0A3F143B304C2714834B8BBE300F7C5D14F102D95721658F2552EE4E5D9E54FDA44C41F94D744909CE5A51345E7065175A71A3253D7569A460BC23669B34AEF6B924A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVRSZSJkMhZtMpIXwteEG77s=
X-Mailru-Sender: 573A2FD82894F0C0D17E9D7A110663F1738B44F6123888F7B951B70A5BD4BD8E982D5DA6839C03B684876E3DC5E244DF7134A88DDC4E9147B668465AE93C1804AD1F288BEB8AC3A34BF454A6271E117607EF0F41A74587EBDA009B5A063416335FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41CF6D121B75A86E9A3951DB0CDE45D8E2FAEC07347A47354049FFFDB7839CE9E5F5CD7022A639BEED039D08E7E506BD799A322CF17183A99D9AD815B81158EAB5C808B5E223E4043
X-7FA49CB5: 0D63561A33F958A54F2D3C0B04A7B7885002B1117B3ED6969F8661BFC9DD36F0E857AACAFE385FA502ED4CEA229C1FA827C277FBC8AE2E8BD9CDC8777CE205DB
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZymmc/m++A+Srot9wixt88w==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

To: linux-bluetooth@vger.kernel.org
Subject: RTL8852BE (0bda:b853) Bluetooth initialization fails with -16 
on ThinkBook 14+ 2026

I'm experiencing Bluetooth initialization failure on a Lenovo ThinkBook
14+ 2026 (Lenovo 14 G8+ AHP - version 2026, released for the Chinese
market) with Realtek RTL8852BE module (USB ID 0bda:b853). The WiFi part
works correctly via rtw89_8852be driver, but Bluetooth fails to
initialize.

Hardware:

- Laptop: Lenovo ThinkBook 14+ 2026 21VR (Chinese market version)
- CPU: AMD Ryzen 7 H 255
- Bluetooth: Realtek RTL8852BE (USB ID 0bda:b853)
- Kernel: 7.1.0-352.vanilla.fc44.x86_64
- Distribution: Fedora 44 Workstation
- linux-firmware: latest from Fedora 44 repos

Problem description:
The Bluetooth device is detected on USB bus (1-5), firmware (see logs
below) are loaded successfully, but initialization fails  with
"Opcode 0xfcf0 failed: -16".

Key observations:
1. The USB device ID is 0bda:b853, which appears to be a newer revision of
    RTL8852BE not listed in linux-firmware/rtl_bt/ directory
2. Available firmware files: rtl8852au_fw.bin, rtl8852btu_fw.bin, 
rtl8852bu_fw.bin,
    rtl8852cu_fw.bin - but NO firmware for revision "b853"
3. Driver attempts to load rtl8852bu_fw.bin as fallback, but chip rejects
    the vendor command 0xfcf0

Commands output:
    ➤ lsusb
    Bus 001 Device 002: ID 0bda:5411 Realtek Semiconductor Corp. RTS5411 Hub
    Bus 001 Device 003: ID 0bda:b853 Realtek Semiconductor Corp. 
Bluetooth Radio


    ➤ lsusb -t
    /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/5p, 480M
       |__ Port 002: Dev 002, If 0, Class=Hub, Driver=hub/2p, 480M
       |__ Port 005: Dev 003, If 0, Class=Wireless, Driver=btusb, 12M
       |__ Port 005: Dev 003, If 1, Class=Wireless, Driver=btusb, 12M



    ➤ sudo dmesg | grep -i rtw
    [    6.876631] rtw89_8852be 0000:05:00.0: loaded firmware 
rtw89/rtw8852b_fw-2.bin
    [    6.876987] rtw89_8852be 0000:05:00.0: enabling device (0000 -> 0003)
    [    6.886529] rtw89_8852be 0000:05:00.0: Firmware version 
0.29.29.15 (6fb3ec41), cmd version 0, type 5
    [    6.886547] rtw89_8852be 0000:05:00.0: Firmware version 
0.29.29.15 (6fb3ec41), cmd version 0, type 3
    [    7.197141] rtw89_8852be 0000:05:00.0: Firmware element BB 
version: 00 28 00 00
    [    7.197185] rtw89_8852be 0000:05:00.0: Firmware element radio A 
version: 00 32 00 00
    [    7.197215] rtw89_8852be 0000:05:00.0: Firmware element NCTL 
version: 00 0a 00 00
    [    7.197312] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197314] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197315] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197322] rtw89_8852be 0000:05:00.0: Firmware element PWR_TRK 
version: 00 32 00 00
    [    7.197330] rtw89_8852be 0000:05:00.0: Firmware element REGD 
version: 00 49 00 33
    [    7.197414] rtw89_8852be 0000:05:00.0: chip info CID: 0, CV: 1, 
AID: 0, ACV: 1, RFE: 1
    [    7.200038] rtw89_8852be 0000:05:00.0: rfkill hardware state 
changed to enable
    [    7.212982] rtw89_8852be 0000:05:00.0 wlp5s0: renamed from wlan0


    ➤ sudo dmesg | grep -iE 'bluetooth|firmware|mtk|btusb'
    [    0.272488] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
    [    1.267765] usb 1-5: Product: Bluetooth Radio
    [    4.109424] amdgpu 0000:c6:00.0: [drm] Loading DMUB firmware via 
PSP: version=0x08005B00
    [    4.109850] amdgpu 0000:c6:00.0: [VCN instance 0] Found VCN 
firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 34
    [    5.075990] SELinux:  Permission firmware_load in class system 
not defined in policy.
    [    6.030638] systemd[1]: systemd-boot-clear-sysfail.service - 
Clear SysFail Entry If The Boot Is Successful skipped, unmet condition 
check 
ConditionPathExists=/sys/firmware/efi/efivars/LoaderEntrySysFail-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f
    [    6.030683] systemd[1]: systemd-hibernate-clear.service - Clear 
Stale Hibernate Storage Info skipped, unmet condition check 
ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
    [    6.751552] kvm_amd: [Firmware Bug]: Cannot enable x2AVIC, AVIC 
is unsupported
    [    6.876631] rtw89_8852be 0000:05:00.0: loaded firmware 
rtw89/rtw8852b_fw-2.bin
    [    6.886529] rtw89_8852be 0000:05:00.0: Firmware version 
0.29.29.15 (6fb3ec41), cmd version 0, type 5
    [    6.886547] rtw89_8852be 0000:05:00.0: Firmware version 
0.29.29.15 (6fb3ec41), cmd version 0, type 3
    [    7.197141] rtw89_8852be 0000:05:00.0: Firmware element BB 
version: 00 28 00 00
    [    7.197185] rtw89_8852be 0000:05:00.0: Firmware element radio A 
version: 00 32 00 00
    [    7.197215] rtw89_8852be 0000:05:00.0: Firmware element NCTL 
version: 00 0a 00 00
    [    7.197312] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197314] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197315] rtw89_8852be 0000:05:00.0: Firmware element TXPWR 
version: 00 43 00 00
    [    7.197322] rtw89_8852be 0000:05:00.0: Firmware element PWR_TRK 
version: 00 32 00 00
    [    7.197330] rtw89_8852be 0000:05:00.0: Firmware element REGD 
version: 00 49 00 33
    [ 9114.511326] Bluetooth: Core ver 2.22
    [ 9114.511401] NET: Registered PF_BLUETOOTH protocol family
    [ 9114.511405] Bluetooth: HCI device and connection manager initialized
    [ 9114.511415] Bluetooth: HCI socket layer initialized
    [ 9114.511420] Bluetooth: L2CAP socket layer initialized
    [ 9114.511430] Bluetooth: SCO socket layer initialized
    [ 9649.478314] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
    [ 9649.478328] Bluetooth: BNEP filters: protocol multicast
    [ 9649.478340] Bluetooth: BNEP socket layer initialized
    [10359.251101] usbcore: registered new interface driver btusb
    [10359.255740] Bluetooth: hci0: RTL: examining hci_ver=0b 
hci_rev=000b lmp_ver=0b lmp_subver=8852
    [10359.258669] Bluetooth: hci0: RTL: rom_version status=0 version=3
    [10359.261690] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
    [10359.261700] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
    [10359.273061] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
    [10359.279751] Bluetooth: hci0: Opcode 0xfcf0 failed: -16
    [10359.282699] Bluetooth: hci0: AOSP extensions version v0.96
    [10359.282710] Bluetooth: hci0: AOSP quality report is not supported


    ➤ rfkill list
    0: ideapad_wlan: Wireless LAN
   	Soft blocked: no
   	Hard blocked: no
    1: ideapad_bluetooth: Bluetooth
   	Soft blocked: no
   	Hard blocked: no
    2: phy0: Wireless LAN
   	Soft blocked: no
   	Hard blocked: no
    3: hci0: Bluetooth
   	Soft blocked: no
   	Hard blocked: no


    ➤ bluetoothctl show
    No default controller available


    ➤ systemctl status bluetooth
...
    Available
...

    ➤ inxi -Fxz
    System:
    Kernel: 7.1.0-352.vanilla.fc44.x86_64 arch: x86_64 bits: 64 
compiler: gcc
    Machine:
    Type: Laptop System: LENOVO product: 21VR v: ThinkBook 14 G8+ AHP
    Mobo: LENOVO model: LNVNB161216
       v: TDCN24WW date: 04/14/2026
    CPU:
    Info: 8-core model: AMD Ryzen 7 H 255 w/ Radeon 780M Graphics bits: 64
    Network:
    Device-1: Realtek RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet
       vendor: Lenovo driver: r8169 v: kernel port: b000 bus-ID: 03:00.0
    IF: enp3s0 state: down mac: <filter>
    Device-2: Realtek RTL8852BE PCIe 802.11ax Wireless Network vendor: 
Lenovo
       driver: rtw89_8852be v: kernel port: a000 bus-ID: 05:00.0
    IF: wlp5s0 state: up mac: <filter>
    IF-ID-1: docker0 state: down mac: <filter>
    Bluetooth:
    Device-1: Realtek Bluetooth Radio driver: btusb v: 0.8 type: USB
       bus-ID: 1-5:3
    Report: hciconfig ID: hci0 rfk-id: 3 state: down
       bt-service: enabled,running rfk-block: hardware: no software: no
       address: <filter>

Troubleshooting attempts:
1. Performed full power drain - no effect
2. Updated linux-firmware from git.kernel.org - no rtl8852b853 firmware 
found
3. Tested on kernels 7.0.x and 7.1.0 - same error

Additional context: Windows 11 is pre-installed on this laptop, WiFi and
Bluetooth works correctly in Windows. Fast Startup is disabled, Secure
Boot is disabled.

Questions:
1. Is USB ID 0bda:b853 a known revision of RTL8852BE that requires specific
    firmware mapping in btrtl driver?
2. The driver loads the firmware, but the chip rejects command 0xfcf0.
    Does this revision require a different firmware file?
3. Is there a way to force the driver to use a different firmware file for
    this USB ID?
4. Should a new entry be added to the btrtl_device_id table in btrtl.c for
    USB_DEVICE(0x0bda, 0xb853)?

I'm willing to provide additional logs, test patches, or send the device 
for
debugging if needed.

Thank you for your work on the Bluetooth subsystem.

Best regards,
michail383krasnov@mail.ru
