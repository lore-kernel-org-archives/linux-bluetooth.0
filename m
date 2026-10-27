Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793121543;
	b=ce0wioT0ICDE3uFR6igAzC0q2gIMy9S5+auXhFjylM8zwr2b3A29Nrgki6cNpvNCm3et
	 DxzM1xIiTMxtEeKxEhNDdn83VLlluRqAbj7MJdnU1MC0UMEctEut1wArNdcLG7HpDQ40B
	 c/oRW6Chr9Y6eo+7XyDRP1aeF/l1VN3zaQhMXjib5Ki8ptclksSC4QRa/47p9EDIDsAHo
	 fOVHn5vEkAVzjCvIgcd2zqmdYzj2dIAlGe5iPq6vjKlKBjLyLOCWZ/CAqyLYMYwFHw0EP
	 XmC5wszgGP5+oB3E1XnYW0PmD+0BjYnzTD+rY+HPLHLnERn/Ls7TSEBQE4rm+flAYfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121543;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=CFOvEIl3DvTsVdQEQrhlCiWJOaTVXX03Nnm2wpi5GO0=;
	b=pK3vOUbmjXuGna85BtZ4RBKQzAF5gBPLWLLfDnicTWdEX2TB/L5mvC0sabbViUHBC3N9
	 alGPbRgXY+OQHWz2iW6+YmH1GovuPy4Smvpx3swttNLsn9vfFvM/Fsp2GRPF6P7Yxu+Jn
	 yiEBzVr5iV7KUKF11ciR1bzfICA4E1Jx5d7gzCdmlYvwOFI64f68Q9xKLzVpLjW9kzsTF
	 2CtZZwruPRpAxd4H4i1fv7tK/l+a+dZMoVH3pxiwfgcfB/LodEwA5/P7r4w8vUQTHXxLD
	 9yu2oH4ayQUKjRT4IldPPLpzjLgR/KDfYmPNm0AAU0QHg900YV7rszjrPMVW1QUYDuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rDhjAM3a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2801606A31D
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Tue, 27 Oct 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rDhjAM3a
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8A6513C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793121543; cv=none; b=uRrMiKPXeVcSqJ3u115mT3Q6Rzpfm6ewuEn1VytdFvYIgXJ7SpUX046Nn/WHo3uO6yW3qi94y7cz19jPLHBvWqFQj8+uKTSgqzbbALb4E7EV7cH0yUhRRFBJ+ZuPg1Q22Hp/W5mFI3yRkH3w7ZaYYmpJPW25bD6vmlvFoqzDAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793121543; c=relaxed/simple;
	bh=lrPe/BprRpwupUDyxJnjkji+NyG29fuDtcDLYTQl3Xc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u7gvm0oHMenyWUvSkqqq8FltqZ3NL8zPidtKzh9VnbQ5wMJ4L7to6OErvifAQ8Bo+D60rU3zMYrc4utoKYWdEkHstZ5MChqUmghWZ5TYHgo7OXFjIjpbWE6BHEWBtg5dzRumw8xBf2j/oTBgD43/rGkfHIYvuhaWCWzu8hcYKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDhjAM3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4939C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793121542;
	bh=lrPe/BprRpwupUDyxJnjkji+NyG29fuDtcDLYTQl3Xc=;
	h=From:To:Subject:Date:From;
	b=rDhjAM3adLKNSxz3Ipc59oGXUfT19PNiCs0O38T/pAKZWCm25cmNbFbixSzuRhw7d
	 WDdQpHwUItaPFJSgE8/+4voPNtEYABmyurXGrnd5/aqJm3pCylRFxY0AmJHBOLO/AC
	 qZp4ByfaEvrwEra1sZNPnbUKLmsAIO8LpJfENH+DuXV4oc2hSyfvS7rrg7WcN2dcme
	 RS1ye4xBsKw+Py4x+1UsFSOVV4mG9uWaLxoQseyPczdUs8Eh5MxsU9EJYWOId1HbKV
	 Cs+wA7XybimxhM57FnQqB2m94ZHrGd/LHPCdgxbjbkBhXq8/edViBP3p0x7AVaIDp9
	 mqeoPcX6oz0cw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9A501C41612; Tue, 27 Oct 2026 17:19:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222204] New: Intel AX210 (8087:0032): A2DP audio stalls because
 the controller stops reporting HCI Number Of Completed Packets, while the ACL
 link stays up
Date: Tue, 27 Oct 2026 17:19:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: danoomsys@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-222204-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222204

            Bug ID: 222204
           Summary: Intel AX210 (8087:0032): A2DP audio stalls because the
                    controller stops reporting HCI Number Of Completed
                    Packets, while the ACL link stays up
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: danoomsys@proton.me
        Regression: No

Created attachment 311313
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311313&action=3Dedit
Raw logs and full analysis

The full analysis is in the attached report-kernel-bugzilla.md; raw log
excerpts are in
report-bt-ax210-logs.tar.gz. In short:

Intel AX210 (USB 8087:0032) stops reporting HCI event 0x13 (Number Of Compl=
eted
Packets)
for the A2DP headset's ACL handle while the ACL link stays up. Audio goes
silent, BlueZ
still reports the device as connected, L2CAP echo keeps working, and only a
disconnect/reconnect restores playback. Happens 1-3 times per day, during
playback and
while the sink is idle, with SBC at short range. No USB errors and no kernel
warnings.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
