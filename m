Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D830100A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176885; cv=none; b=LJkUc88ywaZnFpyC20FeS0tBJExpgEzwRkaLFUtcdrC2G7NNn1gT/UHszGnKeirQTN1FcSKGqKGMyRGeVsQzSgm6iLgHQtdwy2j80uMkTPAx0fSEl/0/Gm2STrxAjzjOyTMgg7sf3wnT84fhkXUSORWu2lLfWH+D4r3cuwhfQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176885; c=relaxed/simple;
	bh=d8ChvPBosuyuwNJ+J6LWdYsls/z/mdfxouHdn3jCe6s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CIRT94VF8AMtnITMBtCVVCbAblvISzkLAcqhx4PbM5S10AgfbIafiP+kP935bS3M4ujqNuvvJD8SzCCE2geBA6YlLkTIFo1ojAYx5VbQ3T7LLF3C5zlIAnLhG9fg+Ep1YIad1JtUA/2Bf3nz+RzMLw5F+kE6L7ysEbyDNV92Phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IXlxnf7Z; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IXlxnf7Z"
Received: from github.com (hubbernetes-node-aac98ad.va3-iad.github.net [10.48.168.36])
	by smtp.github.com (Postfix) with ESMTPA id 0BF2CE1425
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755176883;
	bh=41Te1++G2EBDzA6z6AOXSbyulPn5visEU4UeMWseZ2Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IXlxnf7Z+AwGWDBYGAUxMUoXNhVlqOdumH5+mpU6AbI1OKfqKz9MQCYuQTwC8Ga9Q
	 QvcAIjlJpg7LutIhAWce+olC3MaH10JwmzC8HxF4LuAmPykTwnJlLmyU8Z1MFM83zL
	 rVIWfuKE0zEu4C58zmSFLWOxgoAlCVWy6jNUiQkA=
Date: Thu, 14 Aug 2025 06:08:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990735/2777ff-000000@github.com>
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

  Branch: refs/heads/990735
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
