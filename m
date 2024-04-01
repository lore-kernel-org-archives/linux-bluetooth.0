Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06959B4E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003635; cv=none; b=ejpdd/EDsjxDlvD8d7wam4VuC3g2e7mGxaTh1ALNE0xWyWGgK85XXqorl01yjCUuNuxaH5WLOcTVwiGS3Vcc3w/gW1l/BUqDpLGdmL5hjUBGxoCj8Z6Nr5oN48O0jol8X5Eedwt7Gj/dFg99rhh5tqEwvCUDrkM+JX7LCnvkxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003635; c=relaxed/simple;
	bh=72vL0S+GEyPM8cOJlFBEliv8BGJvKs4xegAxInsrc44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKNYj6bMaxMlwFuyE1RgWQmRsjmyHio7zzggsDDbEyDBm0rVg6mbvV8RbqCC5p74L4ug9zPUtwGyezn++M5xLJbcZlGuhLvGUV8pnEXeQRMlm74jEG1Fzq7n3DfzgUgNOHiyPI0YeBep+b3sMnVj57ldrym1uC+PWpOxorHXrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7xi0MkE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7xi0MkE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2145BC433C7
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712003635;
	bh=72vL0S+GEyPM8cOJlFBEliv8BGJvKs4xegAxInsrc44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y7xi0MkEPkkGF5n59TZQlQcGpHKav/UD381qIHpFy1bVCfGa7OlhtfofrlWYcGg29
	 bgCXISaNqRFDdxXnUQZn8j4Uwr7Wh0D9h/9Ha5W4AGH041deJrzH0ebB5DypvK05Ra
	 66g1wtC4kUO2DcoZ58FfBbCaZuSfBRbG42nPpJQIv3ihKxlaM9a4IG/vdCv7uOU94m
	 5qr0y2JEf2cNTsAmp8kNgKc3rxOoMAd+BXXbspWlCoNS1yldFpI3/o//lqcQO/62Y8
	 4BqPxMlmSO4v9P7+xYetjiLlNtd4F4H3bnQlcbb59E5qqblkO5E4aoiLpGks01r68Y
	 xZMtruVzucrBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 120D2C53BD7; Mon,  1 Apr 2024 20:33:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Mon, 01 Apr 2024 20:33:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218651-62941-B0nEZcud3O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #20 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #14)
> Fix now queued for the next release of all affected stable/longterm series

Hmm, was the original change backported to stable kernels, afaik I didn't m=
ark
it to Cc stable:

commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Jan 9 13:45:40 2024 -0500

    Bluetooth: hci_core: Cancel request on command timeout

    If command has timed out call __hci_cmd_sync_cancel to notify the
    hci_req since it will inevitably cause a timeout.

    This also rework the code around __hci_cmd_sync_cancel since it was
    wrongly assuming it needs to cancel timer as well, but sometimes the
    timers have not been started or in fact they already had timed out in
    which case they don't need to be cancel yet again.

    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I wonder why it got selected to be backported, in any case I don't think it=
 is
a good idea to attempt to do backporting without having at least a Fixes ta=
g to
begin with otherwise we risk having problems like this widespread to people=
 not
really running the latest where this sort of problem is sort of expected du=
ring
the early rc phase, so instead of having these 2 patches backported we could
just remove the above from the stable trees.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
