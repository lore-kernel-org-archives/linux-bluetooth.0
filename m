Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0111411DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365146; cv=none; b=DRgJQFZFdLy8Sz/lK8rQMwCe6o+GKFzveFOePBvDIkrggezS7qak3awZlbzPaui/fXWXdJXylPcl4gbJF4WqN9t2udpIeRs7Mf/Mx+Ytl3kI0caoWkBeH+MhYC0GMFeM+ww6gjYVIRm+QDFNuA27S1tVd8Wmr8VLBPTQMMflUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365146; c=relaxed/simple;
	bh=Edf0vKYxPCmuGg+U4Jw21gn4X7EhySHi1jSHXGkSpRk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IG+08eAe3HwlEaeEh9bETX7ipt54jPh5gRR2CTEi8GkBF3eAixCX/YoxW820iCVI3XUBTDNtxPy3L5GQNovso6AcKohvrUByfmjaURJEms1fY4ELEeHNJUi2oox3rVkbqgKABuRMSX+AhfoWTRd18W3pX2ZiOgAvZMy3IFzXmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQf+K4og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQf+K4og"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB9BFC2BD11
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365145;
	bh=Edf0vKYxPCmuGg+U4Jw21gn4X7EhySHi1jSHXGkSpRk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PQf+K4ogAr9L3/f8NzxkIdsQgoSK0SX3rZIe7DSlrxPrNOuO6Kj9U7EQeMwMY7hdl
	 Iwxx6MbMD5B49OtbFO9zI5AYzERx4kONiCfgOnu/6v4mkNiOIVDWXXjuT45ryynFvq
	 1g+Nsu+gjnnwwkVGZZrC4YYIJd7Xt+jjiN33si4P0KlbvMmRPjtqatnwBzF918Qvya
	 9TYN0Qw8KlwWB8suVC64hO5L5QrFvYf4IR1sInjKvtHSHbkHcWC5J0BQSJPF2XbxkT
	 BC5hCwo7iLerEcbBQpHaIvJYNRqF5BhX5uKUOzMigryaZzqqmmiSVtZL52S/Uw+Svk
	 o+10ZNRIrwtRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C46D8C433E3; Wed, 17 Apr 2024 14:45:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 14:45:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-Llmo50RdDW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #34 from Zijun Hu (quic_zijuhu@quicinc.com) ---
Hi Wren,
for logs within comment #26, #27, #28. i don't find abnormal logs.

1)
could you share your drivers/bluetooth/hci_qca.c ?

2) how do you toggle BT? by UI or command line?

3) could you try by following below steps?

apply changes -> cold boot (power off then power on) -> rfkill list(share
results) -> hciconfig -> enble BT if it is not enabled -> disable BT -> warm
reboot -> rfkill list -> hciconfig ->  enble BT if it is not enabled-> chec=
k if
BT is able to be enabled succussfully?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
