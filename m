Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BC28E34
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313843; cv=none; b=SaoSHTSTEfcxFzI2iPDZzC3Im8N/leN0cAgp/bY/wgonfiYW58XhBjNf+nwcSiAZh9dsnxihIeFio89AIyqoYLiEDgAaES8Gw52EGtE1GOTH0YmXiqgNWaDgbq3oAhubjtp4+IaGpEfMFXurlIAjlLESqoRJxlnYhalPiBkfwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313843; c=relaxed/simple;
	bh=yH7/HcTeF/mVH4P3dUmzZ0XOssJgQ3nGEXovhYJ3Qh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfLloxLefB8wK17StRt/fcwmmOAosaR980QH0WSOLwWFkpriCBPSgwlTcjgv2QDaHuvPyw4PotUk2QDveOi9gh9l8KudOeJCKpZrEFPrEM2ZKWT8OqkRXC8ArRQoVs+LKob36HWAEn6SjcRF2BbUhG7obFQZ6X7M+4IgBVV1vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKpr8rwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKpr8rwp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55193C43399
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712313843;
	bh=yH7/HcTeF/mVH4P3dUmzZ0XOssJgQ3nGEXovhYJ3Qh4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GKpr8rwpz+96dYnptj90KKb4YpkPRGSvX/uOqO9WfDb2WuNfHBU5I+3Yfr3EoJoFQ
	 BaW/O+Kbqcbpz/yn/UOjuv/P+hf9RFYOvKGw+WRgnDdY0mER9uHV4gB/buExPpigLp
	 TfwqNUOmyCGuAnWnEEjqDGN6hlweHmtwQDFWQc5YpHL/PgSxlbthlHoqnn43uY8oUZ
	 WAnvEJcvCayhdrAvrbyrE8sHNkcDFAM6M8voMk/KctINijXDbyEHvnKSbuCNydLiCs
	 rNz4YOtyH4smoPD3IF9Ydvw5eNpBnYRp9eamxsWmWdy1b0poSmo0QK0YelbP/z5E8f
	 zGcTYoqJM7Xxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 476F0C53BD7; Fri,  5 Apr 2024 10:44:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218680] bluetooth connected status not shown in KDE desktop
 GUIs
Date: Fri, 05 Apr 2024 10:44:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218680-62941-B8vmd8N5zm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218680-62941@https.bugzilla.kernel.org/>
References: <bug-218680-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218680

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
