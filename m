Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686217731
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DizBxZPi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB5FDC433C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159560;
	bh=HwD6aiXHjteXBerQlR8ISjWiG09yxl9Y/RqrWwTXaqo=;
	h=From:To:Subject:Date:From;
	b=DizBxZPi3Y1hkf0FOySfAH+tAOixla0GAzOt1afAPgcBAHRPs5YjVJ7YP3IHGYRsu
	 FmF8Q3OYlAVe90PG34esH1TTmVh5YHcm992QZZOTkc8/sIT1LtZHpnS93x4ZNOEqJD
	 FHt81g4mE/EcoyozGkBZihiKHUfZGdlAaHC8HucgFhZm6sJNkd1k5ahgQld0vDRGKA
	 N3Q8zGJASU6sgYmqPXFCbobyatuUsLboTCj/E9B0t5NBfhzPA7FU1EHQKhZe4uu1rp
	 Q2lu+57T/03k7dtvT+LA/Y73mmipNT/ksyGnPo0i8sNtBWB9BD7ghmQwyb1xuYq8Nw
	 JSM5WvQFxb5iA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A107FC4332E; Tue, 28 Nov 2023 08:19:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218199] New: Bluetooth: HCI_EV_REMOTE_EXT_FEATURES loss
 prevents connection abort
Date: Tue, 28 Nov 2023 08:19:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218199-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218199

            Bug ID: 218199
           Summary: Bluetooth: HCI_EV_REMOTE_EXT_FEATURES loss prevents
                    connection abort
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sy2239101@buaa.edu.cn
        Regression: No

Our fuzzing tool finds a possible semantic bug in the Bluetooth system in L=
inux
6.7-rc2:

When establishing a connection, the loss of HCI_EV_CONN_COMPLETE results in=
 a
connection failure, and the controller sends HCI_EV_DISCONN_COMPLETE to abo=
rt
the connection.

Even if HCI_EV_DISCONN_COMPLETE is lost, functions such as hci_conn_timeout
(/net/bluetooth/hci_conn.c: 612), hci_abort_conn (/net/bluetooth/hci_conn.c:
2960), and hci_abort_conn_sync (/net/bluetooth/hci_sync.c: 5379) ensure that
the connection is aborted.

However, in our testing, when both HCI_EV_REMOTE_EXT_FEATURES and
HCI_EV_DISCONN_COMPLETE are lost, it seems that hci_conn_timeout,
hci_abort_conn, and hci_abort_conn_sync are not invoked, leading to the
connection remaining un-aborted.

We are not sure whether this is a semantic bug or an implementation feature=
 in
the Linux kernel. Any feedback would be appreciated, thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
