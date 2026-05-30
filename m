Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871983438AC
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158186; cv=none; b=oBApzg5YpY3MzSCo3g1toBhvTJ74fiFVZ1qSos7jSAozHMbHs7+J7CNHd7jfINOj74slq8yRfO3s9EV8dphsoH0ftNDKYRK1xdG6RW5cHlHJ2WhzU4I5Ip652Bl0ZRYSj4MO28Gsw/8G21KlVz3S/QY2g4KinPlq0OzrbG7btnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158186; c=relaxed/simple;
	bh=K9b8KgxsQjqDa3/vkbDak4JojqvjvixzVevKD4AOXMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOrGgjdM1M0XWRuMEz2f+SpXoWxGw+i92GRperwq/eYFmRVr1+xcFMu3Orqw2Ffct4WptvkvcApK2E87l10KxY5l3bUvSmpZrAPOCFFvLbnQuIY3C8sNZ+TH0LL0OMFXbnw0s3KPhHkz0uXVrBvgV69+hq9hQs6DG90ZWUtjpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmZ89t7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmZ89t7z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7F4C2BCC4
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780158186;
	bh=K9b8KgxsQjqDa3/vkbDak4JojqvjvixzVevKD4AOXMc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nmZ89t7zqsJRNr/rCOAgaJy/LplfBDbvgDx+MtBCOkcvyVvax+yPDaRwqkjEoVId0
	 J0wy+qnapIrsdeJNkKaKKNFbiSd5/oPsL2mkveV0TApuswBPOPZCfSIU82hqqhS22n
	 3RGZ9S49Quzxfp5Tl2PQcU+MxTaz9Sp5eP2L5+6bA+d0i28FQjwITj2SSx298U5YmD
	 7BKkM2vYriGM1xpIiJrMciUnn88sepZBGDqURxIJ6b+EERpIdXFsmIWXio+Xe02wEY
	 krRr/jhtupBIpLGTzvZUtc6ubwWgmgwooZp2MBAno9N6uInX+dfuP88+wPuIY781Yn
	 7eEKEknmeG0mA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 24405C3279F; Sat, 30 May 2026 16:23:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 16:23:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221598-62941-GvQaeBR0vF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #6 from Alexander Paderin (apocarteres@gmail.com) ---
Additional binary usbmon evidence
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

I captured the same HFP/mSBC failure with simultaneous btmon and binary usb=
mon.

New files:

```
captures/btmon-20260530-191225.snoop
captures/usbmon-bus3-dev7-ep3-20260530-191228.jsonl.gz
reports/captures-sco-analysis.md
reports/usbmon-bin-analysis.md
reports/usbmon-bin-anomalies.csv
```

The binary usbmon capture was taken from `/dev/usbmon3`, filtered to Blueto=
oth
device `3-007`, isochronous endpoint 3. It includes full ISO descriptors and
payload data, unlike the debugfs text usbmon log.

Important result:

```
usbmon-bus3-dev7-ep3-20260530-191228.jsonl.gz

RX USB IN completions:
  reconstructed ISO fragments: 12675 x 25 bytes
  reconstructed HCI SCO packets: 4225/4225 valid, handle 5
  H2/mSBC markers: 5038
  H2 bad sequence: 23
  H2 same sequence: 21
  H2 bad distance: 20

TX USB OUT submissions:
  reconstructed ISO fragments: 12669 x 25 bytes
  reconstructed HCI SCO packets: 4223/4223 valid, handle 5
  H2/mSBC markers: 5068
  H2 bad sequence: 0
  H2 same sequence: 0
  H2 bad distance: 0
```

The simultaneous btmon capture shows a matching RX-only problem:

```
btmon-20260530-191225.snoop

RX:
  packets: 3963 x dlen 72
  <1ms packet intervals: 20.0%
  >15ms packet intervals: 10.0%
  H2 bad sequence: 21
  H2 same sequence: 20
  H2 bad distance: 17

TX:
  packets: 3961 x dlen 72
  H2 bad sequence: 0
  H2 same sequence: 0
  H2 bad distance: 0
```

This suggests that the H2/mSBC sequence corruption is already visible in the
USB ISO IN data delivered to the host, before PipeWire/WirePlumber and befo=
re
userspace. It also makes the repeated near-identical btmon RX timestamps le=
ss
important by themselves: the USB IN side is batched in 10 ISO descriptors p=
er
URB, so several 1 ms USB frames are naturally processed together by one URB
completion.

The remaining question appears to be whether the controller/firmware is
delivering duplicated/missing mSBC frames on RX, or whether the Linux
btusb/btrtl setup for this controller causes the controller to use bad SCO/=
eSCO
parameters. The next useful comparison would be a Windows USBPcap trace of =
the
same HFP/mSBC scenario, especially the vendor initialization commands, sele=
cted
USB alternate setting, and `Setup Synchronous Connection` parameters.

Attached archive: `bluetooth-rtl8821c-binary-usbmon-update-2026-05-30.tar.x=
z`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
