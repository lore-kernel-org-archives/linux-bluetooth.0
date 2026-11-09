Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198532;
	b=FPtsmh818fbMCUrRqvZ+a/fDVxoLJSSPsAJexf0R/N4ExZ2i8WqhXcRHwGHfluBMUWaj
	 eSZlJx+9eIbPwoMfEHNZE3fmr3NvAH9WR4QU4GXY8ZNRFlewz5kskyEU7UdotaIYWW44g
	 n8bJWnHrRQ1V2oRZxhqCT7yxoSNqQr4E4e4Y9lvEnl7IiBC+UssYuBfY6OcVwlse44e6R
	 O1gJ/KhRWofRGnhn0h7D3vT1wibz18p43XwGpk2mwSg0mFwkggdxTam9NE8uve5n2aCVj
	 utR6CDBy4/usRAlrPXYwNsHUFfFWyPluLxnksL1vYdmJXF7K53cCINmAFZsTdGGiOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198532;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FiUcCzz6eRwbUbbG4pYyGQ2qW/jd88V1nW8iaclZzQk=;
	b=x9AzeHiqtO3lxFem0GaAjYACLOxUtva3/eOoM+E/wY+osGPsNIWAH6r10nGH1gRQuzt5
	 c6dfhfz9v+DMyDA57Xa23C5Ku1G4mNffTzILKBNVm/V+QJCWMdhQRanv3sQUT30fx4Eti
	 CqUA3IwD0LYC+i4XukZKXdkDZBxTuuaXH1Nhktk1tIB5XnHjUgll+Tc9Wt0flT13I+ooR
	 G43XUjn+Kx+hpm6A26ITxmNYzP9p57QPygqmBXYvOYhk172mWDluBOPj5AMh+U2J9LWd/
	 FZmTcuBAe38UEWT14kQIecPsUU8eLeDUl3l+1shizSMRQvpmtKuCaIFoCCN3kvud3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OPUUchvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D747606A31C;
	Mon,  9 Nov 2026 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OPUUchvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529EC1F0089F;
	Mon,  9 Nov 2026 04:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794198531;
	bh=FiUcCzz6eRwbUbbG4pYyGQ2qW/jd88V1nW8iaclZzQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OPUUchvXcqcg6udQdlvlPeSph4r8aU2+2h4HR8XyzRuZ/eKrMZHZfbOdvKwV7k+86
	 IcDKpcF256QyOZ0wHoSH0TKevcbwSM+sE2tI//+lGGIfvXG2grY5nOy9xIK5gG8rsF
	 ebk4yf4QP4sRcHLdKwW/IR1CO71muJK8RfYRrnRk=
Date: Sun, 8 Nov 2026 20:28:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com>
Cc: bsegall@google.com, david@kernel.org, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com,
 liam@infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, mgorman@suse.de,
 mhocko@suse.com, mingo@redhat.com, peterz@infradead.org,
 rostedt@goodmis.org, rppt@kernel.org, surenb@google.com,
 syzkaller-bugs@googlegroups.com, vbabka@kernel.org,
 vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [syzbot] [mm?] [bluetooth?] BUG: unable to handle kernel NULL
 pointer dereference in __refill_objects_node
Message-Id: <20261108202849.2e5c40a630e66dd39334a915@linux-foundation.org>
In-Reply-To: <6af144ed.f50b2b3a.2c0de7.0010.GAE@google.com>
References: <6af144ed.f50b2b3a.2c0de7.0010.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 19:58:37 -0800 syzbot <syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com> wrote:

> syzbot found the following issue on:
> 
> HEAD commit:    58c1eb84e977 arm64: sdei: Preserve the interrupted context..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d1d369580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a58b6b4d667e7a61
> dashboard link: https://syzkaller.appspot.com/bug?extid=73e34786d639a8eb1324
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255c1a1580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b1ec47537e12/disk-58c1eb84.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bca0c2b1169/vmlinux-58c1eb84.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0a7c49594d5a/Image-58c1eb84.gz.xz
> 
> AI-generated root cause summary:
> In mm/slub.c, __refill_objects_node() replenishes percpu sheaves by detaching a
> freelist from a partial slab via get_freelist_nofreeze() and iterating through
> the freelist pointers in a while (count && refilled < max) loop. Because the
> loop condition only checks count and refilled rather than validating that object
> is non-NULL, a prematurely terminated or corrupted freelist (where fewer objects
> are linked in slab->freelist than the expected count = slab->objects -
> slab->inuse) causes object to become NULL before count reaches zero. On the
> subsequent iteration, get_freepointer() dereferences NULL + s->offset (offset
> 0x400 for kmalloc-2k), resulting in an immediate kernel NULL pointer dereference
> crash at address 0x0000000000000400.
> 
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=73e34786d639a8eb1324

Thanks.

: This looks like a bad syzkaller test, not a Bluetooth bug. The
: reproducer runs as root, opens the active PCI device's resource0
: (mode 0600), and maps its register space writable. It then places
: syscall arguments inside that mapping. On this GCE VM,
: 0000:00:02.0 is the NVMe controller; its BAR contains live control
: registers and queue doorbells.
: 
: Both crash logs show NVMe completion ID and generation-counter
: errors immediately before the SLUB fault. During minimization, the
: same program produced crashes in several unrelated kernel paths,
: including runs without the Bluetooth operation. This points to
: disruption of the active NVMe device and subsequent corruption,
: rather than a demonstrated SLUB or Bluetooth defect.
: 
: The logs do not show the precise MMIO access or establish how the
: freelist was damaged. Please rerun with the resource0 mapping
: removed and the read buffer in ordinary memory. If the SLUB fault
: persists without the NVMe errors, we can investigate it as a
: separate kernel bug.

