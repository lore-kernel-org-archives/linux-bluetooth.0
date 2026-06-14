Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0D358D00
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480490; cv=none; b=eLRON3Di1SlQYqlzyXjyAYnVn1VXmRMD7L3Kl2lXtj/FOVX4jof1IT0iJhSUu5ml4W2gUCbGc45HCvSLJcO7OQ5T4sC5POJd/Tq5uD6m0pbwM+HlpISKTTzxLHM+hv22Z36SixXOLJAqJwCoYB86LCKLVBaPlc7DWKMVvsM10oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480490; c=relaxed/simple;
	bh=RglxYYFu1Sknszd+3S9uEVP2ksYvq9uljiRaGb+bFDI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kf9nu7+H9j76FZYXDkMj0HaoKNg5pDQQL5XWE1skbszlP/Mvl7mmHCM3wywVyoErbBEG5/ts2IVLKKi/MAN7SIBUwrCCNMN01Ivh9yGv4ayCP4Jz144TaS2plOpDYgd0eUfc5VvdVHF/d3+QXJ4AuhJV8UViXreSoCk8k6QuQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHxjE1GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHxjE1GO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DAEBC4AF0E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781480490;
	bh=RglxYYFu1Sknszd+3S9uEVP2ksYvq9uljiRaGb+bFDI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eHxjE1GO59twce8W9Tzgn+mvWdqXMRSpIeyf89pDzzstMTylmdWjIpG30JZbV2hjh
	 EFGBp/gNGnRzouDOf8SqGnj5RSx9tNruwIncqrYG9dY6q+4KatGpUmDWE22ynf4+km
	 hTfY3sfhWct6crGksr6B4vLIZySBt66UM719qR2IFlzU7e5LW77X+caTl6TPN7JUid
	 PowpQP4t5RtRawYdKYZ5+tjz9GGy7e5SY0Vvbet2IUMti94nx7ArTCDoXmkFc+NPX7
	 RG8q228Z7WL1o8etA3QKDpGWsPgNpkWYFKXp3HR+qKUl75xzMyvIcQK3xyUqfb0jH0
	 O5lm9TAs2iqxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1AD86C53BBF; Sun, 14 Jun 2026 23:41:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221637] Regression for Intel Corporation Device a876 (rev 10)
Date: Sun, 14 Jun 2026 23:41:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kiran.k@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221637-62941-gSxdco6tgJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221637-62941@https.bugzilla.kernel.org/>
References: <bug-221637-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221637

Kiran (kiran.k@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kiran.k@intel.com

--- Comment #7 from Kiran (kiran.k@intel.com) ---
Hi Biance, Paul,

Appreciate if you can test and feedback with the below patch.

https://kernel.googlesource.com/pub/scm/linux/kernel/git/bluetooth/bluetoot=
h-next/+/5917dd39db2bfc8b1b4c6ea8ed99adb4badef707

Seeing the error pattern in dmesg, appears like the issue has been fixed
already and the patch is present in bluetooth-next,

Thanks,
Kiran

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
