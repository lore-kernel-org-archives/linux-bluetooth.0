Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2B156236
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206263; cv=none; b=MBCmYaSJ0tlc/sji3KFL1Y7buEqZNtRpsUHjXVbB1uurzw67zPSUl8YWziOgbJnuo1qEmM9QiRmzbVCqrF02pUm7CZMOMleTwb8KVcLS+ck1a2oeYPPQWuQFTUh9xw7SQ4CSeiXXHxzrWU4WzoSHtHkY8TKNv2qdkVlzK9nSxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206263; c=relaxed/simple;
	bh=fchF0XY/BvJr58dT8U48pooLHuCaSNxs+JDDaXtj7Zw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BH1DNNxpVxr+3jTWkUphOdMplcWSklbIOxt9nyhhRDv02ld0tL63ZkQJw2lbCTdAaySV2h9e46xQrbLiS8rRsvHM1OjkRXJ3JMXVlh3PRa5nyWz+W0N1NT1aQItrcZxzrspDprThVPwzt9g3wS19FtNRztXL5rrJSK5lITJV+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoDpDdBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoDpDdBY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC56DC4CEF5
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 04:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766206261;
	bh=fchF0XY/BvJr58dT8U48pooLHuCaSNxs+JDDaXtj7Zw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WoDpDdBYsYIlDyD3Vupx7vnJNnojLFUOPPgk/aRRnPIGm9q6krthMtbIim4I13gci
	 GQ/A5zG/uVR6i+kQrIQwdFYA4nJWTpDcJkBybdMEy12FueCsRib3gCxgwX+cK3yQ/4
	 niE4QRlRNlp8sMBBinL8fLHVkVsJiWQ0V8uXRaZBgTeMqU68HcPBbPvKUFxU+A4rEP
	 aPj/pAawbwe2q40fB2K1nTysifjOtAOwC92o0lZ8bhS7b1Bh6i2L9K/RD97vtxskPu
	 hx4yWsdHBeQwTruKwRKRf56YjeWnK22SyoSSF34eXjGHwY08CbUaglrhMCflnuH45e
	 V+WbBxBk3uwtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0403C41613; Sat, 20 Dec 2025 04:51:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Sat, 20 Dec 2025 04:51:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cheako+kernel_org@mikemestnik.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-216936-62941-s57bZn7Au1@https.bugzilla.kernel.org/>
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

cheako+kernel_org@mikemestnik.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #309051|0                           |1
        is obsolete|                            |

--- Comment #28 from cheako+kernel_org@mikemestnik.net ---
Created attachment 309054
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309054&action=3Dedit
another attempt, see function trace

Seems like cold boot power-cycles a USB device?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
