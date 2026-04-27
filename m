Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB9256C8B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290339; cv=none; b=NImcB84X8EZ2kHmidxY+aDnQfVkteY32aG4Rc2+gU6s5O1W2mV7tgEwtvC8diPYxdPJL7GsqKMSYsVC4xWc3T/snGkdFNFxZMiUAkdPViI0LqmFHlnmcyqMZgRUp5aJveGgFQ1Wl6v5JFzxIefHodF1Jz468LNefmHIW3XdbU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290339; c=relaxed/simple;
	bh=NvUYyxAKJDvGeZfkOGtmvJ3qYm6hA9w1PrYDtQFoYao=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j8+QlfJVlnuJzxaPLIs1xE+wnVqNsDAvWEJerXBo7Le8RYB0rYwPkKubveH0ko3xRGhNYa2N5esSMwJ90qxZPWirb+q3iqA7LvMZ7ZywTT2aqPUAcaLNp52YLf9YPe56CUEPFDkDiOBepT8LMe8SDwyijCnweyXlml14hoItVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TNp2kqy1; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TNp2kqy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777290337;
	bh=wV/GLDhwZE1UQxSkRejn5VAB6mQcR1aZfnyjG0V8E6k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TNp2kqy14MOcLYRZ8wv0M/n5kmYJVUuBQWYzqaS+kH5/QF87F3TKGUrO4zEC/0MW5
	 Qzes+DYAAx/5Ol/0fhPnDxbdZwz2vNV/kl4g9mviL5eForPfze/YsTNPqEflST0YPR
	 w366zR1NbgicwNFAYGrohmuouPpnfkbONTe0Wvhc=
Received: from github.com (hubbernetes-node-1d657d5.ash1-iad.github.net [10.56.130.30])
	by smtp.github.com (Postfix) with ESMTPA id 24CC384103E
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 04:45:37 -0700 (PDT)
Date: Mon, 27 Apr 2026 04:45:37 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086088/000000-dc62cb@github.com>
Subject: [bluez/bluez] f862ae: Add RAS packet formatting and notification
 support...
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

  Branch: refs/heads/1086088
  Home:   https://github.com/bluez/bluez
  Commit: f862ae559fc39fc8d83cf7b0e44f134fbfd14309
      https://github.com/bluez/bluez/commit/f862ae559fc39fc8d83cf7b0e44f134fbfd14309
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  Add RAS packet formatting and notification support for CS reflector

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: dc62cb919f83f3929aab189a0332e0dc8d4de9c5
      https://github.com/bluez/bluez/commit/dc62cb919f83f3929aab189a0332e0dc8d4de9c5
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members as per spec

Rearrage reading of cs_mode_one_data struct members as per spec.


Compare: https://github.com/bluez/bluez/compare/f862ae559fc3%5E...dc62cb919f83

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
