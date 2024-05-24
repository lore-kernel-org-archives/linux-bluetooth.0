Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E684DF5
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585100; cv=none; b=F/Z6LV+7qNRnWxPUNF5L3tByVffwp3LnRiN/gg9m5gAvdZhwUeSVLcLSfAjOULo9YCttlfSjzUgzx8Fmi+pQksZ90t3H2nu3MGKt7jZ4YcA6wgzFbwpxxSdhP75avhN7X1Qc0/jwIF/Qv26Ga2q0Hh2o185ZvaSaYXUo5pwMZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585100; c=relaxed/simple;
	bh=abcgH8TgIWL30N5Ygtl1FhyB6rkngUiT5DiT7jLfLHE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StPNST/azhYxvlmrCZ3KkvH56eWR0+v5gG6VaNQ3i9mkrCpQde2NLpDmdrZofRK0oKleEWlk4YKsRpQ5ZTgs4t2Y+Bqedi8xndOyOmHPuJ2ZbF/ux+9o9AntF54cFM3MbEzCphzJ5kpBoTavNLCB74M91/3dBN4bFgwfhz61l7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhlSSNrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhlSSNrd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D219CC4AF0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716585099;
	bh=abcgH8TgIWL30N5Ygtl1FhyB6rkngUiT5DiT7jLfLHE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GhlSSNrdC0q63RAdOM5LSt5xj8MCZPspwvDZ/gJc0A7DfbLZ6R6yTSI1jXdjb/X4r
	 65HRB+rlPJUebyMyAgUWdNQZ4yMhkC8Z+xgwCqZcw5PXXTkbXgUBfcTrEv/G8to36/
	 /0lFZBk3vqjI0G7pXvIDwVXSJgQkdyIo2vpSQGFNirKdRyvzMldxNz5aopxbmav0my
	 nlXpyFVoB+JuoQTmhiJ7efwyAo8BARtzWOCzHzAV7uDn+GP8Qnk711j1laU+qBH80v
	 kz1YW70sahlfe8mtntZTMF3NgJ+MKHIZM04vUkPLddQjuDIFh6jAFDytKljRTcue7D
	 D0ZrAcKa3m99g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C6B8EC53BBF; Fri, 24 May 2024 21:11:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 21:11:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-p5rZbVEd0t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #31 from Dustin (dustin@falgout.us) ---
It looks like that new error is from when I attempted to use my BT headphon=
es
for a meeting the other day after doing a cold boot. It's unrelated. Sorry
about that. You can see at the end of the logs I posted where bluetooth sto=
pped
working after waking from suspend and the error is the exact error from this
bug's description.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
