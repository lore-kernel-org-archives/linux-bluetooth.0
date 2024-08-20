Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB47192B9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167992; cv=none; b=eqq2p6qVfxl69RADZlQL6Y8LMoWtrIQWja5++9nSDvBH7rC7DqbaLUW1K0ejL6cq1JQsdaSsC94k7zlczjH8/eOkW5ofEqMjcylywaWd6EKC2YQXID/xjiDwbUKs51vWG2TQFIOnA8dyipLMwGOHTxHlMGBpXdf4u23qI0KoDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167992; c=relaxed/simple;
	bh=j/Wf6P3z/Xp8OmUVNBuYDuEJ+KYmRU/PPp9B6NUgsL8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nTcy92uNE4k5QR3/8l1W38dI1xsciPRAXPF4LFJ0skOOO6txChDWp7znmJCwtXl9jlXCQ3e0t9Ezaz3pYf30LUMAquzfu4iOXj+CqGehdYQFFk6OGvj9IYPQsr4bIEErq6GrAz0Uh2F9B+dDwH5HFp72DrwXhPU+v+cU789F3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cETrbnoe; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cETrbnoe"
Received: from github.com (hubbernetes-node-f4d36cc.ash1-iad.github.net [10.56.145.30])
	by smtp.github.com (Postfix) with ESMTPA id AE5BD6C0DE1
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724167990;
	bh=bBMUZlV75U/b1Lt4Stlv2TeC6y+mt7EmqznGHs+r1T0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cETrbnoeACHTWpNNhzI00NE9nNyns9SsgJ8l38K2FMeexo3V6MnGEDWbzijwxnZNT
	 LOPGqgpQKTVcY9tifdlrVQDuXrTUMS47Ja9Vy3WxH4X5VjEafOj2Ko4nfPQnU8NTK7
	 4rNT3Eo/EDz7Pdcg5A8uVen5tL0DFd2yqO3juGsA=
Date: Tue, 20 Aug 2024 08:33:10 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d5c68d-2f3f63@github.com>
Subject: [bluez/bluez] 2f3f63: client: Add bluetoothctl-assistant.1 man page
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
  Commit: 2f3f63467d72a19b4414907a1ce5dbb870e4e2f2
      https://github.com/bluez/bluez/commit/2f3f63467d72a19b4414907a1ce5dbb870e4e2f2
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-20 (Tue, 20 Aug 2024)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-assistant.rst
    M client/bluetoothctl.rst

  Log Message:
  -----------
  client: Add bluetoothctl-assistant.1 man page

This adds bluetoothctl-assistant.rst which is then converted to
bluetoothctl-assistant.1 using rst2man.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
