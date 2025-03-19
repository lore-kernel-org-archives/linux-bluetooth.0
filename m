Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF123A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342467; cv=none; b=u07hQofjPzv9mp9SR4OoQ69ZWXJv4fIiohK+dmq/QzQO15/ZWSs3WOTnr9GOmaaQMNs5rFh4YqNNojjwdQ3vp9M9f0mslOWYepu4pr9SavQVTAbPGrIan5pfNEN+YqKGO+pkh6q8olUqIYYQ56RIGrK21wTZvD8TX482J1Xbnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342467; c=relaxed/simple;
	bh=jyNBFTtCpEPzBH+e8ogmq4oRfDXPYFgfetph/OjeNTA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fbni+25/5Kf/yuQ/4Sfu+2IAtyOsNx4t5oZGnfkAdx3EyMiBSzkxKDtkgcXhoO4jb2L3k8nFWXfvSjfjAOAR1s33z5qRkupwMZDVpnzg8NpJcuTsg92iARpv8bdQy6CE5GZIZWmN1Pefr4QvtZ8PwfUGd8w/6cOo+xyHjmH6014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA0IR0W7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA0IR0W7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04893C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 00:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742342467;
	bh=jyNBFTtCpEPzBH+e8ogmq4oRfDXPYFgfetph/OjeNTA=;
	h=From:To:Subject:Date:From;
	b=pA0IR0W7MTQj5i4Qwzm5l0blwqGJcbvcPLO7H4L5XRWfmZhQR56MmXrW6a2qnxNrh
	 fRlqM60h28VyqbUVivJHa0dnkKtZBQAT8HTpTu7M8Id5rPIfdzYwoLPlTIT1jxz1Wo
	 SOXzBKoc5vUEhPEszcJrbfWxwlyXRJY991lxwASjBkBYT0SxZJwygu9xfh1XXe3Wdg
	 ftRWlbsKcnx+6rhDqlymX88WPh7tAal5b9SWSg6XaRGBUdqC4BCe5vYpXiSllFZHbi
	 3B9JBy+Hbq05v8QGR1Xuv5nAPAdD6JHtW8+VWD27ZIoAZ5M4X++gBHwwUrKfaImz0W
	 19erotIVO3wVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E1379C3279F; Wed, 19 Mar 2025 00:01:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219894] New: Bluetooth Qualcomm WCN785x - Input/output error
Date: Wed, 19 Mar 2025 00:01:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: agurenko@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219894-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219894

            Bug ID: 219894
           Summary: Bluetooth Qualcomm WCN785x - Input/output error
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: agurenko@protonmail.com
        Regression: No

I've got today new MSI X870E Tomahawk WiFi board and it comes with Qualcomm
WCN785x for WiFi/Bluetooth. While Bluetooth is available and can scan for t=
he
devices, I cannot complete the pairing process with following errors in log=
s:

Mar 19 00:56:01 bluetoothd[1456]: src/device.c:search_cb() EC:73:79:59:9A:4=
E:
error updating services: Input/output error (5)
Mar 19 00:56:17 bluetoothd[1456]: src/device.c:search_cb() EC:73:79:59:9A:4=
E:
error updating services: Input/output error (5)
Mar 19 00:56:17 bluedevil-wizard[40108]: kf.bluezqt: PendingCall Error:
"br-connection-create-socket"

I can see that device is added and set to trusted, but attempt to connect s=
hows
the same error:

Mar 19 00:57:33 bluetoothd[1456]: src/device.c:search_cb() EC:73:79:59:9A:4=
E:
error updating services: Input/output error (5)
Mar 19 00:57:33 systemsettings[40016]: kf.bluezqt: PendingCall Error:
"br-connection-create-socket"

Please let me know what other information I can provide to help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
