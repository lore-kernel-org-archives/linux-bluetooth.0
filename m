Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EF493650
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341812; cv=none; b=A8JH9PVI5t2dhKLU5AKMT3Hkv8LlmpFkcl4ey5RWa/6lhE0GMM4FoV9xVHAHKc8ZtLGBu198lWl6rhj2xJwlWYxe7e89YRFA27m6y7p2KsyWqu0Oamh6I8vg3Hns0wuur4kXWSJN9tZta8HZLTeCqzzA/p28sbsMh4FWXP5M6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341812; c=relaxed/simple;
	bh=P5UISf4xRSbixnk9xRV1cNKNuEaf0UQMoI3TrlQeoAQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d9jr7fIrEVLbd6NO/ss3/ArGiYepnCD/3iDqv8EKTr65vRqs/CZSeOsk/QcAUuoToNyB7Y12hJxQ37GVbRH4WqDpRB2a/bNWBjhiQUBK0eDsCBA3OTBl9wRJET1FBSiZ7rQAUKrJdPM6iMf/XAkZkk32eMneHWd2uJdeJ5uthyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BZ7QRv8d; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BZ7QRv8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787341804;
	bh=OMeimlcZ72ogWwpMBQwm2AJ6bqs3Tem1g+MQ5KF9NDg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BZ7QRv8dNZEbceJh+0C9BSwT8QDouaasupX+Wi6lGDNzVjtU+BeKhJuWbKL+EzdWN
	 qiRH9t0JAHOEXgg8StY/2nQbJpgPj44/YFJ7AtDyLbQ+ZGVpT/0r67nWSr8G4gj5om
	 yvAUFxK+ihtdOcandKl8ooyUqH+9r8iJTn8ZZA44=
Received: from github.com (hubbernetes-node-3585099.va3-iad.github.net [10.48.70.72])
	by smtp.github.com (Postfix) with ESMTPA id 52B4680113D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 12:50:04 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:50:04 -0700
From: George Kiagiadakis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149989/000000-af6975@github.com>
Subject: [bluez/bluez] af6975: build: Ignore the test-sdp-xml binary
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

  Branch: refs/heads/1149989
  Home:   https://github.com/bluez/bluez
  Commit: af69758f587714a80678d8ed27d735fc2e11586c
      https://github.com/bluez/bluez/commit/af69758f587714a80678d8ed27d735fc2e11586c
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Ignore the test-sdp-xml binary

unit/test-sdp-xml has been built by make check ever since the test was
added, but was never added to .gitignore, so it shows up as untracked.

Fixes: e55ff8818f72 ("unit: Add test for sdp_xml_parse_record()")

Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
