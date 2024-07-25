Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3561FCE
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940738; cv=none; b=usHoKvHM1or2O/YPPq7oA9L3zKcNUKHNFoEsJBXZH7gMsP8nikvIOmzXsDqibl/V+hSYWD87rlkmQ3lZ6ESGlBufEVafHyLmSIPcTFTYpCnoMLBhiSVd09fTvSNHdQeGbNTaDyYgmMlmj4TmDQpChmKpJfjAMIXk/NECOYbtPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940738; c=relaxed/simple;
	bh=a/G0WZPxr51u1qh/JbrGOc5CIOS5fd4oEdKa5ewE9Rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=psIOvv/joRoArSdtMjigXQaGm42V8XzngLQuyyHo+49VJe5BXBZSWZ0P67YB+hQoKMVpUvzD4sNqHJbeOgpR/KiGGnMRQa3x2BMXuBquOaju9jU1957jZh8pvNGIDZUgCWSOagdT/Lp6FMz8jLp5IJRwqcekz3sLCAgd6ybK+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK0AiXBc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK0AiXBc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A02F1C4AF0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940737;
	bh=a/G0WZPxr51u1qh/JbrGOc5CIOS5fd4oEdKa5ewE9Rg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YK0AiXBcHd1NcMSXuPYh7RNsNxAyFHRS4YCNA28ZvtAz0ZL++Wz3HiNbSnQe1Eplg
	 9WPooVAr/9vt0guhXCigpwPKEWEboWImZG7hQ+kls+l3DYH0Lkgep2lS2C0etYpH3f
	 xIDy3oIpQG85v2YN4Y8QqTkcirSO8godWrhcivDE5Tt5XS6dyzKeN2RVexYT67t62x
	 hcYakOvlIY7anUpUTavBJ7npnf1waVLt/YnOhr8faX629j9N2YVTPibPxlhi/b8ta+
	 CTwEXeysXfogOMiPV7/jtOWvp+ov0iGiDq9R62vQqHvkKstEMMzsk2qjqfQWs/UO02
	 MtWpYS4zcRoSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 956E4C53BB7; Thu, 25 Jul 2024 20:52:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 20:52:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: eugene.shalygin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-OGdYJl5Vbz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #10 from Eugene Shalygin (eugene.shalygin@gmail.com) ---
(In reply to Luiz Von Dentz from comment #6)
> @Eugene please collect the btmon traces.

Please find the traces attached. The Samsung phone device is paired, the HTC
one is not.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
