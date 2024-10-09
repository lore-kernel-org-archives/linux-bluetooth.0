Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCE1E0E18
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497664; cv=none; b=edMbZ7V5Uzq0tEjp27ijklKs535W2DIr0uX2rafH1M32jbjlliSZN5p89OkaVWsN4/QsWtc3IXXrnMCKCRRYSOIFK+oVw1pspe4fYVN8X0h1iqcxE6/n1xcIiIHT3d3x7zVxuFbpPQsJSycy88FjC+xTKHEQqpIjDkKnoddXhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497664; c=relaxed/simple;
	bh=3QV8t10h6XvReGaW62ucRikvHmIOuwVUIjfNwLEUSco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtWHE3dhqOi4YYL+AJOW1kychCF2jT0UBmM0CuzUaewBwR+mARyruVZqX7BVWwzGdU7Jo0bnlZoXSEHxB+BYZbWHd4f2Sy4pInyFjeI830VCcg3CK+/YNU9z7P98nefEYVxwyfHyUCAWQES+hywgzr9VIbuRQrFtCtPGROAjTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BomFLItj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BomFLItj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D692C4CECC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497664;
	bh=3QV8t10h6XvReGaW62ucRikvHmIOuwVUIjfNwLEUSco=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BomFLItjvii5IgSDPBYxdLvH7MyOrfbvlP1UNTcRhoc6tmnGjS/fya5MVhl+aZUmY
	 R5AKSAS5Fnv9Ky1E8GaVH3FsnfUQa8qE7yirW/izK80OD+D7OaiM15tt7ASU+1AUCT
	 gAcC6yvpsPaOTHTxuXiuRHvKnxXtOupepQRBr5uUexQ7slEC2qLiRlmizzC5ZClSem
	 4c/Tye/mEDY5kIWpp73cuP+zT4aFwV0yr1TRKfYs23H9IviM3AU2HhBk01qQHTZRRR
	 6SvsTGSi2tB8brdfIGsDxeGcc2ArljUB29qVb5VSGccC9SauvhrY/4CxNnCFuwFmyP
	 1phngh+9rf+DQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF0F9C53BC7; Wed,  9 Oct 2024 18:14:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 18:14:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219365-62941-cN3DiP5KFV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #4 from Adilson Dantas (adilson@adilson.net.br) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #3)
> Thx for the bisection. As Paul mentioned earlier: "It=E2=80=99d be also g=
ood to
> know, if it works with current Linux master branch, or 6.12-rc2." I'd say
> it's not only "good to know", it's requires, as that determines whom we n=
eed
> to contact.

I also tested with 6.12-rc2 and it is affected by this regression.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
