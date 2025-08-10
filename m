Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C171F949
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811472; cv=none; b=Da3KnU20rCQA4JbT3BrfopXgdY6hAKZgZEUxVVGfb7+E8Wqa95dMWaLw8j4+mlIMYDer+GGUdTnk6rB89orISRg9Lp0SDxf4KCGI92FdXl2JC3CVcqkHn0c2aag0UEHK+ZA011y20d9s4h+NjZHaiLMEg2zwF4zzA1yJmSkpEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811472; c=relaxed/simple;
	bh=kiestZ0uLB+FwPqVFPuzgBumPKg9KPOI8g5FQ9r76Co=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BbNIoGa7kUlgsuszcopaYZBKOeVQXQpzxsKI7N00CRKiXQjE+MeqFxXcNMhZHXOrXKd9H0yhPj9eg+Pnt+Y28RlroAx84T9v5tS9TNcKppuQrQGbzVXbPxqqLIKA0UJWRsmgf6T7gXFZNpqqGIysvdMGhnUvParRvDuCitWC6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EKt5OkdW; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EKt5OkdW"
Received: from github.com (hubbernetes-node-bb733ed.ash1-iad.github.net [10.56.175.13])
	by smtp.github.com (Postfix) with ESMTPA id 2FC9060028E
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754811470;
	bh=sDDeV+ZioarsF1Z6BIV/N09AsRILI/j5Styyv7emJ8I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EKt5OkdW0TkM2EqeWMom7eO1zomIfEtIF6IxbAK0iY+DK/qkPe3aqxSMHoMle8BVm
	 W6CVzsRzS5pxdoa2/++KINxe7miLk2vJMpztfBV+XgD768cZWgM0a/dNMyZnv7d2rV
	 iGT9SZZIeEP4YKWxTS7GR/8BGVZSC9+/GoZOYiS8=
Date: Sun, 10 Aug 2025 00:37:50 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989676/000000-367a0b@github.com>
Subject: [bluez/bluez] 367a0b: Fix buffer overflow in sdp_xml_parse_uuid128
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

  Branch: refs/heads/989676
  Home:   https://github.com/bluez/bluez
  Commit: 367a0b69567e55c594de81ac566d58272bd68170
      https://github.com/bluez/bluez/commit/367a0b69567e55c594de81ac566d58272bd68170
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-10 (Sun, 10 Aug 2025)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  Fix buffer overflow in sdp_xml_parse_uuid128

This was found by OSS-Fuzz.

This can be reproduced by running this input:
`<uuid value="111111111111111111111111111111111111">`
against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c
which just calls `sdp_xml_parse_record`.

`sdp_xml_parse_uuid` checks that the length of the string is 36 (32
digits + 4 '-' characters) prior to calling `sdp_xml_parse_uuid128`.

There's no check preventing this data from being 36 digits (with no
"-"), which leads to a buffer overflow in sdp_xml_parse_uuid128.

https://issues.oss-fuzz.com/issues/42534847
https://oss-fuzz.com/testcase-detail/5070205940531200



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
