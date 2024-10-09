Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65068152E1C
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496409; cv=none; b=IeEuVbXLucNv07zcVNyUvx0Id/BKt9sAG7Q1DmSIMk5M9GOhxJsoBMWXFSRugaPTCQk/ZaK6nGVsihUzt6H3gkxAq/VRiqJWlSPyihx7zf5QbdMdoHKgZnWgnK7TyVjjCgcy83kxjuHNoUFn66Y4kNybOcZbtozV3frB19JIOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496409; c=relaxed/simple;
	bh=g4yq2IQZCDeawzaR+ZnWEmNfNCKeyCM9oGnrwXbLB+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b51Q7yfMa8eU+VfBYfVwQAbbSZWwVQ1ZeZmU4Pu6z1XJzNIsvaL3tujtLun7+uwB6rV7FsZjmhp4oJy3+B1IkU9Eljt6/VbW5Y6oY4QcZWQAZAQsRKmw++kfC4N9QX2WGmge4boF+AiJzuVzWfMrt3edxGNHtL8b8B/isbP9IMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juG90MSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juG90MSz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1347C4CECC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496405;
	bh=g4yq2IQZCDeawzaR+ZnWEmNfNCKeyCM9oGnrwXbLB+I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=juG90MSzTDWUIvC51VqVklnjgJtECQK0LKVk/4DLh6Mlh9j2J/C23m0+nKUMSPLiG
	 ejveALQyegcM4SvXsoCP+wkUKUV30ksQvj/D6DoFYivOcSCzv7NI99Gsnqq09gg1fV
	 lCSt97Ch3A+Rx/aXhO6A6FVB5o2d8QAKrGd+5qkyTFqTaHvIxhSAwl0AQ6jFpC09fn
	 ShE9O6qQpChpG+DeDm7/ym256mj5NVFbXnez6VHRT2k0XzTvafZ4RETTPoqMXq3RsV
	 c9a4isiXzmYdsctjH01hPCbQiH6jB7tVS8g5LADcyxXw1xu2IWqC7c6/vo+Ps9KiS6
	 pVzJ7kekMbHcw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D511BC53BC7; Wed,  9 Oct 2024 17:53:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 09 Oct 2024 17:53:25 +0000
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
Message-ID: <bug-219365-62941-jYIq6avIdi@https.bugzilla.kernel.org/>
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

--- Comment #2 from Adilson Dantas (adilson@adilson.net.br) ---
I tested each commit with 6.11.2 and 6.12-rc2 and I have isolated the
regression at commit 8603daa4300b84abb3c68e48f3b607d7d5a2a207=20


    Bluetooth: btusb: Fix not handling ZPL/short-transfer

    [ Upstream commit 7b05933340f4490ef5b09e84d644d12484b05fdf ]

Reverting this commit fix the regression on my BT dongle.


(In reply to Paul Menzel from comment #1)
> Thank you for your report, and great that you can build the Linux kernel
> yourself.
>=20
> > Maybe is one or all commits has caused the regression on my BT dongle
>=20
> It=E2=80=99d be great if you tested each of the three commits. (Normally,=
 `git
> bisect start -- drivers/bluetooth/btusb.c net/bluetooth/`, and then `git
> bisect good v6.11.1` and `git bisect bad v6.11.2`, would do that
> automatically.)
>=20
> If you already have git clone, then:
>=20
>     git remote add stable
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>     git fetch stable
>=20
> or, if you do not,
>=20
>     git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>=20
> Then
>=20
>     git reset --hard f68f72d04b60d3af36b63b888fe084966bca07b9
>=20
> build and test. If it does *not* work, it=E2=80=99s the fault commit.
>=20
> Then
>=20
>     git reset --hard 846a6fc7860119ee72737391856497b3fcf7c2b5
>=20
> If it does *not* work, it=E2=80=99s the fault commit.
>=20
> Then
>=20
>     git reset --hard 8603daa4300b84abb3c68e48f3b607d7d5a2a207
>=20
> If it does *not* work, it=E2=80=99s the fault commit.
>=20
> It=E2=80=99d be also good to know, if it works with current Linux master =
branch, or
> 6.12-rc2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
