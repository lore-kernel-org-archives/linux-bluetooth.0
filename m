Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC91ACECE
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747658; cv=none; b=UEqpIWz6nAvnVdyzHnLqAlqMQMYg3Pyr7/fV3Bn+hXCFlntFOpJ9ZGl5foKQbVTBlRsK8jiTohy+9+KidpOUnKBReiOv+uzWPcJfEHSYpn0pQ04kS9zh5UoeuL3PpEpeVZrOERcOC7qqYZGECPEnj1i9l/ad+YI+caAVLKMGc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747658; c=relaxed/simple;
	bh=D36PsCXleWazhHyYKxneEcKcbwQatHMRcr2rdQmzupY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atOnFzC+FSZvQQlF82YcySJdWr1CtvIR6wAFp0S/L9L3OfzszWcbGU78k2gP6D8kkuT3hxT79TItFaQFC5dC8WnUSdg0Q0OgsggXW7CiCbj7DeWbEfkxEFEokYsk1LZhnZpRdh5bWhGErAt9nHI8WEWYA/nxKxcTXOLlfK1CrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66C3B43990;
	Tue, 20 May 2025 13:27:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v3 2/4] client: Print a human readable error message
Date: Tue, 20 May 2025 15:26:34 +0200
Message-ID: <20250520132733.1746996-2-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520132733.1746996-1-hadess@hadess.net>
References: <20250520132733.1746996-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevtefhleevjeffteekleehheeujeelhfdvheethefggefhkefgvdefhfegkeeiteenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdrrddpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght
X-GND-Sasl: hadess@hadess.net

When the D-Bus error message string contains an encoded error code and
user-readable message, parse this message to only show the user-readable
message.
---
 client/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 5d53a7be11e4..122d975a08da 100644
--- a/client/main.c
+++ b/client/main.c
@@ -30,6 +30,7 @@
 #include "gdbus/gdbus.h"
 #include "print.h"
 #include "agent.h"
+#include "error-parse.h"
 #include "gatt.h"
 #include "advertising.h"
 #include "adv_monitor.h"
@@ -2013,8 +2014,9 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	g_free(data);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		bt_shell_printf("Failed to connect: %s %s\n", error.name,
-				error.message);
+		const char *msg = detailed_error_parse(error.message, NULL);
+		bt_shell_printf("Failed to connect: %s: %s\n", error.name,
+				msg);
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-- 
2.49.0

