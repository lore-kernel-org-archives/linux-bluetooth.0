Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4A3081C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666140; cv=none; b=l5fYh3MOnvHMsmkY1ubsdxat30+Odz/vL7vMu8cA4tiALmlF7Q4kvC9Hr7BLtqydNJMRDROB/pP611jHUjM5NzLLk7UDyNoUHbLYIj54Gkr0BFrgnSQ5pxO4cjaUDcUKk/NS43voMggUsjNqeoFsnF6qdcInK+OkjxZsq5OuLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666140; c=relaxed/simple;
	bh=mSrKPLG6xoKJ83uDD5JL4Vv6q3Pgzxk+udgbrQUrwts=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bHm2O+bP1u8UKU2kOj81yLnz5PRMC8pyjq1XyRXeyQBq4l3qcjnU9NuVBVbF4T5YAXF/DtWQoP933janGcv8crLqm3ry4oX9Hdc3tt2f2Pv4f95xKX9qw6G7lnhd2ztZhgazjDHiPbpxKwjbEAvB1ev5tS1A7ee2asIV6jJC/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AJjVVzMv; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AJjVVzMv"
Received: from github.com (hubbernetes-node-65143dd.ac4-iad.github.net [10.52.174.54])
	by smtp.github.com (Postfix) with ESMTPA id 010212137B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764666138;
	bh=GoZ6gqHOpasLgvBmRUUhJN+2WLir1qhowDrblex1Mt0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AJjVVzMvtOCwAtCDYsQvSXgKx6ZeVJgRpXCBsqakwqcNY2b2GfKP6yWlMlBU8f1yk
	 WcTsSqYxYXDApC172tdVOF6Re6TtQiqwui+R0i6g9IK+gF0Iv2vWrnO27C2PvOgJ6f
	 jwCA/jn6FN3MsuBv8NvJZYebPr7HO8uH4/vydnFI=
Date: Tue, 02 Dec 2025 01:02:17 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029135/c5ee3f-000000@github.com>
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

  Branch: refs/heads/1029135
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
