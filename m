Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD952C028F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447243; cv=none; b=e0W5mbCNz4gg/UO9Vue1Dpujw8nPcPMtTNUehBXNCKnxm6J70Zq7UklKBSj8b1vD5/ZejzKIlOfpkCCmNqYKzGSlWKBaAmNaX+yHum+qMN4Uu+2NLZQNnL1NhDh+Z0TQICeyhrnrxRP2jLGcE+I9fqP8KFgtacF9+XyILqCNw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447243; c=relaxed/simple;
	bh=+dHC716OQGrjtfZtLegT0rQ6QvQuybvUgx1iDhLcDmk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HYf2Ilem5ZVUd8kJbY2sHnGayTMkMF1IPVBPBdl6Y1Z2nuqhyOLOITX73PNfl3yg5l7lRm9ywnp5L4ekcrGKWwcD9csqz/NPrJv5wNS91wgoAzzex6jEcWhM16nuiFWkZzdCVBOESW/GkkcqIK8xI5DYdMHSjgJswfpfDjJ92J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gL5/ZLfQ; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gL5/ZLfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783447241;
	bh=fuhUiO5WEQ9585Z+lMt9ZK2FetDKjOrXkFVY/yjCX5g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gL5/ZLfQCXiHv8b2pBhMVm8zJYJrcX63vdvlEoE73cJoFF7DmTTfY10vCBRA4kKc2
	 joWEd5XTG6dVym+u78v/a8Z+zPk2xi7X10xohc7PiXIiFQLZQpyiGHwUT+xAttoNcM
	 ZPoC7dKZMhAWLkYFJUIdQ7T4un2XYNdrmwnO7Ho8=
Received: from github.com (hubbernetes-node-9abe49d.ash1-iad.github.net [10.56.80.35])
	by smtp.github.com (Postfix) with ESMTPA id A76ED849892
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 11:00:41 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:00:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120879/5011fd-000000@github.com>
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

  Branch: refs/heads/1120879
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
