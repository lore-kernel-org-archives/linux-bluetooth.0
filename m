Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE13749F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584983; cv=none; b=RrW/QnkqdBxqgTS+pbtDueE9S3v7EAAbwGZupGUX668caiJbuFeJERvc2x06SZQ9fqMGV3I9PolOhZz/eeKDb5WM7DSAKf0cFPWmbZFXqCgyR7zWieAe4hEv8lmRQmZ8/rnbunymOlKIWdVPu0kMQDcLGdzH3+6v/cFr+pO5Gh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584983; c=relaxed/simple;
	bh=uBptgVIRgSSZ3/CMnLDjxki0DebkRQFtdBomy89S3Fg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IJp+coSHHjtySiTI+DGn/QcltCq7MWgrNbFTlOYQv1kiOEjQtM2wSW0FvBTOPLQYY4frCCr3V4v8jThHxL6en3VT+Ma2/W69J9S6B1qp6lXm5Vl4c8OyZGkxiljDPRi3nscSoCiqr1zZdWO8CxnATDYa9jz1sQF1co9ykkLiiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NiBx72Wv; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NiBx72Wv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787584981;
	bh=L7bBErkOcq1I5Re9Z2sNFoayp0n0uLTyuTEmh4qEFdM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NiBx72Wvm2Eq4NwCyusPDnm2eIzV1DrJFtmIxWHenTl2PHoHkT91sgjt8Av5nCcs0
	 AL6NTkhMF6FWvG2Dm82XkPxfSPmAtQ2ytvcvBPCRUSE/WKp77qdPsMgq//QuPfQeSp
	 IBNkwr7MbpbqMUgs7lhM3TxvPYUHKfRlTpnLUjhs=
Received: from github.com (hubbernetes-node-36ad719.ac4-iad.github.net [10.52.173.33])
	by smtp.github.com (Postfix) with ESMTPA id 7F934A0636
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 08:23:01 -0700 (PDT)
Date: Mon, 24 Aug 2026 08:23:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1150371/eaf6e8-000000@github.com>
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

  Branch: refs/heads/1150371
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
