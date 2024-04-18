Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590EA7B3FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430015; cv=none; b=sPyHSwUEfbi5dWud/pAd6c25EPBk1W/iFCaESjmhAB+MnseROzbUn7UKMqWdqypXX9YxT7SKTdzu8uKYeMDYdfMVdj0abt1oF0c9/FAggC8CsR13i6UMz2CdMFlIKrtsyPAFCid6Al7j75P7Kb/OQCcEexwPKscI+i2NkpQOa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430015; c=relaxed/simple;
	bh=0pITwLoEhrS10PU1bp2frMN4CLJJKV3hQxrE/48LIeM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joO+rN7CqXv2dTbD48OgDlOS6OYtYginEMWQrW4Y4FnnHu9lpo+e8FddZdJjEhhtyPrqHTdmHWZqR4CLGmccRgHzD/9yfPJtAd+THPw3V0KEepFqPEi+ftG17T2mT1a+/RsEH4amGIxvx9Fr8hRt93J4ZyAUKKnssVFaKCrz2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMyzxMoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMyzxMoG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D727AC3277B
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713430014;
	bh=0pITwLoEhrS10PU1bp2frMN4CLJJKV3hQxrE/48LIeM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LMyzxMoGJQNzck+5iI3EHlV+kWKEVgzLtdX+NMghdOOeo7eOPGNRJmiJmAQg31cke
	 peHQrfSgo4kdnXYNCNI2Pn4D3GLp9MiYsawldd5hM9+mFJNIXxaYWm/THDY/24EkHw
	 CjW3y4DKA/tRD4sjc6+i69M/QXBHJn1UdJ+jgcHdeTw2JnCkdkzMLdFuziiiPunAtI
	 5Nl7i8McZlPxMDP4QpGBMkMQsw4gdWNCaBH/azl5YYW5S9QhfkLoczCWdFPf0PbPxW
	 R6A1qjoxszBCK5o6QfQuxp7SX5XtxKcas+8HP8s9uhpY4kIHAs7JLTRElKZouJkVHi
	 a8Xf7HxWhRZ5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C72B0C433E5; Thu, 18 Apr 2024 08:46:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 08:46:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218726-62941-pNCys9Eylx@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #43 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
> i also add your Signed-off-by for later updated patche serials [patch ser=
ies]
> for this issue.

Shouldn=E2=80=99t

> Tested-by: Wren Turkal <=E2=80=A6> # Dell XPS 13 9310 (QCA6390) with X BT=
 mouse

be the correct tag?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
