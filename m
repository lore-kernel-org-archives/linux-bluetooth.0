Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0383546F3
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923559; cv=none; b=a26vl9RF18nj2czrYNm3uIAGeq6VIN9biWhdXG/DssIRKOh6gaVIdhKsGroot4GQjBo550mqsyZ+LC35qcFnDpsTRYLM6MGL5J8ur/JWuMTTIbX880a+49CW5gPmUn5BstfTzYk75DaW48nSqbxa0dp6G08IT+LdJ6ppsW8amzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923559; c=relaxed/simple;
	bh=BwYihwVlb9EHo8nTwJjz/dQlXyLpmqkuQBM0Usvxg3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RWl0LPaHjaMPqjNwrIEXf3PPzR9HBgps5wyOs8f6yIoRwfxX+D3PyhtqFnMyKfqy4I/6W/nivF+Byn4QS3wVrrpvD639PJLW/JDHJzRA4wTmThEIGto5SAWJ6XnzLdOm2gXUQrq+Dd6XhmTgLkG5+OVKKf8EdPKU4hSV9kbVejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F7094C442FCD7;
	Wed, 01 Jul 2026 18:32:02 +0200 (CEST)
Message-ID: <90dc98dd-dcee-49ac-8050-abfe6b93775b@molgen.mpg.de>
Date: Wed, 1 Jul 2026 18:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 220564] hci0: ACL packet for unknown connection handle 3837
 and sound interruption
To: Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
 Mark Chen <mark-yw.chen@mediatek.com>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
 <bug-220564-62941-11iNnkhOy2@https.bugzilla.kernel.org/>
Content-Language: en-US
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <bug-220564-62941-11iNnkhOy2@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sean, dear Chris, dear Mark,


Unfortunately, you do not have an account in the Linux Kernel Bugzilla, 
so I am replying to this notification.

Am 01.07.26 um 17:09 schrieb bugzilla-daemon@kernel.org:
> https://bugzilla.kernel.org/show_bug.cgi?id=220564
> 
> --- Comment #13 from Rob Hogan (robhogan@gmail.com) ---
> I'm pretty sure it's the same issue. Extract from syslog below:
> 
> Jul  1 16:01:49 mwenge kernel: [439779.598878] Bluetooth: hci0: ACL packet for unknown connection handle 3837
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:dev_disconnected() Device F0:EF:86:C3:50:D8 disconnected, reason 1
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:adapter_remove_connection()
> Jul  1 16:02:08 mwenge bluetoothd[760091]: plugins/policy.c:disconnect_cb() reason 1
> Jul  1 16:02:08 mwenge bluetoothd[760091]: plugins/policy.c:disconnect_cb() Device /org/bluez/hci0/dev_F0_EF_86_C3_50_D8 identified for auto-reconnection
> Jul  1 16:02:08 mwenge bluetoothd[760091]: plugins/policy.c:reconnect_set_timer() attempt 1/7 1 seconds
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr F0:EF:86:C3:50:D8 type 0 status 0xe
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/device.c:device_bonding_failed() status 14
> Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:resume_discovery()
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:session_cb()
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:avdtp_ref() 0x5c5568690930: ref=3
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:connection_lost() Disconnected from F0:EF:86:C3:50:D8
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/a2dp.c:abort_cfm() Source 0x5c5568671120: Abort_Cfm
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> IDLE
> Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/transport.c:media_transport_remove_owner() Transport /org/bluez/hci0/dev_F0_EF_86_C3_50_D8/sep1/fd3 Owner :1.79
> 
> 
> And here is the relevant handle entry in btmon:
> 
>> ACL Data RX: Handle 3837 flags 0x02 dlen 143         #33540 [hci0] 390.036978
>        Channel: 515 len 139 [PSM 0 mode Basic (0x00)] {chan 65535}
>          33 00 cb db 90 00 01 00 58 17 02 00 00 00 00 00  3.......X.......
>          00 0e 81 00 00 00 00 00 00 01 00 00 00 00 00 00  ................
>          00 2a 25 00 00 03 14 01 00 42 27 00 00 00 00 00  .*%......B'.....
>          00 00 00 00 00 00 00 00 00 ca db 90 00 4a da 90  .............J..
>          00 07 c4 50 00 00 00 20 00 00 40 f8 05 e1 7f 00  ...P... ..@.....
>          00 3f 00 09 00 0d 00 00 00 3d 00 09 00 b6 00 00  .?.......=......
>          00 02 00 20 00 05 00 00 00 01 00 09 00 00 00 09  ... ............
>          00 0d 00 00 00 3b 00 09 00 1a 00 00 00 30 00 09  .....;.......0..
>          00 0f 00 00 00 3b 00 09 00 0d 00                 .....;.....
> 
> The full btmon log is too large to attach I think. Let me know if there's
> something else I should be turning on to help debug.
Claude Opus 4.8 analyzed:

The decisive detail: the handle is byte-for-byte 3837 across three 
unrelated reporters — different laptop, different speaker 
(F0:EF:86:C3:50:D8 here vs. the Lenovo in comment #1), different kernel. 
Random corruption wouldn't land on the same handle every time. A fixed 
value is a firmware sentinel. This is the ACL twin of the ISO 
misbehaviour Pauli Virtanen already documented ("MT7925 continuously 
sends invalid ISO packets")—related [1][2]—, and it's the same shape as 
the handles the MediaTek driver already intercepts:

     // drivers/bluetooth/btmtk.c  btmtk_usb_recv_acl()
     case 0xfc6f: /* Firmware dump from device */ ...
     case 0x05ff: /* Firmware debug logging 1 */
     case 0x05fe: /* Firmware debug logging 2 */
         return hci_recv_diag(hdev, skb);   // routed to diag, NOT into 
L2CAP

0x2EFD isn't in that list, so it falls through to hci_recv_frame() → 
hci_acldata_packet() → no matching connection → the error. So the 
disconnect in Rob's syslog is likely a coincident A2DP timeout, not 
caused by the log line — the spurious packet just shares the timeline.

Should the kernel ignore handle 3837?

Two different places, two different answers:

- In generic hci_core.c — no. HCI_CONN_HANDLE_MAX = 0x0eff, and 3837 = 
0x0EFD is inside the spec-valid range (just below the max). A 
non-MediaTek controller could legitimately assign it. Dropping it 
generically would silently break other hardware. So my rate-limit patch 
is the right vendor-neutral change: it stops the flood without dropping 
anyone's data.

- In btmtk_usb_recv_acl() — probably yes, and that's the real fix, 
routing these to hci_recv_diag() exactly like 0x05fe/0x05ff. That both 
kills the spam and stops feeding garbage into L2CAP.

But I won't add that magic number on inference alone, and here's the 
honest gap:

1. I have no MediaTek doc confirming 0x2EFD/0x0EFD is a firmware-log 
handle. The existing constants came from the vendor.
2. The existing cases match the raw 16-bit value with a non-flag high 
nibble (0x05ff, 0xfc6f). Ours has high nibble 0x2, which looks like a 
real PB=start flag — so matching semantics (raw 0x2EFD? masked 0x0EFD? 
do fragments arrive as 0x1EFD?) aren't obvious, and a wrong mask could 
drop real ACL fragments.

To close that gap before touching the driver, the bug needs the full 
btmon (Rob offered it), to confirm:

- no HCI Connection Complete / LE Enhanced Connection Complete ever 
assigns handle 0x0EFD, and
- the 0x?EFD packets always carry this same non-L2CAP payload and never 
a real ACL fragment.

@Mediatek, can you please confirm, that this handle should be ignored.


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6dc22ab9f085ae165e4ce89d61fb426f94e8a969
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=edef6576853e51faa11bb286884c362ff7fc83a0
