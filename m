Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC61A6830
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781332366; cv=none; b=LeWFv6pN7JnuqRj/uJNAjnS+hlL9IAGFqzjOIQIIOdJm2W7J6r6EgW14OLPvcaswHm/wa7/EVl6PKQJ8g0/X4prXgsaIOFThqjkSPdUZxGAT3AohET4kuuYv7hiAwezlcnrov8x/DrqBtCOeyjNu+dwhqsDPH+JyCZI76AVcJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781332366; c=relaxed/simple;
	bh=CX5Xkq/RRm7Vs7qC8yHenvjsn9vGSpIYNPGVoyfZcQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzuhusNLd8YHD32avFCISub+VRXLDNCBbZWD/dDTc8Ex42CdO07gHAMV79NMz6+4p7TCgH4vthji/138OCpifo5T/Jh2tN+v830PeE4CjKPKwvVgtCIE4t2rhsNxvNvIvoo+Z06whZY4/7P50uJLr5KlIMv9G82R0r/JjRMobwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9sDAdg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9sDAdg4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A5DC4AF0E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 06:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781332366;
	bh=CX5Xkq/RRm7Vs7qC8yHenvjsn9vGSpIYNPGVoyfZcQA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b9sDAdg41nZqYVHwlZ3qp5K1Pi3I55G4W+ZouBS+9w4/YcsO0Wv3E2XinpVX+FDEA
	 cROyGJOiHkjAX/Cjcj5cnV91sj9ZT15EWIAyVzU5Y7Qu3hFKKimGjJYu8oyK19OnWF
	 YLFVLkWAEBoWwC7omGcxbtLZoq/zf7I//QUEv6qeeUtwLtI893ikmIoRiKGCpaB5Qu
	 IGDaZpUrL8pfgfX/rwJQ9gafQTG4tm7fc7oi+S4ch4J58QPTDTajxkLYWPbUy84XMs
	 A/hulno3MnV75/cpIeLA2LRS9kmXsFpVBOu7bW6Ubkw2GLB0OtHa7G2wa9QqYPQMoi
	 5ucDM6MacSQKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C953C41612; Sat, 13 Jun 2026 06:32:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 06:32:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-iMhWyOENuk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #8 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
At least Debian=E2=80=99s Linux kernel (6.1 and 7.1 from suite *experimenta=
l*) have it
set to `CONFIG_SERIAL_DEV_BUS=3Dy`. @Hytham, please check your Ubuntu Linux
kernel config in `/boot/`, for example with `grep CONFIG_SERIAL_DEV_BUS
/boot/config*`.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
