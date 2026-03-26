Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595037DE91
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550546; cv=none; b=l7lRYNTEE4bnDjGsdBEOHq/yXvjImZW2lqB0NtSSF/5iDEH7B+QyHocjHruGPxjF27LWigkEN56ezdwRDnZqf3rrX+/7XJju4VxtOaGrKsa3o9gwzE9ejFQsW5L7d5fiAJoa4eF7IqWhqPt6DAxqTRmFsz7QivNoXA52fJ6rxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550546; c=relaxed/simple;
	bh=0Fyrk6gGzQhDr17PrTiG6OkSUG8UgxzH4CK/wLVaAIM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R8S3RzijP/OMzSeYn+zt8iR0AqwHKMZPV3yuLEJK8JLy/RO89Q+38C7ybOZ70xfdGGml7fuGL2EG+g5plswyWjZUfPBNFzahTORfMIJtfsiCvrlQSmi+3LOzo59nD8VQy9F3axJ7chf7eTYmvkysQ+omKRXmviDSYr9m024A7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kmFNbgqG; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kmFNbgqG"
Received: from github.com (hubbernetes-node-5a59d0f.ash1-iad.github.net [10.56.201.81])
	by smtp.github.com (Postfix) with ESMTPA id 4E9A9140C57
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774550544;
	bh=EtPvRTA9igBz0+d56cl0nK4rbkbUh/IKeE06ujMRo1k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kmFNbgqGaO/kF/tCZFFBbGnEB7rcd/tQg9fMdcKNvFUlA3IFKsikCsQGVogw5+FgP
	 To1sFShqq8rgIjjHgj4B11bdWVtPw/7mzeflwHNeEQfqXy+K7zw7JorJoGVS7O5OS0
	 8z+dU4sfOsjCaSVdhe/TxnLmld0XDlVjMYo+iEmM=
Date: Thu, 26 Mar 2026 11:42:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1073069/583400-000000@github.com>
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

  Branch: refs/heads/1073069
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
