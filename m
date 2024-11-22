Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AA1D0B8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269765; cv=none; b=Fn4dd6yHPeK76LitRBCdP7FqYlaNJH44XSsmAjt9F9u9ky6rZMa7UMTIfoZKJaRArtS34OWzYvnB/OJZBLftyvcPK9dgzOMl5SvfwxA+CgEgjWwEmqCY0W2VSWg4PdZ886eWBZhbf8YS/H8ijqLz/XFNkeNHszBFmGUMthED4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269765; c=relaxed/simple;
	bh=vDxQIcZZLVdepzEIoaRtiMF+OnJg5AeYtiYCSHqBVQg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gp/Q5z+fIjHndv5+zCPnw4L0EkrkUnJviJKHcW0rv8YVtD31TAka4pYJqkblxaNAwhHYqyPTbjGQymMLv3aKUj31sAf+DR5XoUG4zLVds7A6+SskU9fVHAaPM01yJBe1oeT8Rjbp5mwhrkebWkog0Fbe6gQBE8ogIP+froYM3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIe1CRRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIe1CRRr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EFE0C4CECE
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732269764;
	bh=vDxQIcZZLVdepzEIoaRtiMF+OnJg5AeYtiYCSHqBVQg=;
	h=From:To:Subject:Date:From;
	b=CIe1CRRrmz1JwP46xaQwJ/M8BYAyezF0yIZ1z/NJ4v2iYkgiDulFooZ04RSQ0yNDl
	 yIQUl7uXe55whPouTOp9eCZQbIJbpRoxhaXYTPp4CIP7jtnDpl7DxFFvWIwAGTBQon
	 YgXYk5/n0wXVf3H28RwElC7T4wLdLvYQcPljWCOhicD/4FUNoisxoER76OOOiIVYfZ
	 g2WnDm22j1fOCZ2MypPTL75d1nvXZXHbYZhsekN+zn6FS/b7l0B6DwPdBoRoO5SsdR
	 wfFFIYqSnVVyCf+0G80yhkTFg9db6jlzGy507wp1Nm+RTNYQC17oO5TGaEuXigvZDb
	 +CTY0+qwAJuFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6801FC53BC5; Fri, 22 Nov 2024 10:02:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219519] New: Hibernation Failure on 6.11+ due to btusb
Date: Fri, 22 Nov 2024 10:02:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lkml@antheas.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219519-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219519

            Bug ID: 219519
           Summary: Hibernation Failure on 6.11+ due to btusb
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: lkml@antheas.dev
        Regression: No

Created attachment 307262
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307262&action=3Dedit
Stack trace after resume

On an ASUS ROG Ally X (and possibly Legion Go) and a kernel of 6.11+, if
Bluetooth is enabled, hibernation will fail on resume with RIP
__list_del_entry_valid_or_report.cold.

This is under the function hci_unregister_dev

6.10 appears to work however. See the stack trace below. It is from a taint=
ed
6.11 kernel, but the same issue occurs on 6.12.0 and 6.11.y

Bisection between 6.10 and 6.11 made some kernels that could not boot, so I
could not finish it. I also tried reverting "Fix not handling hibernation
actions" and "Bluetooth: btusb: Don't fail external suspend requests"
completely which did not help

The following lines were used to produce the trace:
```
sudo chvt 2
echo N | sudo tee /sys/module/printk/parameters/console_suspend
echo devices | sudo tee /sys/power/pm_test
echo disk | sudo tee /sys/power/state
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
