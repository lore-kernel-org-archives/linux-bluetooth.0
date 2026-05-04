Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AF3DE44C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906788; cv=none; b=FO6EIcQWRX5kGjIBfpaNe4mm6IFambixUhYit3rrmG5W02ojTXxOfT2NNYfRTYgd0GrYY3/9vFMc9zZkSpCe7da9Fcfaj+RYRb0vRiJggclUoclpKDHrGLNjw38Rssyi0wsIpABtn1rxjqvFoYumQv9iWkSj6sRWqCD5uke4aSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906788; c=relaxed/simple;
	bh=WNmSyn4EZxDhkhlceMFGw18WkFigc18TtNO3+30EdHc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WJK9GJT/eQEOR5Ib9mb6yFBDJOedDUPLCO7HshjmYeHnqNIMT/cqtAmPCuT2lBBWTfjqYrma7AFexopMAMe88A930vn6KAMpEuH3Opj0Sb9DcRU0YEWYgMzHOCQcg2G44CL31d6b/mILiLq+RzKM9SuXksPKorQbiA1YZEmVcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HuZhmMla; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HuZhmMla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777906786;
	bh=AiuW6emz4CoE3PM7UC8ntpb4mn0tyvqtZMhmai3rICg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HuZhmMlarWsuwnx+kJZ2P+fzMzPNPR7+eNKjYcMf62PyB66HY8BSj5gpB8bm4BJPU
	 anqO/CzVRoJsZb1vHHjoipdxj68/XAPkvwSIKUFDNxusg70YnKO72ebE7O5nDhdXGk
	 YmQOaN1DS/HG0qMsk6zbnx8hOxwSWKQSvw0taH6o=
Received: from github.com (hubbernetes-node-7f8f281.ac4-iad.github.net [10.52.13.85])
	by smtp.github.com (Postfix) with ESMTPA id A945F781022
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 07:59:46 -0700 (PDT)
Date: Mon, 04 May 2026 07:59:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077281/075831-000000@github.com>
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

  Branch: refs/heads/1077281
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
