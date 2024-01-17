Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF51401E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487929; cv=none; b=UOnrZ8QbNpRup/dYFT5C1XxLrq+cigk5rXK9UoJLtrRPX2wueBdzW8SATpytHS7wqNjyIg6gr7lGzfsmB+LllmcUEK4pfN8Q8Ndb9goemfC/yG2RKLsI/zer7+qBQKMEQHbXLgie1hB5+Fa72/R/y0w8mCEIk6JogOtj4FVFteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487929; c=relaxed/simple;
	bh=8g3yBT+OrI6gvtNJydKMBBlaT9Sp9UOdY14fYZNtYoo=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=d3Fe/R70n9ZA/ZkYWzYZBkx2j2uVycWsfzUtzV01TVqFplVm/m0/KTCqxc7SQVo0qR7kxjobqwhIluId79uVcuNjE+D05J4bbZGiN+Rqeo3OueBS/55i+pgJgX3nNw8Acc3iM+heY+s9HOf93ruocqJGUybXa2glYLCcgZG/f8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVnrejPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVnrejPu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 383D5C433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705487929;
	bh=8g3yBT+OrI6gvtNJydKMBBlaT9Sp9UOdY14fYZNtYoo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cVnrejPuHzyE2Ru6dPUROBXi/u26LP5WJ5/j+9YCSesRKWOGVFv9VD+XPN3s1ywaZ
	 Pkb5fgN3gWUXZXSaDClKAz9RWo2y0o75VbUcRLRhxO+Kz5bG/72uvSteNwS3H+GXRQ
	 NeQKXkW2MLNVbmA41ohwdtrUoRx9K86o7DJXBoypf37D0Ex+50s9liQbh8JiBREZIb
	 Mxhqof/7uSlXTxmz/0vwKl49uODy8JnbgFHiXjWssFlNZMbzWgG9RcPHNa6TstiIG+
	 tpbEshaJ8VMmHX2gTVuWumPxUJ0aPr4wIuRwim2u5cn7zjZ7Zb0z9wmM4CxsZZLzLl
	 k9tpFodrslKgg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 28E1EC53BD2; Wed, 17 Jan 2024 10:38:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date: Wed, 17 Jan 2024 10:38:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dront78@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-PjYOKLuwiG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #56 from Ivan (dront78@gmail.com) ---
last one sounds like zstd support is missing in the kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
