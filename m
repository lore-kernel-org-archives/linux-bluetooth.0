Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BE246BD5
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765138017; cv=none; b=ITRsIzGcT0Kj3NFzfyk7UPTp2wWenpqyTB5TzyhPIoUtgYnJbVTMQNDg++rPb70zogQ5jyE8+wEoql0mlPf5yB9P6KdDPxL5i1D5VnfJO4K8NivNKXTaMXI/1B7G9etg93uohGhB3NgLReoJlWj1dd6HIpuZn/zu24MabhG9+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765138017; c=relaxed/simple;
	bh=wx4b+wDfQruSFtpfY8MhyEQ4jozMbFE+qgN0s6hV0FQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgGN2laOt0/+INATdmEl7xaocsfxr265GZuDFUGn2a8rAcx7xRm9JLZN9i+7kuKqCDLxp6FKlx+Po03U3RSBsWXqRzV3yXcdP7S+0BaNFNixtmzuQB5jhmEgqtkGULLKUCyuX9SEhKJZUSGRpHv2k8sbAtH+tdBgvhObBQGbKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP0+vQJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP0+vQJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D52CC116B1
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765138017;
	bh=wx4b+wDfQruSFtpfY8MhyEQ4jozMbFE+qgN0s6hV0FQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KP0+vQJQ2EDQ9NYzH2yXEGzqD1mx940OYl7BtTmgmji+NK6vkzh1onQY4WJtk7tv+
	 KA2uILemkFCC3JXtrEftx4UOZ9HOwNcvf74HmuKH2+1wM2/u44jfv4br1Ocuz98IN7
	 vy7aJJHn6HB60wEjr06p74Fu2JZYhNNxVuSYLEp7/ahTNmYK9j1p2Xn6Zudzi8F0Bg
	 0N/qJjdpMySqhVPlcZ0S9RpGJDzgsdQ2nUhbG2mi38ieOR8aVD4raMoLOa7TlpeYTt
	 H71t4SoYSWmEBIsAYwiHmkXpwt9+P3VPBv3UQy27DJnkbBJpSD2LG2rdT59iwc8n00
	 27emEP5PZEYJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1FBE7C53BC5; Sun,  7 Dec 2025 20:06:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220815] btusb: Add Realtek RTL8852CE device ID (13d3:3612)
Date: Sun, 07 Dec 2025 20:06:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: azureller1@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220815-62941-r1lh0Bzkwl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220815-62941@https.bugzilla.kernel.org/>
References: <bug-220815-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220815

--- Comment #4 from azureller1@gmail.com ---
Here that is.

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D13d3 ProdID=3D3612 Rev=3D 0.00
S:  Manufacturer=3DRealtek
S:  Product=3DBluetooth Radio
S:  SerialNumber=3D00e04c000001
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
