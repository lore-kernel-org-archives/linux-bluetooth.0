Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D1352014
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191288; cv=none; b=dxhwnYBx8x56d3ug6DfdXgoQfc5O6OstBRUByGr06sqQVCRPFO5dCe+oYznAO6PFvJkUGFJrNMbgY0c2mIsWmud9M3uY+86PvC/4z1oaSzLk2SgUNy0t3jSsEfn7RF3yB+p0AkKgx7/P/pl+AyUSoyusqoGptQb0TxYHSOr3PAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191288; c=relaxed/simple;
	bh=2YQLTT37aFvrmXzkfHz7EAr8hJqr5X5Np0ydheBzBBs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fyrPwHEonz9+O62i2gCznaODGZlFpr1fnMy3KIUdGl3vVvABuzJwdc9C91UDBiO6rCpCmM9tohb9ee8CR+0ZZSdrGrUgEAYmmu+0MaSYx47m7KAGJ6j3yR8ZXOk366LUU126bpMirAzOFXOJ6yMy4J/qCBVc7Mb7LZCmRnPzmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kCrzB+No; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kCrzB+No"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779191286;
	bh=xDgki5EI0BOmi6O6h6eTwXA9IiM7gZhrdLBT5gUDYhk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kCrzB+No+yK0thr1+q16ger7PwDIMrWN7TQ2s2s8o5DPCFQXTJQS0ylGJmhmQi+Bx
	 iL1emmLODWcY8xm3jEL4Oj8ZpEs52xtOnt3k77d7aQZOqgW/MedhXIrqYCm5/DSVGW
	 Y5Bi1QwGrxkhXg7iBWsT9CC4ruruDSe7tGYPs6jg=
Received: from github.com (hubbernetes-node-13a1287.ash1-iad.github.net [10.56.130.18])
	by smtp.github.com (Postfix) with ESMTPA id 8EA2C600C87
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:48:06 -0700 (PDT)
Date: Tue, 19 May 2026 04:48:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097130/e9de59-000000@github.com>
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

  Branch: refs/heads/1097130
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
