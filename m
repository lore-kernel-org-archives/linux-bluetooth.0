Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6C30BF59
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573838; cv=none; b=LFqPj1gbejJqxfV22E2s/tkbvtX+4IYdfObHNXCFlfqy1a7wXxdQlc/GBpbRGfMXAAKy+eCMS/Mpd0RmxSEsdW0h1bJZqWJSG79VkmujorJfyEOP4y4AMaMujNm3O6/fRHoQMRYfRYBkZcFCMLdL3kbADSFqZYqDG+04maf+ZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573838; c=relaxed/simple;
	bh=koZ5KtqOvS0sXzC05cst3jhJ6rX9/dfX9CELjqV2pPY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QHzJeDhuKHXSgS1Gq246eXaQ2GlQs18YofTplBqwwlX/hksID9HzLSGbeSS/q0959waUNxUMemaFjK2HrAzH98AzC22/DFruACI0iCEIATSbaErDwzjmVXAVyQpd5uRV98pIbXXwrxfjoZXbdW3SuXzNF566pwXxKgA/FMNjwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TrCa5imX; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TrCa5imX"
Received: from github.com (hubbernetes-node-d98ef1c.va3-iad.github.net [10.48.141.18])
	by smtp.github.com (Postfix) with ESMTPA id 3AB83E044F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765573836;
	bh=9LUnssuTX5b8lK2ponb7YYzJ7jsPcPtXSVs8wyDZ0B4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TrCa5imXQzkEJLC+9/21TtO36trfHXBZm1o3a0zC/mYDqltNOLMVhfiRky0fpwU4L
	 d2MuefuJtSMp6cR5Pdd7xaaQgEwd3jfLS9tfk5XMRuKJIOPy542+aelnezHPIlombz
	 H8JcU7KROCWlhy+peM0vpmq/rmg/+Rb4gaNr+y/M=
Date: Fri, 12 Dec 2025 13:10:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032429/dff021-000000@github.com>
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

  Branch: refs/heads/1032429
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
