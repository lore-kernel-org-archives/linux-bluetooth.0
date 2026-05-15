Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC65374739
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851390; cv=none; b=HAzpdGxBG0lCAXdr8yKvxASrdXfmu8VZuWKbAV7HgzGW2NSfiwMrrUj4KEHBatrxYzl3D4C3GI77LnsSomAQT2OwvQrKePzmX7EhQ8cwvbrW9ARMHVZNpUVK7xzDkPOYn/KIwVJMt895Iw4QAgyWiJG7hnoOY9tGstF6KeP+KRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851390; c=relaxed/simple;
	bh=eJrijK3NmRUWab8UkXO1tJJcr/FEDOVW9cTjwQknMAY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WBW6W4O/wHo0fqAoZoB2ColFou/skuQlYAWcgd+nu6toubMTk9FKcTIBNprbZIt/P3koej35VXmYgWkazuUA6XMyOjsjmCClFW3kHldeJ6lGo3NX1YXL4bBPB4sg9azNHX7eSBOlXkBXAbxWHO7UNQarM2BmcVUmuyo3XRmke2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQqGVBFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQqGVBFl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57D7BC4AF48
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851390;
	bh=eJrijK3NmRUWab8UkXO1tJJcr/FEDOVW9cTjwQknMAY=;
	h=From:To:Subject:Date:From;
	b=CQqGVBFlyOEGE1zLlAX8St75AUW8FaZ3/aMs1jlZTDIjAeOLh+rUAKGmwtPoVtu3t
	 4Fq8YyoARcnLQkpKASgNO7ZCLSAC1ydVt+wjoHmT9ibsj4mveO/woVwDuHaHG01d2m
	 Q8kXA6aGEa1Q65si+QHU1nylXfkDo9dKuCzgalDanXVU1YY1D3ruAFcGPbmbm9eVPD
	 wKKTQXU/Ii0W6D9DdOB5s2SL32D3+EUnOG0g18fGB5WkWANXJkxPUWFHTfQNMDySiZ
	 OgDpAcuyrL/fnGbVoUMTyoz6lz/7rwOP2g73tOue4q1XjqqtW1OMVR03ARlQkgstYD
	 i/0xNTPQLgplw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4914FC433E1; Fri, 15 May 2026 13:23:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221525] New: [REGRESSION] [btmtk] Bluetooth fails with error
 -22 since kernel 7.0.7
Date: Fri, 15 May 2026 13:23:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: flavio.caetano@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221525-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221525

            Bug ID: 221525
           Summary: [REGRESSION] [btmtk] Bluetooth fails with error -22
                    since kernel 7.0.7
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: flavio.caetano@gmail.com
        Regression: No

Created attachment 310133
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310133&action=3Dedit
lsusb -v output

Description:
Bluetooth worked perfectly on 7.0.6 but stopped being recognized in 7.0.7.
bluetoothctl reports "No default controller available."

Hardware:
Laptop Model: ASUS TUF Gaming A14 FA401WV_FA401WV 1.0

Error in dmesg (7.0.7):
Bluetooth: hci0: Failed to send wmt func ctrl (-22)


Steps taken:
Confirmed rfkill is not blocking the device.

Verified 7.0.6 works, 7.0.7 does not.

Performed a hard power cycle (60s power button hold), which did not resolve=
 the
issue on 7.0.7.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
