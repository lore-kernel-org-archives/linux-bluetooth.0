Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEB158DB1
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727619999; cv=none; b=mAfPkd+KEj8bTc1ibaqgKor98v7rE/QYYh1xw9a8nvzR7flZeKPWTyUX5xRyamSggg0hE2RJhu/xkAt86h7IUh96ZSJ26X7C/0o8VtFtHeor0CQsdvu1sEtH2EpCJVANcFPldtF4MSlrcaPHhVGe5rTX+0JawtIaPexErrvdIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727619999; c=relaxed/simple;
	bh=pyZMiH1hxlsP5H54TA/iY+iTrQcFIWnFI4SwM8k2hSI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVp8Q2mLaYIpPZFhz1qgYJZhyEeFsy/bxJy2C9byvtgtM+yUKMWTiowG0Iad03RWnNVDh+ubS9T2wJdnBp/m1tbp1o4uelrj1PJDo7CWLWFSXAJNnw5yEu0E5ei+DB96xxghKAyiUlmVbC7qIax/IiJRC/X7vVT785jW144uutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sps0t+Gg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sps0t+Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA705C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727619998;
	bh=pyZMiH1hxlsP5H54TA/iY+iTrQcFIWnFI4SwM8k2hSI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sps0t+GgMUc+UAfAWQchLqJsflMPlvEpltbqDbFmnp5uoo+n/9xwvgWzklThHC7IT
	 e/QZmBonAEhORnr8RSIGNOHxUt0HBW0vZtDDmUmApsG4ik4f4LBAGlnqGJtRgTuqzj
	 e1QGuxM311+f84AWDHqqeZ+lu7uwGb4XOfK6FTwj3NmcMGyqyW2gF5nL6ojop9+XHi
	 qDhQX4OhLSnpMkfowCOYxuJq1dtl7pWhBw7Na3mumk6MH/0dGyz5RtYEblBZKqUQAr
	 cSOIAmj2A/5DZhpYmd/AjFz03A4F9n8JlJUsR6lX9YLy6UQUHIYnyZPsxYOp2Y48uv
	 gibzKh4pLfnew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F321C53BC1; Sun, 29 Sep 2024 14:26:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Sun, 29 Sep 2024 14:26:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219333-62941-hkqe2D62pB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

--- Comment #1 from sander44 (ionut_n2001@yahoo.com) ---
Created attachment 306938
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306938&action=3Dedit
dmesg 6.11.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
