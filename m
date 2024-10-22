Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5A12D75C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588893; cv=none; b=jlBpWlmowj25h0zlGxnsNt3ligurTGLUlYRz3PhHEo5PCARKVBzXxm8mBCXdU8JvE/quynCMOfcBHnmVPFVpjDO8MdRdUT9kyUC56UaFoZeXYox6VPlt2TIRVQejBO0g7dfEGqHBwVVvwd+prRT/wAC6ktx/qsOKizoOhpKILcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588893; c=relaxed/simple;
	bh=24qrbKVliY4OUdAlozy9PIupoJnJ31hw9r2+tknRpVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDiuHRKgC7oJ2Ix48q4k7mM6oPpJh1c/lry9dQZtL43NlLoakZziFw/rzpJUJI1UmlUPr9K7dGDyQpedHswWeUXNL6Kzq5/0QSlVQREOmfNejbxVXMCyVwt7YAN4Y4UoBnpQibEJXipLhCjk4+Iafgu7Mf44F9j1bHEMBXy5bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYUJeu86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYUJeu86"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E45AEC4CEE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588892;
	bh=24qrbKVliY4OUdAlozy9PIupoJnJ31hw9r2+tknRpVo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gYUJeu86uC2LzKWvckFLVHg2ATym6hRGQt/4DCKqqcCjzpWfFrpRJvXqKrLtzA7ln
	 eK9wEWR5I+FfgJFVU2zBO6aspSu1Z+GWjGO3uVUpOORrwBjcoftN1MA1/MnNq1eoLF
	 K5jKgqwYrGZpP1KOxkewH41miOCvnbhUJJS7QraTrFVDRU5sWw+wDIkWCD/Kasn6KF
	 AWgWR0+SAd4nrlgXLlX/xomZlsC/K+/UUrsrj5Vo2tcTOhU34knXgu5Y/dl42A4mRO
	 UFR+QcvaIOqG5Kw5FxqaTMEOwMcRtKY1BrToAlqVC5y278YtvzVU/lGX6CKfxSECic
	 jkgwAi/K4P8Yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DD30FC53BBF; Tue, 22 Oct 2024 09:21:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219405] [regression] mt7922 bluetooth scanning does not work in
 6.11.4
Date: Tue, 22 Oct 2024 09:21:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219405-62941-wttlzAQpA4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219405-62941@https.bugzilla.kernel.org/>
References: <bug-219405-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219405

--- Comment #3 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Reverting e63125eec47dcc169cf62a2a56448bec92a0a271 makes it work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
