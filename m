Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70320F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXUA7rWP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 259F9C433C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700102578;
	bh=RyKScIAL2sV0xk+7zmetKfER75N7G/84jPm7nLczib0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mXUA7rWPO+vmiyiFZYwRs//CsYH2dHg0U+Ui2lqn2CcBV2BTTvj9dY8HZZiZNOU7N
	 4OQeJNHJoas/o/dlEBzxUtt9P6X0p9LNPdfBdiIORPfr2yzV15/R+V7XnUwC+y8QsB
	 tMzVJo4faCfz9kclOg/wVvudceZAoDU2MqskZC1Rb7xSM2u2uEaPIVHF1+85MIpU3P
	 ScalKhzHqurnfflCnRV9PqO0wsqQLTF2YitvIOmT0nx22f6dr1dYFfSf4XDko9aeM8
	 fYOwSuvZExsZgQ67ppEUqtQAvMi+O59PuueGWvWc8LVSFOkDcnGko93sFj8E739A6f
	 afwaOqRpPd0DQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0EE92C53BC6; Thu, 16 Nov 2023 02:42:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] Bluetooth: Erratic HCI_Command_Status without Inquiry
Date: Thu, 16 Nov 2023 02:42:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sy2239101@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218151-62941-jeJu71Mxbv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218151-62941@https.bugzilla.kernel.org/>
References: <bug-218151-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218151

Si-Jie Bai (sy2239101@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |baijiaju1990@gmail.com,
                   |                            |sy2239101@buaa.edu.cn

--- Comment #1 from Si-Jie Bai (sy2239101@buaa.edu.cn) ---
(In reply to Si-Jie Bai from comment #0)
> Created attachment 305410 [details]
> wireshark screenshot
>=20
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in
> Linux 6.2:
>=20
> According to the core specification v5.4, the HCI_Inquiry command triggers
> the BR/EDR Controller to enter Inquiry Mode, a process used for discoveri=
ng
> nearby BR/EDR Controllers. Furthermore, it is specified that an
> HCI_Command_Status event should be sent to the Host when the BR/EDR
> Controller has started the Inquiry process.
>=20
> In our testing, if a related HCI_Command_Status event is sent by the
> controller without a preceding HCI_Inquiry command from the host, this co=
uld
> lead to a failure in establishing Bluetooth connections.
>=20
> Through our examination and debugging of the Linux 6.2 source code, we ha=
ve
> identified the underlying cause of the observed phenomenon:
>=20
> (1.1) When the HCI_Command_Status event related to the HCI_Inquiry command
> is received, the function hci_cs_inquiry (/net/bluetooth/hci_event.c:2289)
> is called.
>=20
> (1.2) This leads to the execution of set_bit(HCI_INQUIRY, &hdev->flags);
> (/net/bluetooth/hci_event.c:2298).
>=20
> (2.1) Upon initiating an ACL connection for the first time, the function
> hci_acl_create_connection (/net/bluetooth/hci_conn.c:212) is called.
>=20
> (2.2) The result of test_bit(HCI_INQUIRY, &hdev->flags)
> (/net/bluetooth/hci_conn.c:228) being true causes the connection's state =
to
> change to BT_CONNECT2, and the HCI_Inquiry_Cancel command is sent.
>=20
> (3.1) When the HCI_Command_Complete event related to the HCI_Inquiry_Canc=
el
> command is received, the function hci_cc_inquiry_cancel
> (/net/bluetooth/hci_event.c:84) is called.
>=20
> (3.2) The Status field of the HCI_Command_Complete event being 0x0c resul=
ts
> in the execution of return rp->status; (/net/bluetooth/hci_event.c:104).
>=20
> (4.1) A timeout triggers hci_conn_timeout (/net/bluetooth/hci_conn.c:638),
> which in turn calls hci_abort_conn (/net/bluetooth/hci_conn.c:2771).
>=20
> (4.2) This leads to the execution of case BT_CONNECT2:
> (/net/bluetooth/hci_conn.c:2771), where the HCI_Reject_Connection_Request
> command is sent.=20
>=20
> We are not sure whether this is a semantic bug or implementation feature =
in
> the Linux kernel. Any feedback would be appreciated, thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
