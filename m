Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C0288C9D;
	Thu,  3 Jul 2025 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563125; cv=none; b=BYKFtXu7pXIxdjbT98kjASWEX8UmMXVNI3fjgXGzFvIREfrIPClh0HQTp7JoYD/euEP2E6+Yzga46Ob1X1EKIdNata2cWo903E4r0yJZjZ554D5b9sXRKm/RS+AV9Wlh4exhYIHB5dXsw/vty6aJqTNfKuu4dnjgM6am66KG0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563125; c=relaxed/simple;
	bh=0eCsvuR4bu3TjfVEuzOE91/BdXRw1oTzdIEqsx0Fu/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6RQ9oL8+uUVY82Z3vcJKE4i9T3ZUmOwqjwHXhRDllSxLX5+tptzCfq7REOWbPAOnlo2BabjORl41iu0cqSHnyVBz39OSM4va6CWOMNArp8y38t+3rYvJpfGIfZ/jIDVFEp8zYqvQjyWEHgvy8xZTzdwoREO/zSeOn64bCZ1nBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 816A4442C0;
	Thu,  3 Jul 2025 17:18:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: trivial@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bastien Nocera <hadess@hadess.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev
Subject: [PATCH v2 6/7] Bluetooth: RFCOMM: Fix typos in comments
Date: Thu,  3 Jul 2025 19:17:00 +0200
Message-ID: <20250703171815.1011001-7-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703171815.1011001-1-hadess@hadess.net>
References: <20250703171815.1011001-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehtrhhivhhirghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepmhgrthhth
 hhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-GND-Sasl: hadess@hadess.net

Found by codespell.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 net/bluetooth/rfcomm/core.c | 3 ++-
 net/bluetooth/rfcomm/tty.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 3b8f39618d65..96250807b32b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1962,7 +1962,8 @@ static void rfcomm_accept_connection(struct rfcomm_session *s)
 	int err;
 
 	/* Fast check for a new connection.
-	 * Avoids unnesesary socket allocations. */
+	 * Avoids unnecessary socket allocations.
+	 */
 	if (list_empty(&bt_sk(sock->sk)->accept_q))
 		return;
 
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 21a5b5535ebc..58d1707f7daf 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -980,7 +980,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 		baud = RFCOMM_RPN_BR_230400;
 		break;
 	default:
-		/* 9600 is standard accordinag to the RFCOMM specification */
+		/* 9600 is standard according to the RFCOMM specification */
 		baud = RFCOMM_RPN_BR_9600;
 		break;
 
-- 
2.50.0

