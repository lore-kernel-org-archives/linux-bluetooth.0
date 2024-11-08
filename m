Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745D5B1FB
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083479; cv=none; b=I6/MCDJmFragYnk4TpVYtBkZ+N7A5VR1yfqxIwRkMosF6FxxYP7U5hjcl7iZLe6OQXkG4mBSdLlhDJXf7g+YPE16VwRpZDx7kb7RUDokcktFKYRPoYYi+6MgZiIzyEiGJ52qNEzASszlrmPuFLbLEHxEmWiuh4bGZAFM45iQKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083479; c=relaxed/simple;
	bh=wyjE0L3RRibKMVv606I1nr4KKcOTgCFknLxp7p7zjJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzsU1sV6Ix1ihII69s9E3olKbdxKZfqo+JAzVWSlN/1tpJzcOlYTJJ87FfC3MNgyQ3BIgvL815XzhF39nmRDNF+T/26ZnJqS71mjQMyim9s+b83UAxkhe19DrZnbCbacgH3yHeBKy5y7tJbcBzKzb4D6Sksi+GURkwCdRdBXfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQjnEAJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQjnEAJe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FDB6C4CECD
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731083478;
	bh=wyjE0L3RRibKMVv606I1nr4KKcOTgCFknLxp7p7zjJA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bQjnEAJedGxoCYsMopaPFx2QFszxSOyoHNWwUC4pZsqIjtD1ZkjS5bhDH5zq6bfCm
	 R6mYKOvWR5YDcCCMwT1RQOPP/DYIXgcJiQDCRg933dYoWUKj77JnJU8eUMXeL3LMbz
	 pZ1NGxxcD7QUNEg+oDsNxMyx6XxemhN+cTJO5GZOCVCCK3V3fhN1nAGwSNPjkTdoCt
	 2s010kYCrq/E6sly1jtH4/IawOWpMjktHC7+1u1QG6uLkBCN1HuR2AiqWVmH3ccN/i
	 xak8/miAB722Y3T/+fZHP0cBpZyu5TtZUxV20TAWj8PwQBdwLzvmEaUqcm88C8eJV3
	 6LJM4HurMGbfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 84D0BC53BBF; Fri,  8 Nov 2024 16:31:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Fri, 08 Nov 2024 16:31:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219458-62941-YsCIxIeQ2K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #5 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Created attachment 307186
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307186&action=3Dedit
Bluetooth: hci_core: Fix calling mgmt_device_connected

Please try with the following patch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
