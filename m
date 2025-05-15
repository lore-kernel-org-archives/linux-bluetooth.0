Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE29B23C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340198; cv=none; b=lzpHuY5tH260c3xYSc+UkQzsLPmuGwGRd6Bdoi8NXgW8Yl6PA6OvRaY0XskbER0ZThAcevYI/qHe7UsOgDRhZuRlIZM9+IK6qVPy0/gIRSoIGwJHE94ANgj9ovBtciw9sB+myw44mlFi4GKrQcq0mjeUN5DcK1jeqU5UBkOiL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340198; c=relaxed/simple;
	bh=dc16OlFaLYcjiPrL/hPCFJlypEPoljC7o83zZtoadsc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g8uxQODCH/CYYHmNSRaIJ3yKolByA+panYjwe4bR4r5y7X5XAHFGKemAwyzWwwo76YK9ZGnuAJoToQPFr5DjJHappWAmFAxPJELBYaHBZpdq3xg1E3V/zJYp081lU08QJFpWaKyq+PY5xw6+UjROe6rveKTQONFMvdXl2Od31p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VTgCqfGv; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VTgCqfGv"
Received: from github.com (hubbernetes-node-91ceb1b.ash1-iad.github.net [10.56.226.74])
	by smtp.github.com (Postfix) with ESMTPA id 5A6789211FF
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747340196;
	bh=n+MXfG4s89+ruoJSRhbbyLtleZHj7jYTk54tUUm0jRI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VTgCqfGvcw8ymAhtThDYT1gAGt8F7GC7lUrV1REUbP+8wO0ED84V6/sHBksnGVLwS
	 knVogba2iz95zwqoqObT0hFqpWidZ5MgRGjg0LCE7gk3D3K8Oyj2VcxpZn+gBDqb8R
	 0BPnDK8IJkYWPFWNQ1vRvJH7dE2uERWHQYWm3Lzk=
Date: Thu, 15 May 2025 13:16:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963312/9f18f6-000000@github.com>
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

  Branch: refs/heads/963312
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
