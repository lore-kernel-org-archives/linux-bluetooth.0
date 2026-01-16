Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5408225A38
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568117; cv=none; b=g4KzIbk0+nu56XP+BMxIS536TsaA5BUuCFPk//SJLoyxpK8/efsO5L8Om0QAmO+Stg4eXyoJ3Qkzb5aHfT1a74savcb6WroX08cqNviTYpa7YekoHFb1aEPiV4OW95SF1cd4o7sRsFoK+exMJQFmo4YthD/zJtlKvWtH+VJ03rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568117; c=relaxed/simple;
	bh=cqeaAKvZM3xGniM+Z1eJWPoGou4/vAMMGxicRx+LAdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7B2ODPFmxCTCZWeiJQzyNotrsIHDP4/t7U+lxifCqKHmG032UsxspQG3tG4oKGjvk/+DG2VoIJrD7W+Zaun0sNSM4PBTzvBWBouRQlINf4Ib9k/pj89voUc/hp+HCmjokZbJY6hpvRKJFpSmVJYNE3jqsh8icMyi+5XVzTnJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCHUpovz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCHUpovz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81639C19423
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768568116;
	bh=cqeaAKvZM3xGniM+Z1eJWPoGou4/vAMMGxicRx+LAdM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CCHUpovzfONInu+F0mhKJRapPOX+sADlYsOkHoQJ6F57E6A33iupN5e9kW17vJbDZ
	 WPiFdzxOPm0nzu3O/n493T0cbFhX005KzdzacgHkC1jsdzHdchsCiVugq24RaTSHCL
	 CUzOiXMz0z7QLo+u7DDl244YE9Xqd/gRt3UVRwwWDdIdckq66U3O2WiW7H31CWk8Du
	 ReYgu20Yz08SqfCKIyzRJ019ex/rF6CY116abPC92DoLt25v74J0UYhVzgIygxB5nZ
	 iEy84BAv62E6OPvWEonl2iW5BF6UJvlCpwh6BW4/fp+Eo1mozTteA4iq51UnxFo+9t
	 YBPYQUa6+KUXA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79AB7C53BBF; Fri, 16 Jan 2026 12:55:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
 stops working after user logs in to the GNOME
Date: Fri, 16 Jan 2026 12:55:16 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220682-62941-sCq3TyP5H9@https.bugzilla.kernel.org/>
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

--- Comment #6 from Bastien Nocera (bugzilla@hadess.net) ---
There was a bug in the earlier libmtp errata for Fedora, those are the amen=
ded
ones:
https://bodhi.fedoraproject.org/updates/FEDORA-2026-9e8ba7da64
https://bodhi.fedoraproject.org/updates/FEDORA-2026-59cc133f4a
https://bodhi.fedoraproject.org/updates/FEDORA-2026-98bf98c858

And we also needed to apply a similar patch to libgphoto2, so more errata:
https://bodhi.fedoraproject.org/updates/FEDORA-2026-ecbc75649b
https://bodhi.fedoraproject.org/updates/FEDORA-2026-b2422ec758
https://bodhi.fedoraproject.org/updates/FEDORA-2026-438abc45e8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
