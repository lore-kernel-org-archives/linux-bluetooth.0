Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617111991A4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773281; cv=none; b=fMhEVQ+6/8oz3STS9X2M6o9NClaPz1QcmMUm+8fBf2tBmGKhqRyoPfVAym4qyeo90hH+io7xCEGMtRhPuuNya8i4vGO89eQAbMPL93/aNM0uf9dkuVvncWgbBWrBiaOEB1T4h0B5QBhtvZvqe2I4lNArTAmWP+FKvcQk+PFaANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773281; c=relaxed/simple;
	bh=Zeie2f8zLRhEglmduBm7gtkmEtVpBzrbVTvELrJWgFU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LwlKhcxPNwSsgJ+QPmwigJcrm9oK9JxvQKSybhG68iHMm3kJkdC9sDip/pkpBchhKrMAbkikh1sB6cJ7+2BDVLD6CLYHHF7RUzA4B+F8AwDE+meJhkj1p0WUp7cDz7mGzvBtjXbuskguvGVAIsMd50ZphHIuFpcjLrQSQTqpbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=doj0rUnm; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="doj0rUnm"
Received: from github.com (hubbernetes-node-d160d38.ash1-iad.github.net [10.56.212.91])
	by smtp.github.com (Postfix) with ESMTPA id 69817141075
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717773279;
	bh=vulza5YUmEspqQiHPOjQ8fBTOjUdgyATsQy7gZRw50Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=doj0rUnmsRvSb3PE0HrGzfwfCrNR4xcjuk2ANvY47VT3QfsnjuF/ovqWxtqFT7lwg
	 PlVqz5P0RGCplEzXc5yXO5edxdgSMib0EnV3zjpI9yjzoUlBl/AoBB1V14dalgGDWp
	 O1wpUqc8sDDNUbGUZtQeR54psF11erqmrW0L8D18=
Date: Fri, 07 Jun 2024 08:14:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7c619d-272d8e@github.com>
Subject: [bluez/bluez] 272d8e: isotest: Fix ISO send data rate
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 272d8e8c959908dbe9e4b6b301ebbd3e8e5b53a4
      https://github.com/bluez/bluez/commit/272d8e8c959908dbe9e4b6b301ebbd3e8e5b53a4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-07 (Fri, 07 Jun 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix ISO send data rate

We are sending data to controller at wrong average rate not equal to
1 packet / SDU interval, if Transport_Latency is not an integer multiple
of SDU_Interval.  The calculation currently may also give zero, so no
data gets sent.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
