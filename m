Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF97E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddVIUWYA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44650C433C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Nov 2023 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700101326;
	bh=Z8ZYi3bt5NeuPtEK8FTdzCbVhBXj9amp68qmalUNT/s=;
	h=From:To:Subject:Date:From;
	b=ddVIUWYAQrAIWBhCjRbFdgnXenpCEJirR9KOzSmmuwA9RA0h0ihOgqcp8cBxV+NNc
	 UxArGxey652aOnLPEacyY5EyrsCVB/NMzMYWCNf32o9Rk1cB7yztYjMtofS0CEeMRx
	 O5kzvaGnmWHvzxQ5rG0cCXUjk0ZMH+lGQqLr5UpoGNPDFGsraGlJUg1t9d4iFZvFv+
	 8r3cxPbZpeOrm5pSCniPjPwb/qCgkWYp0A4pXIQmk3pd6fZ/vBiIWF3FPmVIOPHoFO
	 /KMgQk2okhtZA0Mo4K4mo+W6x/bVwwoVK7H8j+rytwBQOqHJ9qIKqg/yHaW3EylD39
	 +ZEf9KwP4Lihw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D747C4332E; Thu, 16 Nov 2023 02:22:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218151] New: Bluetooth: Erratic HCI_Command_Status without
 Inquiry
Date: Thu, 16 Nov 2023 02:22:05 +0000
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
 cf_regression attachments.created
Message-ID: <bug-218151-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 218151
           Summary: Bluetooth: Erratic HCI_Command_Status without Inquiry
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

Created attachment 305410
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305410&action=3Dedit
wireshark screenshot

Our fuzzing tool finds a possible semantic bug in the Bluetooth system in L=
inux
6.2:

According to the core specification v5.4, the HCI_Inquiry command triggers =
the
BR/EDR Controller to enter Inquiry Mode, a process used for discovering nea=
rby
BR/EDR Controllers. Furthermore, it is specified that an HCI_Command_Status
event should be sent to the Host when the BR/EDR Controller has started the
Inquiry process.

In our testing, if a related HCI_Command_Status event is sent by the contro=
ller
without a preceding HCI_Inquiry command from the host, this could lead to a
failure in establishing Bluetooth connections.

Through our examination and debugging of the Linux 6.2 source code, we have
identified the underlying cause of the observed phenomenon:

(1.1) When the HCI_Command_Status event related to the HCI_Inquiry command =
is
received, the function hci_cs_inquiry (/net/bluetooth/hci_event.c:2289) is
called.

(1.2) This leads to the execution of set_bit(HCI_INQUIRY, &hdev->flags);
(/net/bluetooth/hci_event.c:2298).

(2.1) Upon initiating an ACL connection for the first time, the function
hci_acl_create_connection (/net/bluetooth/hci_conn.c:212) is called.

(2.2) The result of test_bit(HCI_INQUIRY, &hdev->flags)
(/net/bluetooth/hci_conn.c:228) being true causes the connection's state to
change to BT_CONNECT2, and the HCI_Inquiry_Cancel command is sent.

(3.1) When the HCI_Command_Complete event related to the HCI_Inquiry_Cancel
command is received, the function hci_cc_inquiry_cancel
(/net/bluetooth/hci_event.c:84) is called.

(3.2) The Status field of the HCI_Command_Complete event being 0x0c results=
 in
the execution of return rp->status; (/net/bluetooth/hci_event.c:104).

(4.1) A timeout triggers hci_conn_timeout (/net/bluetooth/hci_conn.c:638),
which in turn calls hci_abort_conn (/net/bluetooth/hci_conn.c:2771).

(4.2) This leads to the execution of case BT_CONNECT2:
(/net/bluetooth/hci_conn.c:2771), where the HCI_Reject_Connection_Request
command is sent.=20

We are not sure whether this is a semantic bug or implementation feature in=
 the
Linux kernel. Any feedback would be appreciated, thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
