Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228D2797B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478934; cv=none; b=i+dS5Bq059qTX/wixarClniV1FMlbUbXbnx5F6AfzpSJfLESA861POXc+7XxYfppa2AeKBw1HyU+R0J1uu+RYKbOMFgdSAeouKnaOolXLS3pWTrJLryb3vzOCRob0jClij+0ZQoVwgBkpMWaCftFCwgStJ+0Zv1gJDhirDE6qeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478934; c=relaxed/simple;
	bh=XhAmBKHqISzyh8wPxbE88BlVsY9/sxAv++gubJDLTYI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GtApa7VFZxanv9aRJYJLOClBqYizNVNeKFtdqz+IXjMWQbCiXZqbYWXO17U4VoQOyGWfEIlBp/EBfLb1rUnE0jgBSvkzCR6Hwi8B8k2QVPV6uKgZyHshb9F4tNHDPAV0JKZBSuHgGxTofUECn+mlbsZ/8FG03oEvTxhXyb6JydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YfWJ+Xfc; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YfWJ+Xfc"
Received: from github.com (hubbernetes-node-a76a686.va3-iad.github.net [10.48.136.34])
	by smtp.github.com (Postfix) with ESMTPA id 5E7773C11FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765478932;
	bh=Yzm72qRNyH2CP7sduyA2jemCYmH+05ZJEHIG2XhRWOo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YfWJ+XfccyeBZKOBH2pgFE9bF7v3hsaG+C71XAdVBIvFi/sxrra1oeWDxhg5/kc9e
	 yUckFtaslMmXu5EAie+1RdL1EWZYqBTT6H9zqNefLr19gjFUcUA6Y/4m1F6dcy5qAa
	 SI8LySL72em5GlOeYB4naLJ9/b9fX1VPVbn0R+fk=
Date: Thu, 11 Dec 2025 10:48:52 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/72757c-a589b0@github.com>
Subject: [bluez/bluez] a589b0: monitor: Add unknown options decoding for
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a589b0d73c41eb007112411c6f630bf253c5d2cd
      https://github.com/bluez/bluez/commit/a589b0d73c41eb007112411c6f630bf253c5d2cd
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

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
