Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554761;
	b=oHnH73tIvR9wk0lnzcU3YwPkmeq/6YkBVA0y8BE3P7ezUXU7QASgUOvHQV8rzniD4I5S
	 u3XG4JxFj5BDmmf9aUd+p6pH13o8/LGOIJnxIyROmRs9XM1+zXPKzNZZi9xkta1VSwIj9
	 oXXs2o4kdy7qEoGhqy6bmEdp8ZfQ6mx9Q/IN1MO+pmupIN51jsHdbRlavVhVXj5L+c8MJ
	 zk1kXW2RtETrTaevNxefAWiwGcpF1aT0WlQcHCxur9RZ7ei2rfI1L9jNzZFPM6dYz6Bww
	 rqC4wqIXXV1TFM7ISxEyivh1lE0MG01LIq3gRo0gzBAgsKbgJ13wAbMxymFQX/9sKiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=F8rYSABrKPlESdcxDAuXs4pRX0vk4JfNgBSWMnneRLY=;
	b=oVWF/yXxK6a/l+iMZLh28vYk99hX1wRHd4uVvvZMUB4aiyKHpQ2NPaR8Y7VDBV7i6ZFi
	 XGKi4JaC3ZLgWZaFd7lb77MA+wPj8CsGwap8JWCNiiLbWj9QcRalIrSGIl/cYHWyzDQ/Z
	 LA1Mi3WyJvdSQ4seMaInQ2uw6DWXw6Obz4E0LjKQdjweaMw1NKgThvLiDXs4q2lfjKpFj
	 V9XopnPflIXWsbBsgOiulVhM8WKg7wMOle73w4pIKEPH1vI5EZvxc7biqkGt03CG72xS5
	 XiCznAbZHF9mioxPdTTzoq+GId7S477pVutMFB0KqG8g9qQ/xo5G1tMfrs+F2wUvF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GN5MkXZC;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28407606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28407606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GN5MkXZC
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386ab9ab619so5570823eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554759; x=1796159559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8rYSABrKPlESdcxDAuXs4pRX0vk4JfNgBSWMnneRLY=;
        b=GN5MkXZCErMf6dk+btCaHgEKpXVzYUucT2PFwX2t+/tNrjV/cF/U5N19NBBskDejOK
         /X6fzSUtPGQlmlYHqX6ANopqE/wg0voxmqvEsznbkqudFn37VRE3G9EIpQCAZZPA3UDw
         qJ3eo05Kx5mchxy/46qSlgH3QLfQHg3rIpXpD8lN1Z3hQXLfzSbEkDppnC3emxM/rjp+
         P0EZXQiOkwBhk6jJ3Pn9AvdzPJ2g9ROj6DT7ToprpcuQQU7KEZ9EM+quDZgsqlPEq487
         0lEEDuluBkKLwJQsKig7ezsX1gOZOcSvaauArGbPTt2IgORbOlCD2DMU0GYZN/jHHnfI
         7opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554759; x=1796159559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8rYSABrKPlESdcxDAuXs4pRX0vk4JfNgBSWMnneRLY=;
        b=a8/w20DxayrX/7TvJ1O1SBblD2nRYMXool8yLPt7xtVDnZz502deRFi3ZEKQPASG0Q
         MTzRgvs/aP3DrpQvutw1JvM/rC2m9qz6zxBato+WMB/dwsj4Kzj/pzFWU+AbSC9Bb6P4
         ZRjPVqytx2PqY9hPiQFrJGUVZhP3GpYBUuwk5svQc8l6Bk1lUi718aNP1BZhSVaJVqiP
         A/sb2nVu4qMgO8GSRvFFf5czCr6rMdpX91+7A0bxyqfFyEUWYgDGNEtIuDOwXsQU5NLj
         xxdYi0jFmfM3wsebcO4J5j75EFELe+nidxB56Q4gRpigCe2SBF4L/YXsHZUfyfNRpjLk
         F+7Q==
X-Gm-Message-State: APuU4Z8fYVm/agaaEsGbRaKI7r/Fk44s/CPjitzcodkFPjxvXYkXG9rd
	QPa9/wjCe3O75rJqMSZK9FUag3PuDOfHmLY70KB/H4F9HasdhhxR6smzY3KFWd9xPvo=
X-Gm-Gg: AZFdTZdIx0TsQAGHcIZs0JM+ekaV0YEyFUkx50+0IlA1rC9J3L99pA2r5iqEV2/0xiF
	4wQVbJWmpc00w0DGk6LpRvY+TJ+7XciZd+xBHSDdQ9gDde75pbejRfI1PKh68YJ5nu+mdLiJbhU
	DuCivyowPGclumHCECDOfXPv2JGpywmbKILGEwWhXX/Z/C1rwmELdAhvA2ipZ/N7OVt3sC1EYsC
	W7Y7DpQ779Yv5tOfhV6WmN0pw7N8974PTypG3AQEeg6pgjjGetOv7nDIQoMl2Eq1JF78Ev8Ldns
	KNkhsiP3sm1sTK4DWKSuGd+AupNDFK6HBb8KlO7tPF7k/fKKpKgnk4zyh1G0eOKiRdkOoAwD4Kh
	0ZDJHjC1Mr0wnJ2D3u80TbAnKfSlxMNEOEhePTlkrwxiSs2xv6qFGR5UcFGLVPPLDpT4Naa7rDX
	vnPj1Zf/IYDEyKA0EOZ51Cadm1fZBChTT23ZZi68GjPf8TsNxZUO8nDkWc67XKy0d8fXAizxdv3
	7eh3PPNH8O9NkyfMsaF5sthhNfrp+7TW9nDWcLBE2OLrSPCe69J6ZGQp0UWM4SSR+LDYVAUx+qx
	d0Dmy5V+uZSSA9vrNUFbnG1076FD7q3btbe/sLUAa0QxmQ5amWjGyQ==
X-Received: by 2002:a05:7300:1c17:b0:386:a105:fa66 with SMTP id 5a478bee46e88-386a105fd17mr10963340eec.7.1795554759056;
        Tue, 24 Nov 2026 13:12:39 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm22124445eec.18.2026.11.24.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:12:38 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Bluetooth: fix bonded LE peripheral reconnect completion and holds
Date: Tue, 24 Nov 2026 18:11:25 -0300
Message-ID: <20261124211127.41609-1-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
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

This series fixes two issues in the Bluetooth HCI layer seen when a
bonded Windows central reconnects to a Linux LE HID peripheral.

Changes since v2:
- Rebase onto bluetooth-next at 6a40daae69b0. The Bluetooth CI bot
  could not apply v2 because the key-refresh configuration code moved
  into hci_conn_refresh_key(). Update that shared helper in patch 2 so
  both Key Refresh Complete event formats use the same path.
- Preserve the LE setup abort checks in both feature-complete handlers
  on the new base. Patch 1 has no functional changes.

Changes since v1:
- Refresh the saved synchronous request after timeout or cancellation,
  preserving socket references across controller reset resends.
- Keep the LE feature hold across encryption and key refresh. Explicitly
  abort failed setup and prevent later events from reporting success.

Both v3 patches apply in order with git am on the pinned bluetooth-next
base and the GitHub workflow branch used by Bluetooth CI. Local model
tests pass 152 command-dispatch checks and 62 connection-lifetime checks
with GCC, Clang and ASan/UBSan.

The v2 backport to Linux 7.3.5 passed repeated bonded reconnects,
approximately seven hours without observed connection loss, and Windows
Bluetooth off/on. Those hardware results are from v2. In separate
Windows suspend/resume attempts, the test HID application could still
wait for an HID subscription after BlueZ reported a connection.

OpenAI Codex assisted with analysis, patch preparation and tests.
Sashiko provided the findings addressed in v2.

v1: https://lore.kernel.org/r/20261121033104.441146-1-andreiab9019@gmail.com
v2: https://lore.kernel.org/r/20261124140956.15296-1-andreiab9019@gmail.com
v2 CI: https://patchwork.kernel.org/comment/27404265/

Andrei A. Bykov (2):
  Bluetooth: hci_sync: keep unrelated replies away from event waiters
  Bluetooth: hci_core: preserve LE feature holds across encryption
    events

 include/net/bluetooth/hci_core.h |  9 +++++++-
 net/bluetooth/hci_core.c         | 16 +++++++++++++-
 net/bluetooth/hci_event.c        | 36 +++++++++++++++++++++++++-------
 3 files changed, 52 insertions(+), 9 deletions(-)


base-commit: 6a40daae69b0c45d4f8b6aa247fca165b8534f60
-- 
2.56.1

