Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39165103F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580409; cv=none; b=Gr67q1dE4t2mOpQvLfSWsdQeZElx/8biojW1PwXxcNW1IXrKnIo5X63LPbGsizUPm13zzA3A6WtYQs2hhTlG0jjAvP6WKMRg7uh3fIIm9k4clwCrCGi1WIqdW6Id2ghCFGKh1CHf9i3RWJxPo8DyPr+GMuYcbnECgFGmxFtMk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580409; c=relaxed/simple;
	bh=Uq6Z0OseoNzyl9o6cfUs2dZdeNETcu3NraBsLKQBbiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvcJTXUeN1UaheLu4zm1hoDsJpCrX+GtBEdYPt8GqqwZaN1vI7Rd8dxE0csBAaYreSrfcqC6hFsiQU405AAEgZLeSkPagQPXk0QqeTrxKpJONimQsVXkf9zqN4pPjdN7TDiwsL+RYr+rtpp2827N8qqGHoOgPZ57ViHHnb8a4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9hCuDXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9hCuDXf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CEEFC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580409;
	bh=Uq6Z0OseoNzyl9o6cfUs2dZdeNETcu3NraBsLKQBbiA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I9hCuDXffrN/eVfDg1k9cv/at/la2lYyeTwNSoCmHoLeXuGUS15yH3/oitNc/3omU
	 DpeUTOEdZOJQYMY3nXNsbnc3gjY0VK4QLn5u9DHXLefE87+JvAEejDGcD02mN+fQ/G
	 XLZrxKGeT2NH8mV0J0npuIkk0uYl/e90/vSBzbhv61z0+FLQoxCMNuizqlEfuRiIl3
	 8nCJOTqZ70iKLY/lQ+jaB2xprXRWcy69j1NBq9gUpKxqY1ps25FtRSv0mXzO/i1sfM
	 tp9QnhmH0f1wxsaZSV++DHoi0ihatRqGQ9ZCaA1JzpxC1cdM6wdyaO5VvFt6ONKQSa
	 pcfBnlKcWRvqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 538C2C41612; Tue, 15 Jul 2025 11:53:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Tue, 15 Jul 2025 11:53:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform cf_kernel_version
Message-ID: <bug-220341-62941-T2TUSMcx8H@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

Martin Hignett (martin@hignett.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |Intel
     Kernel Version|                            |6.15

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
