Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDB82892
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540485; cv=none; b=mxhNe3FIgqaoRAMRVyWY+OxGVFixSiJmP0G+XqDqF/c4b7PK0GS/dxqTkXiayPfhmGRgEF2zPz5bCjj1B/BEo0P992Jbmv5zQW6ntTOwyqucwCm3gDONuRY9D316WG1XhAZNsq8OI67yJIrkTS9nls3+7y7C1jideVG6m2XaRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540485; c=relaxed/simple;
	bh=4EkJzgqhbMbfjBcO0SLBQlbkCnOXSuuinrLZa4noLDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5RUlirTC6cTBeXSBLCOQ4PCrDPwsvpjiL3Yi8u/97UtwGsxtXL3HfH0/+ZRaUFtDKm8+S3sHWt0m00GnZNFy+v/hTu2+HbzrmwYLJv57OxQcX8Lwxx4DhLNaV8Tz9P0vSqcRjbvXwvTtP6BewuJPtEFUeLlfA1P7QDXyiUEFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4br572f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4br572f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F5DEC4AF08
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540485;
	bh=4EkJzgqhbMbfjBcO0SLBQlbkCnOXSuuinrLZa4noLDA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p4br572fI9koc+tOnM38iR70YS6b+e0UxKzqNAbWS7+S5rVvYFl+F6tS5NobJSTW2
	 byq2AOe8+3sqWr+g4Hq4FRioTVEGbtqN9n47ZUdcRO9zVPIMWyoUCKYV1THLkVcvZn
	 50YJMN3Um5vEGycVnEqSPevqb1coXD8IP6ECve12Br94uTho3afj5w7OgB5MNv0Dk/
	 YRH0puea9KV84rw6rbr4JXI+Bahp0CvaoVUJl7GI3b0DY1oyBGB7/Yh4sA5P5H4A0N
	 Nqyp8mhoFd3TGF/fREvcDgl0FNlDVnZ2VPQ6XlXCnSJToYkYQRBWLb6o0WIgfaBxtQ
	 qgUhzPifC/FAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 06A33C53B50; Fri, 24 May 2024 08:48:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218880] HCI_EVT Packet 'Flush Occurred' Misalignment
Date: Fri, 24 May 2024 08:48:04 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218880-62941-5e9Fyc447T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218880-62941@https.bugzilla.kernel.org/>
References: <bug-218880-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218880

--- Comment #1 from Yuxuan Hu (yuxuanhu@buaa.edu.cn) ---
Created attachment 306328
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306328&action=3Dedit
Kernel Log including HCI packets

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
