Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73332353A6E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003959; cv=none; b=USKtxfc+7d1WnujVFi64DWr05HIhZLAMC4BqrvGRhwvON0o77MmlrOzeh6bltSLr0cQRq0un3510+zbVasQgxZAYiebyloH+JklCT9XFmka7w1QOeKP6ymiCCg3/2zc+XLtxu6MgMPSaha8rM58ZcwAVOzyoU86MWC0ue3+HcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003959; c=relaxed/simple;
	bh=vafJePQjD26LQJFO6gcyN8rPD54igOHpLteX+4u5nrU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/X+tmc7Au4/Io/516Ixd5Yf8RpTGqMAlzgivaJufmwvt6Tj3RiQ9Rs3ROwRfWbaYm6Mn2x4H4X/N7fHARkqhDa85Mk3AXxacOB2LrPZpXQQ4tH1noa0t1jAe9MLRrgLAI27EkSLJdLHA48WHXbEYOHKben5wrylm1AuCxFP8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhAgIkQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhAgIkQD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 158F3C19425
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783003959;
	bh=vafJePQjD26LQJFO6gcyN8rPD54igOHpLteX+4u5nrU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bhAgIkQDOFf9j9yltxg5S3I07lhUWoj/a+o6olr6cwUiTf/mb094dPKpZH04ldFIy
	 6x2yjbhvJiwC7oeB4TBYv3lpfhBjusS5ckIeMMdKX8B3n+fWFELV1dtpaYXRYwskgD
	 ebB2L8KH8+jpnh9ycv45qwHtv68uig88YHyEyhwB6p57ROlshp8gdKJOzhDiTht3oy
	 b0D5hNB9vw3CRWUvbQbP9y2nsNDnbK8U+JXYSIpfezC6vOLEJCVDlJynE6kTyd+NG8
	 ae1170/bPaZGpNoqx0IE9piDMfH1SPrPVlDt+HveC3MtKmKHTorffOZQC0WU9LDDna
	 g+rgNpwbP8zDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6610C4160E; Thu,  2 Jul 2026 14:52:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221696] btmtk: regression in 6.6.142: NULL pointer dereference
 in btmtk_usb_hci_wmt_sync during resume from S4
Date: Thu, 02 Jul 2026 14:52:38 +0000
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
Message-ID: <bug-221696-62941-98Fx1WnSl8@https.bugzilla.kernel.org/>
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

--- Comment #9 from Matt Whitlock (kernel@mattwhitlock.name) ---
Okay, got a result that makes some sense now.

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
# old: [cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4] Merge tag 'soc-drivers-6.=
11'
of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect old cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4
# old: [cdf471c348c1200ca243775b4b8d6eaa6d7f3979] Merge tag
'tag-chrome-platform-firmware-for-v6.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
git bisect old cdf471c348c1200ca243775b4b8d6eaa6d7f3979
# old: [3e7819886281e077e82006fe4804b0d6b0f5643b] Merge tag
'for-6.11/block-20240710' of git://git.kernel.dk/linux
git bisect old 3e7819886281e077e82006fe4804b0d6b0f5643b
# old: [3a56e241732975c2c1247047ddbfc0ac6f6a4905] Merge tag
'for-6.11/io_uring-20240714' of git://git.kernel.dk/linux
git bisect old 3a56e241732975c2c1247047ddbfc0ac6f6a4905
# old: [7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79] Merge tag
'vfs-6.11.module.description' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect old 7d156879ffd6c48428c2f46d5c2b4b80d9c9ee79
# old: [2ffd45da0b06b26f30480584de7c660d84b2d7dc] Merge tag
'drm-fixes-2024-07-12' of https://gitlab.freedesktop.org/drm/kernel
git bisect old 2ffd45da0b06b26f30480584de7c660d84b2d7dc
# old: [a5819099f601c1af5b86b1f5921a56859e45b19a] Merge branch
'runtime-constants'
git bisect old a5819099f601c1af5b86b1f5921a56859e45b19a
# old: [35ce46324556ba2dbc66a88013870d8bec8a99ef] Merge tag
'x86_urgent_for_v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip=
/tip
git bisect old 35ce46324556ba2dbc66a88013870d8bec8a99ef
# old: [119736c7af442ab398dbb806865988c98ef60d46] i2c: testunit: avoid
re-issued work after read message
git bisect old 119736c7af442ab398dbb806865988c98ef60d46
# old: [0830f975e021608c527887ed2d9e122e76b9e280] MAINTAINERS: VIRTIO I2C l=
oses
a maintainer, gains a reviewer
git bisect old 0830f975e021608c527887ed2d9e122e76b9e280
# old: [ca8e83a13ace8d63ede6501a8c313fce625c141f] MAINTAINERS: delete entri=
es
for Thor Thayer
git bisect old ca8e83a13ace8d63ede6501a8c313fce625c141f
# old: [a5db8e4544a4dc7143f30a1438686a4d5fa6d775] Merge tag 'soc-arm-6.11' =
of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect old a5db8e4544a4dc7143f30a1438686a4d5fa6d775
# old: [0434dbe32053d07d658165be681505120c6b1abc] Merge tag
'linux_kselftest-next-6.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect old 0434dbe32053d07d658165be681505120c6b1abc
# new: [6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0] Merge tag
'gfs2-v6.10-rc1-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect new 6706415bf9f3dcb425f4b60a08a3a6f1d94ec0e0
# new: [af58de31bebe737235f0238843f2054996998bd5] Merge branch
'eth-fbnic-add-network-driver-for-meta-platforms-host-network-interface'
git bisect new af58de31bebe737235f0238843f2054996998bd5
# old: [30b3560050486275c6207c8c90c0d53a7cc73ac1] Merge branch
'net-make-timestamping-selectable'
git bisect old 30b3560050486275c6207c8c90c0d53a7cc73ac1
# new: [03afeb613bfe6b0c28e8b843959f716a3d2c42df] flow_dissector: set
encapsulated control flags from tun_flags
git bisect new 03afeb613bfe6b0c28e8b843959f716a3d2c42df
# new: [921ad2879aa7733620585e4904ba673c6c916dab] Bluetooth: hci_qca: use t=
he
power sequencer for wcn7850 and wcn6855
git bisect new 921ad2879aa7733620585e4904ba673c6c916dab
# new: [d4f6acfcb0b0962e2a59165108e212a976d1f078] Bluetooth: btnxpuart: Add
support for IW615 chipset
git bisect new d4f6acfcb0b0962e2a59165108e212a976d1f078
# new: [ceac1cb0259de682d78f5c784ef8e0b13022e9d9] Bluetooth: btusb: mediate=
k:
add ISO data transmission functions
git bisect new ceac1cb0259de682d78f5c784ef8e0b13022e9d9
# new: [6dc22ab9f085ae165e4ce89d61fb426f94e8a969] Bluetooth: btmtk: move
btusb_recv_acl_mtk to btmtk.c
git bisect new 6dc22ab9f085ae165e4ce89d61fb426f94e8a969
# new: [5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad] Bluetooth: btmtk: move
btusb_mtk_[setup, shutdown] to btmtk.c
git bisect new 5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad
# first 'new' commit: [5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad] Bluetooth:
btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c

5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad is the first 'new' commit
commit 5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad
Author: Chris Lu <chris.lu@mediatek.com>
Date:   Thu Jul 4 14:01:14 2024 +0800

    Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c

    Move btusb_mtk_[setup, shutdown] and related function from
    btusb.c to btmtk.c which holds vendor specific stuff and
    would make btusb.c clean.

    Signed-off-by: Sean Wang <sean.wang@mediatek.com>
    Signed-off-by: Chris Lu <chris.lu@mediatek.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 drivers/bluetooth/btmtk.c | 454
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |  23 ++++-
 drivers/bluetooth/btusb.c | 452
+++------------------------------------------------------------------------=
----------------------
 3 files changed, 484 insertions(+), 445 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
