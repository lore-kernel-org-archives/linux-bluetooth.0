Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23953F0740
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191760; cv=none; b=oQS7a++okhTdAV/apdsNDBQvd58w3wrSN3e3WoIGUwsfyceL/7ufvzMxhLhGfF55KaLnlAyUBcVLkn+OYANdgGZXH/llKnw7LBQRLeFnQr5mOC6G+z17J8GvCgVJCkX3tMHSC0b18yC05wWJazuYVsVJd9wZejyiJnJRVhcZvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191760; c=relaxed/simple;
	bh=bZaQVesixtq/CTMrEzvq6vsc3bIQETTijlja2hroLIY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+vynq4dpPVDnUwvJRbE82hRk1wnmxaVSq2R8UCTam70RjAoMObCY+BRt7WRs21p2Y43zK/rOzLLOhHl255dNqEiByJChwByQnNRPxedLjJNjtiXwrOEmMitswr0ldo6v3JFNU4PTBBC8qgDThOHXDMzjTNiw18DF3uErMmUi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F6E643283
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:29:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] Revert "shared/shell: Don't init input for non-interactive shells"
Date: Fri, 27 Feb 2026 12:27:17 +0100
Message-ID: <20260227112900.1946851-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227112900.1946851-1-hadess@hadess.net>
References: <20260227112900.1946851-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedttdejfeeikedvhfelledtgffhhfdvleffhffhueffieeuhfffgfevveekteetfeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgefhiefgieegfedvkeefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean

This reverts commit e73bf582dae60356641a32fc27ae03d359ec4c47.

The fix caused "bluetoothctl list" to not output any text, breaking
a lot of existing scripts.

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2440346
---
 src/shared/shell.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 78d58c513d3e..b061f8001414 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1642,13 +1642,13 @@ static bool shell_quit(void *data)
 
 bool bt_shell_attach(int fd)
 {
-	if (data.mode == MODE_INTERACTIVE) {
-		struct input *input;
+	struct input *input;
 
-		input = input_new(fd);
-		if (!input)
-			return false;
+	input = input_new(fd);
+	if (!input)
+		return false;
 
+	if (data.mode == MODE_INTERACTIVE) {
 		io_set_read_handler(input->io, input_read, input, NULL);
 		io_set_disconnect_handler(input->io, input_hup, input, NULL);
 
-- 
2.53.0

