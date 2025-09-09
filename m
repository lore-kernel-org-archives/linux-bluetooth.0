Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0331D360
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451048; cv=none; b=ou6QHbEwuDRniW6ObcoTkMS4tqauIdwAwI5Fa450SwCuSEV0M4cr6nx4LbmMxBjgIr17xlfVmWu4idPRT1dPTp0akas60Ff9qQJbjuWINXShAQZH6fI4UaHVVozRbSsHYZGTzCp4z9xs/1eewoFv4wMydK3vzItQkMn0XCU1jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451048; c=relaxed/simple;
	bh=bk1aJDsZQ+du14ksqhkJYg4b6BfiN223dZGF6cJSC0M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ivqzNr2xt3lBnWA+VrDlw/I2qngbjIZEvt8f8oLTyvxmykV9tiLRX5qT/Vdck9lbslwXSmwkm7/nOBrQzwAZkAFajvzY8zCqqB1ZYA3IN0b9HEbRI28io9N6SILcIL1kNFGirvy1SESEkB3DMF6h+qmlujzDM0eWNMmwwcxr07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=motyqeb+; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="motyqeb+"
Received: from github.com (hubbernetes-node-293fe5f.ash1-iad.github.net [10.56.165.37])
	by smtp.github.com (Postfix) with ESMTPA id E4843921333
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757451045;
	bh=TEVddNJzqHQFffTQj1B4z34hp3Q2GerB4yUjceZ/eaI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=motyqeb+4lzUbPAFQVsm7LIpnbopxgrCXxSiMd4wPpwmsKw7QDlUvkRGjGX1IIsWL
	 c/EPZ6KI//h3fgtxSY52kfClozIViVPW2hkducbv/crMsf9g9XfwdOBUBm/Jtwvu9f
	 1zxvIpAiXHV7aNrvQajc7Q7ejscEq5LbHk28aICk=
Date: Tue, 09 Sep 2025 13:50:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/999352/288d4d-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/999352
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
