Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D018E352
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143865; cv=none; b=l5VJUuv36YMSuaH6+C0DzwLuTujiZjwvn1NcTFAkgvbRd2jDoRExiugtXUPA+DnwpTAJIlPEYU9rO8OXg1d8Gz272dkmndf8xaQdbm7jyVpiEBavVEcbXjQnJAzokpaX9UGJveKSsPXhcS5uT/FsWyXnbwJ4Qd9SThxBNURYdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143865; c=relaxed/simple;
	bh=UWtwbihwD4czI6riwgMVd6PD40sDZd9jcapgcrwy0X8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tmk9u3f3D9UouXKsP+j9gQfqFMPMXltDsojlOPxqQa88n8jsMmdqHbNaOljlT7qkOJvHnHzAErGJyiy9ufmiLZErqGpXQr10paN6mFh9vQyOYKzqZMiC76SPNcPxw+CESwIrEyojxWMI44nYi8IjnO8aEGHC6BZ4ZBojD2i7oBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdqJod6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdqJod6m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 792C0C4AF0B
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143864;
	bh=UWtwbihwD4czI6riwgMVd6PD40sDZd9jcapgcrwy0X8=;
	h=From:To:Subject:Date:From;
	b=LdqJod6m5UvFK3zbTyRMJeG6w5bY2XFFlOeRFmrU0lv46vo2CNVuWH/luj2bE+nJv
	 iirupdGDYhWxEgYWPrV2VLXCCBxbPF0XX9syKPOGZGP0rY79pWH/Ttpn2qgUPFCGsH
	 BonSkpIcZIyHmIJwu5WM46Av7YVybDlcoCi0rsFklfLafPrfpusyxmNRFTJqSwnUKM
	 e+B+LYiv1rI7cIe9mfgmRLktwYPolbzAul8JjEsSGTg5Q83iB00m66np23s20YKQfI
	 0yes8woKODxECjpHl7YqF353O6hySUy6HffCtzga29Xs6KoNllaNnyc/JnYQ5OvDJK
	 rXwMdhGA/on0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67F93C53B7F; Tue, 20 Aug 2024 08:51:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219182] New: MT7925 new USBID 13d3:3608
Date: Tue, 20 Aug 2024 08:51:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pavel@noa-labs.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219182-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219182

            Bug ID: 219182
           Summary: MT7925 new USBID 13d3:3608
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pavel@noa-labs.com
        Regression: No

Created attachment 306759
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306759&action=3Dedit
Patch to add new USBID

Bus 003 Device 002: ID 13d3:3608 IMC Networks Wireless_Device

Please add the new USBID for MT7925 stick shipped in 2024 Asus laptops

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
