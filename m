Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F4382299
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605284; cv=none; b=PpzzT19fQrr1iZjIRI7K0VBQaiEmKOrrH5Q9pBKrI4sh6jEDEuFgDHnNZ2SAhbOB9C+4ib1KJQlSfs/XFlzsqxdsxrRGicuXJXQc0Af/yalO25omSkeCgcWJNJzi7NeraXnrY2nP7BDU9ucNFlAIyXOVN3SlqFOQY5RTxBIU3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605284; c=relaxed/simple;
	bh=qnvEclRVib3UZYmo1kY3iIDtjQeyZYIwvWL4hWE09/0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XyCmakese2ZY9RaihpIkM5z5nVQcqRIJuEqlZLxk0KQFIvzd/tKviNdsSk0YOp4CryuGqSLEXsUc4cqF0WuLRkjVRevsBv2wvlr0wgQWV8+FPg2YeteeUC/OwKPADRIk1eLxV4yvhzRFJ0IYDuOdb1NAjbZCNCuYiNAYDc2DykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LvO1P5ZF; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LvO1P5ZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787605281;
	bh=Ql8x42VLZ6S5MWLRRLMRfkxzgdPPqr6d4nuO5jpv0ZM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LvO1P5ZFQ8prE53O1XAHDnh9P8Lu7qivEcQiULdGJ5G206w52kCrECCjmL0vzER7l
	 GIkWl0Tk+uiErc8JfMNoO1DVWPBxJ/gwLrqKp+Ju7BWdPQAtKPXssvpCSAbQLZQHuJ
	 YfRkX5D1WCEJqamQQs5enpPtpEB/P2NW/gQVqLEw=
Received: from github.com (hubbernetes-node-efe5390.ash1-iad.github.net [10.56.180.41])
	by smtp.github.com (Postfix) with ESMTPA id B8771181539
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 14:01:21 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:01:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149989/af6975-000000@github.com>
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

  Branch: refs/heads/1149989
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
