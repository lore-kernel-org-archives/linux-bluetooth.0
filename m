Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D873EB103
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029050; cv=none; b=FDZxBsWvw4DrWEdWh+9UP09K5/ij1c/fv5czbZFAJrM5T2ibgbpmruBouy8yOdV6xYKT0zduntseXh++OKi5LVq8iqfxkfP77tYU2RQhz88ECZudIiC3GF20MtxtM3qpW51NRYu+/W/qwymkuEzc1xQQ+7AtLv2KH9Hs+dHvUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029050; c=relaxed/simple;
	bh=MKz2bickWchm7uN7EVuwrcz3klw12T8waBKrq2QxVSI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jo0CsTYZykTF3ff+GSs7mHEI+HXAUPk2es7kEaFwgwJmolSjYY0wH8EWwwBZSvyehRyaVLW/fVCrf+cWSpBbvSMf0gmhIFw0nWlsbhDjNTN82xlm/lfmWM+vz6RITImWWgTntEOFntiuS2nYPzSeO4m7Ypmbkp1L50bnLRGKYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhFUcvya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhFUcvya"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1701FC2BCB9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781029050;
	bh=MKz2bickWchm7uN7EVuwrcz3klw12T8waBKrq2QxVSI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UhFUcvya2uId4Je9wqCmIBxOU03Iox0Ac21rqK4CteDMGFm7/B2o3LTRj58hPS4Ke
	 2E1iRWjSEA/I0eclegTm7E7zJXIt9LWRJowMzCiXmYy4Oxj+0iVW4HoUL+O5j4+2X2
	 mzkKMB29UXkrcAJQvk2nwQ46/vykQtQt2KmXjios/Hbl56Eij14HV3zzXJfOzrdcWr
	 xvOAWgXM2+JksP/fhb3tVCXzG8+aSLqLe27wrI+oREMni+cjnNT4X/zfV5VsV7OYF0
	 YqMSorTtPg+tGyil5yYgRgLYZyhcPEAiKu8eoIiaQbxmokqWoaMe2w0TwhZc3lM06h
	 QlPfXk7kIrKpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EF51FC53BC5; Tue,  9 Jun 2026 18:17:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221629] Bluetooth l2cap: ident leak in
 l2cap_chan_le_send_credits() stalls BLE CoC
Date: Tue, 09 Jun 2026 18:17:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: florian-evers@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221629-62941-9BlYZYWCmD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221629-62941@https.bugzilla.kernel.org/>
References: <bug-221629-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221629

--- Comment #2 from Florian Evers (florian-evers@gmx.de) ---
Hi Luiz,

I considered playing through that process of subscribing, checking out the
Kernel repo, in ordere to create a patch... and decided to write an issue in
your bug tracker.

Please... if you don't insist that I create a proper stand-alone patch... my
two cents: "just add it" :-)

Thank you very much. with kind regards,
Florian

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
