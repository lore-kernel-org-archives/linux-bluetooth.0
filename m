Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932F5733E
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386856; cv=none; b=IONQ5QLLL9ZD26URDgzmcQDUIucbb+VX55cwkMbzSJo3a3pgJKIvAFxXVLjJI6ToUsxUgscjANDNW7lba4Jt9mM/Edah2SpAhWsPVuuJg9zz+qyLfjy/BcLYqdU52tKaa19nuFmvtswEKfd89snORtOtZHexh1UjoN1rE/c87Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386856; c=relaxed/simple;
	bh=ez82zj8K8n0QYPZAQT5ddVV00LUS6SHTryUZ5RTQJ4A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcCxsv003jycayD0Ej5sKhWv/6Z8l64CxggD2g0PkWcGS8zacDyMToc+fOjVveUMKDUZQzh0zxTasWwt5oczwOPdDFijbaFkSIGufzhqkBKEVshyzmtF7b+3TfclgxmzTEz7xoCkCtGddkx+r3cACgMGKUXuCEBqD/gWcz7MNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZhNrXry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZhNrXry"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78C57C2BCB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784386855;
	bh=ez82zj8K8n0QYPZAQT5ddVV00LUS6SHTryUZ5RTQJ4A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qZhNrXryreeooX4xlCTaYS5sXpsSVXo5jil+mH7Hj+4VS/LmEv3X/pr6uJjQByOBn
	 z2rsX9JDMbkvxnkewFifRjWQc43tunY4uEy5kApRzLAbEdfS1P3arDjwoMNkW0+1Xv
	 oGGqf1hpCnMDg0zdAaLCB4D2b6YpElwnRJfpNM89aT6J1x8Bg4bCzOi6AJuP9Nuslr
	 RKlQ4TppZ/J933Ltjf6tGdxqfa+gvX+bp/it8q+c3TEayYFhAWj/iKQaWORl9y0IFi
	 YYpzoe1/4KG0O1j570Ayu65Z9V4QNzBjkeiWJPCJH/wIzGcoigVROBquwH+WxflWEn
	 ZaxLbnkZu3sLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 565CAC433E1; Sat, 18 Jul 2026 15:00:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE3MjBdIE91dGRhdGVkIEludGVsIEJUIGZpcm13YXJl?=
 =?UTF-8?B?IGlidC1ody0zNy43LjEwLWZ3LTEuMC4xLjJkLmQuYnNlcSAocGF0Y2ggMHgy?=
 =?UTF-8?B?NykgYnJlYWtzIGFsbCBIRlAvU0NPIGF1ZGlvIOKAlCBXaW5kb3dzIGRyaXZl?=
 =?UTF-8?B?ciBzaGlwcyB3b3JraW5nIHBhdGNoIDB4MmI=?=
Date: Sat, 18 Jul 2026 15:00:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: dev@fluid8.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221720-62941-VphKlgwo48@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221720-62941@https.bugzilla.kernel.org/>
References: <bug-221720-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221720

--- Comment #2 from dev@fluid8.de (dev@fluid8.de) ---
Created attachment 310476
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310476&action=3Dedit
install Intel Bluetooth legacy RAM-patch firmware

install-ibt-fw.sh =E2=80=94 install Intel Bluetooth legacy RAM-patch firmwa=
re.

Companion to extract-ibt-fw.py: takes the .bseq blobs that script carved ou=
t of
Intel's Windows driver and installs them so the Linux btintel driver picks =
them
up, on any reasonably current Linux distribution.

#   ./extract-ibt-fw.py --verify BT_21.10.1_64_Win8.1.exe out/
#   sudo ./install-ibt-fw.sh out/
#   # then power the machine fully off once

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
