Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961353B6
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h54iQFlL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C9DC433C9
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Dec 2023 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701501199;
	bh=q1G+9ZcNspK44otS8XFNN13MkIU/IH+t/AgWyOnlubg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h54iQFlLZvLASo9JA50X6kdn75a5AS2t1Zw/Tq5K4V+IgAJaBGmMEFX2ru0V2KMOZ
	 /Le2w+4yXdMd63QvUnSq3tnmN4iPH/mE0vp8fu1WDWcd0TDnod5w2bbFiEQIIOBstG
	 gysIhgeVxQhecDyhxAq4q+8bzDnPF/cj/Lr3RwK5ZzdDq1styD5noVySJPiX43hUvo
	 /57XkG2thX4BiS8P7iwJuM5bUjOhw8/tDiKK2E9mGYGDMbNQCUgV+kc5k+KgZb/YZw
	 9plAosMoCdffgmSD1eb822p27zS+/DinlEneGUJRr+RCQ0wGETRvECEReDP0yfwy+K
	 hc3UNaR/h+7WQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 40DB0C53BD2; Sat,  2 Dec 2023 07:13:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218142] Bluetooth adapter fails to recognize on kernel
 5.15.0-88-generic
Date: Sat, 02 Dec 2023 07:13:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugs-a21@moonlit-rail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218142-62941-JvbaBKsat4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218142-62941@https.bugzilla.kernel.org/>
References: <bug-218142-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218142

--- Comment #3 from Kris Karas (bugs-a21@moonlit-rail.com) ---
I'm still not sure whether the bug I reported in comment 2, above, is the s=
ame
issue as reported by Zach (the OP).  But in my specific case, the culprit h=
as
been identified (via an 8-step kernel bisection) to the following:

-----------------------------------------------
commit 14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Date:   Thu Oct 19 13:29:19 2023 +0300

    xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

    [ Upstream commit 4baf1218150985ee3ab0a27220456a1f027ea0ac ]

    The AMD USB host controller (1022:43f7) isn't going into PCI D3 by defa=
ult
    without anything connected. This is because the policy that was introdu=
ced
    by commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on =
all
    xHC 1.2 or later devices") only covered 1.2 or later.
-----------------------------------------------

Interestingly, this bug is not about bluetooth per se, but rather the USB
hardware (XHCI) that handles communication with the bluetooth chipset.

It would be most helpful if the OP, Zach, could chime in here about the det=
ails
of his particular setup, so we can identify whether it might be this bug or
some other.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
