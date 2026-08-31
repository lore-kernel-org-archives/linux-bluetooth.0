Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC2463B92
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188678; cv=none; b=LaJDC6xQxH81zlWOPcZOeQPeMw2FyJ3o7KLhVOtFY2PLNK1PRGU05aMr4WGg8UwuP6wReG80Zkz3cTpMpjKLj7yfQJf5DmZ0yM8JOB3k96qMKappqpvBgW2rBWruVx5YtjgGnxbQSbzf4IyDJou8lu5PAVGFIVmPfFr7Ksc9eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188678; c=relaxed/simple;
	bh=pjktXLl38EPkIB/g8yY5N1a3JbRKfGfng34ItlfQm/k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hEeIiMYzYWrn64whP7yABakW8DjTO1OFswnrjMrcbJ3lZ7TiztdLBnj0mPV1BpOgOBVlnYRqDO9p+aNVOoqr6E9KNkxULffV4VX7TcsqEx/AXK8412LDajCMg6QWi7hqEaxY5Bdx4A961r2fqjKKkFQyDNBaYwtyb85Risdq+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Soaj++4u; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Soaj++4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788188676;
	bh=0dp+cO9WSnpG676xntaMUp+g9/7ANS36PP3f6vXe7Ng=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Soaj++4u10S8iML9yUBVoZxWI8Iv2U4zbshqJVpl0nrCm/FV5azt8NxlKGjRSxTNS
	 inLEOIwo3Cg6gXvhyfUFPB5XdamAaXytHSka3Z2uEMeXx/Mphk89wgBLS/LIVPwjyT
	 hWvozBtp4/AmblsrgRtHuXnw4/zS1DMA6YfN8kDA=
Received: from github.com (hubbernetes-node-cdbba5f.va3-iad.github.net [10.48.170.52])
	by smtp.github.com (Postfix) with ESMTPA id 64FF7800111
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:04:36 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:04:36 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154582/000000-85f3cd@github.com>
Subject: [bluez/bluez] 85f3cd: shared/bap: Fix use-after-free in bt_bap_detach
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1154582
  Home:   https://github.com/bluez/bluez
  Commit: 85f3cda412302a1454580994f5529c0dcb2d5dc5
      https://github.com/bluez/bluez/commit/85f3cda412302a1454580994f5529=
c0dcb2d5dc5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix use-after-free in bt_bap_detach

bt_bap_detach() invoked the pending request's completion callback via
bap_req_detach(bap->req) before clearing bap->req. Since the completion
callback (req->func) can trigger synchronous cleanup that re-enters
bt_bap_stream_cancel() for the same stream, and bt_bap_stream_cancel()
frees bap->req whenever it still matches the request being canceled,
the request could be freed while bap_req_complete() was still executing
on it, causing bap_req_complete() to dereference the now-freed request
once the callback returned.

Clear bap->req before invoking the completion callback, matching the
pattern already used by bap_abort_stream_req(), the ASE IDLE state
handler and bap_cp_notify(), so a reentrant cancel no longer finds a
stale bap->req to free.

Assisted-by: Claude:claude-sonnet-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
