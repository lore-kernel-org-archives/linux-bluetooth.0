Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871E18E02F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151602; cv=none; b=r9Aa/Fh1645o7tudWM05qqkaFlcujWxdR8IMvM827Ylq9AYGaChJIKO7YqBRzmhmlS7k8TOsIgWn/geqz/DiIJRwoTwddSmkDSLPtaqSXFZIXZEZ40RaDMW9pX76y5ZQDZ7SvwndQrMrGEbwCt5Bo5krflI8QcH5f6ZbDS3+zVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151602; c=relaxed/simple;
	bh=DmCTTqwnWlqRjBlWBw4AXfiJT9JQm5up34xBMBdc3F4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NM2EET+iQN6D5ecXw8hxCyPVjhB5q7wnT/lEF9MRt5pV9d5p9Toil2dRjMXTSkp79X9jXsV4+18y6tmVPLIZu8LP9VbRN6GI7Z4K6YYHTrs8wmr7Gia8SXTWbspjwVWoinlX9knFzrBoGc75fQAGaYJBAsb9a16nq3nrE5pc430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4qNk2nO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4qNk2nO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D011EC4AF0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724151601;
	bh=DmCTTqwnWlqRjBlWBw4AXfiJT9JQm5up34xBMBdc3F4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f4qNk2nO9DoqOjp8mTHOJ4hg9oQOLu0sJrp+qoJGH4FunitLixJkBafRkwSRzRwg5
	 4z8PSmrElE9lQJQtpygqRbczlVOQVS5OQf6xDELeemCOnKawuoPwKQ0odPiwKMjruI
	 twzy90/6ImsHIZ0ux4jkdsHqLhNRVwOEXNIfHA+oTXaXGu7FjpUH8R/tG5VZECFeI+
	 NNLiedh92GRtR+lMSGwMJRnOvLy+D/1GbSgRBUBXRQoSO7Uc7jGiVLMhQgY+QSMyg9
	 r+3X1npPtaLHXkOQhgYELt9Joehh4+u9JFUSxGy6gZRfm2lH2eJx4xSwKZriT6a9xv
	 l+X6/Z49x23hw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3D6EC53B50; Tue, 20 Aug 2024 11:00:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219182] MT7925 new USBID 13d3:3608
Date: Tue, 20 Aug 2024 11:00:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-219182-62941-nZACw4IKxo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219182-62941@https.bugzilla.kernel.org/>
References: <bug-219182-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219182

Pavel (pavel@noa-labs.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #306759|0                           |1
        is obsolete|                            |

--- Comment #2 from Pavel (pavel@noa-labs.com) ---
Created attachment 306760
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306760&action=3Dedit
Patch to add new USBID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
