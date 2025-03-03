Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91320E330
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008626; cv=none; b=CbntX8/rIdBU2f51j0U+GpQycgwZr+E7SryP1+MF7VB/gdJnKCYGCSniL3Aiz+ud1rcsXhFb9ae8vcwC+vrv9ATIFYXsYKu2wnXG6p7u8azgSxyDbua4djNEwlMaW+XUbENt5lAhpzlUlmDXGt7RQyIlY9Douhf4VmV4PnhW2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008626; c=relaxed/simple;
	bh=himwkJ/ZEtJYLR/lwTcqTXCEvR7GaTh/V44yncqlrjo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uSI2IVhjMfqTcxRl68q24HlU8sE5nYM6DjnlqXdSjURanAWsXlFUK+gJam9ECSQYm0jQhRmYjMfJcX2nqmmSuMcvKdKYJB+14kunuvCXNUd3fNhl3E5ICxX7gJ+BikbEp99oyH/+QOvwq2XrFZAbP1KhaiE+yc5vK7PAxe0bJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmCS1SpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmCS1SpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23125C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741008626;
	bh=himwkJ/ZEtJYLR/lwTcqTXCEvR7GaTh/V44yncqlrjo=;
	h=From:To:Subject:Date:From;
	b=mmCS1SpQ9PBNZFiWyAjOWlOVYTjbeqM4WZOB43n7QJy6n8svTEYd61JyE91m7copm
	 0xaFrljgEOA6Pw+WXkp0YqVCWtPkBMey553ELy56jQiAJJ2k0C+1vAfi68Kv5Rz4Vc
	 CaBowh5IAo+xStm/Q0Rwrzka//qBDEgSeukWwyMv99EpnZIXAv5Vq6EDUJwYlwhg+a
	 YcEFhixukJOtvdlelyPiSxMvr/fsBEXvCtKhVuL5jJAS99HQWiMkKBIQ7BrJkGtaSz
	 6WWyjatfVDI9eC+TbrglemBbXLgzeGaLT172XOH0xzDTyggt/vFwroLIqUagMKGiXs
	 crUUZEdRFqYgQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18F60C53BBF; Mon,  3 Mar 2025 13:30:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219833] New: USB bluetooth dongle stop working after upgrade
 from 6.8.0-52 to 6.8.0-53 and/or 6.8.0-54
Date: Mon, 03 Mar 2025 13:30:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: foliden163@envoes.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression
Message-ID: <bug-219833-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219833

            Bug ID: 219833
           Summary: USB bluetooth dongle stop working after upgrade from
                    6.8.0-52 to 6.8.0-53 and/or 6.8.0-54
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.8.0-54
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: foliden163@envoes.com
                CC: luiz.dentz@gmail.com
        Regression: Yes

Kernel bug on CSR dongle, same as
https://bugzilla.kernel.org/show_bug.cgi?id=3D219365
(https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/?h=3Dmaster&id=3Db29d4ac729754fa1b515a024386f50dadcaa8c7b)
but this time in current Ubuntu and Mint LTS kernels

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
