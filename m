Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9C2EBBA2
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806148; cv=none; b=m5Zv/NZbNUM9yztCyd68zW1R7JbR2oRxDH+fHtQwqeMrMdIFEgnkaOGHbFCiMLWSEJlxtfhQA6URd+fPu83PMnlKDFRxhuHLzswgZgTxtW4fTS9coD+G/lR38938xJFwhm98917LwpWpKdCJAWTLg96m2tfuRRmAI0yvoUnV9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806148; c=relaxed/simple;
	bh=ESUR+F6wkbHsNutHtzIJFa1w5EQh4XLDIFz3A48zXw4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jDvT3/cIYdSJD3cfJOf3QWgBVtYVr+LTtfUF8A0WrqaR4N7mrB9dk5CKjKQqKhLKmluU13crFQ2kzEwn0ytMaOXoSrHj9iU1fip6mQd1yARSaSWx1NIzPEBLuGLXMBdis8bpAExh9ermk2oPi9pATKMvuJvEQQUmTO0mO1eEr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S2+tcgeV; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S2+tcgeV"
Received: from github.com (hubbernetes-node-6538989.va3-iad.github.net [10.48.143.42])
	by smtp.github.com (Postfix) with ESMTPA id 72B1FE1137
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762806145;
	bh=6TcnXXexTQZfpmN/ArEp5VwXwTqxW5rkFhN9O9GyOT4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S2+tcgeVTZgPJNtCb2f76ltQQnI0raSKcBNIj2cFyOsUXuo0j5IQxFl7h8I7wOvAe
	 8SegQOnM37S5RkSNLSXsE16oNt2bVAsHAuZd/lKZhmuLKRmR8zixVN//lrbrT1oNAQ
	 3Em56Scbnw1vYIXrka0InD2mP0FdnraKXlzUrsXA=
Date: Mon, 10 Nov 2025 12:22:25 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021075/1b3bd7-000000@github.com>
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

  Branch: refs/heads/1021075
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
