Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34946355F53
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865547; cv=none; b=hmxc9zkHjcNEK+mAo6XWEgdaxN2Dw3wnm3yKPcz7MINMULGctonLGodFc1mY7x6YB0uffeqitx8n+ZvLHpy9GyYyeGcmtP5u9o9/4W/+kErenDxmCp4wVU8E30fhaKkbJNIxj+mqQAUl94B3ytpaXJ+Sfnqi7hB1TgE4knCr31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865547; c=relaxed/simple;
	bh=mICIUew/5ACOFd6hLDzQIeKN4014lI6DwPDQhvTLghs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVVSZ15EFfjv0y/XH+l0e4ZfjOXJSmb9ppU5kJvc2BYNBLSH/1MZrhHbaUDcNMm/c0v30pvp7dI76+uPk0sxIUGJOvQRhAIPDme6Mjk9ChruMZsCrM+XPfwzoeEibRZcNwqek+iwFy0Olcj1n47Nm/7qS1iuYoqFC5UjkqsW2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5MSgu0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5MSgu0e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EA1DC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785865546;
	bh=mICIUew/5ACOFd6hLDzQIeKN4014lI6DwPDQhvTLghs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q5MSgu0eeJzfoSB8Uuwzt5Mb4wxgyDCisO6G8esqtwD6J8NRPUPKGWPyGxC0VGp9x
	 pX9e+c9YEVJ+evcW3c73gwbrn9wf4ZkiBGBQYR5/AjzwKrTQPB5p6Y7p6HLUkPMK0X
	 YQmXx9cunjQKz6bjxohoQRvWdZZ/Ksp+ixe7bh9hcdMs/jnDKN7kxj56TjBJHTC1os
	 MLSgkUjvrK9OJEeSPIoD8X5R0YBysPASE0NbsKSHSlujBT8SfHuCarLzB8eLIf6LHC
	 QlbP0wVqOPDRJMJJ1KVkhZKtc3czU2ogQwpj9RO4Mj3kS6IaHn2qy8YJoFUrXocyta
	 6FlHe7OcPJZ6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C69EC3279F; Tue,  4 Aug 2026 17:45:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Tue, 04 Aug 2026 17:45:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lnxps@bbtex.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221832-62941-sTv44thfYA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221832-62941@https.bugzilla.kernel.org/>
References: <bug-221832-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221832

--- Comment #6 from IQ (lnxps@bbtex.net) ---
Firmware loaded:

[ 5246.175029] (NULL device *): Loading firmware from
/lib/firmware/mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[ 5246.175030] (NULL device *): Loading firmware from
/lib/firmware/mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
[ 5246.175031] (NULL device *): direct-loading
mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
[ 5246.175032] (NULL device *): direct-loading
mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[ 5246.175033] firmware_class: fw_set_page_data:
fw-mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin fw_priv=3D0000000041074eba
data=3D000000009415c47a size=3D1254904
[ 5246.175036] firmware_class: fw_set_page_data:
fw-mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin fw_priv=3D00000000e254=
796b
data=3D00000000380b1f69 size=3D198112
[ 5246.175165] (NULL device *): Loaded FW:
mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin, sha256:
089dd0252a7eb95feed55950ad0fd9e6f751a07b4cf22273de722b73fa50d49e
[ 5246.175168] firmware_class: cache_firmware:
mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin ret=3D0
[ 5246.175829] (NULL device *): Loaded FW:
mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin, sha256:
7e4ed27d1e9fe21cdefda35a22da32137b2473fada350617fb603489af19346a
[ 5246.175832] firmware_class: cache_firmware:
mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin ret=3D0
[ 5246.177579] (NULL device *): Loading firmware from
/lib/firmware/updates/qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn
[ 5246.177584] (NULL device *): direct-loading
qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn
[ 5246.177587] firmware_class: fw_set_page_data:
fw-qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn fw_priv=3D000000005dd0=
83df
data=3D000000005f4d150a size=3D3072424
[ 5246.179319] firmware_class: __free_fw_priv:
fw-qcom/x1e80100/ASUSTeK/vivobook-s15/qcadsp8380.mbn fw_priv=3D000000008801=
1a21
data=3D0000000000000000 size=3D0
[ 5246.179325] firmware_class: cache_firmware:
qcom/x1e80100/ASUSTeK/vivobook-s15/qcadsp8380.mbn ret=3D-2
[ 5246.179630] (NULL device *): Loaded FW:
qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn, sha256:
f98e3c974026f288994c12d218fafea7e77f03f6def183749a07d8a053a310fd
[ 5246.179633] firmware_class: cache_firmware:
qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn ret=3D0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
