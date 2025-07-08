Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79B2E173D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990225; cv=none; b=bQa9th4heoEipg5H4UHPSTV/8rm9ugXyz9BnwM/60Tp1zE1YPS2k3vh5ozLVsIzz/LWDadGz2Cig20JD0A34AnBRql1OtOwBBm92GkRYI4g8ow5WlhO4QMdhygIYMmoR1ZZBtF3MUc0b49XO+mpMGB2n6QWdqssY4BQIQOtTjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990225; c=relaxed/simple;
	bh=Z8nUm1U150BFRGIR9Igq43lng/r9lHGgJ7+agCe5aR0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RpKoiGffulAMpOuoKmlrEDf9na5gHVRG72hzDTjeqkCi3YkCoHOmuWmYujrjeo9n3omGY7LOLlIR9ijHGOesQVCvW4ljD/H1R9XLmJv1Uz1spL/beNfHfw2REnbdufiL+CAj76zsNsoX59Jsrhfx3mDyoSI/8JXy5GTrv7ZLKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LfEDrsIA; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LfEDrsIA"
Received: from github.com (hubbernetes-node-3eace56.ac4-iad.github.net [10.52.172.31])
	by smtp.github.com (Postfix) with ESMTPA id C325F20A0D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751990220;
	bh=StVuwB7mpzMLACIVi8yjSDFLVBPgCKukknSkf5WdNQg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LfEDrsIAmEIw3+P6hPjCPKBVcBefLTbaMR4qOqqBUsgXuZwji9/3WBHv95mHKMpqT
	 8C+I4+SyuBlRjrPIyZd37qgOxzrA3QGCT7EvnJ5IEgUxVd52ST3qqpCLASHmhATZkT
	 GeQD2ubF2Q2nFJ5J4PaZwc79vLK36SbdqZzOoCk0=
Date: Tue, 08 Jul 2025 08:57:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979916/1c2af2-000000@github.com>
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

  Branch: refs/heads/979916
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
