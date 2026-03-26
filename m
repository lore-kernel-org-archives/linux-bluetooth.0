Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA21B4156
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550487; cv=none; b=RiOvZCRjsykCa7Qrw3SQyi3EwWfNuZJoEs/j8sxwZM4ytIOe04fEwsl8KxLnoNvbK+s6trC731fAFpYq8PyzD0dh1414OMYNvtCe4kOGuaakXOvpHLc64rD3aZEHW1g//IEcuFFd4bLWK194qivKEwKN1VY8cROe5evYaVnASug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550487; c=relaxed/simple;
	bh=T+kl69zpIJpbbPZZUZFGkz+xRGsgI7eEtEiFwS0yVKg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kRHXZ/KryhhzXcJzebgN7VjGXN18MqJl2fRqxIKB8GkGOv3kEa4k1evDzBW1K2kaCdCF/qjVBVG3fIfyBEi/Wk5dFhym6GaWL0caF4RazofO4g/zzOrplmS6QF90oaWYNC4xn2yydyXSffHXmz8+KJ+GgAyYxwmHosWcGkfW4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VzWR/qyG; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VzWR/qyG"
Received: from github.com (hubbernetes-node-ca0a085.ac4-iad.github.net [10.52.154.31])
	by smtp.github.com (Postfix) with ESMTPA id 8C197202C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774550485;
	bh=IVt2nrsaCYLL0oDJTdDvlIv26obBBQrhyVjRI318NbM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VzWR/qyGSkZdAOFfm24BUaYMQXiGBHjZrqHn9Ftu7ah5rLqMeI9r2XYFgdLoQ2HLi
	 l5XRQXyEEktK4bvvu0TuwnQn45siehDK4rgCIXWOi5YCny7CiPF0JP4ttS3NlmSuqn
	 CM+t1/HIhMDgXd+56fNQ54ElD2172X+4A71wWsaQ=
Date: Thu, 26 Mar 2026 11:41:25 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/097196-0d4bb4@github.com>
Subject: [bluez/bluez] 0d4bb4: mesh-gatt: Fix JSON files missing from dist
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 0d4bb44219522a42a8a7daf94225c0d6ed9237b1
      https://github.com/bluez/bluez/commit/0d4bb44219522a42a8a7daf94225c0d6ed9237b1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-26 (Thu, 26 Mar 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  mesh-gatt: Fix JSON files missing from dist

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
