Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA91D435F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071224; cv=none; b=R6lqHBz9GmMSocJucJawoL8o6fNkf9k3/UWk4MVrPVeuU45CU5VelFMghefJpyycPn9GDb7XxfXtVUSX+7FhOGQjuwUZIEheQ15anlxZFBbn0GsINbUY3Mw8EMlaCeMrfM8pbwWxWFiiOi5b29BPLa2QFHf1MOtBnKbtQw3zUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071224; c=relaxed/simple;
	bh=6yxzoU1pGnDFzaCQRa1/UMYuwWNQOoGwV1xY9YEBBx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hB8xqMIz98kIYO6jR+0KvsxeB+R7LDW7sLwOBqii93ZWXltApNhxtu1GskhPqQVshieMynelApDWg9LCooyjTN2R5Ta3GlrHYxND1fKH/j3gczCxxcozir56mn2sUPoJMxteHsQFQC6ZzHADgIag9Cvr8K5xfcopgC9Jv1LZ188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0s8zFZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0s8zFZx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 852CFC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786071223;
	bh=6yxzoU1pGnDFzaCQRa1/UMYuwWNQOoGwV1xY9YEBBx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O0s8zFZxQ6HACOZGVVbgXHrdY9jZSNK+622PZduNSpZ06sDwKmpdNxGAPPRnx5ETS
	 0D4+e6eeDDwW1d1fU39X/H+vI2p4rTVB5JBIfsJDKFc6bKkF4x5NWZb4PVcjuG82/H
	 SXenSasMZfnPbBZfEy3ORq9R3z8At1umu8f8VmjO7sxvhmfwfhstkq6t38+76BRJF3
	 RgWLxe7CYMHBRrBnvD5y+kGv1HG7N5sDtDMM2j3OHosO7ovYdQ08ErFreGZFHeF/bM
	 aPOa5Gzk2IDXdPfvzRDLB1dIpceBq4b9YdUL++dEvREJDJSEYXr6prIVKZzvgG6sZN
	 e+59JddrLQrXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 72EDCC41613; Fri,  7 Aug 2026 02:53:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221832] MT7925 (Foxcon T99H493.03) BT missing in lsusb on
 Vivobook S16
Date: Fri, 07 Aug 2026 02:53:43 +0000
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
Message-ID: <bug-221832-62941-rvOCIHmhPZ@https.bugzilla.kernel.org/>
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

--- Comment #9 from IQ (lnxps@bbtex.net) ---
.
[  121.044682] qcom-iris aa00000.video-codec: loading
/lib/firmware/qcom/x1p42100/ASUSTeK/vivobook-s15/qcvss8380.mbn.xz failed fo=
r no
such file or directory.
[  121.044728] qcom-iris aa00000.video-codec: Direct firmware load for
qcom/x1p42100/ASUSTeK/vivobook-s15/qcvss8380.mbn failed with error -2
[  121.044755] firmware_class: __free_fw_priv:
fw-qcom/x1p42100/ASUSTeK/vivobook-s15/qcvss8380.mbn fw_priv=3D000000001e317=
614
data=3D0000000000000000 size=3D0
[  121.044874] qcom-iris aa00000.video-codec: firmware download failed
[  121.117515] qcom-iris aa00000.video-codec: core init failed
[  122.269583] rfkill: input handler disabled
[  122.617337] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  122.996022] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  124.797661] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  124.896240] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  124.966805] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  125.315919] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  125.365047] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22
[  125.442740] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [ms=
m]]
*ERROR* Couldn't power up the GPU: -22

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
