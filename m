Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660B6E2C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9OJj3qF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D91C433D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587260;
	bh=neUluy4zwVXl8ewxvCA5xlcu4F5jPWsene8Z8lenrC8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U9OJj3qFEJrxWTYMZyK3seW2ekYEmBVtFz8CZHGHLeOnfpvMa75QMo3SRbxN0BIMM
	 ezUHNlz/5WBv69OumEu6EpUkIwlP9yKqDxn7yCVNU9Q1E9d3smiuANIluKyGTGgYN6
	 Q3itlm7ynuLt6b6c+QxU9rdVZGe2st67hvqs1sVasCaYk4HeI071EKx4bjgSnBvZMc
	 vfm8p3Z4VxaQktQKFUUo2vy3lY4WLn6HEj4tHpcZ09Djm/MwH7DuHGODbLVSauDere
	 swmoOoI3iCtmJhiWr2/zKQTddxZgVHxBbPoVb5OZV/pfJlfUjnfIfvLjA7W0CLmA2A
	 AT/c9YGp1G94w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12DD2C53BD1; Thu, 14 Dec 2023 20:54:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date: Thu, 14 Dec 2023 20:54:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: queeup@zoho.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204589-62941-UqgDCBEare@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

--- Comment #17 from queeup (queeup@zoho.com) ---
Happy to report, my problem solved with Gnome 45.1 & Fedora 39. No disconne=
ct
or freeze with apple trackpad.



Fedora 39 Silverblue
Intel AX200 bluetooth
Apple Magic Trackpad V1 (05AC:030E)

```
$ uname -r
6.6.3-200.fc39.x86_64

$ rpm -qa iwlwifi*
iwlwifi-dvm-firmware-20231111-1.fc39.noarch
iwlwifi-mvm-firmware-20231111-1.fc39.noarch

```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
