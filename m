Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DD32A3C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513790; cv=none; b=FQqHpucoDIGUPYUSrNC0By3RA80qNwmq84FYe3owRHnnVSLhbVodLc5PSY58/9SXm/gUdm53CkSsIletBiYQOM3nrXHQdgUhyhzLiTbHKgu9YdKjylX2IBOOzMr6nkpcQksdqqUnKr1PF0do4C7s0JoK+tuTQUv2Nwu8TElVjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513790; c=relaxed/simple;
	bh=kccQpsDYszCsQAGL7wX12qFiVWuUpIqgUBjDUCmBnEg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SkFgGpCpcgMvYmz36t4D9kHZI3QhU5PPasKASkU4T3HtM50xwnL49iueM/mOcBP9L7ne35gDU+pp35K38bGFsVUdjuUX6kkepZQkOsCNtY1zTfXV9p+jaM2qQa5yCVfill4uDxueWrAa+hlxwbvGaoZ+SlJnGzu/t/w9WOUdZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VQGPw5Ct; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VQGPw5Ct"
Received: from github.com (hubbernetes-node-d99a22e.va3-iad.github.net [10.48.138.42])
	by smtp.github.com (Postfix) with ESMTPA id 3CEFAE031D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768513788;
	bh=cRXG2P0gtVwLDEegFckZb3ZJKj9mldVTxb9pf7QpYi8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VQGPw5CtbBt1jhrOWnU0ELRcvVuUZggfbRcBgagHHHx9rLIYachWsnKTpbNfLfzIO
	 9znSPTtpdygKZQ71GvO9WseyB9DAyfqT7VLFwwVn1zr16CpcN6BBs3vo+SLSTbIknO
	 myqx9AuNpW+mDeQb7zqMpPlvuimSpn8D/mH2A15s=
Date: Thu, 15 Jan 2026 13:49:48 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1036434/21a817-000000@github.com>
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

  Branch: refs/heads/1036434
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
