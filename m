Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92F2D7DC8;
	Tue, 28 Apr 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415466; cv=none; b=CFZomKkb7iisjJnFzWQ3oe/WmJdvXsNBt0oprJE6YA9pmrbO2e4L+OILqj2CNG5q94bLtka+OlUOqT8Jr24jGX5L693GzAsxxl+H2P47Kw2g/Snx9wpSoVdDtr0h8TGtuxpHV1bOwX53tOJleRZf4puuxT715i/mGNVpHRQk5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415466; c=relaxed/simple;
	bh=oDEfPq39Mqi5hC74Mb8AFuJQrxvUe85i/mRRK2y4jEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=eINW/KdahIElgINISxPY5q+XR8CrCuWcLL62QKHxqwaWytRIZ2W+gS2r9SJLs/ezREdHMYD8iy+i4ph7Qdqck0V+5qDpsr4/btsXqoJMGMkL3SZhMZY7MEWakO3KndiESoYE1L19l/O/8t4Fn8RAzXCdMslp4GYrtC/Ny3WUKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC6H/U6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC6H/U6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58505C2BCAF;
	Tue, 28 Apr 2026 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415466;
	bh=oDEfPq39Mqi5hC74Mb8AFuJQrxvUe85i/mRRK2y4jEw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=aC6H/U6Z98H5Q9tPcyGVbxkwf3EisDRl5tZYZX8ifpLp7o1XsleRpvIRzGo6On6th
	 CoPdziguBpkoPkM+elGMrCZmPoLkoiJwMIpEE0U9XvaTkCPZSS0/Ty9F/MUkKu7RBT
	 8UOjyaUY516svIVPrvWgLPUctJ0UteyfCKZ3uGmxDSAOrshqNGJMIZ2sp8e4HXK7OJ
	 0pygrwhTnC0gLVRNT7HDUBI5BgDyfkVN7TWccKs0nHu712RvMIJ9troZtMaMWOYHYY
	 Ym+HlLtVU8hQ5DQ7ZC6q5EPn66H1+dcLSTlgKA4HFIRWMmfdHP3mOTwbSydAIqzBCH
	 RpMDi5KeHCdqw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 00:31:02 +0200
Message-Id: <DI55738N6DCN.185MD6ZLZQXYG@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] sysfs: return -ENOENT from move/rename when kobj->sd is
 NULL
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com>,
 <syzbot+faeac5b54ba997a96278@syzkaller.appspotmail.com>
To: "Conor Kotwasinski" <conorkotwasinski2024@u.northwestern.edu>
References: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>
In-Reply-To: <20260416150600.2148935-1-conorkotwasinski2024@u.northwestern.edu>

On Thu Apr 16, 2026 at 5:06 PM CEST, Conor Kotwasinski wrote:
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
>

No Closes: tag for the second report?

Also, this should have a Fixes: tag and Cc: stable.
