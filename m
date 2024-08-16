Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EB19D8BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818822; cv=none; b=nErVQlbLysoSmxtdqH5tkQSlQ3lKYjO/Dx5DIl9XPLm237oXh8fUxQXr2yKxMuQhB7awEqkl1b8FSLOg6MSlvtJ/o6I7RwQSZP6+4KEVhd7N6DUSqz3X0z4OJZxds3LULNe2eoc+PUDbK7Iwx2fkar0oT+uQhQg0SxeydZ5MZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818822; c=relaxed/simple;
	bh=UEGbjtklTlwZJVi8lNAHGm+7ABCEbB7g28DUilh1z1w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iedII7tn6IM4Fxr1ZeKq5X/2afIvwksLlSz69tfwt/LcV/4xeBI5oDJMyfVXe2A5SwsR9sKNV3/Tfg7XWIk5MZVbappwrZ4pJgOweviFvLXTKs8fM3QqMVOGDXeuMqg+0HDbnELnvoxWMluYim86Bbt2xmZlKKyI0tajXuscgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JqhFanoB; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JqhFanoB"
Received: from github.com (hubbernetes-node-8a28120.ash1-iad.github.net [10.56.147.43])
	by smtp.github.com (Postfix) with ESMTPA id CC6006C109B
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1723818820;
	bh=cOPRtrNARfqDLLNB31R1Tm4Fs0byScm+YfFtqXQdG+w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JqhFanoBjGhYKRFyqS2IsFWjJ+aIsvbcTQAAQIr++X77eirQ231BzaNQ7rJT2OjF/
	 lHLqJotyvAY6QYba4KWbmu4v8GnpimQe/LOsyAE9JT9eXEPOAUSazf7c/3TdnF2gYf
	 d37JmsVFhrlU5MRUK68LlIlvpKyk8+Vsnh5XUhsk=
Date: Fri, 16 Aug 2024 07:33:40 -0700
From: howardchungg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/939133-29d454@github.com>
Subject: [bluez/bluez] 29d454: Monitor: Complete missing fields in ESco
 Connection
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
  Commit: 29d4540828a10148881dbb5c09acaebf1469dfb2
      https://github.com/bluez/bluez/commit/29d4540828a10148881dbb5c09acaebf1469dfb2
  Author: Yun-Hao Chung <howardchung@google.com>
  Date:   2024-08-16 (Fri, 16 Aug 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  Monitor: Complete missing fields in ESco Connection

This implements the missing fields in the ESCO connection setup and
accept commands.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
