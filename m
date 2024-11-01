Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186884E1C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482742; cv=none; b=VrpwGddmRmQEDqp/huX1KspkxiAFsKIDI7RClWtFDDBuatioUbt6AY1Mt3Dg8pzoTLg/exhD+ChiH9qUu9q4JN05rva6Sq6uDyCejvYQabTq1FI0WWGjcVL/bXucvOa+4KFtBcIBugGycR5CdgH0EKaA+amlpPipv3kDgA0yTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482742; c=relaxed/simple;
	bh=JqGjdLx5Y6bZvcw13lqiVgQ/tfdIsg3XQpZCXoinpAA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LEphPjTQJL/8Q+X7GqW5A+JozS1hvBGKMTZLSIUh9HmnMWQ82rxlYDnL5aU9bo+x9lV+OlIIiR8flKnj4lzoBPjettahJYgZ5TDtTgLGY9++qEQldFi3astC7+D7mhELax7jEZOmc+payqWsJWbPfVnAil5I86CjMecgDZa2N68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NYTOM+mx; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NYTOM+mx"
Received: from github.com (hubbernetes-node-22770f9.ash1-iad.github.net [10.56.147.21])
	by smtp.github.com (Postfix) with ESMTPA id 39301601252
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730482740;
	bh=T2yXyk/7M4rD8KQ2TnpslDnB+febP0CFZQmsPHANz6c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NYTOM+mxylb0/NZDwH5wraS+HaSX6lZZ3XYqfKgNDqeuj4C8dobZ07PGRsuvZsMPJ
	 RkW5xtSMFR+8nXgwvOZQMu3kgYG5z3SfjE+VvaBG9xFCO19ibkRdutLPj7ncNm9G4s
	 N8rsu+kL+6VuSBP9YeUEUjjY+oqYVs7V4Z3XkUM4=
Date: Fri, 01 Nov 2024 10:39:00 -0700
From: howardchungg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9e0bc3-557366@github.com>
Subject: [bluez/bluez] 557366: textfile: Fix possible bad memory access in
 find_key
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
  Commit: 5573661fc2a3e2458ef8cd29e00bea83bb67392e
      https://github.com/bluez/bluez/commit/5573661fc2a3e2458ef8cd29e00bea83bb67392e
  Author: Yun-Hao Chung <howardchung@google.com>
  Date:   2024-11-01 (Fri, 01 Nov 2024)

  Changed paths:
    M src/textfile.c

  Log Message:
  -----------
  textfile: Fix possible bad memory access in find_key

If the searched key is a prefix of the first key in the textfile,
the code will assume it's not the first line which is wrong.

The issue can be reproduced by a fuzzer. More context can be found in
https://issues.oss-fuzz.com/issues/42515619

To reproduce the issue, please kindly follow the instructions in
https://google.github.io/oss-fuzz/advanced-topics/reproducing/

Stack trace:
    #0 0x55e1c450e7ce in find_key /src/bluez/src/textfile.c:133:9
    #1 0x55e1c450e7ce in write_key /src/bluez/src/textfile.c:244:8
    #2 0x55e1c450dc33 in LLVMFuzzerTestOneInput /src/fuzz_textfile.c:61:3
    (...trace in fuzzer)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
