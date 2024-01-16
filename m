Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE41CD03
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427856; cv=none; b=Ee6EhQM485bKQTrd1TxcUrEg4AHlJ7Is45Fn+1PME34+IE8eh36/Nf2Pj9SR4bemiigRGWORy56CnA2e4HdAhM/+RD2mHD71j8kUyTXSHJp6FxX8s+p1p/xHDmy/pUCdNT1B9aw+gLdnYWhnSgLbQFPBIj1oMK4vszuq3PfoTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427856; c=relaxed/simple;
	bh=TFtGhPGwRSYM1avqgl3pWSQecf6nKMb5cZVfgqHURu8=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=Tj97IBXaHZVD8uB06A6uoarbvttOB+gOIjPgcVMR0K4jcYSdm0jWN1d8mEetKiv3OjmFUg9+TpMnqrCFs7lLz+Sm5vJf4MG0gyorpYvpg5o6bvcWCl+wnKPXBxbOm9Jk2joWpj3ICkuKmdFcDQh5DPzXMrZAQG2rbI20IoSMe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQRA3mSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQRA3mSI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C1A7C43601
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705427855;
	bh=TFtGhPGwRSYM1avqgl3pWSQecf6nKMb5cZVfgqHURu8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XQRA3mSIIabLeQkJBACRDPHotX4oJhDRxpU2oD7I1GUR8TLZz1zkB0Z9o/r1MVvkD
	 Gg/wcoPwCb7vh0pNyJNm6e/cDeNsMUWcFwGUenGctlgtGBcIO4J848hHUK2oy1AWYt
	 rP+wD2atSTMqFhV8Co9dQTM+YxtL8EqzAY3hAe0hvDSJhlSZQcDuyoACWeglNz3iId
	 EhVsS7Xfnoj1pLlGEAaKlS+OAYOM7Asi5ezAB+AFEPcmhBTXYn3eIR1pE85dh7/vob
	 hj6+qkabVrwRQMdr8x1MBjANXuhJ5O96Bjbg+HuTik/urFzlkeqPajYUJI7iCwNQNV
	 1TEJpmiRj44rQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4C0C9C53BC6; Tue, 16 Jan 2024 17:57:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date: Tue, 16 Jan 2024 17:57:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ben.adler.hh@googlemail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-LlUhGiB6Nw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Ben Adler (ben.adler.hh@googlemail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ben.adler.hh@googlemail.com

--- Comment #55 from Ben Adler (ben.adler.hh@googlemail.com) ---
My AX200 based blueooth hasn't worked on my arch linux for a while (with the
same errors), but cannot say at which kernel version change exactly it brok=
e.
Just updated my arch linux to kernel

6.7.0-arch3-1 #1 SMP PREEMPT_DYNAMIC Sat, 13 Jan 2024 14:37:14 +0000 x86_64
GNU/Linux

and it's still broken. Inspired by Arjans answer, I downloaded
linux-firmware-20230323.gitbcdcfbcf from some ubuntu package, and did a

mv -i ibt-20-1-3.sfi ibt-20-0-3.sfi /lib/firmware/intel/

and it works again!

Here's the broken arch firmwares:
f22358f118acb67b26cb8cac8443e09a  ibt-20-0-3.sfi.zst
f22358f118acb67b26cb8cac8443e09a  ibt-20-1-3.sfi.zst

Here are the working ubuntu gitbcdcfbcf firmwares:
# md5sum ibt-20-1-3.sfi ibt-20-0-3.sfi
dda190be754f26625955b73f05fc2ba2  ibt-20-1-3.sfi
217eaf48a8a825b2f95fd49c241188f5  ibt-20-0-3.sfi

Hope this may help somebody.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
