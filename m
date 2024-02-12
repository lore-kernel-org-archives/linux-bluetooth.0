Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A03C493
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777471; cv=none; b=HTOlhiLFkEAz20LvV0hySoegWRCGjFh0ZVXRvfJwGz6bZXtehIcdu63R7+HxjfzWXuO8N9ozgXFG8LzJkp8tVth1kb9udCFD8GFd5Pirg01v9ZvM6BuR/+5CYw7NuezGsBXyhoC5uKz9rEwNFEPm1nHa32RsTb/0X9+n95ZWV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777471; c=relaxed/simple;
	bh=rbG0Y3H/b7rmiiCZF/OZzP8NJrq47G2TqyYDyUEyFrI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p4O8OBeSZ1h1R8ozB1hDWPgbLuE/xoEuLU9HFuWgcCOAWXvEwR75E7LoMBaYFT/Cy0EQG/CFOiAD8fIx8J035nsY+feosMyWU+VlAQ2/BR8NEfgYrMURbI4sJPILt/xLYUtyAIQf9HL3dPL1FWJmmEXrQwMIhfEpZzoROWVSYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bO5shx+G; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bO5shx+G"
Received: from github.com (hubbernetes-node-c4897e7.va3-iad.github.net [10.48.153.34])
	by smtp.github.com (Postfix) with ESMTPA id 9F4E88C0A31
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1707777469;
	bh=cshtKK7hGA+SUuzinBy3Emp+2hOFkoSy2XyXeoAn+3Y=;
	h=Date:From:To:Subject:From;
	b=bO5shx+GuuNdAQXq1ifARXTKkPRkdhxbelz6ozR169bhRk3E0boZidyaRcxPvhP3z
	 hsHfUevelWh/AlLf2B5M6AZkcMOwJnCpJVAcUan1cubdR6AEDs/JlsLfeuzz8S7vSx
	 mpSTqF2nn1T+HPlBa1NFpHUeAFt3qhMgcsIl+moY=
Date: Mon, 12 Feb 2024 14:37:49 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c18519-41c7f3@github.com>
Subject: [bluez/bluez] 41c7f3: hcidump: Fix help message for --timestamp
 option
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
  Commit: 41c7f3af0352d3e45f4f10b7584e955a7f5cc696
      https://github.com/bluez/bluez/commit/41c7f3af0352d3e45f4f10b7584e955a7f5cc696
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-02-12 (Mon, 12 Feb 2024)

  Changed paths:
    M tools/hcidump.c

  Log Message:
  -----------
  hcidump: Fix help message for --timestamp option


