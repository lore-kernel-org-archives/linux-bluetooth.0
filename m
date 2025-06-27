Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CBEEDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042241; cv=none; b=UrMnWiKxQhQmgu3UyfYmY9srdv6lklJM7RfBz1P1QGISyhiUJyzbjRZpQuc0NXJYBQURT+o6cBrjnrDRPUPjn4zTl+S2pbTLni7eVv0HlfVf9YR3q7HaZHeGif72Te1aahpUlG4GDMTdQWvf5Z8HlhNG9fjYUivSKIEql2F3wLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042241; c=relaxed/simple;
	bh=xU/T+yGsn8BmlZS653Z4OMbvP1tGkNilzt9h6pztVEc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pnSuehq4K3rQxbzfOlNY+RFqRT+vBcp/sy2koOpjhgABS3bDjXsLOTTZhB7MXGy8JdcTs67UGyWIZ4LVVCCVKYw/us72oAcqc5QhwWUM6KpgnzlqnjFFKZBN8pCZdwvzgyGtINGdHv3Ku9uUOQ4WvJz7Rhky1xQj2FIvgbVgegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i15TkHh7; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i15TkHh7"
Received: from github.com (hubbernetes-node-9fa3970.va3-iad.github.net [10.48.175.16])
	by smtp.github.com (Postfix) with ESMTPA id B54FEE0A63
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751042239;
	bh=xotNT8KqH+atwKEqeo0oxrWYEog+l/BkcZ6WJmZh0ZE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i15TkHh7mXEsrsrKGJT4rMI9X9AfGnEbQX71plD+2/ahMmD6x4n7r4xvVfp4LwoX3
	 jRAGVA1dnWalTmL6R8NmhE9rfHZxwQuEdztoPwxU40JzWusVIsjZ0nAMFGegoR0+CT
	 0o2Wue0pANEYPzrD2bG3KGSErlBz4hnoXvzbWpY4=
Date: Fri, 27 Jun 2025 09:37:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ae1b7f-dc7ca0@github.com>
Subject: [bluez/bluez] dc7ca0: monitor: Print buffer pool information
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
  Commit: dc7ca0e3b4156a16e7294c63b246f6b07d1b13f9
      https://github.com/bluez/bluez/commit/dc7ca0e3b4156a16e7294c63b246f6b07d1b13f9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print buffer pool information

This prints the number of buffers in transit and total information:

< ISO Data TX: Handle 2304 [1/8] flags 0x02 dlen 64 #1363
< ISO Data TX: Handle 2304 [2/8] flags 0x02 dlen 64 #1364
< ISO Data TX: Handle 2304 [3/8] flags 0x02 dlen 64 #1365
< ISO Data TX: Handle 2304 [4/8] flags 0x02 dlen 64 #1367
< ISO Data TX: Handle 2304 [5/8] flags 0x02 dlen 64 #1368
< ISO Data TX: Handle 2304 [6/8] flags 0x02 dlen 64 #1369
< ISO Data TX: Handle 2304 [7/8] flags 0x02 dlen 64 #1370
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64 #1371
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 2304 Address: FC:6D:77:BA:CF:A6 (Intel Corporate)
        Count: 1
        Buffers: 7/8
        #1363: len 64 (39 Kb/s)
        Latency: 13 msec (13-13 msec ~13 msec)
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
