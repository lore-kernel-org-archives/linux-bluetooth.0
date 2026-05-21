Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC730675C
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353556; cv=none; b=PyTVhQVdUf7L8G2u4QiJK5sWqOF+Ty/yx0Oy9qtuaneYzrIBDxMN+TaWt/3VtwEMn8jCpiiEBnJje3+D5mwVAfrJQuCGW2yWIPiY74F4QXRtluqOZQ7VNzvNHB16rOkmnM1jfSV/lqdpw3gg2e0eQAJN3BGlzDgIlbXl9taQCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353556; c=relaxed/simple;
	bh=L/psIrJ7X4B0oqU6c0I3+KnsO9t9F1HJZuR75XPBOL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7XFaj9qMCY18tflMZi1ZbFb9ztqUUJvU+G3wj2N7OzHUq2EN1Nmxuu4vCqKjHepuxSxD1WKqJtm9134elqH7Sp96vmsbxWw43DvBPG3OSOIFBkyN4FKg5fVaWWH5qMElPhmlO2lGAuKXhnv8meXpHL73IQSkeWOxpLZYBoEp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRNy0Y9a; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRNy0Y9a"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso656385e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353553; x=1779958353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDAsvJvyQmdC0fwTKh1BhFKpadOSotlrK/n6qdBfDgg=;
        b=RRNy0Y9aqYaOsm6h0w5kS++XcVJZNI7g9VJ9/q73K+9PS03Cg1EtXxt+mafutSb9oA
         2p2O064eH4s3Jxuln1KUCnApfnlbN8vZNa8zloQhv/OjR7gA6oY5Bv4esgK187HoE23T
         XYt7Nw4P4Cu6OTuFouYwMFvGdGoKjC0sUcJPMrF9/MdW5Z3dLX/tsGGsgz6qq0+68yWY
         wXQHYlZ+5SjmsSnvmVitsgRxU7hmFijTMOLin3ev0dBjqEB4uAoydxEsnS9/9yJB1d/d
         cIxYZt84VMME7+YDequdOFml2749wBGMOnVRlgokxWYzUTqmArZJ7mstySyDJQ0KAZ29
         82mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353553; x=1779958353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDAsvJvyQmdC0fwTKh1BhFKpadOSotlrK/n6qdBfDgg=;
        b=EZ4yhIZ3adwbwKOsCxgnVLbVAyzjymF5WTC3is+dMU5hClGhYRp79S6pD20fG2d1DL
         4hq4eQt9AeUixGxl/+8yXzM8fAyP105KmjaSZi/qR4PTE12dfgSao1VLgW0iAmmRelOO
         GjuBVbHdfR4WY4gioykWPkvk1y1ZoDJFtwe78O/yv5JUfcwIoLbUcGn2FsoUZnbvBQqR
         aHgXi9Cih6XDrQ/XPVXMwC3gAlvRpY3cuIh7P023GGj8qDlGNUmC3A82Vefk480vt3vg
         UXARQzAa+Qp0AMzi5tOTH7BF2ZjC10DOiiMjqEyeqlkSOpooFx0fMbbjPnZvgOrqA2tp
         +RLw==
X-Gm-Message-State: AOJu0Yx0wQkG2pteFzQcDXPvBqQeyrFx/wCjc4x3uy4Yi9I4OMVadF/W
	zAdUIxwGTulYJq/6EtppFkgLkBfBx/DE84O/2Hk9M8EFhTbmyPVhnlyWFahRH3+E
X-Gm-Gg: Acq92OECvwyzXBkSr+/0ljQKMaCrgti4d6VlOj91jzbyPHsZ2eGLLq29I7DLOyFWZvQ
	5OSvTB+eTqmxLG1g+FM5lKfQBwttb1dJAxOrG8sU44W55FuJBicKrXTg+XgTaAirJVWJv+KT758
	AilNQpaf27q6TVzumHCfECwDUFgzqgw6kGgbxJIcFv1c0oVrTyqa8ZAw8GgkMAoZvskUkAgeH4E
	1iQRpg+avAU0UPJRB25qt+TjxhSpKfsD/gMgx/ieaWluSrnTxnPvQkDj7pyL9VTN35tjIrUvJdV
	ZmFb7HZgN2puJd/rn65uBV34+uqBPHlJLB5XEztROc91s4SEFlgo6OKaCvvNaVT4b2VMxO2L4EW
	9kfglJ8VxhZvY/UoR/Y+G03FkiMHoSDi60GI6V27+sfKnkC7LAjmZZdiS1wOzWq4NzN2JCF+pW8
	aCPeN5UR9cSzq6BRpA0aU923wI+6T79TAzt9BW1KdEaVifIpcLSSwXJwFDE9B7gsu6CwY18VSUm
	Q/3UWNqd+ikIcj7l/A=
X-Received: by 2002:ac2:4d02:0:b0:5a4:d21:de07 with SMTP id 2adb3069b0e04-5aa2ba68cdfmr461749e87.1.1779353552496;
        Thu, 21 May 2026 01:52:32 -0700 (PDT)
Received: from valor-verifone.verifone.com (balticom-242-238.balticom.lv. [83.99.242.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa2f14f34fsm69386e87.74.2026.05.21.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:52:30 -0700 (PDT)
From: stanislavsn1 <valorcool@gmail.com>
X-Google-Original-From: stanislavsn1 <stanislavsn1@verifone.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Stanislavs Nilovs <valorcool@gmail.com>
Subject: [RFC] Bluetooth: L2CAP: possible sock_put leak in l2cap_sock_shutdown
Date: Thu, 21 May 2026 11:52:26 +0300
Message-ID: <20260521085228.80538-1-stanislavsn1@verifone.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stanislavs Nilovs <valorcool@gmail.com>

Hello,

At work I've been applying patches to our Linux Kernel version to fix crash in
L2CAP (more specifically this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=dd6367916d2d).
During review my colleagues have noticed a possible bug in l2cap_sock_shutdown
function which is present even in upstream's master. With above patch there is
the code below:

	/* prevent sk structure from being freed whilst unlocked */
	sock_hold(sk);

	/* prevent chan structure from being freed whilst unlocked */
	chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
	if (!chan)
		goto shutdown_already;

. . .

shutdown_matched:
	l2cap_chan_put(chan);
	sock_put(sk);

shutdown_already:
	if (!err && sk->sk_err)
		err = -sk->sk_err;

	release_sock(sk);

It looks like if l2cap_chan_hold_unless_zero returns a NULL then there is no
sock_put to decrease a refcount.

We have also asked Claude AI to analyze this place and it's response is that
this if case is a dead code and will never happen:

> Now I have what I need. Let me trace the chan reference lifecycle. At socket
> creation (line 1883-1885): l2cap_chan_hold(chan); l2cap_pi(sk)->chan = chan;
>
> The socket holds its own reference to the chan. This reference is only
> dropped in: - l2cap_sock_kill (line 1256) — requires SOCK_ZAPPED set AND
> sk_socket == NULL - l2cap_sock_destruct (line 1757) — called when the socket
> is actually being freed
>
> l2cap_pi(sk)->chan is also never set to NULL during the socket's lifetime —
> l2cap_sock_destruct sets chan->data = NULL but not the reverse pointer.
>
> So for l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan) to return NULL inside
> l2cap_sock_shutdown, the chan's refcount would need to be zero. But the
> socket itself holds a reference, and that reference is only released when the
> socket is being killed or destroyed — neither of which can happen
> concurrently since we're inside lock_sock.
>
> The if (!chan) goto shutdown_already path after sock_hold is effectively
> unreachable. The socket's own reference to the chan guarantees the refcount
> is at least 1 for the entire time l2cap_sock_shutdown is executing under
> lock_sock. The sock_hold imbalance is not a real issue — it's dead code
> guarding against a scenario that cannot occur given the invariants of the
> object lifecycle.
>
> The check is defensive code that was presumably added out of caution when
> l2cap_chan_hold_unless_zero was introduced, but the preconditions make it
> impossible to trigger.

Could you please review and check whether this is intended, an oversight and
truly a dead code, or a real bug?

Regards,
Stanislavs.
