Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3247DFBB
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995811; cv=none; b=RVx9PRrFEHn1ca4rJ51jRrtYmbZsubiHS84+WwwekaM++F3zOtfCU+k0LnjLJU1SDCjabNMFKwXf+rsz7z3vQi/pjfDEP9GAzANa5yMpMp6ZzIwooN0LEyxB3OVp9Bu5U2OtWIUgKKpR7irGxwjRrYiPaGJaaSHj4C2oAJ39JJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995811; c=relaxed/simple;
	bh=4NvIao2VOV1JvClGekqMIig84CVDvGh7lvQHvbKtjI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyNHXUI5n4TuiadQX4z3RyqnXD8ztTGTTEX4q6L38OrR0G4sfd3yS2MQZZEe9IzNKxhZqI1xtkOklNA2Ib9oKFzSlkXi590o4+MBsJPVRjpy42AEbmVtbNix4IWpybti+GgwHCV3wU77Vdez/I4HkxAqFlZXZ0b6WUfZ1u7PoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8tDVXNh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8tDVXNh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D442C19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782995811;
	bh=4NvIao2VOV1JvClGekqMIig84CVDvGh7lvQHvbKtjI0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I8tDVXNhz1b5qkj5C2CnS8oHWYXwsBGm1H5U8J0m4eNobApW+p9QS783LhoBZxfg9
	 QJys9Xg94zlh/nzDhxXpiRCA1bHR1rvMStCWUNYDYzVpbprMTi6GiYvezw11Qrm63d
	 Ia5dszLADwU0lgXb8wWFkY2NZ+0SlcKC92wKfWoZxGWeGzubyq8iI6ej2/zMS1SxF7
	 fyP4Vpcblw4rUzyS+9cciWuWKazgp2Le37MmlCMgsIKSMY3/zT4wn6dXu0fdvbKBXy
	 asDvkr3sJBMiMVEI7Haa2MF+k7l0qlzN1beWYWdysdbpOgpLIk1ry96dWS8VVy/kG7
	 I3kFt4U5iNZaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37B70C4160E; Thu,  2 Jul 2026 12:36:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 12:36:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@mattwhitlock.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221696-62941-lgDWNpUW8i@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221696-62941@https.bugzilla.kernel.org/>
References: <bug-221696-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221696

--- Comment #7 from Matt Whitlock (kernel@mattwhitlock.name) ---
(In reply to Matt Whitlock from comment #5)
> I'll check the "upstream commit" d019930b0049fc2648a6b279893d8ad330596e81,
> and if that's bad, then I'll bisect to find where the fix happened.

Well that bisection took an absurd amount of time and yielded a nonsensical
result.

I told git-bisect that d019930b0049fc2648a6b279893d8ad330596e81 (which inde=
ed
exhibits the bug) was "old" and that torvalds/master
(4a50a141f05a8d1737661b19ee22ff8455b94409) was "new", and this is how it we=
nt:

# status: waiting for both 'good' and 'bad' commits
# old: [d019930b0049fc2648a6b279893d8ad330596e81] Bluetooth: btmtk: move
btusb_mtk_hci_wmt_sync to btmtk.c
git bisect old d019930b0049fc2648a6b279893d8ad330596e81
# status: waiting for 'new' commit, 1 'old' commit known
# new: [4a50a141f05a8d1737661b19ee22ff8455b94409] Merge tag
'bootconfig-fixes-v7.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect new 4a50a141f05a8d1737661b19ee22ff8455b94409
# new: [115e74a29b530d121891238e9551c4bcdf7b04b5] Merge tag 'soc-dt-6.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect new 115e74a29b530d121891238e9551c4bcdf7b04b5
# new: [b394eabd539d01db10e27b57ac2497cbd1d32c6d] Merge tag
'chrome-platform-v6.14' of
git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
git bisect new b394eabd539d01db10e27b57ac2497cbd1d32c6d
# new: [f8ffbc365f703d74ecca8ca787318d05bbee2bf7] Merge tag
'pull-stable-struct_fd' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect new f8ffbc365f703d74ecca8ca787318d05bbee2bf7
# new: [c85e1497dd10879f447d6a12f97762c581093e9b] Merge tag 'i3c/for-6.11' =
of
git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
git bisect new c85e1497dd10879f447d6a12f97762c581093e9b
# new: [b3ce7a30847a54a7f96a35e609303d8afecd460b] Merge tag
'drm-next-2024-07-18' of https://gitlab.freedesktop.org/drm/kernel
git bisect new b3ce7a30847a54a7f96a35e609303d8afecd460b
# new: [e2f710f97f3544df08ebe608c8157536e0ffb494] Merge tag 'ata-6.11-rc1' =
of
git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect new e2f710f97f3544df08ebe608c8157536e0ffb494
# new: [cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4] Merge tag 'soc-drivers-6.=
11'
of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect new cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4
# new: [cdf471c348c1200ca243775b4b8d6eaa6d7f3979] Merge tag
'tag-chrome-platform-firmware-for-v6.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
git bisect new cdf471c348c1200ca243775b4b8d6eaa6d7f3979
# new: [3e7819886281e077e82006fe4804b0d6b0f5643b] Merge tag
'for-6.11/block-20240710' of git://git.kernel.dk/linux
git bisect new 3e7819886281e077e82006fe4804b0d6b0f5643b
# new: [3a56e241732975c2c1247047ddbfc0ac6f6a4905] Merge tag
'for-6.11/io_uring-20240714' of git://git.kernel.dk/linux
git bisect new 3a56e241732975c2c1247047ddbfc0ac6f6a4905
# new: [7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79] Merge tag
'vfs-6.11.module.description' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect new 7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79
# new: [2ffd45da0b06b26f30480584de7c660d84b2d7dc] Merge tag
'drm-fixes-2024-07-12' of https://gitlab.freedesktop.org/drm/kernel
git bisect new 2ffd45da0b06b26f30480584de7c660d84b2d7dc
# new: [a5819099f601c1af5b86b1f5921a56859e45b19a] Merge branch
'runtime-constants'
git bisect new a5819099f601c1af5b86b1f5921a56859e45b19a
# new: [35ce46324556ba2dbc66a88013870d8bec8a99ef] Merge tag
'x86_urgent_for_v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip=
/tip
git bisect new 35ce46324556ba2dbc66a88013870d8bec8a99ef
# new: [119736c7af442ab398dbb806865988c98ef60d46] i2c: testunit: avoid
re-issued work after read message
git bisect new 119736c7af442ab398dbb806865988c98ef60d46
# new: [0830f975e021608c527887ed2d9e122e76b9e280] MAINTAINERS: VIRTIO I2C l=
oses
a maintainer, gains a reviewer
git bisect new 0830f975e021608c527887ed2d9e122e76b9e280
# new: [ca8e83a13ace8d63ede6501a8c313fce625c141f] MAINTAINERS: delete entri=
es
for Thor Thayer
git bisect new ca8e83a13ace8d63ede6501a8c313fce625c141f
# first 'new' commit: [ca8e83a13ace8d63ede6501a8c313fce625c141f] MAINTAINER=
S:
delete entries for Thor Thayer

That "first 'new' commit," which is supposed to be the first commit that no
longer exhibits the bug, is just some housekeeping on the MAINTAINERS file.
There is no way that it could have fixed the bug. Moreover, given that ther=
e is
only one "old" commit in the entire bisection log, then the "first 'new'
commit" logically should be a direct child of that "old" commit, but it isn=
't.
Not even close.

So I'm genuinely flabbergasted as to how git-bisect utterly failed to do
anything logical here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
