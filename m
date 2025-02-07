Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D6194C6A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963447; cv=none; b=o27Mn1OaGicyftsof9zdZyIB+rTMnmSkJmKeNL2qamO05tEczs4kG7s8HN6cK4qHL4gijnMXfL1MALcLhD+/mdIXjYJ6FYNXIWqCaiQMwXDKA6Qqtc5jkdSxhqaeBduryQW+VXYyDwmXebEMCv66AY3RH3bZADU5lDYvK1rWCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963447; c=relaxed/simple;
	bh=hnQ7WNQ0zlCxHWl3QVobhbLUwXojKEWjrb184F3entw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRViVvjS5mQxkydhwGG5yIMQ3ChCwVCb2f+VWX4TxbZWC0EHyATv3CmzxIDXev0qQ+EuQulgHtIManzZpwoUNwYhSghuk1JXWajNMsqB/1RxUuW7vBOTBDgRv0gaEtYldldmmV4Niwfst9G0Uz7Ej52C0TfCLQLsxh2b38yjVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uugeayV9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uugeayV9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BB30C4CEEA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963447;
	bh=hnQ7WNQ0zlCxHWl3QVobhbLUwXojKEWjrb184F3entw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uugeayV9ou7cQDXHIUxWx7bRKE0NSgD46choX4ifZRUgZ3LfAWKPUbu6lbxr1mTOX
	 l9YKv7Bl87FEGiWfhH5s+xZ+ONE7XvcRslACZBFFpEU54tEv5by28kssQCyKOQJ7af
	 /r+pKMo8kesuU1wOZFv1HWXvzCSRGzh4qpEIh6scaDzuLBAAuSpCW+hbGy44Oqq1MV
	 pwOiBP2hXuzuOk0huhUUo1qUuNjqNVzW+AvLi8ZgR8y9JiHEXV2bCp0DZvq97O7kFP
	 +/1R5hctRsDhUnCvqDIp3Ur9qUAwtutYPTZGWLTjaKTvVgOMbbD52FjNQYFxOHe6e7
	 +4j9mqZXRcNWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 452EFC41616; Fri,  7 Feb 2025 21:24:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Fri, 07 Feb 2025 21:24:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: med.medin.2014@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219514-62941-DECVI7imAP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #16 from med medin (med.medin.2014@gmail.com) ---
Created attachment 307586
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307586&action=3Dedit
log waking from hibernation

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
