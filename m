Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD222156C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146833; cv=none; b=QUeBkYCKsoizn/RiDv3UzCLcP3BOH/VbdLLEtoZjch/EN8jrRMnsQWST+9QmEsOS71sfhlmITVmY0PVrlyjBNCh51TM1HZDERox0kVfBIKapZPcD4EV17PY3RD7a886V/F32e871a4M2joEBRqzWURrdjaDJ0tEjRHcLVMjkSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146833; c=relaxed/simple;
	bh=l7vI4krgQtX4RTKorkUvdXM6mo59Xsyhh4sZSFij1/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzwNBjvlqcxIwxjfchWbCfB23DqZyGeEzy3ri9rvNch7+hU8E0NQk3R3SGVqVYD604zqqDj6DRXKVFUT36fqlSm/ZAOFkwB1SaD3XASDzPcxht+HJ6BHhxQBRtx2YcvwxPcO9/+vteOufEUDLwDiJg3rw8OEbTw6ZjF6JZqkAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC/IOSQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC/IOSQj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 778A0C19425
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776146833;
	bh=l7vI4krgQtX4RTKorkUvdXM6mo59Xsyhh4sZSFij1/o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EC/IOSQjh2SdZAwPFWiLQxjiC2NvDIX8S+Qo++anXQ2VITL4weAvsar0QB3bDFawn
	 9jH2zgOIa8Y2J5NfjUAJXlftDb/shuX4y9Svei+vzohJIhJpHFDSi4SEV6orxMhR6N
	 xg8/jsxye5hcq0uVk65ySOH5QHEk1ur87jFG0LhKP5ENo8zE2oclsOFdsTvWfBeC56
	 orlIIAfcTcYUgiJbq6T2x60W0igD4msLBIdzS0Abf6bEU+qWklASrogQ0him7sCDwx
	 R0U+dO93Ns7k87BJfwJBojod+72wRo1c1V0mqYXh458AsTuX5uJHm26ISFBn9QiX4P
	 OUV/oFJxeODgw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67891C433E1; Tue, 14 Apr 2026 06:07:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Tue, 14 Apr 2026 06:07:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221346-62941-G229zVyJD1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

Zhang Zhigang (zhangzhigang1996@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
