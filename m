Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48615AD95
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430135; cv=none; b=LGachBKvlXtOYAxB9GtKmY/6UzL5msCH93dsyPF1fZ+mQbwTcRhjKH4EbEtYgT9Za8qQSOO896Nf6+AjFLLvy7Z+QB5RKoUVYbizgFi7uuIjQDE505rJJ+mCKdBxyuItKuoSVN+0Tc792nqXZ90SrjhQJbz1jL8krgkGBvkDh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430135; c=relaxed/simple;
	bh=NyrKhAGJ06/UcBeVB+yqA1iYSIkACx7lqJLcnXIoqTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhGvzb2HjhHRKVT29oDQbAKJ+RHHoT6fwU5wSOiz08wN17nqgtM6317qWK58lN4cLsT3wD/Ay987FdpsPkzeFCEj9km06Kfph2JJImrCNwnibzHVH9Mbuv/X1onTI1Vm7SOwAqDRCvyPFzoSkIp30pziwKt9QNYlW0jxpJydVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh9HwsS7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh9HwsS7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B657C32782
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713430135;
	bh=NyrKhAGJ06/UcBeVB+yqA1iYSIkACx7lqJLcnXIoqTM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Eh9HwsS7zzG7ct5vi2EjIvHHZFjt1fLg0Ie+aXNGBIl9FEArRalAOLZy9b0FN8jyU
	 S4Jf52CGZ1Jwih/h2CUieZzsR9sHBh6gF12l7mUi8BawsMDpM4lSv7/SlN+i6a60SQ
	 5yOVn27YyIDhDIYG1uboqBy2mDm1xqMUNzstINs9Ksz3RI5MIAXO7esMtjcPANrp+6
	 74izQRdQGIDhUKJHSad1LTRJczUex90oUXcLtFCEmiDxT5Vq60HalbJlwXHNMyddcG
	 UyjePwAwICJVmRTYiOjnByy39wrzKCdyrU7j4yNxC3PkYZU3R8iPEC+0FE4G+k4yeI
	 EI+7Huerjr2PA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2FDDFC433E3; Thu, 18 Apr 2024 08:48:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 08:48:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-tUnTFc5T07@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #44 from Wren Turkal (wt@penguintechs.org) ---
That sounds correct. Thanks for the correction. I really appreciate it, Pau=
l.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
