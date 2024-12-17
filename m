Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D01F4715
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444611; cv=none; b=tnTrNpD1x5ZnAfkhIgD760FTyXNglpfhAxtzJ60w+uoEIN9VFTR4A/ryor4omltjrNZ9LXcd7Ipr9/j6OqiNoP/6g3L/UZ8MBPzU9d+Y4XfrPCPno9h24UnfR6wGCVMmL3gyCpV5Wj3jyANdEJxAjyBygm5fmmmp6ij5FFg+3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444611; c=relaxed/simple;
	bh=WVYH8uBRMp8PgthVtmsJitHF08uaiBs6PGFP98GmEn4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/OBsJUyuRFUuDbw9vyRlI+3uBsRJnp99+WMRBvMH04ZNftnV1RaBCahUFGhw9yAWX/garU29X+3yca0c6bRxSjbwn3ZML18Hk1XWt8d91t1gfOtnpT9Obg1+b8Oe0bNaODih1txt5OHYJazEHiAGaLgafiXKR8RvbJWtq8s8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl8P+kGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl8P+kGG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A01F9C4CED3
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734444611;
	bh=WVYH8uBRMp8PgthVtmsJitHF08uaiBs6PGFP98GmEn4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sl8P+kGGUHR6d4xhMJ+XPgUsFDiOuyDb1ER4VRUGUiY/hNGc0qmR8S/UT0mR+tpGn
	 kq8JRor/ToIzaTEHvwqsr1opEJ5ZqN0mnm5tleum4pVhFK1M5+B2oFv/+GWEEje0hD
	 lt/q3cAm3lHpQUIRYNi30ji607iaiCtfF0xyDcFlWKh7dTNCoiXAf1I8WafzO5bMej
	 y/w768cE+bt02VecYdn/YZo/F9cQ4OfcdjS9IDda0sbCJIoeiNLHJpXwdP3Kkn4laX
	 mg2qrq+rX5GpAS03DFDc0q8iiLLBIGe17XoR/MUjV/9z+sr3T0Dcumd/Vd/NH522yC
	 jO5wZZ/N2qYjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 99B8BC3279E; Tue, 17 Dec 2024 14:10:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 193671] btattach -B /dev/ttyS1 -P qca -> Frame reassembly
 failed (-84)
Date: Tue, 17 Dec 2024 14:10:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nrndda@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-193671-62941-9uoCaKpfO7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-193671-62941@https.bugzilla.kernel.org/>
References: <bug-193671-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D193671

Dmitry (nrndda@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
