Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745E3939DB
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496687; cv=none; b=nGardfnCZdB5R7vpBxiWwY1lXCEp53TLXU9mhTaAsYEB0lgjnaxTcx6kNZByKosPpeYP2ElJWaKr4apHPAa2kMjA9OphWC8HlfQTqF7Kz5ceVNAmoBFpj4CwadhSTYAtMFkKKK1m1mjr/KbB+Oi3nlqg30ELnO0LjGNE3HynB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496687; c=relaxed/simple;
	bh=uteNMRU9ob2QXhmU/w6rpKMBnXBjUIP/xvPz40+lxTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTMkIQel9BufghaNSN5sRt5EthzOwHR7yEtHpuToRUTmW6k6lsRFhiAf73TY0ptPo8LrDx7P0Ov0G9thmnC+ngUg4RddnGmVq4n/4W8f3zwO8BvdMtgMxJEHqJ1iPR21CWsl7zffOZ+oMrhZrPkHtJsEhrN0B7cAX6zfj67iszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ8q5KUv; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ8q5KUv"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-34e23e22666so155457eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791496685; x=1792101485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQs3bifwvpfzlIeed93Eu+mJNqw4FFjUGKmo6hag/3Y=;
        b=kZ8q5KUvX/Iqqds+3IzVTB8ysMyt3b1ySKFVToN9xcm7jXQeP6B6WTzmTNkD9wKUHd
         sc5W28kLTdt9A1GvJ24sJ5+KQ691k4YNV8n/dkz4lk5C/kp94WJrq1tUgLIBVcI1hgCN
         ErXty9yWQ7Jl7NfXQanG7LBwdBMJFO4gsk4IB5yIBkfX+suUwOhf9ncYdxhtrJjrfXin
         22tzNuO9pLV+hjEa+KxrIrrGZqcSHrFeYWGSycrVYkC7x8mPpXWe6d1U3MBCO4u3g/Kk
         7An9AmArnHb1u3/rmPehUkxGq+VoJoXk3DuOX7KHRmtFhPWRkGIn1RWu4R5PQ0FcETfK
         n62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791496685; x=1792101485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQs3bifwvpfzlIeed93Eu+mJNqw4FFjUGKmo6hag/3Y=;
        b=TWjlV9SZ2DW1JNSX9aLuwb9mdbpWf/lRuzuv9HvSnU5rkrcmx7GvqFS2bWcokQmQc0
         oEhEWcKoEpas7yT+ZUamk9WWLF6T/BSlEgqbuy+jYdPdqGD/B92KHmk59vhtBSudFtIz
         XF8f5lEcea1iArFfI79vlzJ2IdHRB+96NgZpSscbzK9yXlC6Qs5RngkYAHLGWSGPxgmg
         puHlH/HHvMAG8a5N1tSk6VdOxuTQWHei9MV8bYcdiBhUmVlAoM7EaVhCrTgwY4Tgaje9
         IVi+WPQB/wVUPm1gsnI1N3UZfU/V9nf89kImzCUrS9gaaOj2oCMmBIriu4Y9w7qv8NaJ
         Lubg==
X-Gm-Message-State: AFuF++mC/qS7pcfqsoviYo4v9NTqbA6h1ZbiUgZtA3M/LlCkUAUrfav5
	3bz0xWJ1OLIzEaz6BlLl2K2NIxYxTYwkDFRlyb9WrzKV4drbgLitppSsmXAnyxmNZWs=
X-Gm-Gg: AYBFou1cZCe2VJOTrjs6iYdpP2ThFiQeBKyYcu3FKNT8Davd2pgzjETlkP9hHyYDore
	RKupO+574jqdefNRMzQFgv+UNgrbnRb2jqn2Llsjqr0fBV3ZufKIqSf4D2QDBEdqEQMykLDBV2r
	C52TECiI/oEvVwGJySoRYNM6Y53SZUsggv+/rNaIVTfszPltxepnonJC0ZkAEcEYvVwqw5lA+sV
	FjR5jpyJQHfQbD+KnPIGYq4XiCr9ii/ZjHvFgc9QxeC6saBpV9D//+Vdsz2qwUJuMpGVYVYuAM7
	u8sKCvUZVf3hOE6TRBVbv0UGgEghQIRebWokt9ZRphYqybFkHLRABNvaD2Xt5k9xvynchnHTZ8q
	V55QnPB8qdnrbkSyEP+DE9R6fSvK/gYjsD5b/6GBS8CLqxynJjB/yQUXbB8r0Vvu0B7GHyOHfYv
	BevlZK0E55SF5QQsYTbFuHtqmfDL+Lx2BgMGFPZ5H3fh39BT2hv0IUezMSfCWucFUueUWIk9D4Z
	ugQto3wchvF1a0nL1WJ18164qc2aPiaToXzyPKJ
X-Received: by 2002:a05:701b:42d3:10b0:14c:f3ae:c1a1 with SMTP id a92af1059eb24-1657b80bf6emr7155071c88.0.1791496684938;
        Thu, 08 Oct 2026 14:58:04 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd5cb5sm899823c88.6.2026.10.08.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:58:04 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH BlueZ 0/2] Test links completing after their connection was aborted
Date: Thu,  8 Oct 2026 17:57:54 -0400
Message-ID: <20261008215756.2710812-1-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luiz asked for tests that abort a connection while its connection
complete event is pending [1], for the kernel series "Bluetooth: Fix
SCO setup failures after an abandoned setup" [2]. These close the
socket while the emulator holds that event, by sleeping in the event
hook as hook_delay_evt() does, so that the kernel aborts the connection
before the link comes up. They expect the kernel to disconnect the
link, which no connection takes:

  eSCO CVSD - Close Before Complete
  L2CAP BR/EDR Client - Close Before Complete
  L2CAP LE Client - Close Before Complete

Results in a QEMU VM on bluetooth-next (c85976511aa9), without and with
v2 of the series:

                       without    with v2
  sco-tester (31)      30 pass    31 pass
  l2cap-tester (113)   111 pass   113 pass

Without the series the three new tests time out, and btmon shows no
Disconnect for the link. Repeated 20 times each with the CPUs loaded,
they passed every time with v2 and timed out every time without it.

The incoming case of patch 5 of v2, a connection aborted after it was
accepted, is not covered: the emulator answers Create Connection Cancel
only after it sends the held Connection Complete, so the connection is
still there when its link completes, which is the case of patch 3.
iso-tester is unchanged, as the series does not touch CIS or BIS.

[1] https://lore.kernel.org/linux-bluetooth/CABBYNZK9Oy2iL5PosxRy1KPup0PgYDfPUxeHemjYjKyAUu4+=Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-bluetooth/20261008151238.2138665-1-enghitalo@gmail.com/

Hitalo Souza (2):
  tools/sco-tester: Add test closing the socket before the link is up
  tools/l2cap-tester: Add tests closing the socket before the link is up

 tools/l2cap-tester.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 tools/sco-tester.c   |  45 ++++++++++++++++++
 2 files changed, 152 insertions(+)

-- 
2.55.0

