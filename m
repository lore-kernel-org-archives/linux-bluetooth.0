Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AC3C47C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584500; cv=none; b=VzV7xI7k4CnqD+wZkCAJza7wwFJHlu0Ha6RBU2mPwknx0qoqeGaunDrKB90nDFX46dUOoPujeHghnnAYO3N4s8ljriMvsmj5oiAaMdk10Sg2UGmgpjlNEkXVS2odtbz3qE9Q+b5XtpaHZF7lP4CHF0THA88r5tFbOrR0rBsNV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584500; c=relaxed/simple;
	bh=VaWmd48FqXQz1J7cqcrDA7+pFQqNO2h8d9DzroOyraA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5NLsbOA4BTUlWg+fCZhZgTDW2uKqjnct+MzA+u4tVS6LJSN4PdzMSIVRGyq5EmHYUiCkfwa/3sWfVYTSCZpc5nS4VNuN8v87t5yOApl3DcOOiCfasxZnQSLECcSbM4vK3RP23SEcpi3agr343B8eJHEpXSZe8N/pQzSB1qM9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm+fkrt4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm+fkrt4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42B8AC32789
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716584500;
	bh=VaWmd48FqXQz1J7cqcrDA7+pFQqNO2h8d9DzroOyraA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rm+fkrt4RUZAo+aBS9HEv56GvUuDs9v+hjD6YPRx8AfouSHlE1KpfRUG+GGQQfJei
	 gwSV9xGaBoftJG5dsjXabmS6OTVsfzLrqP/mmBjwCVZ28RvZSuIf22KfzYQrTgHnJ/
	 UWAGhgcqOyRF8GVQRFYYvN6FXo1eY5/rCwuPO7JmJD35Upu3LvtCPf9GRRD/GOb+ch
	 WVI+u7+6sEFXEePTVTLMA7wKfIW2MC7FWqW4jwhSxCt3uhgPhwz3pCHp7UwoFJOjOP
	 xyyWOvVBpZxeUKtUxSSnOd5nkROqfoFzcHURvjPkOq0WpQ5gd4ib9uXxiQOFygwE4J
	 JzDRUxYKfPUyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37B9AC53BBF; Fri, 24 May 2024 21:01:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 24 May 2024 21:01:39 +0000
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
Message-ID: <bug-218416-62941-JC8JTNdMtl@https.bugzilla.kernel.org/>
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

--- Comment #29 from Dustin (dustin@falgout.us) ---
That error is new. I've actually never seen it before now. The error I was
getting ever since I updated to 6.5+ was exactly the same as the error in t=
his
bug's description. I see it's still in the logs I posted today in addition =
to
that new error.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
