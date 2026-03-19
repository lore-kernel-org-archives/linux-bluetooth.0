Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0093D5226
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926859; cv=none; b=VNbCG6wKF+3jT+o/dpcqhgYeaesp3wcIdF7/wERI8A6K6UrT4v7xY7WcPaq1c9UekYZbPXSH+tIM6Rb9o/edbtk6Ay7eNMNGmze2Q8OGVWR4nvQ1+CNiC+HKZ4+jLx7IIKmk6PDcWpKJm5zGNW23jpSxoIWa79lVE9mn1B1bPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926859; c=relaxed/simple;
	bh=tSqwhEeZY1ooXEWte1jUw+Lh6Zxy/cYRZadR85cJeXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiai9K4ykUB+FHJPXqinIr5/qbJL0mxteJlGHSJIZtHREzjLO+QaBI6RrLe8RConxxd8dK3lq9UhRMp91k+3Rh7vDDeq6fmhtZ2tjirp8sDNDRwRFLdg4m1lHoce7c2F70Yh1g5OaH/qAXS6Eullr2YNJ0HGL5WYhXHU2Txat5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EF003EBF1;
	Thu, 19 Mar 2026 13:27:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ 0/1] shared/shell: Fix crash on bluetoothctl command completion
Date: Thu, 19 Mar 2026 14:25:38 +0100
Message-ID: <20260319132720.1517783-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepgffgtdekffelheekleelvedugeeijeejtefghfettdefiedttdfhueduudekjedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihhnthgvghhrrghtihhonhdqthgvshhtrdhphienucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeekgffhtddtfefguefhuddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifohhuthgvrhesgigvshigvghnrdhnlh
X-GND-State: clean

Based on report by Wouter <wouter@xesxen.nl>

Test case at:
https://github.com/hadess/bluez/blob/wip/hadess/add-meson-ell-wrap/unit/integration-test.py#L258

Bastien Nocera (1):
  shared/shell: Fix crash on bluetoothctl command completion

 src/shared/shell.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.53.0

