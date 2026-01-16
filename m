Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406A1C84D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567954; cv=none; b=QLhVSQ1XuDTuJqiwqyf43kC0Gl+QWUyI95rjX+srGvxeqVawQqhjuVqxaKWkUNBpF+D2ygap7CQpToWprjBpMUBd3/A1Fm1RTSnvS++mfvXlqKwIC3/ujmM9q+51MYIAV5+L5P0CDQ0g3OL0qFcFcskDgDbvx3i5vStdL1qndW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567954; c=relaxed/simple;
	bh=8Dlow7vyX1ii0UhJDRwJS9eNHQ0kyeBhQZ+qIY7NuCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkEkOQDPLLOipsEUIjZ70usSSYHuu8MOMNJx8BIpyZ2zwqMdaTgP7KhpQFTuI4zskclFYT6Uhh3DL1dN3T6QgX9b2+77hEtaYStuzy9uaF5fraqj8MGi12IVXMw203yx+OjjBRa1Nl0a3aQHz+EOChqKiCE0uT8JF9MutgPmMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgYjU7Cw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgYjU7Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2499C116C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768567954;
	bh=8Dlow7vyX1ii0UhJDRwJS9eNHQ0kyeBhQZ+qIY7NuCM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NgYjU7CwwOYMrIdNUAA9Wu+7voHIGIRD3fWJcz6qQwbZvSz8qasAm29Fhwi56QJFn
	 krzc25ZmP/mXKMcIQSMn1tWj0xNJ3HnnMEdS0o24VJzzrmg7ZlgqnQIchT8t59d3zW
	 VGfC5yq+OWtnBM1m3XKiB8DHzc0lffaWFwsDQlwKR7+BB0dKVcwFqWMJ4UqzVncUMc
	 oWKJkbe6DzpShpChMdg9k2cfyBPzCDatyZmhjN+RRtASUH8s9W3AusFwtisPHtkTC/
	 VNpy3iAIfHKp+s4IefnmKSD//JI6pEkgwNC9my2Z4LqHIiveiQeP2mEV/wL72/Lp8z
	 uqmLeYBO2Agiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9892DC53BBF; Fri, 16 Jan 2026 12:52:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
 stops working after user logs in to the GNOME
Date: Fri, 16 Jan 2026 12:52:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@hadess.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220682-62941-Uq1paliJSP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220682-62941@https.bugzilla.kernel.org/>
References: <bug-220682-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220682

Bastien Nocera (bugzilla@hadess.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aamolodc@gmail.com

--- Comment #5 from Bastien Nocera (bugzilla@hadess.net) ---
*** Bug 220986 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
