Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448B1DF748
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202335; cv=none; b=nWXoPJ0NGakgz8yqYG9RmG4ZbsanIUrUxayQbZhH1gZd3D1aUbI950Lm5BmL/4+nKvcDq00f6RjnZppLmf33lMC7MzDxoV1lOghQYuXTUOERP1xrggjyLE8+RHLwi9pJplKTDdHm/UbRa9P8DOg1sIcz+w0qGjOjN7xi6H9IuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202335; c=relaxed/simple;
	bh=tdqTiKO1ZUN3/N3CrIalTBsZbjGEeKaR9i7Lo9Te8nM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=picAt5hRztLjemzGCt4k8xLgw7ppZfRYMNZEQBlRUWEXxvps0QhYLrfjQgu3yxERP3+ag3J0Ya9KCrBxxCTjpjSA0ZPmGY0/UykVBLK+VgoBxcyKo2I2hG9bSt4Gljb864Qd8WkAHnmJ5JR2NVh2dnxo48ZlxgruhhDoaFkHGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eqCHHG9m; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eqCHHG9m"
Received: from github.com (hubbernetes-node-23b2d4a.ac4-iad.github.net [10.52.144.32])
	by smtp.github.com (Postfix) with ESMTPA id B0C98700398
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758202332;
	bh=4vm7YkOuMUqwNojpSidocCQftAXYNMj9gUDf2RKf/0Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eqCHHG9mfaORs+jR27sNS2CxpvXyEk2usiKyOPgT/u9dTj7yh211kTtJp+b0NXU+L
	 f4Q0NGxBBHfqWHvAKJ15URbrXtm2/1W7ARQB9KsFi3vkOxu6ljlzadoDm/ZKCUXJTY
	 eBBMkehqo9iMgVTJ4MuxuaARUE5FFbA7uhN2mq7k=
Date: Thu, 18 Sep 2025 06:32:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001555/9ddeab-000000@github.com>
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

  Branch: refs/heads/1001555
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
