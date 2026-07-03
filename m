Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423E30C15B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106479; cv=none; b=kGoc20dmNC9jfp4MIchnAQ0xlTR0fDKqiqHBDX4ZmoyrJCz9O0iCKmkt9MWqdGjBxtTEaI1IOcyfK91wR8YxZ2fm2/9VURljyppxrIN2m0Y+6yTBqr+Oh/TqpBm3fUMLwb1VSJd2FsThyAZdx/+gCENpneR+rszo4jUwQsvGpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106479; c=relaxed/simple;
	bh=s9/yrX52VOFD5RhytNsb/DN/ydewaovxeFos4vhPg2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QvJz6KHkxkZ+ZeU+vSC2VMm6TjVPSZJu4uQOlMZyUp5FQLwBM6+F6ql+lhKw8Ri7qd0GNWMtPdgPNyIn5fRQ6XQRjrQZ5m1AWH7gC4qOPR+KyFrG8rv7CGsa0Rjy1QJhJGYHha+lifS4VoPLRjesm/rJqan4CB52vtWt/ZuIKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr355++7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr355++7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83B77C2BCF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783106478;
	bh=s9/yrX52VOFD5RhytNsb/DN/ydewaovxeFos4vhPg2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rr355++7tXEckkcz4v1UPHWdzfvsyM8XtC1k9lYQjoWzC8f4/rIy0fcvoCc5ZFTq1
	 /v2L3gHB/DBZCwP4x2uAfILe/IXbTzC+kztzlOjvixHaAlfW4TaTsbwcuberA0NeAe
	 3ZOXEkTbUVW68icMoKWycoe3u5aoSpJTQ6sIQKVCdr8+HMWEQnWHEM36WnJccTsxk3
	 Vavj4X5VKqfN6yKPdRsOKTWc5ytAGXTTW5XC11dH16zR13QH3tfCrjut3Bjx5BNT1m
	 C/6+eme/TF06f5wntguVETfEiTTWRY2d/2LfpcuDunTesU5asP6aC7T1OqSsB2/xtq
	 OlXLurt38zncg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E8E2C53BC7; Fri,  3 Jul 2026 19:21:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Fri, 03 Jul 2026 19:21:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jcubic@jcubic.pl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-Au6pqz4s5a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #18 from Jakub T. Jankiewicz (jcubic@jcubic.pl) ---
I didn't notice any sound interruption anymore. Right now I'm on kernel
7.0.13-100.fc43.x86_64

I still have many messages in the system log, but that is part of
https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
