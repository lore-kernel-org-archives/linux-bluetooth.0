Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E26C2EA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088278; cv=none; b=trREx0gH6PTzIM+yMwEb+f3+rb0pyzi9X5TlgBtiKucuRMRS7JV3gjYZ/2FgygN3B9JlrtIkcAXIVu/SgwcJG5tF2Q4rtK042IClvzEj930ZggEjNeYSDEfvE9ouMiRYxJBm6S+E7BNUUByahekPrg6GCKPKiIBd7dW31zM9OKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088278; c=relaxed/simple;
	bh=vsYBRMMXDzCVC33HfRT4W0gU87n4hX5N7UvpAHxmgGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iz779naROGXsVl0EoMqqwJ5Q1TT6KXSEUHrxEciG6x/87tOtAjDfKYC4Qptk9+WRq96cVPpiM3B7377lFqgU6tWziDQ+01sj5DEnleV5fd303UBBO2x+aRKQ9AO0HF8Dr/x5FgeeqnKD3Cpowj77tgVCt8teiQdDQU3oczxPqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVWEL7pB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVWEL7pB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E796DC4CEF7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775088277;
	bh=vsYBRMMXDzCVC33HfRT4W0gU87n4hX5N7UvpAHxmgGU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PVWEL7pB0hRSuVbtttOc9vhcXyR0awKDl+0mQOQw3mKtr4lpBtXQY+k8fNxVBrujB
	 kq37FXb2TVCgJr41PjN0dqTtvcwFOKQQPbjIaZR5E8rqxiTNNffxseN9WEnzyBgvhJ
	 MLkeNBzlHO5PN8HOkWWerXj97RCFCH2UZ0VLkD69Iw3kUivLzRO1F/JVfYgcAQsRix
	 iK4wA42RPHOA6VyF68rleGGDxj11XcNPG5NvLiSE0bC5G5aIjYeI6zBjL5GzOYuEmj
	 dzqiAAOGVAM5vmqisLgWuWl7Fi/yUCaFvgLSTADnPupCmiBpKfPr3PbD0asGExqbBr
	 6l20E3VCC8uDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DB6B4C4160E; Thu,  2 Apr 2026 00:04:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Date: Thu, 02 Apr 2026 00:04:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: i+kernel.org@schimpf.link
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_kernel_version cf_regression
Message-ID: <bug-221309-62941-wS09ufbMTD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221309-62941@https.bugzilla.kernel.org/>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221309

i+kernel.org@schimpf.link changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |fbf93476
     Kernel Version|                            |6.19.10
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
