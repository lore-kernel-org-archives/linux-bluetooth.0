Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116E1B87E1
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217815; cv=none; b=SY6C6bnOe39jH3Qk9QnZmgoE8TJhwqxQd++ZyuzmckE565IncTZq+zj2c7l7QQJZlKKfWZyeN+EEggaTwpNnQR6C52164UPni3b79/GQhGRpafVnZisBH8B08XPs0M3N+/RSdzEKI135mV7Ev/W4Y2jCgpXOAkNnQGvq6OfH4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217815; c=relaxed/simple;
	bh=CE8knnjKj6xMpeuAd0zkFXkFUPM4U3A3VFMhSmqlmIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Up3Bne8qKcQA1pLJ9n8Y/A0i0OGss8lFg/QnMcilvNi/hbBQITkP/d3vD16pR2m4dFAxE1Coc2qT8kfH0IC5Xi9DP+bjJBlavoXBAb/rWa+fkz1WvrSqJb2JLiiRSV98MBjxgyOrUXwQFe4VEBi73Dig2QY3jWO/KcXQjfq3kPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azK2Ox1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azK2Ox1K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 426D4C4CEE9
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746217815;
	bh=CE8knnjKj6xMpeuAd0zkFXkFUPM4U3A3VFMhSmqlmIo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=azK2Ox1K7TjAwIAxpaoTSeOXgPDBEhAmhgIKUZfX/AKC1DarsnYVVcvXlgDeyiaE/
	 mZWyTfk10KKt+dgEIE4uuqe4so9X/DhM/8Z0rrT36fAZDOyr8ezrJC4e2eHZcg+Iu7
	 nJNo/6kyRkkziIFiEvUSxly7o+9EwqKck7da5YfV04w+dAgyZPkFC88X+c5ZM/28mM
	 UgZKzNI/NYIApqQcEWWFPCrHjCCJXmvslhSAk+X2IoclhoIBS22OhXZzW/dxx5aUis
	 CX1SpCw90BcRBRYpmL2NNTAiKKyaX6+9n442A3BJRASvcJXUs+/okmjCjW7Rfg0xBe
	 TgZMiIuH2FvRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33F06C4160E; Fri,  2 May 2025 20:30:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Fri, 02 May 2025 20:30:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220061-62941-YrmAlOHMoa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

--- Comment #12 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Sandro Forster from comment #11)
> I've tested v2 of the fix with a DualShock 4 v1 and v2 (the firmware is
> probably the same, but just to be sure). Both had the same behavior.
> Connecting failed on the first attempt, but every following connection
> succeeded. When bluetooth is restarted, the first connection fails again.
> Here is the output of btmon for a unsuccessful and successful connection
> attempt. I've attached to logs above.

I think that is because when you restart the daemon the link keys are reloa=
ded
and then their key size is lost in the process (for Classic, for LE the key
size seem to be stored by the daemon), anyway I just spin a v3 to address t=
his
so if we don't know the key encryption size we use hdev->min_enc_key_size to
satisfy l2cap_check_enc_key_size:

https://patchwork.kernel.org/project/bluetooth/patch/20250502202052.2802441=
-1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
