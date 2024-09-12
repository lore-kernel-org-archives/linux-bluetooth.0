Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0518FDCE
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132977; cv=none; b=EKmVtk0zNniubc7k8MPZz+RAijUfrbKQZDGwY7ZUYaIJnzBTSOmMhoUeF10JbapcbSo3R2uj3GlwzmfgJO1XQjF8cITsEMtuxzBp2ee3OVkjRrJJIXr2/iWv2ghmnbgeS5B5O7nWf2y0Xdg3A/J22xMSPZRZzL5PM+WA2Ol98xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132977; c=relaxed/simple;
	bh=zAwX4201ZxUMrG3lEKWPpgbFB3DPnGDrImkNaGfL8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWI0UFb9f1Q9BsELwS1aLupkSvPEhtM9403e6BGJWXNDCZ/Ucr2Vf4Bj4jM14NtlDPmXQzkthATTGwgYRnEizs8r63PDkycQNhq6wjOVcE9ZDSTSf/phyGlODLybaaiHAa1Eryc8yrp74bPehaVujgthOsfIXYthxZe2MmNIpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BEA52000E;
	Thu, 12 Sep 2024 09:22:54 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 0/3] Fix bluetoothctl hanging if daemon isn't running
Date: Thu, 12 Sep 2024 11:20:09 +0200
Message-ID: <20240912092253.119754-1-hadess@hadess.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Our QE folks have run into this problem multiple times. The problem seems
to have existed since at least 5.56.

Bastien Nocera (3):
  shared/shell: Add bt_shell_get_timeout()
  client: Respect --timeout when bluetoothd isn't running
  shared/shell: Exit after printing the help

 client/main.c      | 21 +++++++++++++++++++--
 src/shared/shell.c |  9 ++++++---
 src/shared/shell.h |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.46.0

