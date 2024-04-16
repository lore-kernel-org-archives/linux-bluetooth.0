Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E47FBBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254042; cv=none; b=DgeY6NYLu9/ZzTeKlIs1bBBcDzHHBtj3rPlLQ18eTNKBfrWlMKNjBfz78Pz3ZqwYL47N8GWWTITjnG4i4zef3FrjsAYm4JYFI3T0Oh+u14tZ+2pTs1C3uucKfyT5dYODcF9I0UpUgC5teT6IJEt5yXnBc+nTmyvp9OrSgN/0EXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254042; c=relaxed/simple;
	bh=ziDxI2mZ/aPBKAJmgOYZ0sd5siTFBP2HhPboqFKgAVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihoe9NSnFP0ZNy2HH8U5d1O70WzG0QgIiZcGmALhh2y4pREeYzV60yrRkadIb37GJ8Wsq0yIo5+6SvDGoba5q/d8qYsSbRIloS8d90y7XlZ7TTocNIL70EPYCDXVRWVNXXgFMPwCe+xuAlBnA5pWMzU2ULofAj2jMX2GJR+ks6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZegZ3e4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZegZ3e4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8C96C113CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254041;
	bh=ziDxI2mZ/aPBKAJmgOYZ0sd5siTFBP2HhPboqFKgAVA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TZegZ3e4/mPUscpbVfjRypfPrctkekER9NqZ3mR+wFXeSJpOsnIFSPLM/b9TWi0L5
	 U5N509FdLXKxQW9HXqrxSliaS+3sQnoH39v7YWKcBsz1mM27sHqfQR8FNBZa3VDMcJ
	 ufjY5IlqSjsQopFS3Si/N7LCLcnlA66qkK46B6edsQSgGdHT+uujSHDtOoVvxOjDNU
	 x/4SOSF3eJaqNVfEzsvQsCRhg/z7mdIXapQSNpZh8NHqm0cS4KCZGbgQMrDl9GLjkz
	 /GcicYNHnBQpurbpsmVmjWKToKCXDuM4V7YtwNwyG/JE6YDHxbze5LguYgaWveiv3d
	 z7LKtdyGba61g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D171AC433E2; Tue, 16 Apr 2024 07:54:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 07:54:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-ChuaIAT8bF@https.bugzilla.kernel.org/>
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

--- Comment #16 from Wren Turkal (wt@penguintechs.org) ---
(In reply to Zijun Hu from comment #14)
> for issue "Bluetooth does not work after a warm boot.", we need to log of
> function
> qca_serdev_shutdown(). it is called by the shutdown phase of reboot.

I can capture that.

Does stopping the bluetooth service cause that to happen as well? Would
unloaded certain modules cause it to happen?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
