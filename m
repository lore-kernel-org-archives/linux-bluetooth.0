Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6C194C6A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963358; cv=none; b=smklCgui14weKtf9l1HeuqCHPSNmd/1AUn06HH4cLiza+hpg+zFTAl4kLOKlZTBsonHo4Q7ELtX4nIQY+lIMJVpaC2s4ZzkhgX2ILMBXyQTVGk/suDQCBVqE02DYS5JJJOqdgA87MGwN1i7QDEdf4t1pMVaXOX8OBiDBczAaglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963358; c=relaxed/simple;
	bh=BaYXuiuWvtQJeOGjOiuHPJw6v/Bj727mK7CiEBpq+Ho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMNmw1yfsJXuafcDngkLyq5XV4es7loZPCu/9qldEqFbYNUcquMKzclJuovneCccXHBo3iEwT9pBX5EZncZ9Fyw5Vp1nI4uqnZXOW73o8zKxe+wwdCvWTSwNfCkG653so3PkSczNpag6sBs+UkAXRK+yzxKjR9UMm8+PO1gSboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YobASeO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YobASeO5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9884DC4CEEA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963357;
	bh=BaYXuiuWvtQJeOGjOiuHPJw6v/Bj727mK7CiEBpq+Ho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YobASeO5i0A+ImPkvkm2637h6nVg0ngB+2oO+hq+UB7lbTrxgx+3bBU2Yc5wLC9dr
	 h5DtBoCCSPnZTkoqQUkNI9voOVgZdYXBkWe0iOT346811qlljXROCJgRwJ6GOLrFcc
	 g7dwHZZ4wH6pNDYn8nP7u49MJN+arzWHfoCgwMlsflgJNlzkPB3emBLpWxPhp8nr+C
	 1H+79iCO7tEyZLCs+9UxnvCGiGHJDkFavekGczvzOxtN+cvjGFs5Ab5nRaOF3AIB+w
	 lhCysg/BWYwdIbQ5CbmXc+UGVTxDOq2bDc1qLUeYBjMNaJ6LCbcHUu4ZlPd+AbTD7C
	 JeYudWn5UHElA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9272AC41606; Fri,  7 Feb 2025 21:22:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Fri, 07 Feb 2025 21:22:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: med.medin.2014@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219514-62941-fAyjn2wAF7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

med medin (med.medin.2014@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |med.medin.2014@gmail.com

--- Comment #15 from med medin (med.medin.2014@gmail.com) ---
I'm having the same problem on my laptops using Intel iGPU, it always happe=
ns
during waking after I let my laptop for sometime to sleep then auto hiberna=
te,
this problem occurs with kernel 6.12 and also 6.11, for now I'm using 6.6 w=
hich
seems to be no affected.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
