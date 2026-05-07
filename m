Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23B32470E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173283; cv=none; b=oRCwols6RS+5F33RNX6VVI1+59wh5opTYMj+eRb/f7CLTQ37eU196cJ8leB+XrDgyrkonVYwPNg6GVQ8O/HflfrWF5j8r7p5dJD6hDQXDVBBokGcCZH+xop15XTw8ZffYDEADuBVX1W+SKnvXAgI1wD8W19MFRdj3j/74I7cFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173283; c=relaxed/simple;
	bh=CBOFZEH6c+0LregSVy02zGIsweZ6hYNIarmlo3NudxA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e6eZyzXm/McrM6ZcQTioQKXdpGMeiGwd1Ed1+JQS3GZvX6I8x6RBUXQLTpaLTcFGCB58GFKaXOOfBGzfOk+LxEugBN2SS+htvQRAhov9RNNv+Mf0boqk6sx6zagpuvK+cMfT2fiP/KpX2MMni5dgcqG8A1TiyOoU4DEVmZdLOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jzKJbAS6; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jzKJbAS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778173281;
	bh=lZ0dsS0Fi5MJ1LNi/HqD5WE/CMSkjKL+YuechAFlSes=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jzKJbAS6i4uPbMoF74MkBpQ3GtmTSlQvaVVAK9kRk+rWEL+jZfkNpduMpYwkWYDH7
	 ybCTDLkS0cdolk8NZt7AXgEO+wZJblkCWiJeCrTysQfHCp7VuLsiIhP9fri52ZZrkt
	 bP1kqD92LpVCLMDpSTMvOu1htM1qZX2e5nlIc0A8=
Received: from github.com (hubbernetes-node-0f1cf93.ac4-iad.github.net [10.52.183.64])
	by smtp.github.com (Postfix) with ESMTPA id 2397D21054
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 10:01:21 -0700 (PDT)
Date: Thu, 07 May 2026 10:01:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090665/63ea27-000000@github.com>
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

  Branch: refs/heads/1090665
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
