Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0191AA1C8
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387459; cv=none; b=Lbs+F+P3cBYHr/V2EppR3nQ3hABY5RyzhTK3lLA0Rs6TKsdm4GSfLxX145bKqmAsmUTOZ+0xnvromUJG411jRrVDgQfZ5tYzFM17+6vH4en/q1UiscYEKfhav1VHt4bKSlD81P3phhibbENPtm7LqSG/VyvFAqrf+OSYcEcYJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387459; c=relaxed/simple;
	bh=kZafl7Qaq7fCDW6L9BG43s4NLrwOm8J1s7vld8Itv/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUZJ4UDI0w5hcYixRnhofsW402KM3d03Hp4gSmTLB6Kzw4ePzHCax0CQyQGA0NTqiwBefuxZnJdiARg4z/Ug7sbirOwuFz6JoiDb9+MThhpfFDcOB90x6NiyolUOpI+HWD+QYvZQSwh4I2gTajAB0qUH1mY0E3KGajXXiw0Cpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON4pyEef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON4pyEef"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC9FC4CEE9
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742387458;
	bh=kZafl7Qaq7fCDW6L9BG43s4NLrwOm8J1s7vld8Itv/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ON4pyEef9Ynopt64RgaM07AST+waLCTE5n9z6ZKK69mrCipwlUnngS1/aIOfMsAgB
	 kK2tSvbm36Gd1YZvDyAbaOsmHfCJ1N8SQDXrtH+8T1eb5t31gcl4eFPS6FGedJ8KBH
	 6v6o20DeBDsSIoP4OODuB6aeYbMN6dKBka4qLMOwCezwQfnAc5ryM8s89ZhjZpKo1f
	 fPxOYQoxZJAJwaCNkeMQAcbVhVDl/+t9yVD4v/oXp2YgBvXo2kHBxz0XNTw5ZrHhxu
	 ayi20cM3u9hidF1rcIOZSkLIUrRfOf2OMWkduR5rNZjNr7SdIOCddLNZy/1k5Ew18v
	 6Y/hxlnAX0OuA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1840C4160E; Wed, 19 Mar 2025 12:30:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219894] Bluetooth Qualcomm WCN785x - Input/output error
Date: Wed, 19 Mar 2025 12:30:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219894-62941-NwN1MWQLUJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219894-62941@https.bugzilla.kernel.org/>
References: <bug-219894-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219894

--- Comment #1 from Gurenko Alex (agurenko@protonmail.com) ---
So, I seems to workaround the problem by passing bluetooth device into the
Windows 11 VM and installing driver
(https://download.msi.com/dvr_exe/mb/qualcomm_ncm865_bt.zip) for what is
written as Qualcomm NCM865 (WCN785x is probably a WiFi part?)

Is it probably a missing firmware (dfu files in the package) and now it's u=
sing
the one windows loaded?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
