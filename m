Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353589;
	b=pTzAFoBVf/bF+dJmfubrq3KK9jyf/pIfAxWzfc6iUjtwlyyM4ZnFqwKxyBIPtzku6cnv
	 1CWsXINBt3nZARzrRHLGeNf/3lSH716L9uukIfsF/fQUCdiJMiDuYysIUfPN4i0IMIwjG
	 ko9E0UHTqMpbbqbmaM2XzuIaE1HWpNSGp96s3aB+KPyZ0yeu+XDYXuHbMUZlnj5EjvZu+
	 QLpKMAeLRmvr8P6U4QCqo1fxWXHlzDzpARHk1/SqMOBZC3ygXil8gUwcwp7vTp4U9Lgg5
	 k0PY30qjwZHYTCvT/UJuxoTvdDJnb31V2xC24YLxjxXNoi408W5qRmFysVMQAlvhghg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353589;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=A7vcxkVLoIHMa1dXe3HbX0AAwg4gDa1Fm8IU9Pt6u6w=;
	b=C8fUkzhJSmkRIGwZFsTpxLayI/mFSk/hUQrkyuuBjf7n2qAMCmdmchqfEy4ACWMG7EuV
	 cDZ5q2EyBhgpcEKbBdmNMAkg9z6yH5hFRLFrhgxSzvIWuei6e4ryTofQUwiS93739GN5F
	 eisVbQcdpq8fwsOZD9cCzK089t4rVq09gJAyutL5S85WXN6GNqVzmfAcDx05UsM27qetn
	 aTxIUeSthuF4ChPTdIG3T8QLlAOpjCipTW0qsZevS++1niowJrYFNzERSBod0NLh0jzWt
	 xuoe+RbzO8DgEZ7LziFncPPsQ++x74bw5nqBr/6ul0jyZV4I+6cwM9bPFCj6UUY5VKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEdDrvzR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189B606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEdDrvzR
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DD0B1F0093D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353589;
	bh=A7vcxkVLoIHMa1dXe3HbX0AAwg4gDa1Fm8IU9Pt6u6w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=BEdDrvzRiw8gW3acKKV1BmmNu+dEB93pNTAoWLZ9Me8asPQyxt8OLzFCQnRFoiDC2
	 h/naJWV7/j11CFClv9f/ovA3YIApWdYfci+RmGbJQWbSm8TByVe89kvSHX7UFT2j5w
	 AQwiASTgWcBHR7YAkCNi0yJiNHzufShMxrX6M4Q9wbwOORwhMiIgcAHMzMYFz34AuH
	 tPKkZinmt1jI7EBuJBMlqxY6RF8kzdALBaPljqzbWWnmG00wFd2xN0ALyOaWXjKBF1
	 pKCPYRfXsAaJVsaqGO2meg5qi0BHY6p/0obuc+psmNOtsg9tYVmxPVTC1ZyHQf3bJa
	 aQrX93aLOKRhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50730C41612; Tue, 10 Nov 2026 23:33:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222250] v7.4-rc2: Bluetooth: hci0: Opcode 0x041a failed: -22
Date: Tue, 10 Nov 2026 23:33:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fgbreel@posteo.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-222250-62941-FqAvjjGiMF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222250-62941@https.bugzilla.kernel.org/>
References: <bug-222250-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222250

Gabriel Francisco (fgbreel@posteo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #3 from Gabriel Francisco (fgbreel@posteo.com) ---
The patch mentioned in https://bugzilla.kernel.org/show_bug.cgi?id=3D222249=
#c1
does solve this bug.

Marking this one as duplicate.

Thanks,
Gabriel

*** This bug has been marked as a duplicate of bug 222249 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
