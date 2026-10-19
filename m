Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F64D4874
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408313; cv=none; b=K/pQRnztskmIBomm6hCKvBue/VakxJNamYlqsICw69BjJonAWpHbmBn6SmWbrpvfFv79qLjG5i/Q7/al3xmBQRtXZH1NysHNSXqKNVg76RX40h8Ahsoa748ZKob56l7Foa7etS5y8GPDr08AK4EzRlNc32MltxfRhNlnhzIjlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408313; c=relaxed/simple;
	bh=lmWSM9PefrTSw8qNkWSb9TH7vtVxrYO5bcFASRVrSxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DL63oONSamBgmw8H8Zz93+ETgDnIOloS7vytO8VyJ4yCzeatI03r622qT+c7uCRaCLoAtUI2MjsYWtr5boIiWJ3/ZRyT16g64JeDbUmVW2I6SOsqRHEFBDMgd8vwHl1h75naktKLHyq1tOvCilUJ1rqYWnS3xEgcZAeQ3dpZpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz4fUoqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz4fUoqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C632C2BD00
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792408313;
	bh=lmWSM9PefrTSw8qNkWSb9TH7vtVxrYO5bcFASRVrSxY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jz4fUoqJx7Qhbg3NugEMHVp9/2BeNnlZBro/G4a1IRVmysbuAHO24Y4nXLwWxXYYg
	 XLaNQW1Js1oS+1VCh+/VHjsEKGccmwBsVUUJooIP8JCtAEV6ABW+DdmJ6ewyuL0P4f
	 +rt5X07IxVwZQUZUHjNm43gag6ztzs/ohJYeCHSKLjdkJhAclHf03XsET0iG6+avb5
	 U1zKkHxU3Q7o7oAWilivGjbTfXGCba9NsTpECPvbKQ5RAoTehgjbF+zv60n2bGCkF1
	 uRqECAOfzdzsKl9y5d39y+31UsvLTxYCvmfokFd8ILMApjf13fnrFJqAsZz2IznEnl
	 QtcgYPio8YmnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12E43C53BC7; Mon, 19 Oct 2026 11:11:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221722] Blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for
 all MediaTek chips breaks HFP mSBC microphone on MT7925 (0489:e111)
Date: Mon, 19 Oct 2026 11:11:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221722-62941-YRRbBrkYTv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221722-62941@https.bugzilla.kernel.org/>
References: <bug-221722-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221722

--- Comment #2 from purpleritza@gmail.com ---
Update from the reporter: I can no longer reproduce the silent mSBC microph=
one
on
this machine (0489:e111, kernel 7.2.8, BT firmware build 20260605184935).
With HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN still applied ("HCI Enhanced
Setup
Synchronous Connection command is advertised, but not supported" is logged),
recording from the headset mic gave real signal in both profiles:

  headset-head-unit-cvsd  max -16.5 dB
  headset-head-unit       max -18.3 dB  (mSBC)

The call failures I see now are tracked separately in bug 222151 (BT firmwa=
re
20260813113236 regression). Leaving this open since another reporter is
affected
on 0e8d:e025.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
