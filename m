Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6E82892
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540311; cv=none; b=V82C6jHmcJCggWKA8mWKIBDWM6vZI1abxQmQzWfflWGYl7PvHAG/t5g5P0NdegYvdaiz6KhhjH0Y9si3AQfp/vyDJ/i9UCEwOfqaLrJJlwreoxZYcFZhZt8ZczJ9zUDlZPs39qOtFjptmlo/eW6P324RR/BYpPcFmkaBECmGCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540311; c=relaxed/simple;
	bh=GdnklgyOv991Qm7pDl9guGN9UTK35HgPNqw5A1PXAzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMf0Xh66LGyEile1I9CrP3IPZN2IGlFCElGufZCrez+rCwsiXot7f46rqhnKXqwT62HKQVQpxrLs3uqh9a3NdjWVVgGAeXbFruLOmw9ecdlPqC+OqG3wimYNf53c+oQKGy4xrlqb3b2KxCx8qc+xpM3tZoupuJS5j6igyasXwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbZln4q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbZln4q3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A7A5C2BBFC
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540311;
	bh=GdnklgyOv991Qm7pDl9guGN9UTK35HgPNqw5A1PXAzw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FbZln4q32cWYpEAsdjRq9fAPxfjCHRVA1TVw0y1tMxzRe2kZBU7s2v67VotHjKh3A
	 n7THZ1N0Jn/EHiTnxlX3GVsu/fd/T0TRaD8AIY8RRKZITjXdhA5+9oSjGDBZFhwGeU
	 yYisOgmDIMX4aZGZQgmQXBpxN7LHX4LbzSAc1OMCuBBuZCojOCZQqCrmTwJYMPKzGG
	 FwaiW1xj05Z/0OASXP5watKyqLAJVKsQfmGmttWU0pIXTm3qgP2kHTteubmuPX4Unf
	 ebmZTIOiieonoXi0EOvxSBAqh8N7E2TXP3lvQg9Zqd/jlDGif/wK8nDTMUfU3FbQy9
	 XFR6ljanFCGjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5185DC53B73; Fri, 24 May 2024 08:45:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218880] HCI_EVT Packet 'Flush Occurred' Misalignment
Date: Fri, 24 May 2024 08:45:11 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218880-62941-QybuCPoeRO@https.bugzilla.kernel.org/>
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

Yuxuan Hu (yuxuanhu@buaa.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux-bluetooth@vger.kernel
                   |                            |.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
