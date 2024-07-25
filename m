Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB3172BAF;
	Thu, 25 Jul 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897473; cv=none; b=qAxpe9GtEdyekIc5z6nMDxRqomTAVpMKunYWBAc0uDUHnh05onRg6/b5dFxtyZlR8a+ArPNndTom9MsHAKOPGQ5sHRM49UTYTEmWAmuR6XmC8MVm0pd4NVRCw+2905NNH/kwDm1F89UHCjvKsyswu6qnlqwA/ascO2gkJamOSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897473; c=relaxed/simple;
	bh=dHODdX/8kdpsxIa/rTtzdc5tTqYEofnfE/ezMJ1823I=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=d3m1Ki6TN3YH42jQ6Dd5vPab8LKZzX/quAunw/j62sRcEjI1WZie181GH8dVfL3m67JJadVgdqsTBXWLfPu5UURTms0dNjx4zYwonc7HimcocXUF8VSTG/O5g1hColEN2KMjq+UIE5VoaiHsp/dMxCdQ4Y1JXSlE3TU8lJ1nBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=tht9vLj+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="tht9vLj+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tW4sVbmZ6IkoO9JFHpG0v9V4u4ngChK5k3H+tBu6Tis=; t=1721897470; x=1722329470;
	 b=tht9vLj+JV/Q0cPQyR/8gSnTKHw2KsGupBV16agfkQPl1ksEsWXoA9mL5eL+m5vLf32Dc5EdVF
	ouaywJldYeXhJgpDO19SO0qE/6I0ZpVWDLj3QLqIASMDBq/F6Kn3omsTPpJg4OyupYQF/hc49u0hf
	iuEP4O5TymWDbDMPCUttU2uFJ0ScNKjyVEa22zyYF1dreb74S1ne+C4QjFc/QHA5ZD6jq8M3xmhLc
	jAhgvl6BIYhN7draDJ03JGk4ie4AHcXyZ7ReIVoh9M9tX7R7wjI9ZNDcRWSwsceGtNrQzVAAGOq0p
	GY9dV8enfPgiuaf1saXjHxkkJn+m0FV24JhcQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWuBn-00088i-HD; Thu, 25 Jul 2024 10:51:07 +0200
Message-ID: <564711dc-488c-4898-93fc-bcf42e3a8ccd@leemhuis.info>
Date: Thu, 25 Jul 2024 10:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Eugene Shalygin <eugene.shalygin@gmail.com>
Subject: [regression] bluetooth scanning on AX210 stopped working
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721897470;377314e6;
X-HE-SMSGID: 1sWuBn-00088i-HD

Hi, Thorsten here, the Linux kernel's regression tracker.

Luiz, I noticed a report about a regression in bugzilla.kernel.org that
appears to be caused by a change of yours:

2e2515c1ba384a ("Bluetooth: hci_event: Set DISCOVERY_FINDING on
SCAN_ENABLED") [v6.10-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from █ :

>  Eugene Shalygin 2024-07-23 19:39:38 UTC
> 
> With kernel 6.10.0 bluetooth scanning finds no devices (Intel AX210). 6.9.9 works.

>  Eugene Shalygin 2024-07-24 06:56:42 UTC
> 
> $ dmesg | grep -e 'iwlwifi\|Bluetooth'                                                                                                                                                                                          
> [    2.633116] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
> [    2.643454] Bluetooth: Core ver 2.22
> [    2.646521] Bluetooth: HCI device and connection manager initialized
> [    2.647920] Bluetooth: HCI socket layer initialized
> [    2.648885] Bluetooth: L2CAP socket layer initialized
> [    2.649972] Bluetooth: SCO socket layer initialized
> [    2.658734] iwlwifi 0000:03:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
> [    2.660717] iwlwifi 0000:03:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
> [    2.662120] Loading firmware: iwlwifi-ty-a0-gf-a0-89.ucode
> [    2.667789] iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.42
> [    2.668164] iwlwifi 0000:03:00.0: loaded firmware version 89.202a2f7b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm
> [    2.693021] Bluetooth: hci0: Device revision is 0
> [    2.694469] Bluetooth: hci0: Secure boot is enabled
> [    2.698894] Bluetooth: hci0: OTP lock is enabled
> [    2.700339] Bluetooth: hci0: API lock is enabled
> [    2.701262] Bluetooth: hci0: Debug lock is disabled
> [    2.702069] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [    2.702719] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
> [    2.703431] Bluetooth: hci0: No support for _PRR ACPI method
> [    2.708740] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
> [    2.711227] Bluetooth: hci0: Boot Address: 0x100800
> [    2.711230] Bluetooth: hci0: Firmware Version: 120-18.24
> [    2.773104] iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
> [    2.783598] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
> [    2.943521] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
> [    2.943552] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
> [    2.943578] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
> [    2.943602] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [    2.943608] Loading firmware: iwlwifi-ty-a0-gf-a0.pnvm
> [    2.944080] iwlwifi 0000:03:00.0: loaded PNVM version 35148b80
> [    2.959773] iwlwifi 0000:03:00.0: Detected RF GF, rfid=0x10d000
> [    3.029643] iwlwifi 0000:03:00.0: base HW address: 2c:33:58:e9:d5:1d
> [    3.822131] Bluetooth: hci0: Waiting for firmware download to complete
> [    3.822963] Bluetooth: hci0: Firmware loaded in 1085762 usecs
> [    3.822999] Bluetooth: hci0: Waiting for device to boot
> [    3.848969] Bluetooth: hci0: Device booted in 25377 usecs
> [    3.848982] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [    3.858349] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-0041.ddc
> [    3.864001] Bluetooth: hci0: Applying Intel DDC parameters completed
> [    3.872025] Bluetooth: hci0: Firmware timestamp 2024.18 buildtype 1 build 81528
> [    3.872028] Bluetooth: hci0: Firmware SHA1: 0xa8bb3f39
> [    3.882989] Bluetooth: hci0: Fseq status: Success (0x00)
> [    3.883003] Bluetooth: hci0: Fseq executed: 00.00.02.41
> [    3.883014] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
> [    6.943128] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.943131] Bluetooth: BNEP filters: protocol multicast
> [    6.943133] Bluetooth: BNEP socket layer initialized
> [    6.943661] Bluetooth: MGMT ver 1.22
> [    6.946103] Bluetooth: ISO socket layer initialized
> [    7.068883] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
> [    7.224190] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
> [    7.225614] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
> [    7.226232] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
> [    7.226803] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [    7.384675] iwlwifi 0000:03:00.0: WRT: Invalid buffer destination
> [    7.539920] iwlwifi 0000:03:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
> [    7.541272] iwlwifi 0000:03:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
> [    7.541861] iwlwifi 0000:03:00.0: WFPM_AUTH_KEY_0: 0x90
> [    7.542422] iwlwifi 0000:03:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [   16.078066] Bluetooth: RFCOMM TTY layer initialized
> [   16.078073] Bluetooth: RFCOMM socket layer initialized
> [   16.078077] Bluetooth: RFCOMM ver 1.11

>  Eugene Shalygin 2024-07-25 00:13:34 UTC
> 
> [bisection] converges to 2e2515c1ba384ae44f6bf13dd64b9a0a950798c4

See the ticket for more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 2e2515c1ba384ae44f6bf13dd64b9a0a950798c4
#regzbot title: Bluetooth: hci_event: bluetooth scanning on AX210
stopped working
#regzbot from: Eugene Shalygin <eugene.shalygin@gmail.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219088
#regzbot ignore-activity
