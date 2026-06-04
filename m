Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73674403123
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572306; cv=none; b=LXwuxIYJnjkZeDKbCbD5h6yde5f3+SNHD25VOP5UzlGEVZeOM6EHu13YbaLmUU+ZQnarCT7yZrPivc6Ch5kkdtU9wbpQ54MbqJx040PFAEV1Wjc2ilQOMAiMo6XsqvP++aodN3/7LNrEw8046tYzyZ7YJf26DqBEjx2DjoRgFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572306; c=relaxed/simple;
	bh=nNSOFosAJPbV3AMD5UmG567338OEh7AseQa/gmIEdCs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=vA3Qv9wfOxaS5X/4YhOi81E7fnNKqciEiCUOnkvwxvugCvyBOkdiJg29LngqWQ5qLYWEzx7avUc0WGF5CRJa9gUUDvqtN5VE2j0w2K8kNg5afTolHzgQ5qqo4slyMLx7ndzpXGRofgXO23EqXIHrqz3llxz7jiz70/oEHY2/3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cOBtVHm7; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cOBtVHm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572304;
	bh=Yua6BFlJUrre45IxDz16lMZyzNSXxFckIwjFFwhmhqg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cOBtVHm7BuiL9oPlgfkzdsA6X/ZvZXeCSKFLx9I0U3EK0IBoOCMtEcli4ClsJjh2D
	 TazpxuzuvJURK+3l1ZGtTdTJqsLd+l5jC75NFSa6hLjdx/d9e8Ay2KlmUt/VBgg/z0
	 W7bn7TnZytX6kQ4u0eTr6YIJir4N1PNGTCHU2yHQ=
Received: from github.com (hubbernetes-node-7db4f4f.ac4-iad.github.net [10.52.142.16])
	by smtp.github.com (Postfix) with ESMTPA id B7126A024D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:25:04 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:25:04 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105853/000000-db3304@github.com>
Subject: [bluez/bluez] db3304: profiles/ranging: Read measured_freq_offset
 field-...
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

  Branch: refs/heads/1105853
  Home:   https://github.com/bluez/bluez
  Commit: db3304369a708b9189777e2ad89026a3d384e010
      https://github.com/bluez/bluez/commit/db3304369a708b9189777e2ad89026a3d384e010
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec

Fix in V2:
Fixed compilation issue.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
