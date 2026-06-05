Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C52390616
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680684; cv=none; b=TseDCtOooB072GyrVJfrZ0+vNp93G4PoxgpjHyUxXx5qwh+ktJuKBF6mlQHrSdSx+0UnnUtMa+0X5qwGTX+mlkhfK8xzyQLONenCw5QxhsjApIsoqB/dY7qI90vTHRg5Dx6tuJ9oA2Bc4/wGfsVHVBvhT8PESQ5cS5wSSF7fxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680684; c=relaxed/simple;
	bh=gdQrNohmlzAT7rGMzVpuzs8ursFoe+Yzm6ZQLl9IRsI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i3Py/8LXWdEETGyTQmm4RIyvJkBILfHlGMEUZdlBUelRDaFSRfrnhp3JGvZRtKY90ZAs2sSUsJ9qbbPTnqlmftPtVvLLlV8fGYAdG4hSNDKUEuXru02e3nESRpC31tLTQMuHcYUJ0DQia+EEnqk8FwPwmLXrQTGAy5RnPpcfIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=D57CfKcl; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="D57CfKcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780680679;
	bh=lKVUN7aJ/WdORcmpgdq+UzGmS4LbIuSeLNUGkUEqnn8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=D57CfKclQER0j3Mlbcr5aNYz47tIydBvypL44EYIphACGdtLp9gp0JG0ve6WHAb2q
	 FM7Pke5OhV9nYne/RjJEZRYCYTq5i0pMv2wq4M/7jK9DTwZ+bGLmQz/yJTTq2HH1CT
	 3CYE7Mw57bfIkxqZdgFuklmvyM0+WE/y2rlBnF1M=
Received: from github.com (hubbernetes-node-18d423a.ash1-iad.github.net [10.56.208.66])
	by smtp.github.com (Postfix) with ESMTPA id 6AAD7521151
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 10:31:19 -0700 (PDT)
Date: Fri, 05 Jun 2026 10:31:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106487/8650ce-000000@github.com>
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

  Branch: refs/heads/1106487
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
