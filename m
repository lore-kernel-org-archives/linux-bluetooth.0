Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFE41776
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMDgAh1o"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D16C433C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702568127;
	bh=Clj3R2LTWdfjRiwfpu+vxfaph/m6t8r1fCpnF/LY2u4=;
	h=From:To:Subject:Date:From;
	b=EMDgAh1o6ST9FTqrmjxDzRCVLra9A6pAly7EJE63r/vPVTGPs8yGduKCB622pQ+XL
	 PUUFuVAPxz0c+PtdFQzxgXXo6gfN3flyZe4sj1HnjDG+RMRV+eW72bXOxrkQZUIcj9
	 pwVzjcX4gh9SwKStNUYaFo/4hnFvrttc7iTgCsCccvmR7GKlkiJoUb1RY4lXA2XxrD
	 OrNM49wdtiIgfSvrMIK76vuNgcUoLvAGU0vVI1wIMr8N4TdfEu5p8/qtKxGS7IIQzY
	 jeURdBornNGIIaHJepPR7YM553XghYe9YYLWAOE+EKQAzJCWE8ksljUlN4UHEXjDOl
	 KhEeqEk0QgNJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 21D20C4332E; Thu, 14 Dec 2023 15:35:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218264] New: Potential kernel regression with bluetooth pairing
 on specific radios
Date: Thu, 14 Dec 2023 15:35:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218264-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218264

            Bug ID: 218264
           Summary: Potential kernel regression with bluetooth pairing on
                    specific radios
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: marco.rodolfi@tuta.io
        Regression: No

I had a Logitech K480 paired with my Steam Deck (RTL8822CE) from a previous
successful pair on Linux 6.4.x/6.5.x, not sure on the specific version. Sin=
ce
Fedora updated to 6.6.x and I accidentally lost the pairing key I can't in =
no
way be able to associate. It connects fine but just fails with
bluez.authenticationfailure. I've opened a bug report in the bluez issues p=
age
https://github.com/bluez/bluez/issues/654 and after testing on another comp=
uter
with a different bluetooth radio (RTL8771) + kernel 6.6.5 and bluez 5.70 the
keyboard connected immediately and requiring me to insert the passcode
correctly. I'm writing this from this specific keyboard.

I'm still not sure if it's the kernel driver fault or bluez fault.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
