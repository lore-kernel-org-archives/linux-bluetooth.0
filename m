Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4738DC56
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677954; cv=none; b=brQpinr7Zc594bSRKE2B/en5C6RpRoQATI7Y71LOhiLbnClt7htix+uXGgJEIxA2NPtMMzxIE5Ag8MqvMUs//Vwqt68BkNwihMnkIh2PFc8YINGoZeHfFuWkVkvnivadH/1QTIiQAozg++oZCnJtiRUFHHgJ+oZiL3J40rE7TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677954; c=relaxed/simple;
	bh=ZsWMOPj3Nxm20ZruhsAVcAP3hyBIEoPQusP9kqzYfYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sCBmSfDujK7YpgOMZLN32r/wRfn9akzgc8PtreukF9hLg3RfwlH4UHrTw4AoZNrad+l6KHyEd1Xv1xfvsyQ+Q0HIGZCPcnhc8CeUO94+zXod3w2R7uWBw5LgQXDY1+8PzpEEIWXqSdpI1ba/OixerfYWmoqIu4/WpiIrK8b83AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShtAfsaO; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShtAfsaO"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a6c77d255so28569137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677951; x=1790282751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0ql5uwPn1B1ILcPxLIPbBLoRw1ymP9C0RVLIn0/6hM=;
        b=ShtAfsaOTyPPAtCtlpABKNg+l2FediXy+fN6I2FWk06JN4J5UoghCrVHzO6Y93yxF3
         0TMmcm44RFPvX8+MR/OH9GOH2dz4uNiITc9H3DKmzQku8yznNeV1oNem5uJS8rPwyscd
         T/NhELOyPIsGgrwFtKGWQ8Pta2D98O79SZusR6hHWq1zVbGtFuhQZeu1vVThM91Q7sRk
         CiBYkMHM37p6HudSxNwga6K5lUK7sROJ+3JQfRr9p99hwv9onhNxYrSYRZn0oGPG0sAn
         QHRqIWAQpJ9DofvQIxrz2LtohTakDUg48orCZQSuUSEvET2+a9kxE2JsUCTO+t8JyNTD
         rkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677951; x=1790282751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C0ql5uwPn1B1ILcPxLIPbBLoRw1ymP9C0RVLIn0/6hM=;
        b=X6jSZ8bN/xIBorZlGrtAPhmZV2CdSSBrJDbUhH5zjN2TTbNeRzQEl7u9YhJ7ctnmxo
         OpDFHcDT1USXZeiK97ucy2f+xDnv45aq5TplxHE5bWaxYnw+HZGUzoQAezKUgMuN4pwc
         j4zde9MxGyqPHoLY0/2JpmAeqU2Xp6gF0Bw9g/yTR6/q+3TWMmKxoAU3Pp2WCRZFgNy8
         4Ej8+kK0z5APAcz8MEPAsIqdUrGFj4kLetbByLiA5ilI4atPUj3m0jIWvs5OD7y4PwDG
         kQDNKbWUh/JouEnZxdwrobavbzMUqIatDO7BNi8VeF6uBStlWXtvGknTkEYRZkNfTTpJ
         x+hg==
X-Gm-Message-State: AFuF++npDlmP95UPM8CoO+RE76GwkgXR0sJISs6BkvVSlq63DaN3DXsZ
	ddi81P9zsavMhhHKj3DoGehk3qCA98Tffc1SvLGoFDHBdMIMk0fAna12blI2ejUafKF/lg==
X-Gm-Gg: AYBFou3zWUWYVQArjrDKtUYM2EplaQitNGU1SgaW8iLTnjHugEdwCcMTNoQwOy8hhOE
	cK2EeqdAObCePImSboJcrbL7UjWUHxOlHuhtSqgjifNIdnsxQgmb5e/LHiYRwFnHUAME3UDHDUT
	676j1VLnc3jZ3ZfYaAEHn5uXrgmYc4/nVivIvE8VDnnGBtnUq9Z7MwPLbLbjKJqqDseC3TkHugq
	OrXDw93JjE+uKpfQJ5ENwJKkqaOtsMMonIK66L4a1ndlWGOY7El0sgl+VNjemMo3GLLemmlZhTh
	UqN4zmTaXy4XzobXNnQZPQZdB3VyCP2B/ahncY1tWZyfUBJ80EaPEWR2UtG7G/+nntQDIF0GC67
	Cy9u3pj7Rbh2v2bzK08EmqmjMZVDxYbGuCCaMP/5WOyNvhEvpG992ZSLYbUzrWBvCiARkUr9lbT
	BGbWSwLzAdJJCb3h0o4EvNCPNwoWkq8QLaH/GWqUTMy3b5hvZpxndNGdZMFw+y6PkVvXXxI7Pq8
	85kc+YjAkkj95VyBj2aZeMeN5JdfWVhyG0M4orejD6PQsObn/S0fwIZEy/wRL/Psg==
X-Received: by 2002:a05:6102:2922:b0:7a2:2a6b:e7b4 with SMTP id ada2fe7eead31-7a55a0253damr140148137.2.1789677951492;
        Thu, 17 Sep 2026 13:45:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/6] monitor: Search the frames with a pager
Date: Thu, 17 Sep 2026 16:45:35 -0400
Message-ID: <20260917204541.2176720-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A frame spans several lines, and what identifies one is spread between
its header and its contents: the header says which controller and when,
the body says what happened. Searching a trace a line at a time finds the
line reporting an error without any of that context.

This series makes the frames searchable as whole entries:

  $ btmon                            # then press Ctrl-R
  $ btmon -r hcidump.log
  $ btmon -r hcidump.log --print0 | fzf --read0

Patch 1 sends the decoding output through one function so that a frame
can be observed as a whole. It is a pure redirection and the output is
unchanged.

Patch 2 separates the frames with a NUL when something is going to read
them as records, asked for by --print0 or by --read0 already being in
PAGER. Nothing is separated otherwise, so a pager reading lines and
redirected output are both untouched.

Patches 3 and 4 hand the frames seen so far to the pager on Ctrl-R while
capturing. The capture is never paused for this, as anything not read in
time is dropped by the kernel, and whatever arrives while the pager is up
is printed once it closes so the trace on the terminal has no gap.

Patches 5 and 6 use fzf when PAGER is not set and it is installed, since
it suits a trace far better than a plain pager, giving it --ansi and
--read0 wherever it is used.

Luiz Augusto von Dentz (6):
  monitor: Route the decoding output through a single function
  monitor: Separate the frames for a pager reading records
  monitor: Hand the captured frames to the pager on Ctrl-R
  doc/btmon: Document searching the frames
  monitor: Prefer fzf as the pager when one is not set
  doc/btmon: Document the pager choice

 Makefile.tools    |   1 +
 doc/btmon.rst     |  64 ++++++
 monitor/analyze.c |  44 ++--
 monitor/avctp.c   |  68 +++----
 monitor/control.c | 163 ++++++++-------
 monitor/display.c |  93 ++++++++-
 monitor/display.h |  14 +-
 monitor/find.c    | 499 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/find.h    |  19 ++
 monitor/l2cap.c   |  34 ++--
 monitor/lmp.c     |   4 +-
 monitor/main.c    |  28 ++-
 monitor/packet.c  |  18 +-
 monitor/rfcomm.c  |   6 +-
 tools/l2test.c    |  10 +
 15 files changed, 891 insertions(+), 174 deletions(-)
 create mode 100644 monitor/find.c
 create mode 100644 monitor/find.h

-- 
2.55.0

