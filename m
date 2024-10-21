Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB5173
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536318; cv=none; b=QoPRpUVIVS7QpY10jlzMuk4sIUA6a5VV91mVXaA9SDlBtCHSv/xDTCh3j1QmIrysDQzRLt6nXw2/ZH9J4BG7wkSsakuhljVk/bpzvsv3ItFoSuMzgYjBUnMdCJZhXcwO+btC+1EjiVIgDw4vCsWZuqddGDBLuKyvZKnkW4hnG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536318; c=relaxed/simple;
	bh=5tXVoezfznoWWAbpYCyGSl+UmtNvDRmszBpeLF6pD+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBwEHyiw828j7Pekk+R6iAXh3gKv1Tt8hemmzHova+CuINbK9Yp5jFX+oWd7N5GaoYGLPdi1AxibLwe1wU9AZutCv7/PgfNNwoECGa/BIzIQslaJU7RnQW7NR9vVqEjC5hRiY23w9pEFMeyg44ZKH1HmGK2yChS00IVBhpYzEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVPr/g5r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVPr/g5r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1DAC4CEC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729536318;
	bh=5tXVoezfznoWWAbpYCyGSl+UmtNvDRmszBpeLF6pD+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qVPr/g5rmtkwWsvUAPW55qckwTc5jJNvLuJjj0QovqF6k1sRbJICYMTqsB22BTAP+
	 3sShZ/7BX8kz7Q0eXr9eR962utVZoVUJC2nLaQzHT8GJt+3YF+/6MsQFJgkzOWF/KC
	 RtX8zWYXKnWGFT+S6WErysuastHjy5aIVS/jD+GAkTGFx+nSF3npCiNuniJqt7DYah
	 ruu3Y3IzkAEaN8HcrjGn7N/UrAn5GukSEGZ6L1k5li2qV8lT77QuMT9PxZzRDalqC/
	 k1zDPfPvihN5BRN20mU43DDgt7iuPOTlo4WGfYfJ6+ngqDc0ACxTBpFiXCZYVmW40c
	 8zH1pJTD+3m0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A545C53BBF; Mon, 21 Oct 2024 18:45:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219410] Need help with Product: CSR8510 A10
Date: Mon, 21 Oct 2024 18:45:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hhsnakeg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219410-62941-twSMieMkM4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219410-62941@https.bugzilla.kernel.org/>
References: <bug-219410-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219410

--- Comment #1 from hhsnake (hhsnakeg@gmail.com) ---
Added output  cat /sys/kernel/debug/usb/devices

T:  Bus=3D05 Lev=3D02 Prnt=3D03 Port=3D00 Cnt=3D01 Dev#=3D 17 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D25.20
S:  Product=3DCSR8510 A10
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D02(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
