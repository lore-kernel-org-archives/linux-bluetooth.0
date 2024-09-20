Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD04AEF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726864821; cv=none; b=DyD/IAmT/8G1J5/TPuT+tF5lojSf7iQLeBj0haXOaayefWwCGWY+aRIy3X4ruyiYJDzTdZL2gYsa9RbZpf+IO58dQOpS9ZTiSju4m466V7WTNTMFPplgxgpW/TKjEw7h4/RXI7JfIL4pNyJ5Qh+7feh/hTlfNlSgIfAAVs5RYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726864821; c=relaxed/simple;
	bh=yOXTK331P8LcM4xwqy/RqioOiDgua8OTyuNMLc4i3BQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thd0500Mh/TxdP+jFAXJl1s88Em64wATLefGJPvZy6fKPzNjVT+o2wEg3Sd37pTmbbdnoN+XvZIFcPOD3EEPfIs9k3fwH8zZBwNIo0MdhwbybjRDoIflugvtNWoNH3QAgqaSme48kEcS1XrqqmmoWv75qI89zQLbVP5SZ7knUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQMe+nSC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQMe+nSC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A7E0C4CECD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726864821;
	bh=yOXTK331P8LcM4xwqy/RqioOiDgua8OTyuNMLc4i3BQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TQMe+nSCwBTHw7LqVBHLyPfoulj+uoVp+YGyFTo+3PDkk7ZPa8BIKjfhwOUPekaNw
	 RHwLDveF2LqpurIZA/lAMdWLhUPGyHIx5nDK4FpYRDs8dQn8CRmQPHznJrPm6K6q6Q
	 fv1IX2F2FymOAUeosz1VRuGU0BaIkTjrVsKeTkvZlGoQh0SufWTKiXb03ECklez+Yt
	 G4Osa4v55B2TraFrNa5BjSeqOddM6rfJU27uhNsZJihhQAnq4WK8WxNM/U/p9uWvgG
	 45hwBBWfcXagiM776qcDF8IFpl0k2C5BgegvV9aLGjjkB/kjHSG1dEI9XRzbqUAG0w
	 I8H3rxVBxaXbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 232BAC53BC1; Fri, 20 Sep 2024 20:40:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219294] NULL dereference pointer in Bluetooth at boot
Date: Fri, 20 Sep 2024 20:40:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: casteyde.christian@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219294-62941-hEtJv4S0NY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219294-62941@https.bugzilla.kernel.org/>
References: <bug-219294-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219294

--- Comment #1 from Christian Casteyde (casteyde.christian@free.fr) ---
Created attachment 306905
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306905&action=3Dedit
lspci output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
