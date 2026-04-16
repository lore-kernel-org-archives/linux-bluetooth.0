Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4312D21B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354758; cv=none; b=D+MkczAtyZV610J3VfNRrRIjz2aaKn8l9oMek28qNTkQ3KFscnAkH6owzBTf+eLsw2ifJvOCxXGTogylxiki8VuPC2TZS1nsNKvFn8mLPQorhAMS/ePsESQMDy3UPcxnzW+GSkUZ2UkaTGtQnEAQ3lvuVfPqD17DQWs/4rCi5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354758; c=relaxed/simple;
	bh=pDjlnVFM5wuVyaYqBv3rFepblwCyuV5RmRFxT83oZFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p1bx3svCRdcQkToNC5aH7t4v2R6GlNNBREJSPodV5ThyE+Jg3bRRuLtMCSRZrVFV9ho48wa+mS/AARWPTwwT6Jn4FLM1HsuH3y1VZ7/m778tr5oXJBI48jMiR1y3OmCGz4/Yu/vVcNpC94eMQu51+nKifkfSh9TYhnTnpJbQR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ijg5SEQP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ijg5SEQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776354757;
	bh=3aLPgF20EjNGhwcWhTjinWTAHDRthaMpmA+WuojGhNA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ijg5SEQPqmfLCxahSfS6GR9NAOxaF2kE8zxvNDWkHg4B3OtmB6kCPU7Q4BGlNm20J
	 oEGNh+2aR4JKvsjKpyxuaSK/8AIkJaBLz0kGugGNJFec5c+LBf3BjRcGpRsQUFkzqM
	 wl13VMPOcaTfDF9ODZFsvwWSzoIdBeSOpRtHV2dE=
Received: from github.com (hubbernetes-node-536360a.ac4-iad.github.net [10.52.205.69])
	by smtp.github.com (Postfix) with ESMTPA id 13E76A1157
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:52:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:52:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068070/d222a9-000000@github.com>
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

  Branch: refs/heads/1068070
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
