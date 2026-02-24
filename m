Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE1369233
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934436; cv=none; b=PP7n23dFi8r/eCm/7D2xu+rvNK/mItL6qcF767AQPuLR8CHDYoIFyYTgcJTGKFQuBRnzWESEeQ02VbtWW2N6h1GKTPCRzttmKmXLHQ7vzYahcvj5AzPWznvpEzysnC3OfT64gRbsmMoD54U20kccSWSRlpJ/tFRJse9cjdifwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934436; c=relaxed/simple;
	bh=Qs7lgKwy62SSTbAkvLqhUu1YFsW8OrDPethdH1f7EDI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L9b+JarLdWaCyy/WZZWmmDqPUY0p4vMyehEYH4fNZIsi4J8dtkuvcqHeb2LSGJjhT/livtZCzA7Y4eoMI1YXyXSvjE7TEWVqJiqiYDHJGBH1+zBu1CORnbGtXGXRyrZzBfQUJxbN9PVpuxbIAKsJdMEOiXFo60OqLIe+2t+keVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hqaAmJuh; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hqaAmJuh"
Received: from github.com (hubbernetes-node-3dfc02d.ac4-iad.github.net [10.52.139.34])
	by smtp.github.com (Postfix) with ESMTPA id 71AA9641097
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771934434;
	bh=s+EH0OqjZc7ZZSyqmV7SIgleSY2WTkRYqZQ2tEBBDt8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hqaAmJuh2uS1fWwut0pzO3hKPLW942KXuHHrxdoZrqABdod7hXFJOdNzGWLK6h1W3
	 PRzdMxov0iP9rh04NyoUlQHkF1wSmPNUKxmyyVuo4UgfUc0neR80Uc1DAMnXB76C9K
	 FmHva2IXDpGHbEy4YJuLqzLx5TylQFbVkf5MNbjY=
Date: Tue, 24 Feb 2026 04:00:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052474/1f28d0-000000@github.com>
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

  Branch: refs/heads/1052474
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
