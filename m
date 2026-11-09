Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239105;
	b=GJlbTrPWyh0zYeVT8nDzpqI2wxoWcXtW6hVr0X4UeL+TSsK8WZx2R6c+jX1aO767ZfgR
	 leKFeZtWJImWP4Q/IxytwdXcDprMtm48DWWivV9qbc1yPCyV8X21JK/LLter2+36cgjPV
	 cHOuj+mgvvfs91T/pjjltdeyUt/bfRfToz39QDpyBEFTNw5Dwii8cZ/U/ZUCE7ann9eK4
	 lCRI080D/sg6G+05e/Au+AgoO+hEK2bJmS3c1MlFYyVBHFynQvb73v2Y1evhVgtNYXgS3
	 1EFhA8GeLoPaazcabwnSaTnXGQO+lSW9CRVAKzVuzzYQx1u9o88OVgCqc+5ZmJ2G/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C5lUgzfeuL4LjF/79S2fj9GI/NHD7+kP8NUHTC4TQ6s=;
	b=bqH2X/Z0qps3KEQZGVF0M6VzXZnNU0e/tKwhg2smhO5Y0hIpEjRvd4wbPXsRBWf7nlrb
	 H+twbLszlm1fAVm4blffKiccDGdHSLaio+GhYYtKf5GvhzI6WA9pxUt6OWYgYltHx8oCJ
	 j2Iy9wt3ZDzmUoigthgKZX0Uy7U/2NpQJXPUuTf3zutodsj38t7NmJSQWJ7QjLcJLWxf+
	 +jnqa3shLzUXjoB0uM7XomzNMtQWoos4osIqVjpuknGvPhU/qhX4NGtc0z0kv4oq1qDxN
	 JqpMx4v7am3eSPXbh6NxFxe2dlLvmwRRXqKMizRr9X2/uQ04GNcwnufNS6J5xmHRlPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qffCY970;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FD606A338
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A68FD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qffCY970
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ecda93627eso304081e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239103; x=1794843903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5lUgzfeuL4LjF/79S2fj9GI/NHD7+kP8NUHTC4TQ6s=;
        b=qffCY970eAPDZfxC7pn2g5JB72v1FJQWO3x7CSfDgk7onQfJsGf6K0MeghI2itedCb
         Kh6WWIcA+/IjWhSiXJtddR65qK3qd6dwJBiOrZrk71u8oyxnct9XvQYxNAPnBr7OcIDS
         5o3l/3/VUEo669mwQH3EYMtmxeCUoTBHvQQ8S0au18IaF4sVS4s3Xc1b5v1WnIMAZme2
         asPxMOyDjA76aZk2c3ZeGw/gYou4XsgrJmQJ+fPsdiQTVgqNF7xxzfVkFqU88kqYGdNF
         W3+E1JvV2YuYbiK+EX9M6uZr2+M4t7jYQiuooBF2qZNlfzEEldYDumOSaDJd9OWs4mTK
         KElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239103; x=1794843903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C5lUgzfeuL4LjF/79S2fj9GI/NHD7+kP8NUHTC4TQ6s=;
        b=equXWO41D8J9NSmPVGgevTarR4NWhxT/+7TElZ+xg0DHjFGo3d2n9es9GJXO7f+FxJ
         vRHngCidcnka6XrW9c88nOL654xMJ4abi+96IDfdgqbAhjiGp+3k7d/E/8joe/ub5AV3
         Qzs9HWxuzRBbYwHw0cjTHzcAuuxCB3u57IsHy8YRaOM9UZMqYuqmndfK2aN3T1XLlETU
         x7cLbC/m5cGqC6Ucaj1imfPQJMfE5sra+8JNwQutNY17dB4IuYYx29jMkudSITdcTm7C
         criXsZuqUH9GONzJMJM9n/uu7GaXREO8WgJIkf+Aor+45zSGYnifAIWx1n0ZPcApipQL
         2Seg==
X-Gm-Message-State: APuU4Z9HdMLDJQ8MC8YUIgRcQD7DP8yIYMlqmbkRszRceEoq+Znv1Fsd
	wqSvJ+4m2Odu0VhkiPBlvzK/B64KEBm14IHal1RRfBHVBJdk02mX7vpDJqEDkw==
X-Gm-Gg: AYBFou2lZy8IWhboQ8b7DdwEusSB/iH+ulzBVOPFuKhtXVFnf/3ANs01jrYC6CBACjr
	AVheEzF96PrL6M3SIzGHPJ0By9VXgz07aTjC5WfR0zfM7llTrRsV52Xd4WxyI/7V+MkLxQgDwwt
	1AaqRnbNYUof9V6Mwgo6vfBnVVtYUjzf8C60jQM+RBf/TbQm+BM4bcvbY1Pma1rZFDTwy1dMbPr
	UiPQuz/Mxfb4oObunnYnnsZZmyf0hIPjqRg5lIMkrvkNYWRhrQyLMEkfMyXJbBK4hM4gUey1bfE
	YOxUoItVQG9UVBgu4XRBikUzsgB3oVRjgbyaNJQtI5V4FgMBYtjWJ4YODpta2vGsyqOqyBONu1i
	pipq37+BrA81N099Xl8gUD8HaRN2PPSat6SntcodMxkKjHSPUuTUf0R5GA4pjH5OD/TLQtpSlWP
	6R3jvrryBczEY+87MRn+zEoVONnBiD59IFrRhyZ7Wnilu27gFHovWBIAkrx5IEDJukQWWSZgJiZ
	eflCjDySqgCViXsrHoFbL7gV/IQF2JYtWTW1YGHt0rRR+9cggILab/UCzJBCVjqORJZs6pOeRmz
	ga1YAFNLAtQDtAvwx/eT7te8P2J0GYdJ0vn1SOcMvDEyJhjcl3i72lJRIivNqevEeBU2hjcURcU
	kDuaCuHtE+DLZL7QfT9pcVOuSNiGdDNA8txJzgaFP+EYfw6XeCTmggJYerYwzQrLUe9MO7LHgXM
	hhYaU=
X-Received: by 2002:a05:6102:26d3:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7d2db206098mr973695137.37.1794239103514;
        Mon, 09 Nov 2026 07:45:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 00/10] shared/gatt: Use util_iov helpers for PDU handling
Date: Mon,  9 Nov 2026 10:44:51 -0500
Message-ID: <20261109154501.1362649-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts src/shared/{att,gatt-server,gatt-client,gatt-helpers} to
build and parse PDUs with the util_iov_pull_* and util_iov_push_*
helpers rather than pointer arithmetic on the PDU, so that the bounds
check is part of the access.

The conversion is meant to be behavior preserving, the existing
unit/test-gatt tests pass unchanged. It is followed by tests for
malformed PDUs, which the original code already rejected, so these are
regression coverage for the converted paths, and by fixes for bugs
found while reading the code:

 - the authorize callback was called with handle 0 for writes
   (reproduced by a new test)
 - a failure to store prepared write data sent two responses
 - the Execute Write registration failure returned NULL for a bool
 - handle_notify leaked a bt_att reference when the signature of a
   Signed Write Command could not be verified
 - handle_notify subtracted the signature length once per handler

The last four have no unit test: the prepare write failure is only
reachable by an allocation failure, and the signature paths need a
signing key and crypto setup that unit/test-gatt does not have.

Note that "make check" runs the tests under valgrind, which reports
uninitialised bytes in bt_log_open() for unit/test-gatt both before and
after this series in the environment used.

Luiz Augusto von Dentz (10):
  shared/att: Use util_iov helpers to build and parse PDUs
  shared/gatt-server: Use util_iov helpers to build and parse PDUs
  shared/gatt-helpers: Use util_iov helpers to build and parse PDUs
  shared/gatt-client: Use util_iov helpers to build and parse PDUs
  unit/test-gatt: Add malformed PDU tests
  shared/gatt-server: Fix authorize callback getting handle 0 on write
  shared/gatt-server: Fix double response on prepare write failure
  shared/gatt-server: Fix return value of handler registration
  shared/att: Fix reference leak on signature verification failure
  shared/att: Fix signature length subtracted once per handler

 src/shared/att.c          |  38 +++-
 src/shared/gatt-client.c  | 203 ++++++++---------
 src/shared/gatt-helpers.c | 452 +++++++++++++++++++++++++-------------
 src/shared/gatt-server.c  | 380 ++++++++++++++++----------------
 unit/test-gatt.c          | 214 +++++++++++++++++-
 5 files changed, 821 insertions(+), 466 deletions(-)

-- 
2.56.0

