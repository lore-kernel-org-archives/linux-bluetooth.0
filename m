Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A1281357;
	Mon,  4 May 2026 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928146; cv=none; b=ukAgm4ywuaPY8TGbm7nvGw8eueUlAPw3fIWJ6KCX8i8WQ5WMjUGQKeYdN3k0HsZdsQElWyz6Yz4SzihNAULd7ORXVaJTNPbfH6PFkcrdcwy76vBiW7if3muvi168rAtEg2UsLRAiViQz/nUjU+nQhcPt0lE5hm9hy5GKA3rhFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928146; c=relaxed/simple;
	bh=fjSHG95gGb7IT7lXBJRI1uIB47QHMOdwdAvTLl9GHwU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NTLItaDer8+xSLHQAR1iWOEGuiIXoOZ5ca8mLHVxLPIaHHscdBzRI0hicGcPfbu6qC2JDXiZkJPnyStvjrIRF7UowK3zJScF1cEOowHB2i/HtKv0GMcFOUjsA4lAZxxsLJ01AOpAOcwkpeFEmhHvHDyvypJewY9zur5izMnPR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkLP2g/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkLP2g/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FB1C2BCC4;
	Mon,  4 May 2026 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777928145;
	bh=fjSHG95gGb7IT7lXBJRI1uIB47QHMOdwdAvTLl9GHwU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XkLP2g/mhkEbDClQBvH0VXTMAkbBaWf4yLdEMbc7hIRyfa2BaZ9CKfbpTdfgKkSR7
	 NKd437UfE5paIA10TYFhZXn4mGZHDPCbIgbnCtlBq34Nk0E6lqYz1QDhz2Up6YHHjs
	 FSj6UOzMySPtig3pXeO9ABwAxvhNeS7zp/N5jgGEqYO6GuwvjZjHnCcKbppo7HwS4k
	 vzqlsB4ws60HkOLXHeQyW8XbWBMyV32ZGQusGIWPxPstQgcBhWL9ReDB7173Nfd+5X
	 V2aQdgqLrJbSvYXft5n5OcyRMeutMoh/sOy85b3JrX9XJbvgkmNOxPq5MA4GkvpbKl
	 SWX9yOQhiQ73Q==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 22:55:42 +0200
Message-Id: <DIA6XD2G5094.1FA2NH60YN1C0@kernel.org>
Subject: Re: [PATCH v2] sysfs: return -ENOENT from move/rename when kobj->sd
 is NULL
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com>,
 <syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com>
To: "Conor Kotwasinski" <conorkotwasinski2024@u.northwestern.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu> <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>
In-Reply-To: <20260504050736.17672-1-conorkotwasinski2024@u.northwestern.edu>

On Mon May 4, 2026 at 7:07 AM CEST, Conor Kotwasinski wrote:
> sysfs_move_dir_ns() and sysfs_rename_dir_ns() pass kobj->sd to
> kernfs_rename_ns() unconditionally. If sysfs_remove_dir() has already
> cleared kobj->sd, the NULL flows through and kernfs_rename_ns()
> dereferences it via rcu_access_pointer(kn->__parent), which KASAN
> surfaces as a stack-segment fault on the shadow lookup:
>
>   Oops: stack segment: 0000 [#1] SMP KASAN PTI
>   RIP: 0010:kernfs_rename_ns+0x3a/0x7a0 fs/kernfs/dir.c:1752
>   Call Trace:
>    kobject_move+0x525/0x6e0 lib/kobject.c:569
>    device_move+0xe0/0x730 drivers/base/core.c:4606
>    hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
>    hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
>    hci_conn_del+0xc36/0x1240 net/bluetooth/hci_conn.c:1234
>    hci_conn_hash_flush+0x191/0x260 net/bluetooth/hci_conn.c:2638
>    hci_dev_close_sync+0x821/0x1100 net/bluetooth/hci_sync.c:5327
>    hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
>    hci_unregister_dev+0x21a/0x5b0 net/bluetooth/hci_core.c:2715
>
> syzbot has reported 35 hits with this signature across net, net-next
> and linux-next between July 2025 and January 2026, via both vhci
> release and HCIDEVRESET ioctl.
>
> Return -ENOENT in that case, consistent with sysfs_create_dir_ns().
> The underlying ordering problem in bluetooth -- device_move() called
> after the target's sysfs has been torn down -- is a separate issue.
>
> Reported-by: syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/687c6966.a70a0220.693ce.00a5.GAE@goog=
le.com/
> Reported-by: syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfaeac5b54ba997a96278
> Fixes: 324a56e16e44 ("kernfs: s/sysfs_dirent/kernfs_node/ and rename its =
friends accordingly")

This is just a rename commit with no functional change, so I think we shoul=
d
pick the following commit instead:

Fixes: 608e266a2d4e ("sysfs: make kobj point to sysfs_dirent instead of den=
try")

However, that commit is quite old, so it raises a bit the question, why doe=
s
this pop up now?

Technically, the API contract only talks about callers have to serialize ca=
lls,
i.e. your if (!kobj->sd) check should not have any TOCTOU issues, but it do=
es
not talk about ordering.

That said, why does the bluetooth API run into this now?

> Cc: stable@vger.kernel.org
> Signed-off-by: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu=
>

Regardless of the above, the patch seems still fine even if it turns out to=
 be
hardening only.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
