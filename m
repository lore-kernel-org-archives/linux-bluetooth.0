Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394813C76BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117410; cv=none; b=rIsB37UhSS6rNZBi5GyFTDstJ8e3/+NPmXPHUUstnETFsVMjhZ2QAyRzD6Mdh9C8fO7ycAOwJJlPzii1+2A/U4U8kJvEExgcBPm4JuWCiygoDIxSZinyAp9CEaoZZ2q8R5jwRiGOTa5lKZOPuQKguDj1taUAVTeUcso6xpOh6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117410; c=relaxed/simple;
	bh=Ue8hx++9YxohKyy4QiWyQo55DedY9VeUzq7lm6Sr15A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bWZozz0atEPey+ad9sWnJQ5QUEK+bEFuHwJVOp2dzTq4zgtf0ydAhJ6LL3BOf3YdFYJgABcYzn8f2jqQwECpYxO7XXfd0AFdiYuZAfNpsuoO+e7MRQXjZCUKMuEQmkJvndwAjnsfVPgw3Kejs+fO8x8EMMV1YSsbUgN7NpX0M14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOho7z2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOho7z2d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8659C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784117409;
	bh=Ue8hx++9YxohKyy4QiWyQo55DedY9VeUzq7lm6Sr15A=;
	h=From:To:Subject:Date:From;
	b=sOho7z2dqrCV5qyBACqeoXudSu/YRaGDgMu4dWQVf/eE5zgwZ+B5u+RvQXNr90rVE
	 lgAXw4a1PoEsG59sKNhnFeQGrL2kER9EOJIQ4u3kbJ93q4H3ZCYsbrPeWZM1brEWUd
	 SCedNuMzfYo/RQ0yK4PhLkjfNLZ2AK6ELeqN6zJrp0izBFgZeyOra4LqvToozM7DNw
	 V0hwATYVPKnZbhuEz1FwYNG2WnWBnN2VE7iPUEbbTIDCm23Ylu9AQmLr7K22eq0imP
	 qNsg4CTn3at2mdQ69BDmRME2mTWHCbQKnsd2+ocWQ4IPWhJA+fNJ4Zd4nfaeO+plGC
	 UZ9U1RC4lhejQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1487C433E1; Wed, 15 Jul 2026 12:10:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] New: RTL8852BE Bluetooth (0bda:b853) fails to init:
 Opcode 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Wed, 15 Jul 2026 12:10:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: serge.brun@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221754-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 221754
           Summary: RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
                    0xfcf0 failed: -16, hci0 never registers with mgmt (BD
                    Address 00:00:00:00:00:00)
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: blocking
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: serge.brun@gmail.com
        Regression: No

Full bug report for Realtek RTL8852BE internal Bluetooth failing to initial=
ize
on
Lenovo IdeaPad Pro 5 14AGP11 (Ubuntu 26.04, kernel 7.0.0-27-generic). Inclu=
des
dmesg output, hciconfig/btmgmt/rfkill output, and a list of all troubleshoo=
ting
steps already attempted (driver reload, USB rebind, firmware replacement, D=
KMS
rebuild, manual BD address assignment) =E2=80=94 all reproducing the identi=
cal
Opcode 0xfcf0 / -EBUSY failure.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
