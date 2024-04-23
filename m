Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55923EA95
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916373; cv=none; b=J6UxT2xIrG4jC4+8W3MYn7Qbc5OaWR8sF5sLXxid8cjRV5M9qS+Ejs4hRMQLa4DbWS89agS935i9UbO9u/feWBVbKmpIhzCdsQ56yf/frk8eaACjzLI57VBKYzKbz4YhCjGrkD8J4X3RvDTrkMOfguhpa+3C/NTTQ/XVYp7wxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916373; c=relaxed/simple;
	bh=9b+S5jl/jKsVQ27cZ8nY4u44EGfr32p8LTVLO/fmInU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u64869xDeIU7JwfCu3Sr606TRISlU8ou9+AzPze1xUBb5/+wLV+maya1NsFI00LpD0v8/7fvMeE5G30Ci6BKe7W4oEE03Sr/AjXwkWtiPSL7eNgh4LwNw0fe95A2x6u3DUepS4VYQiu+6pNJ/S3lcpXe1glI5zaXCjdF33zFxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEaWR3ha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEaWR3ha"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38114C32782
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713916373;
	bh=9b+S5jl/jKsVQ27cZ8nY4u44EGfr32p8LTVLO/fmInU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pEaWR3hayUd5OdKXM1APFTIk0Hc1xFE8RxRGmkKFW68TFtlfO59Jz4is3jgoLoQm4
	 IaBREKmW+cRRJDpvFd+YyrPGhNiwiIrPfwAh7n66syWhNMDDj2bZfchgPg1YsyY2bC
	 6spkHwL+Q1FN2pfLXEpaLyZDP0a6TmqSr3i3oQo+HstrwbWzsIyP+y7LmTKQw9l5Vv
	 +il+sTJnrtQ7MNZeebGoMFbI9OWrcSYX6WcYpqzjpZATeLIMupcg3BcETZoO8OjsDP
	 B6g/ELSJFo9/X3EL4AwMfgPK/0QCOIx+0cTIjfzzVA7xgaq/IWDjR7G4X8hBoWD4sQ
	 S1AK6bfFmyZBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2914FC16A72; Tue, 23 Apr 2024 23:52:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 23 Apr 2024 23:52:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-WvibfxHuiq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

--- Comment #46 from Zijun Hu (quic_zijuhu@quicinc.com) ---
this issue was discucced at below link before it was reported to bugzilla.

https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b=
4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f

as commented at Commented 37.

it is verified by applied apply fix debugging changes over below bluetoot-n=
ext
tree commit:
e00fc2700a3f Bluetooth: btusb: Fix triggering coredump implementation for Q=
CA

it is verified by the reported device a Dell XPS 13 9310.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
