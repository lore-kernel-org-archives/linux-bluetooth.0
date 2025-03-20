Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43252227E9F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504999; cv=none; b=ngt1AB9Gp17D4cojYjsQryoJqQ3vdt3yid9EEnGQsge86+fslehfdGjj2fNjUaTu/loFWJvl3vzXGXKpVNUJoAbpQoQG/rFrlBgfvmwJT96kqaSCndCEMo3DO2+k5g2F4t5URKnNmoZgLVjjoo8GkNny9wcbkbGvATMucNiNmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504999; c=relaxed/simple;
	bh=G5Exs7o267Si3GXzJTCNeidxxTLEawdUhgnSqHiKkZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfZZmmK9cPVBbGF2rreco8kGguNBPdqH5XTKNtn6pKuupiG/s4YjfifaVA2SpoSRWaCGBk82ozuoSA+ih1oJOyDW7uLv96czqLBywp4Bo/8aLiHaAyuCbOMj97oKG4KAVuLNtGWubN7SLl5XUIONkxVa1ApRhopY7H12G3qaqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWM16eUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWM16eUR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB475C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742504997;
	bh=G5Exs7o267Si3GXzJTCNeidxxTLEawdUhgnSqHiKkZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bWM16eURmo0Mr9Wm24F5hS+LzSowsvELUFm4JQRJMIc8WDcnB3mAeSb1t6BpQ6G6a
	 NQaM8SiJWgpxGSffwiqMhfw3bFcCx4UUFbheUC3tbY/DvZ4dPbBHwJ0ZZQfqoKz08F
	 62bD5RPKWxPNqq8nJMyE5ZsV5QMN2IMMKZ+gEuQABP1FQNEp6WVGMlWTAkN/yx+4im
	 b/T8VSC3bFjlhqHMQFG3U9Wl1Uen8qitH/RnEbxTZE7+93p2leeMIUgnmMWM9wHf81
	 OE1Otn+1m5mdSLwIucGaNWWHr41MNQpZjHyMh4etV2qst7B//3s/gESdAepxWAe2TY
	 /4IDINIu823Eg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AAB4DC3279F; Thu, 20 Mar 2025 21:09:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt
Date: Thu, 20 Mar 2025 21:09:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219898-62941-vsJIJx4pTj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #8 from Hunter M (miller.hunterc@gmail.com) ---
After further testing, issue does occur utilizing bluetoothctl as well. On =
the
first Pair attempt, org.bluez.Error.AuthenticationCanceled occurs.=20

On the second attempt, pairing is successful.=20

This issue can be duplicated by removing the /var/lib/bluetooth/<adapter
address>/<remote device address>/ folder and restarting the bluetooth.servi=
ce
(systemctl restart bluetooth).

Seems that without the cached attributes/info, this issue arises. However, =
if
the BLE peripheral attributes/info is stored in /var/lib/bluetooth/<adapter
address>/<remote device address>/ folder, the issue does not occur.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
