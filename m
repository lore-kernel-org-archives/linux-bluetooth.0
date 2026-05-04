Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A801CAA65
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912136; cv=none; b=JAl4eGSd5kPTHMRhcuc/Bv5IK1I0T8zrhzKvpGWggnO6ksRCnmH9QNQQEuQPRTvOEAGstBKnsFk/NHyZF8hH84S6MyUZeeUbaI7Fkh8TvkGhD3OSxA3T/5Qfuc0P1lj8uQ4IJ3kNuI07LWfIhV/h80QItCvJCGbprpwcuaZTRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912136; c=relaxed/simple;
	bh=UswEh6IZeKsTc2h1AzuVd07z13F1SCQ9QApu6rIF2FQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Igj4NRvf/e0LEJn7k6+/7Iu8+o5Rshy7pGAxs9jYdIKSZ6s4IFAN3/mYol1pG3cXXSIPIuLHs/P97DEF58KWxIfkKQavjNaC1HW/lNq6Iy06mAZV6isbv5sU6/oymrpocLK/LKEr1pI+0RNi0UHoLTqVup/im8Oh/yT8TBkZ8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bM2kC5V/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bM2kC5V/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777912134;
	bh=HPLhNBL175iPTvkJbFdtv45oEbgYu2LZ2LhizxL0ePs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bM2kC5V/tKgR6rCwRXzy0ALgFXIvf7atzimIUmgT65hCZ95EPKJ646GkfoBj1OQ4e
	 GSJloMH11Ov1Oj+nHoDZcI0MydWUyinOoGx+VL7RhUn1xEMppFF/Ry7lIZwZjYAJ63
	 uFCgO9IFBVLwxFVUeGXN+5shJe4gg6ReOvi2nnnY=
Received: from github.com (hubbernetes-node-51e7316.ash1-iad.github.net [10.56.130.49])
	by smtp.github.com (Postfix) with ESMTPA id 8BC866010DF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 09:28:54 -0700 (PDT)
Date: Mon, 04 May 2026 09:28:54 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089386/000000-db9aa4@github.com>
Subject: [bluez/bluez] db9aa4: sdp: fix overflow in sdp_extract_seqtype()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1089386
  Home:   https://github.com/bluez/bluez
  Commit: db9aa42f19a13582e17c7e2b92f41fef63c1824f
      https://github.com/bluez/bluez/commit/db9aa42f19a13582e17c7e2b92f41fef63c1824f
  Author: Martin Brodeur <admin@fluentlogic.org>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: fix overflow in sdp_extract_seqtype()

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1.

Reported-by: Martin Brodeur <admin@fluentlogic.org>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
