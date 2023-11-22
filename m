Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C671381
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCdidb9w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E433AC433C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700615163;
	bh=p4xmT8wYt7OgNzfygOj0z7FCVn403c7uNS28xDSA3yU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gCdidb9wh6BP0uPM8Lh3dHOu5DvifPaYo234racghQpPjRNVjUEXSTZziB+nuckyv
	 rXj6KxTue6S6cGXuT2zyPhMN0o/38Hzb10gKWqJn3AEhORbcWgLncR74kh9YD+4O8E
	 80uCgTmXLEw1KdF4CX5uDnlSGrdh7rMXDKMxgBxVHOxIpzmnlGmqOh1VJbJrEhjnZ5
	 3UKNAr/bcflYBkuUQ1bo2kYjjD2j2K2nkeo7EgKFoN7ZuIJy8MHMU+fbC4yXjk5t7r
	 g5ED9qy95ACGM2CUIEgIhguHPAHTm5mGYlp/izCm5EfW9figvWktJpo0kzkcVwLoHX
	 RlIJcAEuWrktA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1F15C53BD1; Wed, 22 Nov 2023 01:06:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Wed, 22 Nov 2023 01:06:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sy2239101@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218151-62941-IjoKJbiAWZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218151-62941@https.bugzilla.kernel.org/>
References: <bug-218151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218151

--- Comment #5 from Si-Jie Bai (sy2239101@buaa.edu.cn) ---
(In reply to Luiz Von Dentz from comment #3)
> https://patchwork.kernel.org/project/bluetooth/patch/20231120151039.32306=
8-1-
> luiz.dentz@gmail.com/

Thank you for your valuable input and feedback! I greatly appreciate your
response.

I have confirmed that the bug has been effectively resolved on the latest
mainline with this patch.

I sincerely appreciate your valuable input and solution once again. It has
greatly assisted us in the bug fixing process!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
