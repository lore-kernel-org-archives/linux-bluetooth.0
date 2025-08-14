Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268430AAD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192761; cv=none; b=npEBa/+FGXudsobaQ1hapA12k1Z1H12b6zTbaYyLP51QRhbJuO/FUdTh4hvKDxpVHrM7ZWgoDLSVow+Tr7DQGQWY68/FvXwZIxY0RGN62fTU6sP3zio57X4OZWe6noum/dcEDJEaQkiJjhqPsLdCX56IUHryIjDopDjyrOh1GT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192761; c=relaxed/simple;
	bh=c7xNgfF3xBCJyEnmd+J/YpND8JJnbP4W2RVu2I/yO+Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kbZKJbo8HgL0KDY/vFJx9xoKoXEwTuH8PVxRi/JFLudb3CdL/Xy3Qb/lacnhBWhAx+A+6AoBh1VnwbxRfIH5tf7nZfrRkrjvDCmuBdazZ0Eb+MQ2RsGAIyqzy1LnxtUmturEvRL1NNTiLgPC4ioL9HJSkJPq0fPh6g9t+BfGLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fBf2VEit; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fBf2VEit"
Received: from github.com (hubbernetes-node-aba0b77.ash1-iad.github.net [10.56.180.42])
	by smtp.github.com (Postfix) with ESMTPA id 304AD9203D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755192759;
	bh=k6acz1Ihlnhq5ociaXim7D5rTXAx7ja4aw5tr1ZpmfY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fBf2VEit1DfhsAa+n2MYFbvSOskFmDC/Jr4b1mDuiMJYQ2wttukADf4yPa25Cn5ng
	 DJkWy/7UsId8AAu/H2nG7g00Z1DGlv2W1N9LzJYViLCbpkvP8nOM7nnTLvbnavrTn0
	 t3Sg+awg7vh+nEjE0cfdEmThyNmwqFxP9JHe3F20=
Date: Thu, 14 Aug 2025 10:32:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/991602/085492-000000@github.com>
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

  Branch: refs/heads/991602
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
