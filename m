Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45062E229F
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788015554; cv=none; b=PQItZ+39uEC3MAldwtmn/ZZCL5D5zAfcPGEriAKDjD2/OwieZLl+6xFwHVTTRvstiVfqFS5vRbrgpgQt+y1o0c9J2Yys5ANTr5DggsPqwABmINuLLUtOOxMFcL670Vx/JPOUtyPeU5ERajC0fD2hX3ha5q81i7CWLViku2zBSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788015554; c=relaxed/simple;
	bh=wUfvdAWAAYnfbOagvFDweQsROzPOE2QOF9+3/Tljlng=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=resEbfHLADbCOg8+U7oR5VbwBueJheYQte+wELFDy1JuOYALgQGtUV9MOZhDqyuzEMOppI1t2o+dTZxud4KFPVqBhhycBtPrXsnvI9hLfdt0CT/0wEN/Boa+N1RKHlRE+rf8nDc22VpIviJpqVuW/Ig34s8SqPPVHTgm2gomuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PkvTIV/P; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PkvTIV/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788015551;
	bh=m2cT1p9a03sJR0GwM1CqFN7p5BP+9JRVXxvsjfNlh/w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PkvTIV/P9vUjyc7zcmowoGZczEvLjwKqOkCAHa+Y1gO039CWV4QkWLyDorgqunR5X
	 tz3IiEBFDdmo8iwKU7yXukXO8LAMvN56exr3QN6OSbxv3VFlFZBAVVZrL4pNJ84A2o
	 tyvgJmfFZxyjuzfXfsSqzYiXppimKd3sLgaXJ1P8=
Received: from github.com (hubbernetes-node-8e7611f.ac4-iad.github.net [10.55.93.39])
	by smtp.github.com (Postfix) with ESMTPA id C1524780AA2
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 07:59:11 -0700 (PDT)
Date: Sat, 29 Aug 2026 07:59:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137365/8ac88e-000000@github.com>
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

  Branch: refs/heads/1137365
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
