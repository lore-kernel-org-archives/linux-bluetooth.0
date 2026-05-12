Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF938333C
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613878; cv=none; b=CHxAqEXla+tAISsE6Y2Ji22gB33pAWIJgKWT7LVnf5VF/EIRIRiFP/UPHrOa8Ok+ner0gNrL1uFm5tZFBsFEXcCviusK5xHOcnhfXKKN9+qB7Ni91u8sq5fBiTXH7MgMNi4+UCCwO0FaGBoBn8gAm5b1VBQu6s6imCWlGnQlI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613878; c=relaxed/simple;
	bh=kk2ASwceEOQMdFo3swxY2GltsdBQOFJQPc/CR7qVETo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ab0kKlB7fR18Ud74DL0k9m/qzIR0g8HFqfCt+iHTY2so3MLZ+Hma0/tmyYh08IgKWN7HUw0MpVkDdJ8uDyoOkP3shR1tl4ZjuVeVzfIMtBmbCQNru5s7QXc9Sw6vez3kVxvblK98sEMIgfTsLizjHlmsLtcEk8DiaIsHucxBycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RdsQ1jsh; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RdsQ1jsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778613876;
	bh=NCNfPGC/Bsq/Mm1kidajlhMmiqyA+3lGO3ZBMq6dsbo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RdsQ1jshuJNCrCxVWBE0uffUHE8YtlucbqEuJI3gbUVXW0ppn2bZuO8whNWDl8e0l
	 DhQLzNK+UCM3uIdz7cIW2RCOU5Nk0YUgW+WBIFyjrV4S3vK0EfEjQX25vpcAntLGUC
	 +PAW0FXc/DIpApkVPkBGlsqJJOgAM+7Aeax3q9yc=
Received: from github.com (hubbernetes-node-3d8ce78.ash1-iad.github.net [10.56.207.29])
	by smtp.github.com (Postfix) with ESMTPA id 6AE4A920C7E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 12:24:36 -0700 (PDT)
Date: Tue, 12 May 2026 12:24:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093372/88b4a6-000000@github.com>
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

  Branch: refs/heads/1093372
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
