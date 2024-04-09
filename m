Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66C131BAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675535; cv=none; b=P5gIvOegkcI8Wsgw/B6Me2jvXDJTmZ27Sfs5uPnIVnh+J12cwkZWmV/M3On36I8gwfeRdQseaev0OOXEqG5f5jVDMIcfuY9eHbIp9cNbDmMLPZxo4/YQWeuKZogo8wrawqLbwsq0i9PjmBNuYMaRlFH/gpfbMLYsYK8MI4EzFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675535; c=relaxed/simple;
	bh=D2NIyCWG51LcjQ2v3BubgMg2+tAcjaiyKMP5m8UgQIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okGLx9+cdZEaKGI139U9Xb01vyHq7RNNiLDoqQmlFDcEkPcUCk/DGzPHO3TI++jmRCsEcUeojnmPE99SWPkJn2RWV4vRF67RRocG9tCU8GmGqwoW3LxkFJtHTlkZ9D5v52I8RnMW+vRsFIBkdjHIWuFJYmNk4Fi+1E2s7OVNtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHQyQ6zO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHQyQ6zO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D4C1C433A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675534;
	bh=D2NIyCWG51LcjQ2v3BubgMg2+tAcjaiyKMP5m8UgQIs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JHQyQ6zOs5Q40hJvgQ7Sax8igEvIo7cE/uY0sDx4PwciB9Egi7TIoaYGTDm/jv54B
	 wOVStIF8d7DFUWnSUGRvaSsN26IAE5eZVngiVPIggCD6upUc4hY+oA0aq2lLM1Jd/L
	 ar+v6yq166cbObAnrdJYfkR5d4ZQWzjc/XpwezcZW6m7aRDHBubCYAnl1fKTbeTSSv
	 ceKkU03ml2RtXVTKH2tqfnVqXdTfV1xyI9WVv+PWyzMbAhytPxsfzngIrv1UXxe5X1
	 IxPEZZlt7EfcICq4u7KDlpq13/r9DJ1Bk3kQi14FJbp+kN4y6dKHLdb6L9kszCgDvY
	 wpwSTgfkEVw1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 746BEC53BDD; Tue,  9 Apr 2024 15:12:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Tue, 09 Apr 2024 15:12:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickolas@gupton.xyz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-IR25MMNKyC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #23 from Nickolas Gupton (nickolas@gupton.xyz) ---
Yeah, I turn my PC off every night. Have turned it on from a cold power off
every morning for the last year or so this hasn't been working. That doesn't
help at all, the only thing that works to get Bluetooth working after boot =
is
running the script I showed in a previous comment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
