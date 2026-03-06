Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871A3BA243
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810685; cv=none; b=BNBRjWKscIg8oLMe4RO1JjKuXVIAIF5PFcv9+sJE8rxrZS/smrIMMe5/BEx97JYCHzpoOd8joE1eUW9G4V4odDc39hITmjDkW68cNjoIIlrPgP2dXCOcPtczPuYasPlWOVEDEjvlovJh+NRwuwRpv2P3t/knqiSW7VLJmjurQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810685; c=relaxed/simple;
	bh=Z+vGn+5Lk2/sCGEsgVSq5F/Ze5J2PJt/glLpSgKK/3Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IpfSGsIBho6bO8xwP2JHC/fFNqvfV/5mon//dKzpMtUIj2BV4/fXn3iASrEl886Y8Zb05Q5hADtoMxoWmjKCC07tYgETemjxenMlJcvAyE9U0sfq0Kd24Nr8sgqkpxXU+fIC/9xZS5f2w5LhPffNOCT5kJhQcmmFyhlJ9Z6Itxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tt9Je+y9; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tt9Je+y9"
Received: from github.com (hubbernetes-node-e6c0ae5.va3-iad.github.net [10.48.180.50])
	by smtp.github.com (Postfix) with ESMTPA id A40DA9210D3
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772810677;
	bh=TgVn0mKrBp7Aj+RwfhueGkbzUeg4xApQ70jrN7V3aoo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tt9Je+y935aHCno3kvHOzPZfj52pUjlexSWR4rKzCRDbYS9senI8xm4cZMRMZCOO9
	 PSyLzJ/c0gnJPuws5R7KeOYa17xNvZEOX/MaFpx7MGtkfNjKk6p2Fp1GwBCAY6sOUw
	 5m3PVHs81cco5AldandX5GKXfa4IUW+JtRnVprCA=
Date: Fri, 06 Mar 2026 07:24:37 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1061563/5d88ec-000000@github.com>
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

  Branch: refs/heads/1061563
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
