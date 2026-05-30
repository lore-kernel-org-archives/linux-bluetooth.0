Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C8298991
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154431; cv=none; b=kSy8k6Xv96L9cn+hj2Zv5nATFBL4uVN2LncXueO7z/weRmKea8fhS+cK7EmpCtNEZjQ0K0pPiEqGXuvOnQC131vVhqMDk+pIHjDyFnHiJCvZFypE72oRMB3s4yVMNrW9h9aiXCQggFvxykPy1ZkTNzChtb/UOpa2X6zKytuKc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154431; c=relaxed/simple;
	bh=d1gdpH68zD3kvQfVyXJKNpRTV/V/4sBle6/PuwL7NGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePH3AbJJ1EM/LVaRpg9LmKW+Y9WmVufg+8pD+vr3kw44Zgbu5nxEMvzqFbJ23JSqjk8XKPA09ZarL2afOztUcfAfZ87Tr8EdWveY4OjPCeCTH830pmbLgRjfYjofeKjMnzjx2WU87PqpCohS8B8fWuqOqyJMMhCnzBjlcQMH0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOZnNwfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOZnNwfi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76F0FC19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780154431;
	bh=d1gdpH68zD3kvQfVyXJKNpRTV/V/4sBle6/PuwL7NGg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gOZnNwfi3Fnr43BSEYtBdArvhVsaV8/HLl5t71bFFTHBt31TNIVegXUSqSmXK+kiA
	 SpOyxoz2SK9MoJRwbXLQLnZS/Bu5DbQRWTwAqPkNivmvgcE24FtYIEo1/vAcH3R9xn
	 0sk7o+mHg8a/fG3m81eABmXi7qEOsqlCIfuRzGhPg6Oo96T8jDy95dzwB4bgAw4Kg3
	 H2RyuQk4Sk1TjaKVEgl4tnOTfPkcQqugrubrXgHSFxhh1qFWZUWsHobvycB4YC7HxN
	 INds5MPg0jH0Md1SfdqwZYUqhD180dsZqFo6eUGhS+n4iJaTgLDqu+NmowtHCP31xl
	 +mBBlMW4XlPWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B575C3279F; Sat, 30 May 2026 15:20:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 15:20:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete
Message-ID: <bug-221598-62941-vtPVyjN6rN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

Alexander Paderin (apocarteres@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #310211|0                           |1
        is obsolete|                            |

--- Comment #2 from Alexander Paderin (apocarteres@gmail.com) ---
Comment on attachment 310211
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310211
btsnoop captures and report draft

Marking this attachment obsolete because it is a duplicate of attachment
310210.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
