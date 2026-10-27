Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085738;
	b=3e586edVGq8Xf+Tqhrl1tKCj28c+7o4aQfsQOExDy7wNEPFlCcKy0aeNaLKhWZqMa1VS
	 WyrlWrULmOMOppm6zp6QHgoW7M6nO+WH0GDsqYRLiHf4My21c8fqA14VkwhJCFg7rRgWl
	 o++odslrSv10PFgtfrf66bxM/8E9qX6RJKivI4TaPAlLSWQwkKaQHAwih3pLXNMv362v3
	 J2sCOHGwKasXrd86IqVu4BMfqCHTBBj0mQbd/VNGcGpD59lRTzytAaU7xFqVFrRqsrmd1
	 7IpplGQmsGlk/hXrYw2nmlTYwHfcTvSdOFCbF+PK4hN0D3OPINghgE0bSZRjmoXRD6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085738;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sT7vIWfCQlpmrCp3AHvB6LAHtIID/eRbReS7/Np2dEs=;
	b=siYZ3vxObHHcLTh/g13fC4Yg/LrCpv4KrSLeUinCpVrsEQUBVrawa8UgF2uJ2kovADYY
	 O9JshjY4XZB7z3FBHD6ln5LLK+IMReyLVzA4flxpTUxTbj5bfdS3M0s1k412lVQK7OXRA
	 yQTt+9F1BFhXy1eB+yROe1/8rocXIvZt5x7eLmKmaEm3BuwCnRCAyP6Ygl37mVT6TVhDz
	 4cZ3qKnbuLeWM8QzjgvQdnY8+t2Vvz+oSqMkvlk7i9V7jd0vA/Ehiy7KqsbWoGxFwEM6W
	 boWcQd1YWYzuQUcdZN7yaUkpsrB5miuKPrIfutYLonARNGa0b/vdf+jIXI6bxT0ev/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVGrKAuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAC606A31A;
	Tue, 27 Oct 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVGrKAuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB6F1F01825;
	Tue, 27 Oct 2026 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793085737;
	bh=sT7vIWfCQlpmrCp3AHvB6LAHtIID/eRbReS7/Np2dEs=;
	h=From:To:Cc:Subject:Date;
	b=SVGrKAuW2S9Gio8AsSjBcvCXpRZ2B2cuQZ9lwXvaNxRoYsd7YbaqBZeVFHQwnfyCt
	 cEf6pDGFunx4uJt7nk6vl3UbWVfxzKe5oOIrcp7RJCKTB2Lb3WkMkmN8h/LWJTfZZN
	 ri7MEs3f2qLjzdY+hUMKDGcYtWjIUavJ+WcD84Wd3edyTpgQnXnvK6kSnnLHm+mLoP
	 PD4blr0wSaB18glwF6AuzQtKMm5kntQ6mz43NZvLgGBlqVxxhqi7KeJRNlE1Y7AKm6
	 m7mh76VtHtpl4Kp3Gasyf0Qd2CJue01+BHNlaRE708pu+DRx9Zkt/rQH3fBEMLdMpL
	 8FysE9YW8dFLA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	tfiga@chromium.org,
	tzungbi@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: btrtl: Fix NULL return on errors in btrtl_initialize()
Date: Tue, 27 Oct 2026 07:21:46 +0000
Message-ID: <20261027072148.3963826-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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

In btrtl_initialize(), the `err_free` error path frees `btrtl_dev` and
returns `ERR_PTR(ret)`.  Because earlier calls in btrtl_initialize() set
`ret` to 0 on success, any subsequent failure path that jumps to
`err_free` without setting `ret` to a negative error code causes
btrtl_initialize() to return `ERR_PTR(0)` (`NULL`).

Since the caller btrtl_setup_realtek() only checks `IS_ERR(btrtl_dev)`,
a `NULL` return bypasses the error check and causes a NULL pointer
dereference in btrtl_download_firmware().

- Patch 1 fixes a NULL pointer dereference observed when
  btrtl_vendor_read_reg16() fails.
- Patch 2 fixes a similar issue found by inspection when bt_skb_alloc()
  fails.

Tzung-Bi Shih (2):
  Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
  Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails

 drivers/bluetooth/btrtl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

