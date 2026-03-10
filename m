Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B813DDDA5
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180094; cv=none; b=isAmBLdNZZXjBTgs8e2bnBayWG7i1Yp8npokfdilAlJSYlJVSe6vX7sGTKrFwTMgkBpEtG44fotdMZb1bKEvBQKQVzhrnQ5aBLkZKo6jVLwUg+F0Q1fRQ/tFBfPMNv7gsrjiO+oQFgf/JBopcrdEEU74cnAo2N3P6tkguRwlHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180094; c=relaxed/simple;
	bh=HuHenCv0/TBcoXN13wG1T3H1aIyXuwuYloRwQ83+fDk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JXzswND3BI527iJDVZ/7tiQDrj9zBHRro1YwWalKU+C4eD9N+kxaiwRXXzaugD/oWmqERELT76F1+DkLFjU1GMzD8A/e1VKaRBC65855edwBGCE/HSBwH5qZ1liISx+xmgDK+fb0h6qtRjL7/v6cXMxkMhQYq1F5hMnLSpMWwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q19JNQrp; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q19JNQrp"
Received: from github.com (hubbernetes-node-6da8720.ac4-iad.github.net [10.52.125.69])
	by smtp.github.com (Postfix) with ESMTPA id 2655B202BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773180093;
	bh=0BtBCJ/Mo3JfU0UABaCV3gHmKioYfM8QwgZJOna8+RM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q19JNQrp5/M1NYWDU+yt0HKhMBvwo3RsNHVbbDXHfIDOLfsa7m2Ea9/lREcB9HX84
	 0XH2+as5/++BKrAkTCUvyUqHlTaNYJKJdUl+OgSdVE3hZ715MwEuezeYKzjOp9dwim
	 FdOwslXXpzRYgXb1VssCg+v68H80nPrcPE5vgGcI=
Date: Tue, 10 Mar 2026 15:01:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1064536/f73018-000000@github.com>
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

  Branch: refs/heads/1064536
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
