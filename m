Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B7E556
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940620; cv=none; b=uCbkw2apMifvJY4uPKKxPNAaD+yzc9N05XzNJQHK00r8DhGh/tcIXEexcugkfIQFdOiAnGwxFAoASfk145Uw+66wYsE1NvLXPqyrSnlktpZYlp9uZs02L2nkpkdP1X983WHummV1WUk+wVr/cT4ZlKuPItp5GifOp0lUm7Qc9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940620; c=relaxed/simple;
	bh=y0o2TMX70b0Dx5y9RCPlB//7sdyjziZJDiKo4Oqjy6o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyIF5Nj2zyUy0F5eM+AnvRlsyXReUtMXal/g/+XukJv5XGiDBXJT7WAkVe5TEIdnD7g7qDGR9nB5rwvwtYLvKIwjJ5jWTVNPdkjxb3fwcjso0Qi3t1PfJT8paVB4m7vmOKygNRjopTgP8pdNAJsWjICXJg6Q5Cox075PwY/Mujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ4Q6ImC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ4Q6ImC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5D72C4AF07
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940619;
	bh=y0o2TMX70b0Dx5y9RCPlB//7sdyjziZJDiKo4Oqjy6o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bJ4Q6ImCJkeoJCHppKV9C6jKa0lKfInN1HIaZ3xFAXTOaQowXMzk6quD5I3Ml6djY
	 IYu8qPd0No6DFuBBNxBwIyS5CnFdiJLnitFfdLuZItZpSDWGfAVNYKP48ZO8KcYThH
	 oA1XqA78lKYlKyU8c7xJvoQDx6eRXlBNHTUikItO7YnJqAha1DQzLPeBY6h4bCyTHH
	 P94Q7krhHYG0JelyFHo8DQL27XLUJ0fG17ehlbW4Y+ObDr+ted0x1/MPXFqvvvWyMd
	 R0KBTSsQHhKeoQ2FPJey84kzU1tP1dnCGYWi/HHXqRTNbKNBVfjOeFCik1TFnWORSj
	 CWRvnLx8BtbeA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DFA46C53BB7; Thu, 25 Jul 2024 20:50:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 20:50:19 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219088-62941-aIJFcYZD5r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #9 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
Created attachment 306620
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306620&action=3Dedit
btmon trace 6.9.9

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
