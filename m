Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F817984
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034515; cv=none; b=Yo5BTeXZ4wjCUtf5AQObFnsuOuCIpbWkNKU22sbB91TCdKOqTbNTmf+3bkegmqDQCTFDeBPTwRu8RkAMSlnjGNy1GJ+EJbApUHelnRye7CTvqDyREQMhumaLKMtkDet+t4ykbtGUzSyYgZcarE2OxP5UFHBa6CpyGVKLCCX94mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034515; c=relaxed/simple;
	bh=aOCQmCdwcPCThGAlVBH7PzmkLi1bKPDoydzl9ujBk+8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cSj6SHKGs2uJnDGIJEUnaOcCp8YNHeSmVHSxvlsORIJKXTFgcEkDdf8ZpEedRowX7PWNUf1VXbtl3Wq1RWd6149ObJIfx1RBeVeP+o1bEmBIZCUps8Jw2kz17QpoOo5CYaB991R52EBn5mVBL9zoAeJochneNqcopbiZNzhTGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPNgQEC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPNgQEC3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47849C4AF08
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 02:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034515;
	bh=aOCQmCdwcPCThGAlVBH7PzmkLi1bKPDoydzl9ujBk+8=;
	h=From:To:Subject:Date:From;
	b=sPNgQEC3fo5CH5tPNQbQjvbhDgrpPOb/h/bCF+Xu0vXqtjlv5t4z3lFsRa0atXzte
	 4EGbeZBTC6nUxWTHemAXvL8KTgeObKvv3pWmnzjg4ZTTKhGHStubxFNo1A5CdWesWx
	 ojn/Qz1Y+Qc0S0/pjOvaIGO6yLmX2iRI4XtISJh5CYzYUbD9p8fR1tPrU3SmAk3WQo
	 UV+pYbEOcmqnL06vhiO0H5oqn0tpKVthYcZbQEJ0f/0ef5ERIvuxr9HHC33KCco8vr
	 BgIQsxo6nco0y//egRJysb1iv74wqORFgH7MPH4I67aouEYoEuDPVFHX73QCAevgiI
	 40yfRlTQoj2sQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3CD22C53BB0; Thu, 30 May 2024 02:01:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218914] New: Missing HCI event REMOTE_NAME Causing Subsequent
 Bluetooth Connection Failures
Date: Thu, 30 May 2024 02:01:54 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression
Message-ID: <bug-218914-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218914

            Bug ID: 218914
           Summary: Missing HCI event REMOTE_NAME Causing Subsequent
                    Bluetooth Connection Failures
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.7.9
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: yuxuanhu@buaa.edu.cn
                CC: baijiaju1990@gmail.com, johan.hedberg@gmail.com,
                    linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
                    marcel@holtmann.org
        Regression: No

Hi All,

We round a possible bug during 2 consecutive rounds of RFCOMM connections in
kernel 6.7.9:

(1) During the connection process, the host sends a HCI command REMOTE_NAME=
_REQ
to request the name of the remote device. Normally, the controller responds=
 to
it with a HCI event COMMAND_STATUS(REMOTE_NAME_REQ) and then sends a HCI ev=
ent
REMOTE_NAME containing the remote device's name.

(2) Upon receiving COMMAND_STATUS(REMOTE_NAME_REQ), function
hci_cmd_status_evt(net/bluetooth/hci_event.c:4356) is called, which in turn
invokes function handle_cmd_cnt_and_timer to clear the timer.

(3) Since the timer has been clear, the host indefinitely waits for the HCI
event REMOTE_NAME. If the controller fails to send this packet, the only
recourse is for the user to manually terminate the connection process.

(4.1) Because the connection state is only set to CONNECTED upon receiving =
the
HCI event REMOTE_NAME (hci_remote_name_evt
->hci_check_pending_name->mgmt_device_connected), the remote device remains
unconnected in (3).

(4.2) We tried to reconnect for multiple times, but host is unable to send =
the
HCI command CREATE_CONNECTION, resulting in subsequent failures to establis=
h a
connection with the device.

We believe it might be necessary to set a timeout while waiting for the HCI
event REMOTE_NAME.

Thank you for reading this. Appreciating for any possible reply.

Attachment 1: Log file containing HCI packet contents.
Attachment 2: ftrace records of bluetooth and rfcomm modules.

Best Wishes,
Yuxuan Hu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
