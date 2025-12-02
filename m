Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822B2EBBA1
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707255; cv=none; b=lMEJekOp0Y/oPGvpbwpQo72xqLPND0gh7AqpA19wMSLIHMyGGBV8DTbVKLVTvI308741CoLNaOTa/s7g67jHrHzadIMgsbkHjWjOauuJvkXiX8rVzC+Han5o+TNi5yvt0Mt84LowKmZMoAt17p5Zt09+DHYkQsdkWRvfHCiqpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707255; c=relaxed/simple;
	bh=MpKaFGjkZF6Icmak2gwLYzfRoTte31t1pGmiLyDPskg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qer1GDtsjmLp8Xo6zng7HKbX6rgPnLzVgY/u/Wnr7QDoIgHvHvAGF9kCjC76eUx3/ZQ5oBFmPYcgMHkikGRM9i/TYFDTJZwHumXKs3nUky8aXBSxSY9Y2j2qW9ZV6QtXXGKa7vdAxJv0nhs3Pca/QCzjfduwzFkYpajHF5JfVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dIRSFcJS; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dIRSFcJS"
Received: from github.com (hubbernetes-node-e305f0a.ash1-iad.github.net [10.56.211.78])
	by smtp.github.com (Postfix) with ESMTPA id 83AFF1411EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764707253;
	bh=SxR+kVIp3wsXNolDmnToAa65/PlwWJv9m93qY+Z5w38=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dIRSFcJSAq9aM0Y+MuE7kJV9yFqOLA6FoKYj8O1CdnMvlm2s3yI5UsMP6CGvdONwR
	 G+NV6famhuyCsqSybud3dpG/OAYi10UloA062aqFzkaJOYxC35dM67kCeFuLEYidGb
	 1inA/rFTdX2QnDpD5q8j9INb9Cp4a8IVfJhJWP+4=
Date: Tue, 02 Dec 2025 12:27:33 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029860/000000-6f115e@github.com>
Subject: [bluez/bluez] 6f115e: client: Fix transport.acquire auto not working
 as ...
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

  Branch: refs/heads/1029860
  Home:   https://github.com/bluez/bluez
  Commit: 6f115e145fe23a7c03d0180ceaec5477f2569a0b
      https://github.com/bluez/bluez/commit/6f115e145fe23a7c03d0180ceaec5477f2569a0b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Fix transport.acquire auto not working as initiator

Transports configured as client/initiator do not transit to
State:pending since that is used to indicate that a stream has been
configured and has to be accepted, when acting as initiator role
SelectProperties/SelectConfiguration can used to indicate that
endpoint stream configuration has been initiated locally so use that
to mark endpoint to auto configure if that has been set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
