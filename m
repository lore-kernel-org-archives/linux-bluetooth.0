Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654B4418E6
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993070; cv=none; b=TuxGFngK1hU59QUTimOMW6Bg1hjkP2iF0tXdBKmymEppNlR6P3xc/4HbR7P13Czr82eWNKwDUZs9qHfEsOdE0jh8OCBfPzLYbnrJq/aa2G1JRW0hARzOL6dQZzVuMCWg+hb7ARNihm98BI/opXRjLV5dPsG50qw/cdxLyhmgKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993070; c=relaxed/simple;
	bh=TDnoHUeTmp/TjrTdqiKdWbIGgtIRakvdhmzo7viGBGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M13X1RKn3mldZTjMvIc/Y6gyc1WoXNwPz+3TQjs+wDytPdKeGCtN7VOuH72yFXuOO6xJUTiIwyYZa/97Y7iAz8NbTRdSbV58HcbhqTjZR2JxL6ST+OU6+tTcnuWaGT1ub6pS2e8yWUXaZiGO6kFWtGdhyvnY6D9dz84idgzjijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8C9C3EC8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 21:37:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] emulator: Remove compile-time header only glib dep
Date: Tue, 31 Mar 2026 23:36:37 +0200
Message-ID: <20260331213731.3895736-3-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331213731.3895736-1-hadess@hadess.net>
References: <20260331213731.3895736-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFenMGUDv51xu6ewYXD7nvHPpBm9uS1zDGxGmHkEOomvN3TyrraH3NvRH2hcTR7XOKE0Xnp3txmsHjP/3Zo+c0CqLbAiWgpq3+TL/VrrbnsQfHmj5TMr61yHkskIYPmltcVfiGItDma0KmHSsXfBjI0Cn359uTdey9fyXqRfqTxcYJvdNAm4zrPgAGdRac1XNTDBssCwfAYhhTAVAJE2xtEn3pJZGxQJSa0hhjEJCnGaI69dtSLpMuMQch1zdI7vGOXhb3Ooi6qif0i3+m5qcj2mEg8JnQMniDqGbwCWNRSBAScmqmzJov84Y6yjs4cUnB/qmQ644HiO8PGtblbUB55Uct+IJmvlZplOEKDaI3bjtdU5XcdrmOH0Sqa/W7/zh84Ma8Gka6lInMMEPhuBQ3+EPwRPBRroukeiqUsNTACyi/17jWP12Y4xxBPwpOVoumXAAjjYkxS7RXE0olQuDGUp7pw6K+5KrrQM60JJXGet86WObHnAJgMRfv4qJ8FSIKsRiRCJb2JYQ/oicUh4sFauAX4HJLgyI8kWMjC9wsaHR9PZGtTyLa9WpzYZBeJt2rMs5XZpfzN77732J9hml9xSU5MM1iNCMHAxNMrsV6ySG2T04Ap7oLkcWI4mmsvPv/E1o88dW6PYuhgQnDUvzPX/nQ1LkPTrO81K/cUrokpsQ
X-GND-State: clean
X-GND-Score: 0

btvirt relied on a glib header macro to use MIN/MAX, but didn't link
against it, meaning that it was dependent on other programs in the
project using glib to compile correctly.

Remove the include and use our own implementation instead.
---
 emulator/btdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d3a9c6735ff1..3a295b679f34 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -25,8 +25,6 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#include <glib.h>
-
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
 
-- 
2.53.0

