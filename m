Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E65125A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578448; cv=none; b=nMeXVZaCPAb60uJAzulYb76r8b3sk7GWnLefc30ZcMRGpG1TT6xJuUVczD5F1g3Soyj6G51gSKIf9qSUuh3QvQ3LyDI74S3U9lp0g0amxzXyq9J0Ahcj1FB2jjzAMzV4N7qJg4N1TGfxZkeFIRHGg0s0w4a8+He1XPlAHOzFvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578448; c=relaxed/simple;
	bh=BZdXqmjjt1282h1m28zqk8wy1agZW5M90h7wq+WcVjY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oK9L4LcANQySOWK+owZrk9lZwDDjLCbFUYLo0Cwnk+NZ/sU1+q36M0JJIOqSOvgoAxsNIPVT9pJAQ3RO+6AWkirJs1MUKkh9eKULgng1+pc2B5yrDM4kLENXK146DREh8XEhG785kTKU7u9dDhMhh+3I56X+6fyt4ppMrVtXmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fv/mUj0E; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fv/mUj0E"
Received: from github.com (hubbernetes-node-4cba89e.ac4-iad.github.net [10.52.207.83])
	by smtp.github.com (Postfix) with ESMTPA id A62132139E
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761578445;
	bh=YxUSYPwVX6R2Kb9bzKu6kmdDP6IyuXqNguKTWjQaaC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fv/mUj0EFVVvLE1L3WL/F3uWh44uwiXvG8thCa2MEGO2GWDJ/MeK95Q9OZbMP5O8u
	 o8Q9uH8s/+Yvi3ZwWnvXjgucyl3jyLpkLgz6TX4JkeY6zM+x0sG8tszHnKXgrFdXbw
	 EQQ99OKzU1c8jSBbj5FNWioyT0gd+4uFWMJiJIUI=
Date: Mon, 27 Oct 2025 08:20:45 -0700
From: RSmirnov512 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1016339/000000-27acde@github.com>
Subject: [bluez/bluez] 27acde: battery: improve the display of the charge
 level
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

  Branch: refs/heads/1016339
  Home:   https://github.com/bluez/bluez
  Commit: 27acde77a800c318d8545b4623d0547f5c3d0b3d
      https://github.com/bluez/bluez/commit/27acde77a800c318d8545b4623d0547f5c3d0b3d
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-10-27 (Mon, 27 Oct 2025)

  Changed paths:
    M src/battery.c

  Log Message:
  -----------
  battery: improve the display of the charge level

The battery charge level may fluctuate due to uncalibrated
sensors. Commit smooths out such fluctuations.

The algorithm for determining uncalibrated sensors consists of
finding the number of changes in charge direction (i.e., "spikes").
If the number of spikes is zero, the device is charging or discharging.
If there is one spike, it may mean that the device has started charging
or has been disconnected from charging. If there are two or more
spikes, this is a clear indication of an uncalibrated sensor.

Check that the battery charge is fluctuating. If the battery charge
is fluctuating, use the average charge value, otherwise use the current
value.

Fixes: https://github.com/bluez/bluez/issues/1612



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
