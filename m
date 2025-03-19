Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295411DE881
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395885; cv=none; b=DayVWwGtQYX2iztgGF72r3Vq+4HtPBBBj4O0rDBCBn7nyTXZLdMu6mxYuFuIx0Ua5WWPaE1rHC0v1TMjONdpoYD1LbmydacRKZl+a3OalRNLPdyigRCauA4uqsxzm+Y+nQmlcXuEUgRGvLsMw+4Y/FWZQvTwi+SIayZ6N3m+S8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395885; c=relaxed/simple;
	bh=IUGTtWTU5zB3UsHQrZCtkT+Qp5rh1G+9rM8HCXUp64c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aas9zVPY9MDXemSnFsWMSwbt4xaTzbF7o7r2v1qwdNavVH50eovxnq4U7VWutWQoUV3/UfRxUEdcZ8VQqmQjaFOMOqe52MFY9FI8jsX14h91UtBOZvdZyTn5x1+FLgnM/hHDMjx1tqk4GMVqpEbJlmhb3MmIElWEBOTUTe0cNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsIko6lR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsIko6lR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 933DDC4CEE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742395884;
	bh=IUGTtWTU5zB3UsHQrZCtkT+Qp5rh1G+9rM8HCXUp64c=;
	h=From:To:Subject:Date:From;
	b=CsIko6lRfX2GB7VsePmuxxWrYua7nKMyfGUD0j9yeD2rAQA4fAGxWahkzSc/ZllRD
	 MYVc3RUd+F7oO/pGBkdgSRtdnpnXgCuvXBEKXDPPxIajt/U1/6hO8jHlp/FKdTUzfK
	 P8tLkW5oiXRpGkLloZxOHIJqJoxvgVws70hehHHyUShpO1+rmLZJDp/KmiwKFhlx44
	 do0U0GLml+Ps/2yuVpWuiq0PLrNyho2HLnKYhY9SPaKeBrXuhRE4sHs4W/w3HEObYu
	 wxmNYVrhBe4VQwNnTz2/dQ0ZTG5ImpCY4Cb0oMEG9Qi3ylcOMl9Bub8u4tpPLbFk4O
	 furJ3PGvuSWGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8570DC433E1; Wed, 19 Mar 2025 14:51:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] New: BLE - Intel AX211 fails to Pair on first attempt
 but succeeds on second attempt (utilizing software-controlled bluez API via
 Dbus)
Date: Wed, 19 Mar 2025 14:51:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

            Bug ID: 219898
           Summary: BLE - Intel AX211 fails to Pair on first attempt but
                    succeeds on second attempt (utilizing
                    software-controlled bluez API via Dbus)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: miller.hunterc@gmail.com
        Regression: No

Created attachment 307860
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307860&action=3Dedit
btmon trace using pair method via Dbus API

Attempting to Pair with a BLE device fails on the first Pairing attempt, but
succeeds on the second Pairing attempt when utilizing Bluez Dbus API.

When utilizing bluetoothctl directly, this issue does not occur.

Note that this issue does not arise when using Intel AC 9462, but only aris=
es
utilizing Intel AX211.

From the syslogs, it seems new_long_term_key_callback() is never hit during=
 the
first Pair attempt when utilizing dbus API, but is hit when using bluetooth=
ctl
on the first Pair attempt.

I'm unsure where to go from here, but open to suggestions on how to debug t=
his
issue further.

From the btmon log attached, it seems that LE Start Encryption occurs in # =
40
(2.293188), followed by success in # 42 (2.294177). However, after the
supervision timeout of 30s, a disconnect is sent # 86 (32.619238).

In the second pair attempt, LE Start Encryption occurs in # 142 (37.979552),
followed by an Encryption Change event in # 143 (38.157560). Following that=
, a
new long term key event is notified, and pairing succeeds.

Seems as though the Encryption Change event (0x08) only occurs on the second
attempt.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
