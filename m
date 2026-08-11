Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFB306765
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423470; cv=pass; b=qQwlDwoGr0CBSDUuLFC7sjHmO6GUQP59yppm4fgmYwi95yL4VoszKc0FtFPUjXwOe6xpTXxX7EqNtl6O6/PRzPHOhA19BEOkB8qg+eRLt6alDk4HjAUefO5AvI6TtACvZOS6KEjf3nErjunYKqS33X6NmHJL7xkDvVzOtEr0TJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423470; c=relaxed/simple;
	bh=CHvnt+c9/ZsiwBoYHEfWqDZt4dGfPzdYE0pq4+SLD1w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HRbfG8tbFsxkTyGW2Uyp2QvHwpCH+KkldxnUxO8L9zjikmBi92nvUVTzNLmpnoMNO3Gznk8kzdC1tH/e85c5FT0r4Dayimo17Ip5RJen6uBhi/vFUDBahdNV88ba5QvoDadHo0Ipm4XTP8nGG0bw4aOWs/FjpN9i3XhdnYXDhek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxhJnUf8; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxhJnUf8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfad59921so15434621cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 21:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786423468; cv=none;
        d=google.com; s=arc-20260327;
        b=S/53LUefhyGfKUBQU5deOQvQU9Pd3A+pYLoIWd/E12CdJtA3+71oLcUSDZWryOHcxv
         yjWkzjmEcvA6eU6bCoO4PsJrwBwemm/rxSu7G7yFJkIKM3rYRawFVqr5jexKJo5YNJop
         O4JfJIBKojsmtI7s8TVshUZxUxpGp7i2vy5cuevDV4bHBrkntjE9cRSrtUHFzxos6bvy
         Wq+VrRK4+YTxWPkJ1TXRSnmYMncDkZZJbI8xdos7jv4LfdKxuTuaDlCkh/Bt/e9mXvrm
         1fGPtr568FmC98zOzW90afQXiF6yrnNcg/GSdyln1ZKkpoKJrgefW6YJ27DJHbN/Nvyy
         q9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CHvnt+c9/ZsiwBoYHEfWqDZt4dGfPzdYE0pq4+SLD1w=;
        fh=YXwOjxO/F2hs8wxX6HqE2jfYmkc2sJDAnb60i+ZkkHc=;
        b=ECtGRMQims4/jF4DSqqrhu+v3F2I1Ui+VITNLzFpcQfYeMk3hj0tbxehTp40qmIjvV
         6H1Hls1r3POqxFplelzslKUdey8W8ZBbvo2att+U6wnseKHv7/fE9jy92890D0Rmc5rE
         fvbz51dcqHC88uLpFnMIe8BbQiq4daGw9P9P1j/ZtTAg+uWOxG91W1byQTRQVIMu2m9N
         +f8OZxYmBQX/WUtWqQJIgcVuLYYCTssxwVDVsvFVelo4kJiapaxplLzgzv28w45P/65P
         EqBdi1eaRLuavjY11KLMVl/KQDD14sRTNR9h7Inf5+m5wFljWnZvx5/m789yaM9EWVyN
         ZxSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786423468; x=1787028268; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CHvnt+c9/ZsiwBoYHEfWqDZt4dGfPzdYE0pq4+SLD1w=;
        b=cxhJnUf8ZZp3fOOKrvLqL6mR63pGa/wpfk2WwBTQb1WGWIrxXDE0oFpLxZfyu9fS3/
         2N8G4/JCc5NZuXxsNIK6CLp44Ye02m4XafMN5zs/H7aZtNeMxoMLdeWBvhMA4t2ppbid
         Bw8RjabAH8BqkqxQVhOr1NamojHrGCJRfbLrPUGMHAYtqaF1OxufyLkpr2t722LmZGUN
         +iove67SJp6zL7ANr68FNATpw5gG7WAQKf/VzrNnDhcmIwi90GdavIX+lRFJI5qE75R3
         sZx1XWkv59YjmZQhD92dVRaO+JDuP9N9VrspP2CpyAGgE2CRtLVZs5CqdFOFGKCOu3+8
         RsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786423468; x=1787028268;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CHvnt+c9/ZsiwBoYHEfWqDZt4dGfPzdYE0pq4+SLD1w=;
        b=ZU7k5FN6//oPf4AIcjLodNxgbCefd/zv/e4QdEc8i4fP9G8h7DxVqxdSR9Q8pvcUQa
         HtbbRw1Gu5lAe5544+UgBRRC3zzLhmsx/lN7Xqix+ggBQbggUJSyh94jYwEez5kZcCoE
         +xNr3ssDzykT2a0KMbfbyT8sj8n3UT7ZlsGPbN+ZRDwLv5SE8gsvGdSYaZudZani8qve
         JsVdiJNx6D/F7pejOKr/fpF+945TANFcSsEKEF9H0RLmCmAuir+0/qAnBFNUP1Wzcbmh
         NEpp7WmMCrBkgX7No/9cEyLO221dV9EwJ3U3gzKKlBr9h0cyv8dyK7wc+iVpMnRwcVDB
         D/Sw==
X-Forwarded-Encrypted: i=1; AHgh+Roc91UwrY23kimxTiKvk5nSLs7pQR+tPIWtJGaPSPcz8n25HxlpTFqG5K3oADW705sac47Zn1lK6o1NAh4rnR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCizpq5LsYhA9+/5JYRe5cD5ghDwqdfzDxyyCI3qua+uFcJIVi
	w7Y1L7WISMAdbHkkz5sp7efGt0YkTHM7Z7gWJDR4cR/qbj9pvkVWaa9UvkKkujwWfIqHv1w5ktH
	oEj9VJKDKAiRxQCYPgC86rRVxQU042to=
X-Gm-Gg: AR+sD10vXxHC3As0OeUKaWR8dcpaGZvWP6PD5bxZYayh84KTtEUGh+WJ5g//07N04ei
	wB5hpCgdGN6nI7iba98IXVH/QVSNZeZPZjG++u8C2SjN1I5nkcujtm0VO9qMo6yk0PTbbXm4+RY
	y0D2ONo2qq7QtqmMzP+j56SjqmiEooO0GdhDp8VnGhpXxrzLwmF7atnKm1NjRBjVuTfptrjRshr
	xw56mwX8anRgVr5yhNzOG30wiaMtFaIpzGBwCaWvftyxV7th6qbbhLshch6OF35N25zNOCT7TtX
	D6dUQYvw2eOWkEk0mH0OKrollHqddw3HhTIuUQn2uWl3pg==
X-Received: by 2002:a05:622a:48a:b0:52d:41d0:89e8 with SMTP id
 d75a77b69052e-52d586750e0mr4849541cf.33.1786423467749; Mon, 10 Aug 2026
 21:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Tue, 11 Aug 2026 12:44:16 +0800
X-Gm-Features: AUfX_myovcwt3pdqNsO8mCqeMjbo9YmO-hz_6-8ufDqY1Au9ibUU4a7AxVngAuM
Message-ID: <CAA2SOT5U4fUJg2DOKr0-YKm0g5xAutjLKvkci99k5kQ6GMtf0g@mail.gmail.com>
Subject: [BUG] Bluetooth: KASAN null-ptr-deref in klist_put during HCI
 connection sysfs teardown
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a KASAN null-ptr-deref triggered by a syzkaller
reproducer on Linux 7.2-rc3.

The crash happens during Bluetooth HCI/vhci teardown. The reproducer
creates Bluetooth L2CAP/BNEP sockets and issues BNEPCONNADD. When the
syz-executor exits, vhci_release() unregisters the HCI device, which
flushes HCI connections and reaches hci_conn_del_sysfs(). During this
sysfs cleanup path, device_move() tries to move a child device away
from the HCI connection device, and the kernel crashes in klist_put()
while removing the device from the old parent's klist.

This looks like a Bluetooth HCI connection sysfs lifetime / teardown
ordering issue, rather than a generic klist problem.

Reproducer:
syz reproducer: https://pastebin.com/raw/n2k0FdAq
kernel config: https://pastebin.com/raw/j608iPvW
console output: https://pastebin.com/raw/Sy0Am14Y

Kernel:
HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

Crash log excerpt:

Oops: general protection fault, probably for non-canonical address
0xdffffc000000000b: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 22881 Comm: syz-executor Not tainted 7.2.0-rc3 #1
PREEMPT(full)
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010+0x4b/0x170

Call Trace:
<TASK>
klist_remove+0x12a/0x2d0
device_move+0x136/0xf10
hci_conn_del_sysfs+0x87/0x1b0
hci_conn_del+0x5ca/0x11e0
hci_conn_hash_flush+0x184/0x290
hci_dev_close_sync+0x656/0x1350
hci_dev_do_close+0x31/0xc0
hci_unregister_dev+0x23f/0x6a0
vhci_release+0x181/0x230
__fput+0x401/0xb50
task_work_run+0x172/0x280
do_exit+0xa54/0x3030
do_group_exit+0xd3/0x2a0
get_signal+0x26db/0x2790
arch_do_signal_or_restart+0x80/0x910
exit_to_user_mode_loop+0x115/0x660
do_syscall_64+0x5ba/0x7a0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
</TASK>

Registers around the fault:

RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000000000000b RSI: ffff8880006d5940 RDI: 0000000000000058
RBP: ffff888075ce9c60 R12: 0000000000000000

The NULL-deref range and RDI=0x58 suggest that klist_put() is
dereferencing a field through a NULL klist pointer while device_move()
is removing the device from its old parent's klist. Since this is
reached from hci_conn_del_sysfs(), it may indicate that a child device
under the HCI connection sysfs device is being moved or removed after
its parent klist state has already been cleared, or that the same
child/connection sysfs relation can be torn down more than once during
HCI device unregister.


Thanks
