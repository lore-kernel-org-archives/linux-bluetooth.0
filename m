Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC51FB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481146; cv=none; b=P3L3Ka5a7S3zD0KXymGo6HYmKmT8S8VCvrHyXJFo+jDiHXZDuuOR21AmrW7EM1LA9oF8+pqbQMRsRs/XqWdJyRUBGpa/fHIdC4lFhxQST41WHBgAEWGt6+KSD0E22lUnLQWl/gMQybupWbvojwLWdmg8JaY6buYseORbSj+yifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481146; c=relaxed/simple;
	bh=SGoUxl9fmrv6cYDORl25guntypU+zNWr2H2He7XgXUY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ah87ST9CpmMzMM2lPRik4ZIKmM3ZfwohVpO38L+KxJiQXkJTJ6b3Z+3D9sJDpPXc3cVikZI/hHreruh5oQWnkiWq2V7YZCmBqi4Nf2qNvwScYQlt9PEpiufOOBJeh7hcpKENDAvKD7sCaa75k4Dq/CiGpUA58GC/13XNK43NanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VCGt/PUD; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VCGt/PUD"
Received: from github.com (hubbernetes-node-5d2e678.va3-iad.github.net [10.48.173.16])
	by smtp.github.com (Postfix) with ESMTPA id 725194E0846
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760481143;
	bh=LXz1dlMg/iWunPpGbA3zt/39ZnXzk8h2N8ISdS0pviY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VCGt/PUDL+ChiKiuLShpxe6//Uj/BZYtgDJ8kZW5EIdWbNNOm6jiPJqS+oiJXB4Q4
	 HFmVNdfi5s+e8k8n0jFyiI+DOJ/IFtQL82pxt1Yv0P6mYrWJW4hdp/BfFtkrV7iru/
	 zTenSCLijWYujj5UcPziVwBFKhTgzw/9nTl0vO1k=
Date: Tue, 14 Oct 2025 15:32:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1011517/951647-000000@github.com>
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

  Branch: refs/heads/1011517
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
