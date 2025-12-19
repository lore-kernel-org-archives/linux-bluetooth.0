Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27110261B70
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182225; cv=none; b=aaxoQbdLgDQbSIyfuUadLqxX7sXaJq5XDOJW2Tz48cjZAAZZMMWKlT1QbgXmtqWTUKTOKzqNgUsDIfrwx9XmNKLrtz1kWWv7tk4fHm4/74yYGrO4Rd5vA0VxC3oiAFh7NuI9uKPj7RrZ7B4asTS05lLk24vFKZPcSIisWBNnvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182225; c=relaxed/simple;
	bh=jZtfcGGorAYAu/SyVopdsqs3gNcC2f/35d25IURykrY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfnHDSYKgiGe6fpJ0j/YCyqmX3ukRMMg3R0sYc1a9HUdX492LqaLuF3l+MiLnOS0kCvcaqTZfjVQUEIdDrW/8fqsjdi/KH1QpSHkj6VCWrGZvE+Lhs+OfEXO2H/IsPW8QKDCKtzAXn1pQkDw/LB5gIqkZAIu8npsqU/+oM3x3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEeETjfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEeETjfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3B23C116D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766182224;
	bh=jZtfcGGorAYAu/SyVopdsqs3gNcC2f/35d25IURykrY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lEeETjfJqGo1uRtDqhDHiLSkDh36aLJW0GkG5f5yPVP3CdCRae7VYfL/uAwKvklrX
	 fcRvWzTl8QE8hJpZvKQe10HnVqNcqFiW400tghsbdonOdM2fT3zNBiRyT58HzTLWFE
	 1KzbiMyvLUxNOm/hqZNzzBNM213uLLAQB6qSUUYopwqW4JOu2cuMGaar++Sf02CPNp
	 Eug7me4IDHPBcWojjk5lrf6FaqvDv/hMg9z/lTlDPY6vFQH7D0jUpqKSgDO1qI8tFl
	 cd8TLtSRO2/qkwNqvN6Yn82UGw1/gD0tGQ0oiOtLcgqY5o0uFzXRCBDbzaE/0XQIeo
	 Y8I+LC2nY7uFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9708BC41612; Fri, 19 Dec 2025 22:10:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Fri, 19 Dec 2025 22:10:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216936-62941-kIVQwWN3ty@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #25 from cheako+kernel_org@mikemestnik.net ---
Created attachment 309051
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309051&action=3Dedit
Failed to load fw dyndbg.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
