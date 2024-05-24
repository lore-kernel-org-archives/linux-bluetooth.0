Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D495208A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540292; cv=none; b=IY4Mu57TRa7Ptar54Gx6fWGdGQ/Gmd0BplkUl0sU4qjiGrXuKoZ2tIUgs/XKm8CmICbAFDxb7gVtVx49VfxQ+Seii9FJjyBa8SPOD0eN6X3rKiUUC9whoRzaVSR2Td9LvlXgIoar3pIMZsavmQ+rju64TXUSvSKhqP86nCFG988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540292; c=relaxed/simple;
	bh=tRsvLXIFozs9x5GblDz1Tl7OkZSNWWZr21rv3BybihI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpwMuXCUqMjPzd+Y9+g51AQIqhxfv7TzBho81H9tMPZww3zm7D2OEq6vC3DXJMUhxX0VWd8ll3CJqo16dnWq419h4QuDulW6uxfmbfxMX+0ALiL71JVlqFW9ShQf1mZjvjHpRLRV8BKm3xpnBz3DPdGzOqJ+GlmX3AAEnZ2mV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeXIeW9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeXIeW9z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB76DC32782
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540291;
	bh=tRsvLXIFozs9x5GblDz1Tl7OkZSNWWZr21rv3BybihI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EeXIeW9zHkX+vz+0lyBFUM6LIHAiqQEgaKmKnqzL88vJTwkT744/7z3e1lUsovdlC
	 yKhfc2/y/F9Sx2YfOZgcrOOTekaD92+RYys5gtYZigFAowB8hKkmqBly2xJHHrs8Wr
	 HQfugBFIfRVPT8GMijXthdYco7BOmF9b0vIUMuuTB4BdciaDowyjOLzdzaIoDJ1ph9
	 65/BgiylNH6AEiRytXVEowLAdJscFiZa7l0wi9+7CukznyVZPcaiDfsbMJgqGEVYrd
	 fkyBZ/v4Db/n9USySddyO9hGUusDlW+hWKg3xEBlqqMCrD4HQOkkY5iBUSwIQDi0Fz
	 QT5sHwB9iWc4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 98BC2C53BB7; Fri, 24 May 2024 08:44:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218880] HCI_EVT Packet 'Flush Occurred' Misalignment
Date: Fri, 24 May 2024 08:44:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_kernel_version
Message-ID: <bug-218880-62941-c9y1XXlvA0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218880-62941@https.bugzilla.kernel.org/>
References: <bug-218880-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218880

Yuxuan Hu (yuxuanhu@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |johan.hedberg@gmail.com,
                   |                            |yuxuanhu@buaa.edu.cn
     Kernel Version|                            |6.7.9

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
