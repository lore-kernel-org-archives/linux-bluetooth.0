Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416628313D
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549373; cv=none; b=Do6bgx8ZAHZkiSX6dM7e2On82hML7K78T2dhPU8BJDOeUTaGPcIZZ2NTMq3TuF5GUND8aAKv/8peVxGqXo9g9gZuhMmOscAmQTlSNQFpzJmyBAZG5ARWioTSp6HS+R4gpOAH6MyiAE+wjoJ40rskAOmIRMbLcoe3oLfHxq96ShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549373; c=relaxed/simple;
	bh=gm+U+LIrYn7v0ktK9QlnXAOGf2BOLx8M/oyyJp+sJPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdHBbBMrz2Z8V/YT7IdNQibBw6mORmuN4ISgpdnjdeaGOx6RAB7WXnnCH9H14Zl3OWex/pS7Rj1fayRd96in/PYga6h1tS1ODGoJWNbyym/oTQRuiaW/KjJIx8LkJwRm1M9+lmVPmuhX6mKlAaBF+aS0GdGW8IDle0++u0oVDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1lYTlcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1lYTlcr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1667C4CEF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761549371;
	bh=gm+U+LIrYn7v0ktK9QlnXAOGf2BOLx8M/oyyJp+sJPM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s1lYTlcrjJMDXLeAR6dfnVrNaNcay4R2jMRavFEQPCi2XFrsg2AXU90PBX9j6SJAo
	 8bmBYAsXB4Y2HNTohMi9R3RzVNLAJy47p4xol/3rwItsnG4F+6UIdK9ZyA1AR+k5cC
	 Ag5SsstB7veyDFNI7aisMUeokUnCgejPQVhZ47MTsUp58cqzxnUDSvHfyMzCmuevjS
	 YxnaeBThAZp4YGfIbFe0hCamubXS8hf8XneetJ0seiTvg/ydtrBZVMHfuXkkdc9TOr
	 c9yFPwoSJS+PQwxgV+oxAaVjBFSifvf/zd8T4cbk/d/1qlVUwghSZvljNjcOmBOAnD
	 2vcQzm+57y8RA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8E56EC433E1; Mon, 27 Oct 2025 07:16:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220703] Bluetooth connection is sporadic, quality is poor -
 halts and stammers with linux-firmware-network-20250917_1
Date: Mon, 27 Oct 2025 07:16:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bob.hepple@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220703-62941-MnhBsIkRTh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220703-62941@https.bugzilla.kernel.org/>
References: <bug-220703-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220703

--- Comment #1 from Bob Hepple (bob.hepple@gmail.com) ---
Firmware version is linux-firmware-network-20250917

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
