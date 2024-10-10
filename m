Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD217C228
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529462; cv=none; b=WWnWpd8v8k/RUhBkA5iZOKVton8Zh5COjHsAkyZiGDOALBghbYCMolJkEYl9J3i71xrUgFYpwjwfzElXitEjUXkBpF9n8ODOny2AATofPx/5h6UqMuvEECLJ1BEESlVbPHKZqez2oA9x8b3DRbBCCDwqde7O3u+6VorSTDF0qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529462; c=relaxed/simple;
	bh=KTrgG8mKlHqN7nLrg/x8bh/+CfMUcg5oMTZTW9RAxfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBD4/TnRN+Muwa32rNTOtsElqCwkIg/oGDdB3+FbEDWCZteodX8Nc8t+X/Sel3rmPcI9/+gu0jTGoRl9MzwkaotVyKviAHsHkq/LBs6ySGGxh0fP8eWQ4y5x0evONp9J88F/TV33QIAJwSzStYrUJkvCXFoFfh6E7wBIMMB6LnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKtzkEcM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKtzkEcM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8787C4CECD
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 03:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529461;
	bh=KTrgG8mKlHqN7nLrg/x8bh/+CfMUcg5oMTZTW9RAxfc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CKtzkEcMrZlbD9jjVIT9SW7dogQr08E0x9a9Jm08TupKWS2irUAX2b+YaamXGgjF4
	 lx09xjF3Q+FP5OEYI+cwd9WecHO9FoSTIpDqIhid30/Zs58y9WLpnIvK7L8kopK7af
	 U8U8OntKx0UGFzIS3LhDhhN7JLEVOrI9BtrJIahUaTf0v/O5A7qiZXxzqe/dfplD/g
	 RNmjqxTmYbXm89R10bEwfy5dByunFjMAKGuhrlZA18d9ZOQfWDkthKrQuduZUfeJeB
	 /w+TjG1u8RgnIbEFVnvBYK8BVLVYsjrK2Y5k3HMVk5ylon/05puUhYBIGv9hHqhko9
	 U7BwDCJVACvmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A0F8DC53BCB; Thu, 10 Oct 2024 03:04:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Thu, 10 Oct 2024 03:04:21 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219365-62941-3qlGdx5F7x@https.bugzilla.kernel.org/>
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

--- Comment #7 from Adilson Dantas (adilson@adilson.net.br) ---
Created attachment 306997
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306997&action=3Dedit
Trace usbmon file from a kernel without the fault commit.

Trace usbmon file from a kernel without the fault commit.

My BT dongle works fine when it is plugged

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
