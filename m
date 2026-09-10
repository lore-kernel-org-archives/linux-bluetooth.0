Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DE38E11A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065866; cv=none; b=iNcWfOIXHmDi1G57tm0V4Dq+Qg01PePscghGNblsPPmIu50n1TFG5cRrOYQP6x2Rj5npJpBsEyAXvNtnGNdahdlVR3DaJe8CWGqE6jHw3YAg87LgghsKXhuxqZzGYunVQhk85N75KNM2zkxIiPA0if/hnd9ajXQjwEr7P229pVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065866; c=relaxed/simple;
	bh=5OD2nBW9Kq+Pei6/f8JaK82yoRMZE/SjKEZRutY7XgU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g+uO/LgQ5RGJcAWo802tA2or8V0oLu2tU8/2qGDY9ilsb9xe5/Wf5Q1g1ECrVBrmOrwJ8cMJTFEa3zFJUZ/bx85uwsL/mRWLzibz3qsi+j9Kl4InodGArs97Z+xqa6ERa+Jcrsegy9d/7s7RiWgSw3x+bYYBsL/kiL2YWj+s6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PnmshBUW; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PnmshBUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065863;
	bh=Hu9IuX7ty+ObgaC3YJzjW/KTMXzFHau97YARo5F7WLY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PnmshBUWZOS87zKd4GbIiD32Ot6B2qGX9569BVhzqClI7cbnBTAnqoGjsJByPzSxh
	 ftT/4MGWQ3NxpyCweuj6kDgQ4F1fW9sq8Jr8lJaBI5fI4wKytuo4zA3xau4BCi0eEP
	 fd5RFVvcfLVvWKIR3iTXSg6cYBA6xW7poaGm7DCY=
Received: from github.com (hubbernetes-node-adcadab.va3-iad.github.net [10.48.67.86])
	by smtp.github.com (Postfix) with ESMTPA id CE4E4180A5B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:23 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1160712/b28861-000000@github.com>
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

  Branch: refs/heads/1160712
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
