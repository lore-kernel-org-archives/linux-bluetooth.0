Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07EC23DEB6
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655157; cv=none; b=G6aQtfVyQp98NgMZCea1v4HqttV3GJ/zGsHbLbEOqAd/PdO/yeeWj1eYvmB/UT0uLCsTxDveVFICWC3XDtQJM9EQpbn0g1q6dHrw8EYwrx+D9fiosqhwTauUtkRHeSTnzLlqZ9KooV3oWg6BIkC60/9ZoeajZiL55p1ORIcD1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655157; c=relaxed/simple;
	bh=fluJYSSYCw9O0LmiFHfnIz2FRzJcl4l37rmowhGLMWA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDbSwG5uVI1rUeaSbdRKYakxzkmehcsUFPTvDllWKohzoTSaptPGRwK8lRGOBrWPDHinUSSmnaRle6GgefQy1K1W3hHzhFOMbigXvWIeAvADaCPzPzwTpNu9P4cQ4cb5X20iB8I6p5F1tGJfTEARYVglV1Chvn4ZTx7UbtHZA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8yYEiaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8yYEiaF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49B19C4CEFB
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766655157;
	bh=fluJYSSYCw9O0LmiFHfnIz2FRzJcl4l37rmowhGLMWA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K8yYEiaFsZ3QFm4yJFHpoA+VFORwHMruph2XZ2l0JCozEo6Fad1c6xF9Ko2KSp+4k
	 Ed4P4Zid3YmXoU54iRvP2XrL2gtQE/nJAzCeWxDaM22uSlhaNow4CbAIf1vwVDg/vD
	 IPtUmYJq1FQtLHAvfywnKaHxBxTCplAI5QSUUUgcz3T0zFxfVREv7/B+ojXwnDwF/X
	 8jqHuhK6LojHPwdmvWfb2lYLt7s8FL4gqDnm5SaAy9RPFSZYELlKmLcqyndtY0wIUp
	 oArgAXtqg+5bK+tPEl7Uv1FWEvAN5BpeiKy5igwwyMkTCLpAvzomQsl15pg3xlP3sL
	 IFL/jLAD/fM5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 372C1C41612; Thu, 25 Dec 2025 09:32:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Thu, 25 Dec 2025 09:32:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jay+bko@jp-hosting.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-OWoK8xHvwX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #39 from James Addison (jay+bko@jp-hosting.net) ---
Thanks @cheako; the device-id of my wifi controller is already in the
fwbug_cards_ids array, as far as I can tell (0x24F3); I wonder whether the
laptop itself (X1 Yoga Gen1) lacks the relevant quirks definition.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
