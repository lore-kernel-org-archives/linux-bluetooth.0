Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357862E1746
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125718; cv=none; b=HdTG86anryikR78otzN4PyTRA+TuP5TPl+JBOV7By8HZIZV7TaI/JIaind6YA9VA0SLVrR6FgZ6oWSnLYHI17UNr4aUK9KOQlv27brnqUJ+Yi7qMIwqN4K8ScBK9d9Fk4Ve8nbg1Dm6sxeJnGwE89Ti6cbb2tmDA5rDLAyab9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125718; c=relaxed/simple;
	bh=0kUOP0A6Yt7feahXEqMGWokyNWShsQWoZCvdt2a7eE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbOD0bF17iwZqmSkAckGXKC1etQIA2tJbfdQls+D/w2qZx2EcaFhPmtmSgHSiucAx8hw402hBEOY7ahGV/YwBwfF31/zfANYxgHHZx0uOa03FxoD56JG6fkNnCbIXYp9cnRrh4AOp2CzSodxDLvdm2bvLWrqGwaWUqrO1wIzlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onrV458r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onrV458r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF368C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775125717;
	bh=0kUOP0A6Yt7feahXEqMGWokyNWShsQWoZCvdt2a7eE0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=onrV458rxxrj10SO19ZPlS/Y7nNknGldJTMfPI8K40RFdyai9gojsDf1tymPYKimq
	 KLT+krn7WHJ4czx9Dc2KZcXiYdavc/8i0i5IomUOpQ6zIfHCK0nZMQJCudXKqgfcw3
	 VygVEpTGBrmhXEPyfSQNV1Dy4uJCC29ZnwNxybDO3Udu4gxmRxR9eLMhNhmB5zJVAI
	 nu8i+/bxdlMdS+5HGBJkbq4yQiHRbOtp2RVSTOxAmJtTkmly6cerhMQ8iD6l0zeRpd
	 6+NiglZanJJsJQ8vXfhBVq2Hll35cxB0pcx8G+sRRjub0SN4mzelJTJbDWcLBlkzR+
	 a4tGPHg/Thuug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B5E9AC53BBF; Thu,  2 Apr 2026 10:28:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Date: Thu, 02 Apr 2026 10:28:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221309-62941-JzPJV1VKnc@https.bugzilla.kernel.org/>
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

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you for your detailed report. As Hilda does not seem to have Linux Ke=
rnel
Bugzilla account, I replied to the Bugzilla notification on the [Bluetooth
mailing list suggesting to revert the commit][1]. I wasn=E2=80=99t sure, if=
 you would
be ok with me putting your email address in Cc making it public. It would
probably ease things up, if you would be in the loop.

[1]:
https://lore.kernel.org/linux-bluetooth/bug-221309-62941-wS09ufbMTD@https.b=
ugzilla.kernel.org%2F/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
