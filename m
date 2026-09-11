Received: from 6.mo582.mail-out.ovh.net (6.mo582.mail-out.ovh.net [87.98.177.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74B49B5B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.177.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143431; cv=none; b=NMYHnPfCpZMe5bXVunk+vrP/pT2YBmRad6I0K0dSYWlNAYs0EOihT+YWGIeimfMSRFV0n9pb28FeWpKUtSUg/DzjP2MdjmkQ/3wNtHwZf3fL7zoUWXT4egEN3qA5ktOV+ZWFrcTniBo82CIexCZf9D4PdXEa2sT/7Os5JyTfwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143431; c=relaxed/simple;
	bh=cUPop6knQ5y9lPrarOfRSsV1X3oIoueZ2ncpuMLHtqg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jQwIKsoHcX1BqBlUgnuCmfMFgVkT6Y1UqMP1qNjyenyjnN5SDVhN71n624A4q1QO2917ffSuJAMqGFTRw1NraoxQW2UXQIQ2DMycXgsc55pWONGDsXATk+nft7nK6EFf6uOj6xbo4JKqpZqUaJ0G2Ol8GQbc575ZMdG+Q09DG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flutilliant.com; spf=pass smtp.mailfrom=flutilliant.com; dkim=pass (2048-bit key) header.d=flutilliant.com header.i=@flutilliant.com header.b=Vq4dEE+4; arc=none smtp.client-ip=87.98.177.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flutilliant.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flutilliant.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flutilliant.com header.i=@flutilliant.com header.b="Vq4dEE+4"
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.43.105])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4hhC4H0GMHz61G1
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 11:29:19 +0000 (UTC)
Received: from ghost-submission-c7b579475-qbmcj (unknown [10.111.174.124])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 10275100178;
	Fri, 11 Sep 2026 11:29:17 +0000 (UTC)
Received: from flutilliant.com ([37.59.142.101])
	by ghost-submission-c7b579475-qbmcj with ESMTPSA
	id vNZxMA3mo2qbWTAA6Sud/g
	(envelope-from <tristan.laroye@flutilliant.com>); Fri, 11 Sep 2026 11:29:17 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004f4585044-ea68-4e6e-b383-77af03fac49d,
                    208AB26B4DE4F8E8E6E63ED20A83750ACC6C0889) smtp.auth=tristan.laroye@flutilliant.com
X-OVh-ClientIp:86.195.138.201
Message-ID: <f166df21-09fe-4c16-bcce-07fbd9b31122@flutilliant.com>
Date: Fri, 11 Sep 2026 13:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: Max Chou <max.chou@realtek.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-firmware@kernel.org
From: Tristan Laroye <tristan.laroye@flutilliant.com>
Subject: RTL8852BU (0bda:b853) rom_version 3: btrtl -ENODATA, no ECO 4
 firmware
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16577468756354650798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGWk2aI/DTJRQa9+iEbZvzpWrHvVh9fLnwJWQrRHhQxtWYg32vSw7v1dUvUpMnQtcjyStpb9P7PZpDEUJMMCw07sr6Ot29/2nZgDRyc+5rXMYPUqxGHqU7S0+cqJl51bvm9H/K4nNXc+fOSEpWSwjXvvlFEn74CZYAUBL7dP+N0lXBgyuJ62DoEacBaOn/QyLfKtBQ7CZR0KskFLReplA+au7YxZt064j/trhrmEfd44Mu7jTdZEmjAPpT67y2dIR57ZPj9YwdtSCCJIx1tRVinmN10CPnOyzFlApOc9xQl/WPUWzwDIaHcOLAeNBkkG++b0pjrKQ9+BcJfbYEWLuRLO2zuAwfdvEWyY9jUN0qmIT/Trmdp91st+VyeFMJy+ltcpt+77bfxa4+1A/CN7oJwZuoUF11VmmxvPW68DQSfy7evZLLizs0sSWJeFYxKe5yeOHIO5tq99QMPg8kfm6mDcCcQ+KacjZZrITSyrcb6Mvg9Jg94k9KzRXw9ZvF266rSriVYdCERe/9t98ZAOMo3nSU+GQj2WHAAEUa1EsQQ5aXu3Ec3r8VR4cwzVGQN8kPaW25kp8iwrUURWKGxz1xmliRJUTsbPlWWcp/EOgmscZdOQAQGTvujceXVIyx8i6nbjQUPJ9P/XAC80FkndZKqx8INel0krfQQCB56BcQmlQ
DKIM-Signature: a=rsa-sha256; bh=cUPop6knQ5y9lPrarOfRSsV1X3oIoueZ2ncpuMLHtqg=;
 c=relaxed/relaxed; d=flutilliant.com; h=From; s=ovhmo3576131-selector1;
 t=1789126159; v=1;
 b=Vq4dEE+4kAO9QhHS7gtMka8G6gO04OzMAWaEPWay6cJgf2stfQLA2tVFL7x6wuXCrIZ9Lrc2
 Q9FOJH0gdftHBYWKgK4hpTIOFKDF8H3dM0Hr0ipx8rQNWCizNE3SzeLmkrXNTRWjQcyvrBGPBIg
 Pcky82rCPRAQFkZgv+2QwY6V2Yh9i3FxegPOBN4UpG8myCicucRzOr8iYK2Bl26+6nNvcNLi0L7
 gfFS55IbudUAZ+pr1l+hculBG/WNqZddeyG22v7ZwXpo6TIck1RcgxRKMqeZPkjfizL9CSdC6zT
 oQGHJzXRHpAOycwJrQVC4EvhgMzp+gTyM9KB5d26uV+sA==

Hi,

The built-in Realtek Bluetooth controller on a Lenovo IdeaPad Pro 5
14IPH11 never registers with the management interface. The controller
answers every HCI command it is sent, but HCI setup is aborted before
any firmware is downloaded.

The cause is a firmware coverage gap, not a driver bug and not a
missing file: the controller reports rom_version 3, so btrtl looks for
a patch subsection tagged eco == 4, and no published rtl8852bu_fw.bin
contains one.

I could not find this reported anywhere, so details are below. I am
happy to test patches or firmware images.


System
------

   Machine        LENOVO 83SH, IdeaPad Pro 5 14IPH11
   Board          LNVNB161216
   BIOS           STCN32WW, 2026-07-07
   OS             Ubuntu 26.04.1 LTS
   Kernel         7.0.0-31-generic
   BlueZ          5.85
   linux-firmware 20260319.git217ca6e4

   Bus 003 Device 003: ID 0bda:b853 Realtek Semiconductor Corp.
                       Bluetooth Radio
   idVendor=0bda idProduct=b853 bcdDevice=0.00
   Manufacturer: Realtek
   Product: Bluetooth Radio
   SerialNumber: 00e04c000001

0bda:b853 is not in the btusb.c device table; it binds through the
generic Realtek vendor/interface match. That part works as intended.

The Wi-Fi half of the combo module (rtw89_8852be, PCIe) works
normally.


Symptoms
--------

   $ bluetoothctl show
   No default controller available

   $ sudo btmgmt info
   Index list with 0 items

   $ sudo hciconfig hci0 up
   Can't init device hci0: No data available (61)

   $ sudo hciconfig -a
   hci0:   Type: Primary  Bus: USB
           BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
           DOWN
           RX bytes:88 acl:0 sco:0 events:7 errors:0
           TX bytes:34 acl:0 sco:0 commands:7 errors:0
           Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

/sys/class/bluetooth/hci0 exists and its rfkill entry is unblocked, so
the HCI device is registered, but it never leaves setup state.

dmesg at boot, with no error reported:

   Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b \
              lmp_subver=8852
   Bluetooth: hci0: RTL: rom_version status=0 version=3
   Bluetooth: hci0: RTL: btrtl_initialize: key id 0
   Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
   Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
   Bluetooth: hci0: AOSP extensions version v0.96
   Bluetooth: hci0: AOSP quality report is not supported

The "loading" lines only report that the files were read from disk. No
download is attempted, as the trace below shows.


Analysis
--------

btrtl.c has exactly one -ENODATA return, in rtlbt_parse_firmware_v2():

     if (!len)
             return -ENODATA;

len accumulates the size of subsections accepted by
btrtl_parse_section(), whose selection rule is:

     if (common_subsec->eco != btrtl_dev->rom_version + 1)
             continue;

So rom_version 3 requires an eco == 4 subsection. rom_version 3 is
confirmed twice: by the dmesg line above, and by the raw reply to
vendor command 0x3f|0x006d (0xfc6d), which returns the data byte 03.

The correct firmware file is being selected. The controller reports
lmp_subver 0x8852, hci_rev 0x000b, hci_ver 0x0b on USB, matching
exactly one ic_id_table entry:

     /* 8852B */
     { IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_USB),
       ...
       .fw_name  = "rtl_bt/rtl8852bu_fw",
       .hw_info  = "rtl8852bu" },

(The 8852BT/8852BE-VT entry is keyed on hci_rev 0x87 and does not
apply.)

I parsed the firmware images directly, following the on-disk layout
used by the driver (rtl_epatch_header_v2, rtl_section, rtl_section_hdr,
rtl_common_subsec). Installed image, 127301 bytes decompressed:

   signature : RTBTCore
   fw_version: f1013501c4330200
   section 0: SNIPPETS, 2 subsections
       subsec 0: eco=0x01 (1)  prio=15  len=67133
       subsec 1: eco=0x02 (2)  prio=15  len=60101
   section 1: opcode 0x8 (ignored by the driver)

linux-firmware git master, 129733 bytes, a newer image
(fw_version d6253501f8c30200) with the same ECO coverage:

   section 0: SNIPPETS, 2 subsections
       subsec 0: eco=0x01 (1)  prio=15  len=67133
       subsec 1: eco=0x02 (2)  prio=15  len=62533

Neither has eco 4, so nothing is collected and the parser returns
-ENODATA.

Every other Realtek Bluetooth image in the same package was checked and
none exceeds eco 2:

   rtl8852bu_fw.bin  (Ubuntu 20260319)        1, 2
   rtl8852bu_fw.bin  (linux-firmware master)  1, 2
   rtl8852btu_fw.bin                          1
   rtl8851bu_fw.bin                           1
   rtl8852cu_fw_v2.bin                        1, 2
   rtl8922au_fw.bin                           2

Published firmware therefore covers rom_version 0 and 1 only.

The analysis was done against current master, i.e. it already includes
commit 83e3e515fd26 ("Bluetooth: btrtl: Don't leak return code when
parsing firmware format v2"). That fix does not affect this case: the
sections here are SNIPPETS, not security headers, and len stays 0
either way.


HCI trace
---------

btmon during a "hciconfig hci0 up" attempt. The whole exchange is seven
commands, then Close Index:

   = New Index: 00:00:00:00:00:00 (Primary,USB,hci0)         [hci0]
   = Open Index: 00:00:00:00:00:00                           [hci0]
   = Index Info: 00:.. (Realtek Semiconductor Corporation)   [hci0]
   < HCI Command: Vendor (0x3f|0x0061) plen 5             #1 [hci0]
   > HCI Event: Command Complete (0x0e) plen 6            #2 [hci0]
         Status: Success (0x00)
   < HCI Command: Read Local Ver.. (0x04|0x0001) plen 0   #3 [hci0]
   > HCI Event: Command Complete (0x0e) plen 12           #4 [hci0]
         Status: Success (0x00)
         HCI version: Bluetooth 5.2 (0x0b) - Revision 11 (0x000b)
         LMP version: Bluetooth 5.2 (0x0b) - Subversion 34898 (0x8852)
         Manufacturer: Realtek Semiconductor Corporation (93)
   < HCI Command: Vendor (0x3f|0x006d) plen 0             #5 [hci0]
   > HCI Event: Command Complete (0x0e) plen 5            #6 [hci0]
         Status: Success (0x00)
           03                                <-- rom_version = 3
   < HCI Command: Vendor (0x3f|0x0061) plen 5             #7 [hci0]
   > HCI Event: Command Complete (0x0e) plen 6            #8 [hci0]
         Status: Success (0x00)
   < HCI Command: Microsoft Exte.. (0x3f|0x00f0) plen 1   #9 [hci0]
         Read Supported Features (0x00)
   > HCI Event: Command Complete (0x0e) plen 22          #10 [hci0]
         Status: Success (0x00)
         Features[0/0][8]: 3f00000000000000
   < HCI Command: Microsoft Ext.. (0x3f|0x00f0) plen 2   #11 [hci0]
         LE Set Advertisement Filter Enable (0x05)
   > HCI Event: Command Complete (0x0e) plen 5          #12 [hci0]
         Status: Command Disallowed (0x0c)
   < HCI Command: Vendor (0x3f|0x0153) plen 0           #13 [hci0]
   > HCI Event: Command Complete (0x0e) plen 18         #14 [hci0]
         Status: Success (0x00)
   = Close Index: 00:00:00:00:00:00                          [hci0]

Two things to note. There are no firmware download commands at all,
consistent with the parser failing first. And no standard HCI
initialisation ever runs: no HCI Reset, no Read BD_ADDR, no feature
read. That accounts for the null BD address, the zero feature mask and
the empty index list. The commands:7 counter in hciconfig matches.

The Command Disallowed (0x0c) on the MSFT LE Set Advertisement Filter
Enable, which surfaces in dmesg as "Opcode 0xfcf0 failed: -16", is not
the cause. It only appears once the controller has been through a
previous open attempt; after a cold power cycle it does not occur, and
the controller still fails to register.


Ruled out
---------

   - rfkill: all entries soft- and hard-unblocked, hci0 included.
   - bluetoothd: active, management interface 1.23 initialized, no
     errors.
   - Missing or corrupt firmware files: both rtl8852bu_fw.bin and
     rtl8852bu_config.bin are present. The rtl8852bu_config.bin ->
     rtl8761bu_config.bin symlink is normal packaging, shared with
     8852au, 8852cu, 8851bu and 8922au.
   - Stuck controller state: rmmod/modprobe btusb, USB deauthorize and
     reauthorize, and a full cold power-off with AC disconnected and the
     power button held 20 s all give identical results.
   - Forcing an address: btmgmt public-addr returns Invalid Index, as
     expected, since there is no index to act on.
   - Driver version: master behaves the same; the missing artefact is
     the firmware payload.


Request
-------

An rtl8852bu_fw.bin containing an eco == 4 patch section, so that
controllers reporting rom_version 3 can complete setup. The adapter
works under Windows on this machine, so the corresponding ECO 4 payload
presumably exists in the Realtek driver package Lenovo ships.

If the right fix is instead a driver-side change, for example a new
ic_id_table entry pointing this revision at a different image, the
trace above should carry enough identification data to decide.

Happy to provide any further traces or run debug patches.

Thanks,

Tristan Laroye

