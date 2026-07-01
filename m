Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B7423A78
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918559; cv=none; b=oqoywGufpCHzT865CdO3yVML0IalFLrjeWD6DYBLCS0zIyUBDi1tNRGdRqA9NUEwnhHbTQhBAJoSMfabEDq02QOmbMqlK+YnlDEZCFA4mcEQFm8lpysrBbARJVJSjc0aQYWQW0hiGYa+V2WbKavR2dG/O47QyzMflHzZzg8xidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918559; c=relaxed/simple;
	bh=tUhbqP/DU1xPpF4wqNoexxMOosLjOYJwC7VRnXVHvzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7VuCs9fSIKDnNvbNuLDNaaHR7gG00kPeSJC+NGx5ighdDXfIdmGA5Zlck2JCgA/MLAMfu4Vw3co/8w+Qw5GpBVdzeTIOrs3PoC24pCChu/A7s3mBsWwZvhRppkLEWCRYTn8kIclRbcbynPym8diTs32xGAIVaMVTlVerb7Dnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsckfCG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsckfCG2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F3F8C2BCC9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782918558;
	bh=tUhbqP/DU1xPpF4wqNoexxMOosLjOYJwC7VRnXVHvzs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qsckfCG2hLr4V5PxwVWLurrm6pqljz8qPX2L0V4SvrOV/CXvoYwcjrPJYkiZGlPu2
	 SO88F6D0A+R97dCLWzd7bWvdg/G6FYFmiAQ4b5vDtRrml0CfkItddZ+hln9xMaoCfE
	 ZW5rzQS2N7gjE1/b9zLlcued+DDF+4CpBeXvxwem/T1Qnkbb5tWzkNsaxbnvKqk0WC
	 n2+QQ5V9uujHt6U9XU3PjBVTB/JBMwPS8ufAfe99y42ANrMYnx7i9vcCUDG7WY2WqB
	 jsoeVr7rurpgcB/OxnT3jVY4YVOCRmfWO5WxDDK5XPpQvzBr+mvMfe0Ce49ip3lxWl
	 +tLcoeaNsZ8kQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5DC6DC53BBF; Wed,  1 Jul 2026 15:09:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 15:09:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robhogan@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-11iNnkhOy2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #13 from Rob Hogan (robhogan@gmail.com) ---
I'm pretty sure it's the same issue. Extract from syslog below:

Jul  1 16:01:49 mwenge kernel: [439779.598878] Bluetooth: hci0: ACL packet =
for
unknown connection handle 3837
Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:dev_disconnected()
Device F0:EF:86:C3:50:D8 disconnected, reason 1
Jul  1 16:02:08 mwenge bluetoothd[760091]:
src/adapter.c:adapter_remove_connection()
Jul  1 16:02:08 mwenge bluetoothd[760091]: plugins/policy.c:disconnect_cb()
reason 1
Jul  1 16:02:08 mwenge bluetoothd[760091]: plugins/policy.c:disconnect_cb()
Device /org/bluez/hci0/dev_F0_EF_86_C3_50_D8 identified for auto-reconnecti=
on
Jul  1 16:02:08 mwenge bluetoothd[760091]:
plugins/policy.c:reconnect_set_timer() attempt 1/7 1 seconds
Jul  1 16:02:08 mwenge bluetoothd[760091]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr F0:EF:86:C3:50:D8 type=
 0
status 0xe
Jul  1 16:02:08 mwenge bluetoothd[760091]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Jul  1 16:02:08 mwenge bluetoothd[760091]: src/device.c:device_bonding_fail=
ed()
status 14
Jul  1 16:02:08 mwenge bluetoothd[760091]: src/adapter.c:resume_discovery()
Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:session_c=
b()
Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/avdtp.c:avdtp_ref=
()
0x5c5568690930: ref=3D3
Jul  1 16:02:08 mwenge bluetoothd[760091]:
profiles/audio/avdtp.c:connection_lost() Disconnected from F0:EF:86:C3:50:D8
Jul  1 16:02:08 mwenge bluetoothd[760091]: profiles/audio/a2dp.c:abort_cfm()
Source 0x5c5568671120: Abort_Cfm
Jul  1 16:02:08 mwenge bluetoothd[760091]:
profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMIN=
G ->
IDLE
Jul  1 16:02:08 mwenge bluetoothd[760091]:
profiles/audio/transport.c:media_transport_remove_owner() Transport
/org/bluez/hci0/dev_F0_EF_86_C3_50_D8/sep1/fd3 Owner :1.79


And here is the relevant handle entry in btmon:

> ACL Data RX: Handle 3837 flags 0x02 dlen 143         #33540 [hci0] 390.03=
6978
      Channel: 515 len 139 [PSM 0 mode Basic (0x00)] {chan 65535}
        33 00 cb db 90 00 01 00 58 17 02 00 00 00 00 00  3.......X.......
        00 0e 81 00 00 00 00 00 00 01 00 00 00 00 00 00  ................
        00 2a 25 00 00 03 14 01 00 42 27 00 00 00 00 00  .*%......B'.....
        00 00 00 00 00 00 00 00 00 ca db 90 00 4a da 90  .............J..
        00 07 c4 50 00 00 00 20 00 00 40 f8 05 e1 7f 00  ...P... ..@.....
        00 3f 00 09 00 0d 00 00 00 3d 00 09 00 b6 00 00  .?.......=3D......
        00 02 00 20 00 05 00 00 00 01 00 09 00 00 00 09  ... ............
        00 0d 00 00 00 3b 00 09 00 1a 00 00 00 30 00 09  .....;.......0..
        00 0f 00 00 00 3b 00 09 00 0d 00                 .....;.....=20=20=
=20=20=20


The full btmon log is too large to attach I think. Let me know if there's
something else I should be turning on to help debug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
