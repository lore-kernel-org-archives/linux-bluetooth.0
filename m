Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1D26E71F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791341; cv=none; b=szaazh4Salw22KfUkV/Fe2C1rX8Z1PSdUMuyhdgp9Vs1IKEf+wbb88Vzc6wRbRAT7sGIGzf3fdON7T7mrakippc2fVFzlw+DzqomCBOaxFHj0vay+jNskgsoBriHmckoXysbUfQkaevsFl7BRvvuIzZISMczGgunw/dSnxsGEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791341; c=relaxed/simple;
	bh=m44O0dwBKI30dD/BNVYtje8eoZK0yrU4cbkCCOY9GCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8yCQ9Jvan2TwhI3C7MMx8ptKGU03QVmqHG91wyJUOAek4nPlYCKCDT/IjqpvyxWKQol20YD4hfinnNDJxjpyiTXCO/9MK8DF+nQOOsLzOJyuwTb6YI+tWXg2NHw/puXFYG9JFBxsk3jEi3VF2kq9yRVx4+AZOJ5ZcrZk1I4Hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRs6iQI6; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRs6iQI6"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d87610513so51065911cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791339; x=1777396139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFUP7oxtLw+TaklzOUYMTAsDjSFshdzQqWmKfd2xajk=;
        b=LRs6iQI6yZWLHSyQtiV8bkZhBNfG7qNL7IzzvxR6IeC86lglESWkXSYbrag3z7jqQk
         0RAcH0QJLDlryaHP39YyNQw3faHf5bB38DtkEzJn9ERLwm8UBFqOttbNkkkBNuF8EC5N
         f3cXiFsu41vmYiLyL6vJ+G6tfryzfDuCsnrjjkkh+in4Be6dBjxDo+ymsBarhdX+V3/z
         VZHaHrupZD9d2FNtn2DpnvxIeXcX6xD4NCvfZGQNNOEw6dYOPCkSAmIeE27ntIQ5YDnh
         rS8B4apd1ZrjtrnjP9cZkgguMlHlepyOS0XTS3zy0qgoX2/u1PWqNTvXVc4pYqGSld1/
         5aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791339; x=1777396139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFUP7oxtLw+TaklzOUYMTAsDjSFshdzQqWmKfd2xajk=;
        b=NAx558RnbbA8w1+MuTlcCZAyOonTwYU+LBmA4yWRfEtGeB77XHtSxXH8sBiqsm5jfB
         +WrgdK5+/QRSW/OUIHMEHpQ5dnimbk7mWaNKq9O/fIHt2Z98B5UVANNtE4nAE1KtI/Te
         IvLIXceyYz8DtTR3OT4gGilz55eL7WeH8VmDGp6akvvrn24s+rVzjXSQyjrGMb6vSbyi
         GfQ7J3yBtDKy+YcY7LZjBpR/L0yalUHNc2hG/3E58rhTQIsV26uX8GespH8RGqLs18J1
         claNybomofqsA8NFisgHNZydr3+ByPcaW08IuJawkhX4JGhCpm2BBHhLlnMP6HHrTKb1
         bl6w==
X-Forwarded-Encrypted: i=1; AFNElJ/wx+dU2nj+uHEAQ7zsH2jENz5gkBXxwlcoSGYXlDqzNPZ8ftrrlESGE33vI2Fwg+u+Hcoq2kmhqt40cuCrgA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygnlY8BxaTOC3b3Lg7aNu6gR2iF7t+LG+n9pESBWQ6gnLtWgph
	T2H4k/q+GUYkVzsd/ayCwujqXMv09CWeK4lr2idb/NPQDdaACuW+ZJhu
X-Gm-Gg: AeBDieuOYecPN/FfJaMtxEiunXLcpgQNK1IWrHlAFfY4QNBqBHjHc/1/MCldEqQUVjY
	zF8sUBNm9rqqZJ2vnbJ4Cmu/dQTxUz/K62wnXSS8KZvGZcIPpxhO7wb0oBSYNvvBqsSriJ7REYB
	ng8wlak4+AaZhpNXqXNTSvffh4A6vcUM64quVpFB61wv89+8Y0UHCPgpjQHFLgutTH2GTRENBxl
	L5MNDuqcpzFBAgp/3oQxRlPOEP5KwyhgzgJsNvMJyJ7Vay3mgjF65I9Yly3iBCo3fGhHd5sxw4D
	sZlaPdy5YuB3KNxZqhranAGvme0wAAx6lifTXQLYM1HUuWE0oEjBURHtv0Yesan8/u6P2HfuIIg
	fRmmCl9VJRDaHSVAWdwoTbnKGppxaEPiTp3Nia3JZ8Sah94BZRtqjqHXio8GcpOnieIv+ntYK1M
	H6mRDL/a10FWnNtF3SvJFCl2L7NZtJBnPCKXVOTt285bO8jmTVqaJcAjbzOfhlK7tzBzk1fMelV
	YkIxLsaRpUMr8Hz/5oiGXs4yjpZ15Q=
X-Received: by 2002:ac8:5ace:0:b0:50f:ad91:8902 with SMTP id d75a77b69052e-50fad918c7amr93780241cf.37.1776791338948;
        Tue, 21 Apr 2026 10:08:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm13134471cf.5.2026.04.21.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:08:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 0/2] Bluetooth: virtio_bt: harden rx against untrusted backend
Date: Tue, 21 Apr 2026 13:08:43 -0400
Message-ID: <20260421170845.3469513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
References: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Respin of the virtio_bt rx hardening patch, split per Luiz's
request on the v2 thread:

  https://lore.kernel.org/linux-bluetooth/20260421151659.3326690-1-michael.bommarito@gmail.com/

v2 bundled two independent hazards in one commit and the commit
message got convoluted trying to explain them together. This v3
keeps each hazard in its own patch so the rationale for each is
self-contained.

Patch 1/2 keeps the original v1/v2 concern: virtbt_rx_work() calls
skb_put() with a used.len the device controls, with no validation
against the 1000-byte buffer we actually exposed to virtio via
sg_init_one(). Checking against skb_tailroom() is not enough
because alloc_skb() can leave more tailroom than 1000 bytes due to
slab padding. len == 0 is also accepted, which lets an empty skb
reach virtbt_rx_handle() where the pkt_type byte is then read from
uninitialized memory. 1/2 defines VIRTBT_RX_BUF_SIZE, reuses it in
alloc_skb() and sg_init_one(), and gates virtbt_rx_work() on
[1, VIRTBT_RX_BUF_SIZE] with bt_dev_err_ratelimited() on the drop
path.

Patch 2/2 closes a residual short-payload hazard found during v2
pre-send review. After 1/2 restricts used.len to [1, 1000], a
one-byte completion still reaches hci_recv_frame() with skb->len
pulled to 0. If that byte was HCI_ACLDATA_PKT, the ACL-vs-ISO
classification fast-path in hci_dev_classify_pkt_type()
dereferences hci_acl_hdr(skb)->handle whenever the HCI device has
an active CIS_LINK, BIS_LINK, or PA_LINK connection, reading two
bytes of uninitialized RX-buffer data. The same hazard shape
exists for every packet type because none of the switch cases in
virtbt_rx_handle() checked skb->len against the per-type minimum
HCI header. 2/2 requires skb->len to cover the fixed header size
for the selected type (event 2, ACL 4, SCO 3, ISO 4) before
calling hci_recv_frame(); drop ratelimited otherwise. Unknown
pkt_type values still take the original kfree_skb() default path.

Both patches carry the same Fixes: 160fbcf3bfb9 and Cc: stable@
as the v2 commit, because both hazards have existed since the
driver switched to skb_put() for used.len handling.

Fresh runtime repro of the original skb_over_panic on an unpatched
tree and a clean reject log with 1/2 applied are attached in the
evidence bundle referenced from the v2 thread; no runtime change
between v2 and v3 beyond the split (the final tree after 1/2+2/2
is byte-identical to the v2 commit).

Prior public versions of this patch on linux-bluetooth:

  v1: <20260418000138.1848813-1-michael.bommarito@gmail.com>
  v2: <20260421151659.3326690-1-michael.bommarito@gmail.com>

Michael Bommarito (2):
  Bluetooth: virtio_bt: clamp rx length before skb_put
  Bluetooth: virtio_bt: validate rx pkt_type header length

 drivers/bluetooth/virtio_bt.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.53.0

