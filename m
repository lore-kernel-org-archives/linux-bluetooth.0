Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C143F4C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834634; cv=none; b=YSBo0DirZwrQKAaEoADtpzy//fqobuNKU46tkYQuzz3dLOkGhpbEKV1fzoZqD02SUK2RKlTsVHLkX7EZesQwUKAuTiOVbAhw8ujoRwyiI5nJxe70bWaCyZlH8jtuEs9mttnaS7WvVOjG0x0G8T4TgM1k9aKZTxsO3/6Slp1Crk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834634; c=relaxed/simple;
	bh=0mmCmxuPxv4MBYZHRRzwx8zAxb7n90wce8rPJzFCfiI=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=je/4+rWgC7bOpsdX7HEoWHmUVLD+FALzS1O9OoQATyk/XmS3DDysAr+BRjma24iDvt/pO6Mc8lxgbUde75u05x+JI/ZbjIjahpuFsHjlGVrx1p+42asWZq23UM41NAywEZwrTgjFQXdbShzQi92tH47S4jJnuB7SJ39J4EL0G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=DEAJTYbl; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=AWjuhD8i; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="DEAJTYbl";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="AWjuhD8i"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834627; x=1788439427; bh=0w4U2TtwnRVMAzB7My
	M3yx6r+kmkw280q29TxCD1fOE=; b=DEAJTYblUagXJ2iGumxPAE7ZoYipixr6ltuHn9GfUH7uV
	9TemXN6qN0ZSXIUA2e1g5Xo+zqp+BNPH2xarXBL0dbvnTOgcwUQOtRTjDRKR4xLYN5diuVpVj2c
	qZdKBu6MySuZPzQHDiKCeWfnktiv+lqrgH6QPn3W97cdxUlVLLcD+an/yYUy0KBFruqoQOuXiUa
	XfKvqlgMG892C8igeiegwgKEh/dwAYEgPttQN5rUrGlghqHlmkJQPqYpv6qrIJ2cYuP6NDEBNxj
	Tsf2BrzS6iv1HsyGw/6kLIwxwbv94qz4o6uBjRfKRylUv2bBrsgFq6BuvOD1WZv6D/323vvw==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834627; x=1788439427; bh=0w4U2TtwnRVMAzB7My
	M3yx6r+kmkw280q29TxCD1fOE=; b=AWjuhD8iuNAmAEAMcQnmYr0PREn1nYeTea7YjmDmCwcbO
	peHjGTZ8IBA6o8PIQaZxfXZO1jZdT3L2JXpTPNchQJzf7QhbQ1t0PBcGqwEDnEZbbKy/QOZ6GdD
	pWwz+DMDKxHvGCQRQE0icyz3SUn6eGqmo97tHBbHj6+0z+YGZKJU5ANKvS/i5X6DVsSox3r8CFf
	iuXLPh7ndUqJYo4dCsOnj2gkDAq9OHKQqVWyP4c0ESZp8WR8kzRF7WVXjxfWa/wQwz5kZwx3/II
	NHEEk5OM3DVA0QL9iqb3utnzKffycnhDvkrnww0f2NrMJ0+GTh4ijoHpL61OXeXNfCZMNC/A==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+ef32d1251d8555af@bugs.sh>
Message-ID: <6RpR2fi4iS5th20EWMG6Wt0CzXK0hP6xdKdd@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:38 +0000
Subject: [BUG] drivers/bluetooth: use-after-free
To: linux-bluetooth@vger.kernel.org, "Marcel Holtmann" <marcel@holtmann.org>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/bluetooth
    crash   use-after-free
    commit  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfiguratio=
n throttling")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+ef32d1251d8555af@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/ef32d1251d8555af/patch.diff
        report.md   https://bugs.sh/b/ef32d1251d8555af/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  7cbfb180945c ("net/sched: sch_cake: fix autorate reconfi=
guration throttling")
    VM setup       https://bugs.sh/b/ef32d1251d8555af/run.sh
    config         https://bugs.sh/b/ef32d1251d8555af/config.gz
    poc            https://bugs.sh/b/ef32d1251d8555af/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave (include/linux/sp=
inlock_api_smp.h:155 (discriminator 1) kernel/locking/spinlock.c:181 (discr=
iminator 1))
Read of size 1 at addr ffff88802ae9c1a8 by task kworker/0:0/9
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.2.0-07243-gf87cd64fed5=
8 #63 PREEMPT(full)
Workqueue: events btusb_rx_work
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__kasan_check_byte (mm/kasan/common.c:574)
lock_acquire (include/linux/kasan.h:402 (discriminator 1) kernel/locking/lo=
ckdep.c:5860 (discriminator 1) kernel/locking/lockdep.c:5843 (discriminator=
 1))
_raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:155 (discriminator=
 1) kernel/locking/spinlock.c:181 (discriminator 1))
skb_dequeue (net/core/skbuff.c:3987 (discriminator 1))
btusb_rx_work (drivers/bluetooth/btusb.c:2519)
process_one_work (kernel/workqueue.c:3322)
worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
Allocated by task 793:
Freed by task 1234:
Last potentially related work creation:
The buggy address belongs to the object at ffff88802ae9c000
which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 424 bytes inside of


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


