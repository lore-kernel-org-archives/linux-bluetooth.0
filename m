Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4F2CCC5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967425; cv=none; b=piyiucIzPEGi4aksYWhIyZRiuSgBQ93sugBnGOfAm7a/HxygYKxeoHGCVBvnSr1JckHoZAac+UNwqzcZfY4Ov8aaxy0kLixs9KvEPPicDT0/6yNDVo4Vn9PquI9c6sQXDryDgVV6eA3jpioDBfa8auYvB09ZciRqPODKTDgnBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967425; c=relaxed/simple;
	bh=K+p9n7B7qPE2thi7ckpu92DkKyXlaEDwLnJ+pHfjUJU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UjsGDszKWJNydpzA084zejvtQZ7ZkwCwfgWEw8Vj+7q5cQEXHJw4UeEfTFbLt6ByuzLz+TYLNZiL+NFKIrkCT3wQVSkKGLqH5KwCN7bsAMUdy1qzRb+uXeGxTQotw7Cbuy7Db8upHgoTmcOnM/3sFd/t4edxzWHP96JgIyNa3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jZoCuLPR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jZoCuLPR"
Received: from github.com (hubbernetes-node-3294be7.ash1-iad.github.net [10.56.159.37])
	by smtp.github.com (Postfix) with ESMTPA id 4C179920869
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760967423;
	bh=fMTtml9C7II48kpeJK8vjDMpSuZAYvkdkY2gkmnXvBk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jZoCuLPR/C91NdBSDSCpMHNvteJdrxZd5JRqyu4JzyK+RRSKmn/xpgjJ5xcpl3d/h
	 wvmcONd0ElEj58Qa/5t+vrUr3omV0OUaIXwpe7VeoPgLNdVnx76F2X1ZeE1fJq17MC
	 DXWAbMWP2q8PdmOWtdGNNBQ++zootBsNwwTinQIk=
Date: Mon, 20 Oct 2025 06:37:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012592/70e635-000000@github.com>
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

  Branch: refs/heads/1012592
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
