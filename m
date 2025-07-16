Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090021C195
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650261; cv=none; b=KqzACYrbZ1n8x30gbzrUx3bEM5adD5K4fGvm311s2XEA0WuEFilg/29MFLLbiZWqRooCVnGZDarnB3YsqTbXaJNeuaIhmKnowaItt8h4cwkFJtLeGli9iWnkrevQZjKkeKN38ElAAlXn9LkiMaSNSJYx+Dx9AiYhweQi/92vtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650261; c=relaxed/simple;
	bh=Gis8n8U30G6RaNYBaa8SxUUxlSxLM0Y0xpcyBoev//4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBojGjOKO5epS2zkwu389Ykw2rOKcuGS+iAUDWIb9VQ6OpGbcFVcwjRYG7SxVCKgJeAwtunq+hOuS333ijmW45jF8qR2ah5N20MTlTeqOfNSTuup3q/epTbjxbnddx4uHIiI6I+J73jiGsHtTaCCOob91Ml9kNsARyriPamhmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOcWLx/6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOcWLx/6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 939FEC4CEF0
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752650260;
	bh=Gis8n8U30G6RaNYBaa8SxUUxlSxLM0Y0xpcyBoev//4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tOcWLx/6VybXb3aWNXGnrG+BtouOYGee1QI2G5XTrfgn+WwRhjorTumfjuXgYy1gb
	 mOVYzMAXkS6gwOghA+oueSnXnk+I48voLLjWTx3x1JDuvbfVAgm4ESn4pVeWsn8BKG
	 uG8i5THM1wHJF9h/aHc7ULDjCe6GvCCzgiKrZsjIdJEeNOz3z7nOAABJRBJMsZacsI
	 6y+Nc6J55VkFDvbYNqMqb5tq26PmOFTfl2V2fuRE83sxLByT+0wDwnqp9su+5wdxLF
	 RCsBs5HB4Athh64/abYnaiwEaqucoCy2wtz+w98J/LfmEY+7IeNP2q726w9r7Sl7kH
	 z6d/FuRTBErIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85ED7C433E1; Wed, 16 Jul 2025 07:17:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Wed, 16 Jul 2025 07:17:40 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220341-62941-LO3MtVUG9g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |nicolas.baranger@3xo.fr

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
This seems to be a duplicate of bug 218952 ([URL][1]).

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
