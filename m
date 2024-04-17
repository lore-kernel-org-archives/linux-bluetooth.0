Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F64139F
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362230; cv=none; b=RNXJAaBz3Te5mAPYiqPpQ4x4VNxidYspXMmLC1T3+aVBxiTegGcY4wUiJdIZibdaldox5zEF8qE2JIMwSw+qrZHfV8TsSPGZgTzlQCNs0uEFZCYlOjOiGmvvzAMYSLdCwHzcF1EYKbFIMI2CQwKaWJpd6SQ95vkIH0hkpTzliRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362230; c=relaxed/simple;
	bh=FhH2z5r1TlqTdtbKlgr7bslJ8oFv8fVR26iAxCF7js4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIn4HqU/Y1kebcJ+sflukO98fmEQcl50M/SYDReynRiiIaAIEOLjphiFLZzBVF8q51tLfJBXG/Y2+AJsvXBvd9psbK9U3rX1+eOozESFE6fDWx4h8wBfIECJLncnHOdKCD/chAVl3RSS1IFsxcvaQ8ntN+ld/1j1ksSBmJ7Baqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEsrCint; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEsrCint"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F544C072AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713362230;
	bh=FhH2z5r1TlqTdtbKlgr7bslJ8oFv8fVR26iAxCF7js4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kEsrCintFOIkO5pl29HlJJs4YQc33cff9CmzZc4VTghA/2RWv8CdgDORQytnFyC3l
	 J9JZjjG3p0GlET6m7rx8Zgdee++JY2JIpJKLGT6o2f72bTFP+5Ce/5MiWFUZasJq/m
	 4IG28FnbxziuDZWSmJostoKntdSk3Y8aEMwhPpUwgmv8AjXO1bfRaVxCPUYVnPNEGE
	 IlKKFQUNsv8vbA3cKIVObEIbWzIOJArzQIOEB4PooQlrefYR6qLyTILyX7nG4G3EPd
	 A+BnPUy+6/yzS8JBTbs07hiBf3f29mswHfW5oTcLy4wPJGLhtTVboG2kCeI/9KeIk9
	 lX5XjZKT3et4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07542C433E3; Wed, 17 Apr 2024 13:57:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Wed, 17 Apr 2024 13:57:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-AQDcJVJ0Mq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #32 from Zijun Hu (quic_zijuhu@quicinc.com) ---
there are two issues as described below.

1) cold boot -> enable BT -> disable BT -> 2nd Enable BT -> 2nd Disable BT.=
...
BT can't be enabled for 2nd and later enabled operations.

this issue is caused by below commit. i have reverted it and submit a formal
below patch
https://patchwork.kernel.org/project/bluetooth/patch/1713354823-17826-1-git=
-send-email-quic_zijuhu@quicinc.com/

Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
gpiod_get_optional()")


2) cold boot (power off then power on) -> enable BT -> warm reboot after
disable BT or NOT -> enable is failed to be Enable after warm reboot.

let us explain the 2) issue we are checking as below:
your device does not have H/W reset way since BT reset pin is not configure=
d.
so=20
qca_serdev_shutdown() needs to send VSC EDL_RESET_REQ to make controller re=
turn
to initial clean state. the only reason for 2) happens is that EDL_RESET_RE=
Q is
not sent successfully during warm reset.
let me check it.

we can get logs for issue 2) by this way.
cold boot -> enable BT -> disable BT -> unload hci_uart.ko -> dmesg kernel =
log
to see if EDL_RESET_REQ was sent successfully.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
