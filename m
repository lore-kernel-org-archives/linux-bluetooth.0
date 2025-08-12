Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3001DE2D7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021572; cv=none; b=cuvv2TAYwQnd0ycjoprQGSOwzIi4XQeMkjd8h1U0SrjXgHPtrx3XghXnAA1Ion3R3cn9uXvZS05aq+7WFK8elt94GYkg4suvr7g/li4wpuYy64OWvStzzu1hrhu8rdZ1m53K2nEKEmA5VMJJiGAeYCpe3gPxx8sKyRCIhRLuUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021572; c=relaxed/simple;
	bh=OhtYZnVWa2yrSdNqrc8SbdxnZ8JyueocAQ3T6OUhZtw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GGm/+NlJG/Odyz2xie5+2jOY335p2i94IxNgbnwACMsDu19EY3U/YEsJ4dhcG9xpLlmWS2fARotoJgzDUa1JtC2VI/2Z2ej4t3RiCZR/mkl4jNuijN2SSaj8xXW0hbFqV9PUtkx+yyqYKeKPH97VFDuXl0fJJFmdGNOl06tiSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yd2hBhdf; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yd2hBhdf"
Received: from github.com (hubbernetes-node-7e90b62.ac4-iad.github.net [10.52.167.34])
	by smtp.github.com (Postfix) with ESMTPA id C46BA700B31
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755021569;
	bh=x1tsmA5dOC7rRzmfsBBR50ihVNU60+2qZBPxMJx2qLI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yd2hBhdfe3FNi3POagfrheCknzaceRsi66y/MvcHjTFXL57jnL4KRQV9h4ugobY0x
	 GC4SWAXUbvd02HYzOl1UR/pt3OnTOzK0eQHzWLKB3lZ6mh9UQ0Bh9aZiJIKuRb0YeI
	 QRS5Gai4tjdEAO+Oz+4ghD/omjvWt2I07lR4Fb/0=
Date: Tue, 12 Aug 2025 10:59:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981848/e0bf89-000000@github.com>
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

  Branch: refs/heads/981848
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
