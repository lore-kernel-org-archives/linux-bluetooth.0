Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778726738D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727933; cv=none; b=lKcTqeil6CdiEnHDzkwvsV1lLfRsQlpW5cnFAJIJO9oDHwd4v4eFp9vGq60h8zRUfua6EMvQgFJEdp4VtTzno8eCf6EXw4PM9y6PFGmQN0PMdF5nxsd3SvCP/IJT29MeUmcxZ5gdeK1ZOhHvIqMWclqzuYgA3TDn7EJd2vT7UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727933; c=relaxed/simple;
	bh=GlV7RZkmnW6xNd+oz5JsDygGxoIfJVAx4ZLAOlz8dcQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E/d6LWDEklqlNsuvhV4IensD20RCVTsxhXTpXg+OZ+gJURPDAnfeKdmnVLhHsBSpz/hAg8GekPPRThgzCkkGwty7cXiK85foEdrQAtSNfheCf1MPu98RM4hBIPr7Nh6V+SaFNKsFNmVlYHQLdIsamsNKmOnfcBgWdrGavVUPt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1PYWUCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1PYWUCo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D5D9C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779727933;
	bh=GlV7RZkmnW6xNd+oz5JsDygGxoIfJVAx4ZLAOlz8dcQ=;
	h=From:To:Subject:Date:From;
	b=k1PYWUCowrlaK+ye88cTHu1KyVZwqdnsRuodJ+eH7GNDWcekiJ3kqh+0ivzwgM9sj
	 ipCVj75pHrpxKwM7u03wbEDdQ34K3k0m5uBfpCB6IUHkwCM47oWmaklCNZoNBiyfHr
	 Ers7tuY8sfHVinMbUv6SaprzaRA7bpnzb6v0k4AFhZOD81jEdyt8B/WTcpLDUGsj5n
	 i2d+T66aOfKBbiF84mR4fT7knjO6j0W3xIzYwXpU63EXgALsEelWBXqnpSJQD/CAnk
	 oYe/mMAPiCt3HkQmCItDYH6xLcmWeWwIiG7O47Bx/c9//9wraMODAtTn0za/3GUukV
	 7LXBG+VolLJMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 501DEC433E1; Mon, 25 May 2026 16:52:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221576] New: btmtk: MT7925 USB Bluetooth fails with "Failed to
 send wmt func ctrl (-22)" since kernel 7.0.7
Date: Mon, 25 May 2026 16:52:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergey@batalov.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221576-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221576

            Bug ID: 221576
           Summary: btmtk: MT7925 USB Bluetooth fails with "Failed to send
                    wmt func ctrl (-22)" since kernel 7.0.7
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: sergey@batalov.email
        Regression: No

Regression between kernel 7.0.2 (working) and 7.0.7 (broken) and 7.0.9
(broken).

Hardware: ThinkPad, MediaTek MT7925 USB Bluetooth
USB ID: 0e8d:e025 (MediaTek Inc. Wireless_Device)

Kernel 7.0.2: Bluetooth initializes successfully
  "Bluetooth: hci0: Device setup in 1774290 usecs"

Kernel 7.0.7 and 7.0.9: Initialization fails
  "Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260414153243"
  "Bluetooth: hci0: Failed to send wmt func ctrl (-22)"
  "Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported."

Firmware: mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin (present, correct =
md5)
Distribution: openSUSE Tumbleweed

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
