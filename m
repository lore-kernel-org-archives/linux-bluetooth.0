Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF62E973F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007483; cv=none; b=pFRiDMOh8Hn+QBObD1ZvmzTY7fAounXV+DxPW73KVSW8unMZDb7xKwfTrb6LKPkKkjd7pOpu8DfRZhGBOcgFEvrHZ1RC3hnSlDJdD7pNouWHyLr/0W/V7YAjyT45DJz32CXbiC71mfc8vlyNXrHTO8nbeBk9ODhdE27dds/kCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007483; c=relaxed/simple;
	bh=ibaSFeiTljDTLcJJlVxnzY8SBoGV5L+6YvRInHDRyJs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H7VaUZjMLPVSdgkYWsqI/GzS62343YpC2spW9fQDN0vsEV+tR+zu8Fo5HLzWnYl6/2HDf6I24NqdqwoNVRiais7nLPboSvsQfiaadhQEePDo3Q3TdBMCACJhTZmqrLck9SD2LAj2b+yNg8KWAT/vt3xXsfktmjvVg4tBy8f3r34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O0yWgFBx; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O0yWgFBx"
Received: from github.com (hubbernetes-node-093a6c8.ac4-iad.github.net [10.52.221.42])
	by smtp.github.com (Postfix) with ESMTPA id 15DDD20958
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760007481;
	bh=tMQYqR3nlkkmheRPJA8TfptLw4oJXPrpSZBAKQMEsqM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O0yWgFBxJEa0jcXXIgC+NuKjIm/QyYAtPMmJrmp/tP2DSAA7A9N2/0LhhRbLU4Mal
	 SbIU5aCoRg3wleFQxqIRj+neAC5QM5ejVngrFQM6i0qvzBWeTsm+JypDJNQWSS69bn
	 bRobECjzKCJTSDkZhnPD+9HWxccbIRQLfDjqaLlg=
Date: Thu, 09 Oct 2025 03:58:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009338/2c2412-000000@github.com>
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

  Branch: refs/heads/1009338
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
