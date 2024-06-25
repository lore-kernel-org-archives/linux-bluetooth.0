Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934C156646
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319949; cv=none; b=iniYcR7bHhWF12bh6vzzdE+hdO4avsK13I6L9CF1z0zO7miNTWfLY/8Ex50Jm4OnO9qqEe0gIc3mLm3b+jBaVTWqm+mHqp+ESkPwU9RUewpaKR5b85L3clVFxCxRKl7O8xiG+S3QUzA5seBlGRgJIOTsHr7D/BaKYVvkU+EAJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319949; c=relaxed/simple;
	bh=GDNjbSjT8bGx6O5Nc74+6BXMdGllq0AXtkRO9rpaFXQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SeVDmCFZ3FhiTa/Ph5cr1FgbcDflWMUhHZo1U90YlDWrnuQQL3F88sP2NyEgorGS0SyENNmghKn2gS27bewXDxwnyKGHgaEWAiPuljDelGEN0tQhgMwSE7ifti6W8Lg+wrY+PSwSbdhD94ptN/GldoiKo3YqGWzXJWkPLfaBR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J3+o4bij; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J3+o4bij"
Received: from github.com (hubbernetes-node-5a2bf5c.ash1-iad.github.net [10.56.128.54])
	by smtp.github.com (Postfix) with ESMTPA id CECB1601280
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719319947;
	bh=QNm7tOw2+F23NO0eivK75xbVXgBRGy1B3DLTyWPJ8fo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J3+o4bijuxoXFIkmHEvWphsKOtmcx+m3ZutP+Nl3nzuBt54U4W3u4DvBMl9TKONFX
	 4o9F9F7/GpV/N+kHJ9CNYO7F6ex6EQscz7+qqPj/a0A4iTIuEuc1D19XruxERSkB3S
	 PSwidurTZ8x6pEfdNe2pkr/ZuGpscHrzljbEDwqc=
Date: Tue, 25 Jun 2024 05:52:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2bd25c-5ebaea@github.com>
Subject: [bluez/bluez] 5ebaea: hog-lib: Fix passing wrong parameters to
 bt_uhid_g...
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
  Commit: 5ebaeab4164f80539904b9a520d9b7a8307e06e2
      https://github.com/bluez/bluez/commit/5ebaeab4164f80539904b9a520d9b7a8307e06e2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-24 (Mon, 24 Jun 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix passing wrong parameters to bt_uhid_get_report_reply

The parameters of bt_uhid_get_report_reply are number followed by
status, not status followed by number, so the order needs to be
swapped.

Fixes: https://github.com/bluez/bluez/issues/880



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
