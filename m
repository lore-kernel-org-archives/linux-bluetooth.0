Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447503002D2
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410312; cv=none; b=YIuoBPR0hGYCllb/MehuvmroSuQFqnPtcKZcJXNbE/uS6idAm/15oPQlrVTB9XhXwIDPvkXwthdv99p/CZ3ge0hiHoB/YagZpHm0o9VFVNNj2D3Ki7+YgB1CmCnEYUYDLgpLU2J6+JaLhQ+P4xbPtYP1uvAI2Fn1djFDMnUbDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410312; c=relaxed/simple;
	bh=f4GJkZRkrF4L7sN+jsn6cS9fWc8X72ZUyZp3WbjoRsg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p1L+Y3y4XkhMZxLTwdF25RvQyasO/hOhJsCRB06vg+29LyiXvar6l7VCXy5JtQwjdaENd6MSmeRKAVaB72kuhVzhfewSwnX17OakZPIO7r0uOfSHgi7DbnyTgrwpvz6YMYXR8sPfNPEynaP2XBOGAncGqqOQ7zwAymDTRbaWl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LL5jWXgJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LL5jWXgJ"
Received: from github.com (hubbernetes-node-1fba64e.ac4-iad.github.net [10.52.220.39])
	by smtp.github.com (Postfix) with ESMTPA id A518040119D
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765410308;
	bh=LIwSZmYkfP2rKucu16zb0Q1fzjI+9uGORQuHoD0e9VI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LL5jWXgJheCEjbqdD3L0OFr/sbPT8fMQ5JVNnQ+1b3H/x17o9adGzw8uNfbAB8DhS
	 nJcbuxU3jsd0wG2unVhAs6aQ19A1lptO70yfrx/PUIDITFyPku61wNsz4MnH2loXWU
	 n2Yi+eSVb9GTCkauf+XoSmi7914zGa8EyV4+Ymjo=
Date: Wed, 10 Dec 2025 15:45:08 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032118/000000-b63544@github.com>
Subject: [bluez/bluez] b63544: monitor: Add unknown options decoding for
 Configur...
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

  Branch: refs/heads/1032118
  Home:   https://github.com/bluez/bluez
  Commit: b635447f59823d380301b3cc4ce4b938c8d8714a
      https://github.com/bluez/bluez/commit/b635447f59823d380301b3cc4ce4b938c8d8714a
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M monitor/l2cap.c

  Log Message:
  -----------
  monitor: Add unknown options decoding for Configure Response

Unknown options respose for Configure Respose packet has a different
layout that of unaccepted options, so it needs special code to handle
it.

Before:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 2 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04

After:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 3 len 7
        Source CID: 65
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Retransmission and Flow Control (0x04)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
