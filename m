Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521921BC41
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034549; cv=none; b=tiuLgQoHyMK8BaEFs8TiEFF0TPjZPBFHpY0JoxuIpz+4pjh+swUt7XG+VQOTYp3He2PSwBoa3nE0oy6FK9L65YFEy/4PTlAkfPhNTTL0W4wedoH5UUjysCc/5FzlSSFDHK8riktzeVa/yE7PcD2k09S0PUIf1GB/8ARECMDq2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034549; c=relaxed/simple;
	bh=cM++/QXXIv80GkZcTitr4jdrH0iEafCvaHx3rTSM57k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qObLIgrBZSI9K97WcePfTpLVsrQYRW4+f2+0ZTNnWCrAkxoFUwFraCY1AVViNhutHPG4xw8HBZpLevXAlIzk7fzrXgY4W0QmCeSLgDEORHafZTlyK3yq0Kj1FzxYw4AJ/PEKj6tPaoogiLrb2wvEFSUbAwgL1C3HdjkOUDcoecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWCN9s8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWCN9s8l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB897C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034548;
	bh=cM++/QXXIv80GkZcTitr4jdrH0iEafCvaHx3rTSM57k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hWCN9s8lhf6UAc1h92ZPkWAVLXjhYJTEnxos8/0w/D+h313txNiRoOaLmwv5/SYgR
	 8OAglpALl7DZ7PLBIyS6VKJot95chEeUe3m4jPXi5LJswms/a0htNY9Uk5RtQCstoQ
	 JkRrlB9XV6Uvazz35zuo0CMX9sWQpnu7A0+EYuIZXQ8/CiQYG+/aOuK/3xLZPgiOzO
	 69a1vuijNfbA7v6d/4EcPg8YwMTNSRsu9Yn2j5SnOEZZyt09ZP7Rp+4jiXRsTuA64G
	 i0nsMIdKPMptos3ZVVbr6Xy2TiZ7xeRDDX01a1PiGbgn9F+BjcpK0jt9snmDEbaoHS
	 TfRS552pjXkhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6976C53BB0; Thu, 30 May 2024 02:02:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218914] Missing HCI event REMOTE_NAME Causing Subsequent
 Bluetooth Connection Failures
Date: Thu, 30 May 2024 02:02:28 +0000
X-Bugzilla-Reason: CC AssignedTo
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218914-62941-sjx76jYLnb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218914-62941@https.bugzilla.kernel.org/>
References: <bug-218914-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218914

--- Comment #1 from Yuxuan Hu (yuxuanhu@buaa.edu.cn) ---
Created attachment 306373
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306373&action=3Dedit
Attachment 1: Log file containing HCI packet contents.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
