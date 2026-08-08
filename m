Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F311C5D59
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786223086; cv=none; b=f9qGJS4gwwqsUgKd4NuTE2FCBO+GOATIjOWQ9gyBSGAw71EgI7WxCpdlgTFPH7uxnkEdEm3KOSSc29fPTINOS96QM2OqL2jiP6WvaGTqk0cmHuNPLKMuW9iWP1/13Q2Yp0Cm0WPMn4G653TLox9BeCcqBa1jqoJNg7Z3RSj2VkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786223086; c=relaxed/simple;
	bh=dX3TufK9aa9gbQyL/ORaQj5053Y77jQoz+u7SiXF3xM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WmJvAUGDmDoNRjUUgbwYPL++hQypgSPooUXeKjxCZf6d4luDEkO09H2xtLHQgFuSCgmh6ygELXXbbIBNHHQ9/weJ6rysV9yjYSaVFoncRLR32z2cmk1c4eWQlWcmY2/MJVAAycYW9axLroyMPzu/bkex9yKGKvA+D5OYEj4TD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cgSESV52; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cgSESV52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786223083;
	bh=SG8Q+eaaiBQZatwle49JqJFQHKd3wR5J7b0YgNWMBC8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cgSESV52616LqG1iL8F+eALay5KZXLsgh0eUJlV+YnQZcJFPGLQul+h1XA/h+1orC
	 Ii+1Pc3DDsq9S0mp1RM1/4qgz4XRrUkWEMwLcJzT7ZXEZaOTXRpFU4lB2J6H/n9zSK
	 CbGdxVDkCK1I9GJiFLxTxQtLAOPMxLQMhItXtllo=
Received: from github.com (hubbernetes-node-09f3fc0.va3-iad.github.net [10.48.81.60])
	by smtp.github.com (Postfix) with ESMTPA id BFC7828037F
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 14:04:43 -0700 (PDT)
Date: Sat, 08 Aug 2026 14:04:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142766/306156-000000@github.com>
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

  Branch: refs/heads/1142766
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
