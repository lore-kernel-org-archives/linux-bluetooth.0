Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07D85C6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426739; cv=none; b=YpbT+0hRb3RiBq9WOrtmAC/sZZx/MzdOhXqV/iYtuPFSb72molzF8v20KblyIev9hUproxNbNZk+bGwem7HQL/AJPHq1IgyD0hlA/P4CKcvQKTJjS+gI6SVYIZlT7T4V0Jg2Iy3ySzvGFj+pEKEcbVLkkMkhCSxMh5tvwYGTjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426739; c=relaxed/simple;
	bh=KlG5lcjXqsYjAnGoUN7scqqD74lSpk8JMvOummwOHww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XukaXYw2TJlqlbuV+88ka3Z0dh8pCTgnACHj7HGlx9uhZuYQL2ji24kzpczJ7DkcMf+WLLLAjxXk/26AY3hyIHfukRNxqLLAOPslpH7NfMkNqjspqwyYFYsY9jIrQjXFsK/CmtaCfJbZLPJo89bHR4NhQ92qc4g6JVwM2qQ9Zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ign7N9CK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ign7N9CK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE806C4AF17
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 21:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714426738;
	bh=KlG5lcjXqsYjAnGoUN7scqqD74lSpk8JMvOummwOHww=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ign7N9CKapTrNdBv+KPO1WmQJwN5sBErbtKI+SvRmldrnZVUv4B9XnOhS1zwf9BjN
	 P0vpernqXDGQGlDshD6otc4Uwcdl6da+U4JkQUpLLqV5emXRN60xF91Lt3InDkdcvK
	 RX+VH0eWoRHU2wEzh4zFie9RUB2xwKMDXHJ6mSUGNAxhMnXOAU3CHk75t7AF8xm1Vs
	 +QSDsYV4x6eavhDFM68krAIdaNWaoktUWyi73HSGFu/nAnDABMeRqZdBH1k5Oej7CH
	 CdwFDqT/jQAlwx6nDJcA7HGArJFRQuAwUeYJlyRzh7K51qii24iwhEYAQcf/4bsE/O
	 jO4oFMUHjYPag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B1DFEC53B6B; Mon, 29 Apr 2024 21:38:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date: Mon, 29 Apr 2024 21:38:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215197-62941-7msEhzrxgw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #13 from Erhard F. (erhard_f@mailbox.org) ---
Seems the fix has found upstream meanwhile. At least I can no longer reprod=
uce
the issue on current kernels.

Closing as obsolete.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
