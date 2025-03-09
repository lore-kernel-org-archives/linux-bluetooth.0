Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD541DE3D8
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Mar 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542537; cv=none; b=iD+vkP4qUd2fYUlP5ooZkknw3jwfeMCorBSB2WTnIRdCr1vYnssbjiMd2C+sJL110qdrHvah87Tq4te1ivczgyMHR2v/X2m5Jdh25A6IQVAnKLTpFzJ8JDtDZzPKRaVp4bCZG9uJ5yg68W8+T2/bax0JvXoU+ZFo63byTPAh9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542537; c=relaxed/simple;
	bh=zlrL5WTmhbnzMHyTpxX0WAW5s+2iXwCn7Vt6kdp4Bo8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UTCnzrcr+k5NujwBSP9zeqIPalx2j3x2jlKZlmFG00RBCmP3yF6GmgllGo9fnQpynNvW7pBOyKXF6Q1LpA/3bpJlqn/1/HHHRist3iIqMiw7LToiCOdn/9cj9Ig075kITv5xIQ1X8y/x9GczIuLCl8eqKsKZDfx9Ws6zNW14JMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObzKUv2i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObzKUv2i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45329C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Mar 2025 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741542537;
	bh=zlrL5WTmhbnzMHyTpxX0WAW5s+2iXwCn7Vt6kdp4Bo8=;
	h=From:To:Subject:Date:From;
	b=ObzKUv2i8P2ePxWN+UkiyXx0w2kMjLt0lDBmRtXGxP8cx0XIs3MlsAkUOLgUvOPHH
	 cKUfzYcJCz53QtiX7Lqh8KEP60nuna57wfKvoiTOXEInKpNZpgmt4vWJzUXIZCd2S7
	 d6ix/ItaWLMQlqfkdjin8zJx5PIbKkCRA296pYm02sLwYXFPqxdi6OTnniXH6FZdPG
	 cxswXaiMr7+vzakqE7xAzc+eRaCNES6x2+TWUMoHEAiuC7kJGkIgYfanDyufYgaier
	 AHfp2BFfoUuU0B08UB9RgWC7YboWU/JMA2KHaxb8SwefsSprZBxgJoxaruZzEgctBU
	 bbIRjepWgUtnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37A70C4160E; Sun,  9 Mar 2025 17:48:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219854] New: Bluetooth devices can't connect after toggling
 Bluetooth unless they are re-paired
Date: Sun, 09 Mar 2025 17:48:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linux-bugzilla@ericswpark.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219854-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219854

            Bug ID: 219854
           Summary: Bluetooth devices can't connect after toggling
                    Bluetooth unless they are re-paired
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: linux-bugzilla@ericswpark.com
        Regression: No

Created attachment 307785
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307785&action=3Dedit
dmesg output on Linux Mint during reproduction of bug

I noticed that my Bluetooth headsets would fail to reconnect to my NixOS la=
ptop
running `6.13.5` if I toggled (disable -> enable) the BT module. When this
occurs, attempting to connect again via KDE's Bluetooth panel (or the Cinna=
mon
BT applet in case of Linux Mint) would fail with a "Connection Failed" erro=
r.
The only way to fix this is to unpair the devices, then re-pair them and
connect to them again. Then BT will continue to work until the module is
toggled and/or the laptop enters sleep (I guess the module gets power-cycled
during sleep).

Under Windows this does not occur. On a live Linux Mint boot running kernel
`6.8.0-51-generic` the same issue occurs. I am not sure if this is a regres=
sion
or not as I have not tested earlier versions of the kernel.

Attached `dmesg` output from the Linux Mint reproduction, after toggling the
module on and attempting to connect to the previously paired device.

I also posted about this on the NixOS forums here
(https://discourse.nixos.org/t/cant-reconnect-to-paired-bluetooth-devices-a=
fter-toggling-bt-unless-i-re-pair/61366)
and that post contains some screenshots of the issue occurring on KDE, as w=
ell
as `dmesg` output from the NixOS system (which seems to be more sparse comp=
ared
to the Linux Mint output).

This was tested on a ThinkPad T480 running the Intel Corporation Wireless 8=
265
/ 8275 (rev 78) card, on NixOS-unstable `6.13.5`. I tested two headsets (Bu=
ds2
Pro / Sony WH-1000XM5) and they both "fail" in the same way.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
