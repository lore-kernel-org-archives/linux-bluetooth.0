Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A83D9029
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917514; cv=none; b=Kh15kRvFK285wAM/4Py6XJ6mv21c6BkC3ggqKmqMLdl64oa0oSlsqlvVvgXYlHtc4LVCbVHCilsqz/pmwZWOcGkDDXn5wefeTfRihb8YKC4VEc1xZbnWB03+qJbd8qHrq3zkRVX4J1wLmzrp/rkNHMc9oYBimhjoGUKNz2Gz9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917514; c=relaxed/simple;
	bh=jWWLPRklRW146gdZeme9qwAmBaiR90MslAd3Cb5Fcm8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i1M0rz4x2vEe4oJGIBhWjDzpvSQ2cbgLJ0XpzWI4ZGiwc5A4LZIn3vkFiRA0DPjDRtvnk3kST07vfQmn4JSsW4VcXyerJBJvtKOKaBCRGJcRwiT73e1a+uAua+8daM8IwER6K1RyHY3CyhDQQSbtmse1qkA+nrHxIKFM2nlJISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OcLbP9Db; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OcLbP9Db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777917512;
	bh=vkkTkVjKfTtUmJLtW87jzzgPWmOfVQt7Wc/4atZWT8Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OcLbP9DbfMX5NDAMyV+UgBoQeTPeTG8+oaPykGRcYbh4eaZET0ADj/IJidBT2/Hyn
	 zyuSqTjuChVdYNGK+zKb10lUxO3dmUdhNaPrYx0s5/Nxz8go0w2vrlIVE2Ub0d3Q2J
	 MNGNmUfyNQzRp3PyP9nEYYZyLQbulZl7s2LTR6lM=
Received: from github.com (hubbernetes-node-683deae.ac4-iad.github.net [10.52.202.124])
	by smtp.github.com (Postfix) with ESMTPA id 0152A21084
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 10:58:32 -0700 (PDT)
Date: Mon, 04 May 2026 10:58:31 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089431/000000-dd093e@github.com>
Subject: [bluez/bluez] dd093e: sdp: fix overflow in sdp_extract_seqtype()
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

  Branch: refs/heads/1089431
  Home:   https://github.com/bluez/bluez
  Commit: dd093e5cd4678eddd38db79325fe7cfb83084a7b
      https://github.com/bluez/bluez/commit/dd093e5cd4678eddd38db79325fe7cfb83084a7b
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
covered by commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1 flags and attributes").

Reported-by: Martin Brodeur <admin@fluentlogic.org>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
