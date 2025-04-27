Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2F2F29
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773202; cv=none; b=lslDJdOtPeE2P8Uh/P6xNBuZkKqdwGGQCKyTl41cLjOBFyVIVnsRgEP5kIA9PqRR6ln2PPrhGWE2z0++vMeid+1CdMLUfZKammlSz50+xyUi4qNJJx5UGrqbOfosG4VhLrxSdrMblhPSAf9Fngf2Lzx96NnAyVRV4O0ylugG6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773202; c=relaxed/simple;
	bh=ScfE2ns5F+murgV0lo95MwXMEP2fdMrsCxKIOSUmyNk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P58XErJ1LFt7RHEjXRltKaTnFvaveggJAbv4vZsGs8UNoqEsFCFzZZTXA1a7m6GI+4p91AA8H1JuIfFJEI7oUJ0ffNHEXKuMbM0FiR2MWimMwbmbsEn/pDpuOq/MLJP7v/VnOCuvr5NxA3EDmpiF4BT59ielqobjTrr75ZNSfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ahJVAH09; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ahJVAH09"
Received: from github.com (hubbernetes-node-7fe5816.ash1-iad.github.net [10.56.166.30])
	by smtp.github.com (Postfix) with ESMTPA id B7F92140794
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745773199;
	bh=GjVJsYI3y0K5ApuMN/ou/+iMrkqKFrqpBDBUNRZ7L9w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ahJVAH09/qcZ6AAkWeUXkj/alV6m1HNLj8m3hwumYriKYCdEFy6AKkB+cr+n7dFxS
	 I5aemUqla6DXa/xFRicqtJgiNYVQ1MNIKizAZcXkmHjAV/tr2QqQs2tK12oTu8ofmZ
	 DB2DNjQf/ilFgEqqSV5fhuh97TUu7upOEGPbZ1W0=
Date: Sun, 27 Apr 2025 09:59:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957498/e838d5-000000@github.com>
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

  Branch: refs/heads/957498
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
