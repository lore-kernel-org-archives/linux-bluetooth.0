Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431953;
	b=a2Mr8EvSj1/LY4wL2nYN5hcgeOTSHxbrPR7YWR58uojAQYr6N3g84WSr1NaVKngMTNj6
	 t301IJFrqR08pzmUujhI7SWU69LNhuWVe9n8fTW3ItflMncHHp1SKRmWvXC6NK3Vj0WM1
	 5uKPmBsvhgMz2g48Z9Wk6mH/TkhVGGnylVxYN3u0OuNuMMS0cO2gd+6b0DsahpH8WBsq/
	 bNUf7y1CvlFdMMv+kNEWUuMuz96snF5M88oimT6Od1nJ6UPm4i/IXUn9WUfoh/yUpvwoZ
	 E5RrbwoCHaCOoWpbcPg4hhdF3lPRpW9sH9vLwZQPUbt+l/2J9ZEiajz17WCANYFHt3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SwG56EOzHHh0S1sw1BzNNeewAAIG+9Q3bqBhbj28D+k=;
	b=bz14XEuStEQlRFo90bx5VTEkv5UG1ikUeuQYGxONri/n8T1HO9cfvhR99hQBI4uS9V3Y
	 aYXV+2m7zEEP8wYhYRcK9oplUjLOSmKqqOq0PoYwM3heYAmTIvEpU6oNwD7V4wPRnr0eF
	 fzIwW6gh4+QH9FAGvb6z5C42SleeEdLdqZEn3oMvVt/nz4d8cFeQUuBy4KnYH5YEhjoH6
	 BmgsGigSjTKYUQvmBQRcJX2dGlTb3H0WzOO7En8EJ0och88dI6nRsfIAGlh9u2FdARofB
	 qkhFSb94YAD/sgmor7Np6ZyA+SYTpJ2LxU6w8N8BRK5Cup3dPuWexbVYbdhKXZwgoyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qh9Gb3B;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920F606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 07:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3920F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qh9Gb3B
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so625713a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793431952; x=1794036752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SwG56EOzHHh0S1sw1BzNNeewAAIG+9Q3bqBhbj28D+k=;
        b=0qh9Gb3BneawzI3UrU54Pds8B6y660Y3v1867DL9iKcSsYE3qdeZjdSAtN7CKWXclK
         dhzlXts/nOAXK6soHQP7iIL+H1EdoNbbvaBdM10QQLuTf4PNIIUxhq4ZrvoGoTAMMBu9
         kO9zoOBKcFfnScszMYjg7jGBALYwrizjh7I9LQYey7R69zJD9kJFYjUCXe6GYBTvpRr6
         FgOV7S95lDGcVRQ9/HP6mYaJAZbKz1lcEdrtFCi9QxkBhaU0wH+ynl7RkA5lW7ny85RO
         TcHYjT8zm9J6t6WcF4+kYaYQ1n3zZ8fp8/XQ7P0gE0L3FDfGcWQW85Cg6zsDnNsoQBFC
         ZRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793431952; x=1794036752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SwG56EOzHHh0S1sw1BzNNeewAAIG+9Q3bqBhbj28D+k=;
        b=wJOjg+Jh0Xv9Lel6itd7UWvEgl4A8+dUuRwPFE3AD/vztDd+RvXFmsLlWxs308J0Er
         3fSNLBFKtpmW6jRN7owRyS3a6Tk79a37pPxhDdb8snTs464jHTZhKFoh1Z3Jpoksw2w8
         Q3jJe2xoD1ZxYziNHniee1K7bX6TtjIf+G3gvY03N0pLLLRyG2q21N2lHiBQeEP99Hld
         CV4ilgNokiArXg5KKC0dMlAWSU1CQXC9EJI/MUYXaLdJeHY4IkS/vH3ToeBEGrUPye6F
         7eFJaPvbgwtOiCWO6+rJyaE5mPFdOK/gW7b7jI9h9iZ6wExBYM+CgFOzxGZYdfAh3zG1
         Ho2A==
X-Gm-Message-State: AFq9FYLZ3m+qHTaMN7jIZZgVBAp4kJYAs9qV9e8p1pzxzEY+qxT9q0Ub
	civ+bka+MAakGJcZfudl4axxqLuO6+YN50Gh8vj1udqhwSC4gk8sEBLU
X-Gm-Gg: AYBFou0ou2+vHB0ONoQ72yZimVzxMzbHew58D3p8Y7Jsg6Yq75C62LGPILVuU6uVNuX
	QxspnShmyd+57iY4xDh7DCqNeb263HY4m5ifwmgZqQMZiQADwFg+Mef1lvraYWkaG+Q4cR0pE6Z
	0JZaq5604t9O493Uey5gj3rstklqM5TG5bjq+s08OH1E5GyOcZXZYAS+cKYm2Lf/cg54gSxwZQB
	8QVnfyg/aIwfcBZyUsJDjAQzLfrdAJqks1dE02tDdXrd0ckxccneGeRezFyl6i5lp7FAQQGMHug
	GMDJbwytjRHRcDnUkVzsXQU3s4oF4dm7V18BZb59cmFxJqwaVkcmlsnRXaay4l6N3fJIpYmfsVV
	3czxRF+vSBBzWW6VAnLe9lFC0SMYM5UiLEvhwtMm5UyBXeki27tUG2yaUzEHbgP3pwWIcz4ZAOu
	dTvAFdnpoKzwXWIqlsDOPvSfD4CnxUDgrK/wW3UvXjlj/f+yXg3Vwh2W4j63aDxfpq/fGtuDyrV
	RfmjvcQfK728jsJrYnuLtVAzQWO4T2S/XnDYCr5w1poq+bnAoffHdjhOpKdjcnQpNyeuwfdidOs
	0THl1O+ZgFpoY08J6Rzzb2U5NA==
X-Received: by 2002:a17:90b:58e3:b0:3ac:80dc:f40c with SMTP id 98e67ed59e1d1-3ae897cca98mr3643392a91.14.1793431952431;
        Sat, 31 Oct 2026 00:32:32 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae841dd1b9sm6691486a91.0.2026.10.31.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:32:31 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3 0/3] Bluetooth: SMP: Serialize root channel updates
Date: Sat, 31 Oct 2026 15:32:21 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The SMP root channels in hdev->smp_data and hdev->smp_bredr_data are
used by HCI event processing under hdev->lock and by SMP receive
callbacks on hdev->workqueue. Power-off already removes them under
hdev->lock in hci_dev_close_sync(). Two other writers do not serialize
with these users:

  1/3 The force_bredr_smp debugfs switch creates and removes the BR/EDR
      root without hdev->lock. A connection confirmation can see a root
      whose operations are not set yet, and a disable can race with
      power-off and release the channel twice. Take hdev->lock in the
      writer, and skip the deletion when power-off already emptied the
      slot.

  3/3 smp_register() replaces both roots when management powers on a
      controller that is already up with HCI_AUTO_OFF set, while HCI
      event processing and SMP receive callbacks can still be using the
      old roots. Run the registration on hdev->workqueue, where it ran
      before commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for
      power on synchronously"), and hold hdev->lock while it replaces
      the roots. The caller waits for the work with the request lock
      held but not hdev->lock, which HCI event processing on that
      workqueue takes.

Patch 2/3 makes that hold for every caller: hci_power_on() runs the same
power-on update for a controller in the HCI_AUTO_OFF window, but has
done so without the request lock since commit cf75ad8b41d2 ("Bluetooth:
hci_sync: Convert MGMT_SET_POWERED").

smp_register() still warns when it replaces the channels on that path.
This series only makes the replacement safe.

Cen Zhang (3):
  Bluetooth: SMP: Serialize forced BR/EDR channel changes
  Bluetooth: hci_core: Hold the request lock for the power-on update
  Bluetooth: SMP: Serialize root channel replacement

 net/bluetooth/hci_core.c    |  3 +++
 net/bluetooth/hci_debugfs.c |  2 ++
 net/bluetooth/smp.c         | 38 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/smp.h         |  3 ++-
 4 files changed, 43 insertions(+), 3 deletions(-)

---
Changes in v3:
- Address the hci_power_on() path that reaches smp_register() without the
  request lock, raised by Sashiko: https://sashiko.dev/#/patchset/99158
- Add patch 2, which takes the request lock in hci_power_on() again, and
  correct the locking description of patch 3; the code of patches 1 and 3 is
  unchanged.

Changes in v2:
- Address the CheckPatch and GitLint long-line failures reported by the
  Bluetooth CI: https://patchwork.kernel.org/series/1197223/
- Trim the crash reports in both commit messages to the headline, call trace
  and allocation/free stacks; no code changes.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com
Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com
