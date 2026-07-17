Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D33F164D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286447; cv=none; b=GtgLrBj02dOpNufNKjmjh1OU/KTjjBqGUZVL2UObrLFVg3+hGzmgLwx4HXfRCllgNCIW6Tx1Ne4UqSiG5lAuhqt9nah08YL0EapluelQ970mwu57Qz6FIPaiVUeT79Iji7V6H59c3osTIcqal/fbqDQAzXAp45msy0EmluHjuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286447; c=relaxed/simple;
	bh=frWSr66pZzUX0Y0X1dHJWg/9I37Gg2fzYJKymq95AUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTE3XcXVKJVgNFud6b2sidOm0heWEpjA9IvXF7tMqIarSd+DEYngw2JsvlFb6n61F0xEW4/3dxNBveUL4ofNqQ6C2dN+MBH1omJpDe561sEjXl2pfAOz40t/SBrhKKWvFZZB7/nNd1ANGl4PedDgGU4G2BetGMJcS4d9XQb8w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTQDDYtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTQDDYtq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E166C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 11:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784286445;
	bh=frWSr66pZzUX0Y0X1dHJWg/9I37Gg2fzYJKymq95AUo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sTQDDYtq7t4C6gTGhk37j0fYDhndWTxnGOAOzmbrE8i/lHQjRROtXmQE1gbxdKLiA
	 8YzYVT+fcvuFHsVgoW1Cn+zYt9RuoVyf5QBP84ubOojgQdaSyt3T11RCOti3ggY5Vg
	 yFX/ThGhEX7naLpQU4CYcSe42/vCFfHL/Uwm1jSVhcRsuPYKcxq4+6/BMqxI0NCz3L
	 ML0doxIVxxYfVAg/jZYwqZDlfS04WCMLK7sTeMyE4Z6g5AInacqnqHCJ3NdkGGMTxe
	 b+gaZmLgGEB+8SaidwmGL5VtdQsXSCiltrTgzU1Mep6dx2EJr/fFpKruoIKBqns/qM
	 3b0G31Y961CXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ED48DC3279F; Fri, 17 Jul 2026 11:07:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Fri, 17 Jul 2026 11:07:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: dohojda.adam@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221754-62941-jg60bQUV9e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

Adam (dohojda.adam@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dohojda.adam@gmail.com

--- Comment #2 from Adam (dohojda.adam@gmail.com) ---
I have very same problem on Lenovo IdeaPad Slim 5 14AHP11

Disribution & kernel: Ubuntu 26.04 LTS, kernel 7.0.0-27-generic
lsusb: 0bda:b853 Realtek Semiconductor Corp. Bluetooth Radio

My filtered dmseg trace:
```
[    3.426562] systemd[1]: systemd-hibernate-clear.service - Clear Stale
Hibernate Storage Info skipped, unmet condition check
ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-=
4b0b-428f-9387-6d876050dc67
[    4.034621] amdxdna 0000:05:00.1: [drm] Load firmware
amdnpu/1502_00/npu_7.sbin
[    4.058678] kvm_amd: [Firmware Bug]: Cannot enable x2AVIC, AVIC is
unsupported
[    4.081452] rtw89_8852be 0000:02:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[    4.089206] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.15
(6fb3ec41), cmd version 0, type 5
[    4.089213] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.15
(6fb3ec41), cmd version 0, type 3
[    5.716983] amdgpu 0000:04:00.0: [drm] Loading DMUB firmware via PSP:
version=3D0x08005700
[    5.717220] amdgpu 0000:04:00.0: [VCN instance 0] Found VCN firmware Ver=
sion
ENC: 1.24 DEC: 9 VEP: 0 Revision: 16
[    5.750181] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b
lmp_ver=3D0b lmp_subver=3D8852
[    5.753172] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[    5.756172] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[    5.756176] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    5.757225] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    5.766164] Bluetooth: hci0: AOSP extensions version v0.96
[    5.766168] Bluetooth: hci0: AOSP quality report is not supported
[  131.458300] Bluetooth: hci0: RTL: examining hci_ver=3D0b hci_rev=3D000b
lmp_ver=3D0b lmp_subver=3D8852
[  131.461055] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D3
[  131.464314] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
[  131.464331] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[  131.465152] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[  131.470914] Bluetooth: hci0: Opcode 0xfcf0 failed: -16
[  131.475291] Bluetooth: hci0: AOSP extensions version v0.96
[  131.475307] Bluetooth: hci0: AOSP quality report is not supported

```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
