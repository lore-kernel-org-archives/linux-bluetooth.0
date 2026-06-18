Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E4392C21
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779898; cv=none; b=V1ft/xD2tDSerTK92HE9v99HmJbHTZooVCbgWqxAqi8UZhb88fuLl5zM3v8FlaeFF9ibtiuuInjAe0V5CRvzjHuGWLNYVThzYSuPWByE4K+gOdMXSFmJKqhgrnvdk1KpNuquV699Id5DYMOunFL5BHiehn/x23xJOi+mQoqyLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779898; c=relaxed/simple;
	bh=eyvSmXGQSJtucPXR3l3JPdY24HbSzRoyaN/7QNSvXKs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pX6ENC7L1acD2EJLDWQ5Hfbd05p0WiyF6ciz/1KayJqZWWMOybxnEMqFf1ip6bWEdwGePkyyVHlnecxtScZn85DJOIywj67Iqk/PMmzMHbz3hlYTXwEKTmKsS6AXy2Xt5WUQTwWXl0dfxv5hDHZdB6d2zahvUkuEiEdSZUjKAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h33zX+tq; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h33zX+tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781779896;
	bh=xViKkGLVSTqinaC23nyy331bzMTk+g1tfcXrFpv0zUk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h33zX+tqZxre6KcalimzARECKHtqsmPUeTQDK6quVOwZAWh3MsngqSBStCcj/IYhm
	 ojGntpRFG2WhOWwdKq9fdvWNoxnnc2nQl4bw9DfFGh/TOFfUoxHlHfxybruehFz+2x
	 4c1yAIixQkrljLpdntw6dzIh6u94K0JmI8g5OCz8=
Received: from github.com (hubbernetes-node-d140f91.ac4-iad.github.net [10.52.82.33])
	by smtp.github.com (Postfix) with ESMTPA id 2EE6FA01E5
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:51:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 03:51:36 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1113283/000000-14e39d@github.com>
Subject: [bluez/bluez] 14e39d: shared/rap: Fix Mode 0 step serialization
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

  Branch: refs/heads/1113283
  Home:   https://github.com/bluez/bluez
  Commit: 14e39d635f2c1d426c7abe8b8d423d5b2efe1db8
      https://github.com/bluez/bluez/commit/14e39d635f2c1d426c7abe8b8d423d5b2efe1db8
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-18 (Thu, 18 Jun 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Fix Mode 0 step serialization

Replace raw struct byte dump with field-by-field serialization
that conditionally includes init_measured_freq_offset only for
the Initiator role, matching the RAS wire format (5 bytes for
Initiator, 3 bytes for Reflector)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
