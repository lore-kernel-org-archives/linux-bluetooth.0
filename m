Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F6213E89
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310804; cv=none; b=f0vU+wbDyQ+IU3p1DpdEOd4URrUmn58HU08yWqdscsAwOajYl8gHcn7Fs9/PCCK8ztSEToNorTmy73/fTntQm4HHAP1Ivag0TLm2bIyBpxIa/EG3wCQfbrSgOhtk7o4cVvSInOuNIGIsiWx/fb9hUykWDkwYKXzgk7mxzGmXxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310804; c=relaxed/simple;
	bh=5OdvDVxDqv1UvqB4rTjRUL3//zR5e51zo//Nz587idU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSsb3Y0bCzTNkhztoEzS4rSlDNPXM0P7Zg4s0cd9/DLRHj7fYJ+NtPKbom5WirPKgqGZqxrDg9DCAsqwweFco/PctSSxw6aVMEkSAjwDMsbkjpGFVlkfAVUFwOeqbmBzAFy5ritumO96C5UanU1BoqnhZoYgDK1sBkihefDXA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Y0tWc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Y0tWc5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 815B4C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310804;
	bh=5OdvDVxDqv1UvqB4rTjRUL3//zR5e51zo//Nz587idU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i8Y0tWc5FLcdbouwqlISuR7lGMezHHzWzavl6qgqPD6i+QHJHzYy2Xu5J3KtkA21d
	 T/618hzc5EiZ22aUFWrgIL9nTlux/bLzzByjtieNZiaONfhwPq/I9O8HLcr2zicN5R
	 Z8G9GjC7VJO/Ay4JBGMZSLg1CrC0V28wl1plcFtsWPn3o+a2Ij5LzAa7eo/8mfZc/K
	 6nMGATE2OCAIYUoBRFxHpGAfIUep8hv2YYYxJaKBe8jlV76gtEtrJZ9YIelCIzyt47
	 rVkdFLTHMwBE/DvzM6ed5Q1xRq8Ne7aJ3rihDdv2oGFuTtYC+r3hvp0Ln2JvQ96gsk
	 wuKRwVkQPxDCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7587FC433E1; Mon, 27 Apr 2026 17:26:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221426] Intel AX211 Bluetooth hci0 hardware error 0x0c with
 HID/HOG failures on 6.19.14-zen
Date: Mon, 27 Apr 2026 17:26:44 +0000
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
Message-ID: <bug-221426-62941-ROVj4Ugbse@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221426-62941@https.bugzilla.kernel.org/>
References: <bug-221426-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221426

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #2 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for your report. Do you know if it=E2=80=99s a regression, that m=
eans, did it
work with earlier Linux versions?

What firmware is used?

The BlueZ issue template has some more commands helping to collect things
aiding in debugging.


[1]: https://github.com/bluez/bluez/tree/master/.github/ISSUE_TEMPLATE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
