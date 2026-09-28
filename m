Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F85013A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631132; cv=none; b=c9wNs30Dfj5RHecKCur1d5QxyNGEgXjUHUELWRAX5OW0mFIIIiJFQarfw3gSMd81mXhGvK108eQErAeQHT2n4oByC0+uhGrM7u0eTqVR63sBKclvyyafAWUrAtd4z8nagQNBi8r/SiCZ2qtHVP3nG6PBdtQv/w9SuiDbCGJV2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631132; c=relaxed/simple;
	bh=CQpeg0vOogiZDBzlSUWGJzsUFr+EupcTWof5frM+Wuc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L5frSWxzqRFUleuIqYuIV234SVv5z0TmY4HRtkcla87vLTqDlA09Uvne6zcAr0XTN1HDo2f04nn8dSHqITjhb0c9CvFktfuoKID73qFLkTjPYlFFTz6mRknDKkYdzzEkBTY5g2ERRXs5ReGEtriz07//OuYqyAg8c22Xk9ZA0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l+EhWJhf; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l+EhWJhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631126;
	bh=Xd7kpTjMta44iivpuNm/rJhEMssjsb4ItwQGaUYAiOk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l+EhWJhf9ZbE5tuD+OwfeU/OSwMGEssbQSV62uANG8p5+ArydOYktd+LtIulNK8kx
	 GAfN50oh7zeWipWQXJC1ozfUPgSEpSH//z3ubiTqQRewI7xG4hm440v4dc9b0hPpvt
	 gXULU3nVViAepxl31pSSLokz/sb4tzgUJzNpd9xA=
Received: from github.com (hubbernetes-node-1f44628.va3-iad.github.net [10.48.71.86])
	by smtp.github.com (Postfix) with ESMTPA id 5DEE27803C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:32:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:32:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173742/9ef837-000000@github.com>
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

  Branch: refs/heads/1173742
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
