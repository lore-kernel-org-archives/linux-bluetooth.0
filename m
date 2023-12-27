Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC945947
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkGab0Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC4A4C433CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703688880;
	bh=n6WKZFayuvWdTS3Y7xn8KMr18fY8emZsUcMszzJ9pvQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nkGab0Fl+RV8Ktvd3Ql1UiB0b41ZSX1EwaVK+zDlGuBw9PlbYqDwu1Msh/2tmsErm
	 3R4Dn66it0eSSxtQeFhadwPziSOU7+UcWFQpKl22DDctIrlROlz7U0QeJgfKnj41cD
	 yGD7NpuzJuMRe/NCv+GMDYaih4sb892H2kzZ+5H7lxqZq9eoVfdvEQ8GtQLNWrgH1v
	 VLgIrMqcaLMJoXRCZgLKLOM+KYPg0XiD9bD/X9GOT4CWqfomwg5WYFnayyPi0Cxebc
	 LrJkIHD/XlUTFMRugJSyGmDq6kZsK7OcfQY4YxvLPCBf/n1hlPLR+Wtnz5POBo4Vav
	 8K40aR57dHtyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AC30AC53BD0; Wed, 27 Dec 2023 14:54:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Wed, 27 Dec 2023 14:54:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mahdisalimikingmallo@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-70VuYieJSU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

mallo (mahdisalimikingmallo@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mahdisalimikingmallo@gmail.
                   |                            |com

--- Comment #276 from mallo (mahdisalimikingmallo@gmail.com) ---
Hello! I am experiencing this bug with kernel version 6.6.8-x64v1-xanmod1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
