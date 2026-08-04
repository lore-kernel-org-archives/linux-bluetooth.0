Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F103630BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843525; cv=none; b=oJ9wezphPuKLAqns3aY2sjZA2jhjMMVxSpLrPrcx+hzLVGllCXmhmgPXbgv+/NqSro4t1L7MElJXLoQmQho8N50JoXpkcJj0UVxH9KVWgqgT0Ja30qZb3E2w1zR7oH9yaqdLbF6T3UWN3sKUWW27U10MzaIG65kDh1+SLf2pi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843525; c=relaxed/simple;
	bh=hRqLIuHoCGosupquHwzYcVPEzyPFUCLaeSmhxPENh3k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QILElqnseqxVt5okmyW03UkOAT8xjnB02JpNAlAH/KRhfbvjUFL0bQBSNpIr1XihZTYypfv2nnyhGf2LjrzDLk5kEvVOQvGnZOGZcvyxypQ5ss8qXm7j9sQCGnzvu/d12bsiywqSTgUF2Ce7t208UguwcAm3doDl/dRVuigaDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Pnr3iUBR; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Pnr3iUBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785843523;
	bh=Sq3ZujIDpVOGCd5xqtXk0AkAMJ7ylKz8YVb8D1z7E6I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Pnr3iUBRmsn6/vj7wET5ni4z3haK6nLIc2Hanrt0hLMXcA1q6GrMaGc5dBVX0yI3I
	 03tLtYeqlq/pNniHrh+HbiGHbHwoNMlI61uFqZ8zKknOw53ueKb2BrawqjY0UNsIuj
	 GVbo8D3AUF5PcTLbd1UnSktVMh61gSdrRD4li4jw=
Received: from github.com (hubbernetes-node-8da3906.va3-iad.github.net [10.48.71.68])
	by smtp.github.com (Postfix) with ESMTPA id 65FB128141C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 04:38:43 -0700 (PDT)
Date: Tue, 04 Aug 2026 04:38:43 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1139970/000000-c73543@github.com>
Subject: [bluez/bluez] c73543: unit: Remove Android avrcp.c dead-code
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

  Branch: refs/heads/1139970
  Home:   https://github.com/bluez/bluez
  Commit: c735432a9fa050eb949cc346424286f2c0828067
      https://github.com/bluez/bluez/commit/c735432a9fa050eb949cc346424286f2c0828067
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    R unit/avrcp.c
    R unit/avrcp.h

  Log Message:
  -----------
  unit: Remove Android avrcp.c dead-code

This code isn't referenced anywhere, and seems to have been part of the
Android support in BlueZ, remove it now that Android support has been
removed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
