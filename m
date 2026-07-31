Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5D307AE3
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506543; cv=none; b=vCj32I1rbVmsmghlF3u2gvGzybaX0GrnJipHMthlRv4ktWSGwrzhD7JZtfaPAmXMxZXYNxz14e0x7OWuq1Cek1sYvkitIHissDUiL34yY95wwjawnkq2w9Ja7Iq5JKOlqZIMWN9SUNi1cNwfQPb5w7um6VewzZI9i3DbtrywoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506543; c=relaxed/simple;
	bh=TZHplNNhQDAtALl3wk1sfkSPC2sy6rAB+uSr/YBD0lk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GKHO3/y1XUAoPxDQrFlcmWX5xDA133D6JyC+Cg51vAzC81G5j17XksNYpsQ7XDFJYuI8eq02/13J0l9yHCzHZ9GSCj1DJ+vGvTztiOy3JzyvV9OcIhu/4S642Z69hjaPyn52ftZnKmJbMhssXh7ojNct/svrfUG+F0Mre4Yifn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IVb0LsmF; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IVb0LsmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785506540;
	bh=Oc8Y8BhzEdb0FXRFNpM9u0r+hwEBafealBk72S/EPdw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IVb0LsmFltpNKZiZo07s2VeLq/hpljzjBknKZK9+5j+1Vk2hiP+8DLiqpvC1GzP3q
	 9IsCiw+M4F5KwlR3/fdmnGGEYhd7DIpGo1sZvj1TY2J88uKko1lsgsqSmJnLdhfNXO
	 b1YV1nYvj9hMkSsQVaZURK0I0mx3Q0Ed5HWnXYE0=
Received: from github.com (hubbernetes-node-5ec67cf.ash1-iad.github.net [10.56.155.24])
	by smtp.github.com (Postfix) with ESMTPA id F1AB73609D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:20 -0700 (PDT)
Date: Fri, 31 Jul 2026 07:02:20 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1138148/000000-31d59e@github.com>
Subject: [bluez/bluez] 31d59e: unit/test-rap: Add PTS tests for CS
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

  Branch: refs/heads/1138148
  Home:   https://github.com/bluez/bluez
  Commit: 31d59ec05ce131048f15100ec75b13be2fc610b4
      https://github.com/bluez/bluez/commit/31d59ec05ce131048f15100ec75b13be2fc610b4
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-31 (Fri, 31 Jul 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit/test-rap: Add PTS tests for CS

RAS/SR/SGGIT/CHA/BV-05-C - Verifies the Ranging Data Ready characteristic
exists in the GATT database with exactly the Indicate property
RAS/SR/SGGIT/CHA/BV-06-C - Same characteristic-existence/property check,
for an IUT configured to support both Indicate and Notify
RAS/SR/SGGIT/CHA/BV-07-C - Same check, for an IUT supporting Indicate
and Read on Ranging Data Ready
RAS/SR/SGGIT/CHA/BV-08-C - Same check, for an IUT supporting all three
Indicate, Notify, and Read
RAS/SR/SGGIT/CHA/BV-09-C - Verifies the Ranging Data Overwritten char
exists with exactly the Indicate
RAS/SR/SGGIT/CHA/BV-10-C - Same check, for Indicate and Notify support
RAS/SR/SGGIT/CHA/BV-11-C - Same check, for Indicate and Read support
RAS/SR/SGGIT/CHA/BV-12-C - Same check, for Indicate, Notify and Read
support

RAP/REQ/CGGIT/SER/BV-01-C - Verifies the IUT correctly discovers Ranging
service
RAP/REQ/CGGIT/CHA/BV-01-C - Verifies the IUT discovers RAS Features
characteristic and currently identifies Read property
RAP/REQ/CGGIT/CHA/BV-02-C - Verifies the IUT discovers the Real-time
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-03-C - Verifies the IUT discovers the On-Demand
Ranging Data characteristic with Notify and Indicate properties
RAP/REQ/CGGIT/CHA/BV-04-C - Verifies the IUT discovers the RAS Control
point characteristic with Write Without Response and Indicate properties
RAP/REQ/CGGIT/CHA/BV-05-C - Verifies the IUT discovers the Ranging Data
Ready characteristic with Notify, Indicate, and Read properties
RAP/REQ/CGGIT/CHA/BV-06-C - Verifies the IUT discovers the Ranging Data
Overwritten characteristic with Notify, Indicate, and Read properties



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
