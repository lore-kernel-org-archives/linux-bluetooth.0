Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD21C1AB4
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439143; cv=none; b=V0d+OF2pkOlzKWEypAVmzR0agMUJqMcjNMc3dbOjYbHJa59jNFJl9L2LMTnuuMjnxqvM0Hr7RFSuH60kRRLr23Z+sY0vd2XzPhsoLhdua8pvC1o09/etoYEaOYVtN4ZOERfGFWhhjeBtYeBW6M5Ui92Aem7OeF87ihDykE4I7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439143; c=relaxed/simple;
	bh=OMVXu/a48xfCyLEBMQgxXTbOjBGH1tVrcC/APcJNLJ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fU+CbfD5c+LBzcIzT3C72wGikwtsGuBKnD+noV6Br80ijwSfaUb87cIWc8YvAKBd41S5lYZaaaKcUWQuOZqLoS3+zlmMCJw4rP1FhQaq7kKmPjIpisxyXKa5FDlN2AkOk47pq5wQ4wqHDjfeYMFylbFG5huO5AAbDYj3B1rnIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iLalYamN; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iLalYamN"
Received: from github.com (hubbernetes-node-be630f2.va3-iad.github.net [10.48.219.61])
	by smtp.github.com (Postfix) with ESMTPA id 659F9E1236
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746439141;
	bh=qz93sFE6DEixVrp3qpGhJ7zXu4ttkJ8/oodWagU2CfU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iLalYamNpYyeTz8HQkZQhx2Qkga6VNhtqFBPSZkqP4tfMumSIrPQqwBxKmBddeA3+
	 5kPw8tRh3gydQLi9VqAiU4Dhy6HWvmJTKzgSEtHHEB0s8dVatFmfgi5tvdpkMX3dl5
	 roehcHyeuHcB9dWe9nMOXb8j6G4e0sNwMIl/Qfdo=
Date: Mon, 05 May 2025 02:59:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/950146/610f97-000000@github.com>
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

  Branch: refs/heads/950146
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
