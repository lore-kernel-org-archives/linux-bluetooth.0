Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566F1AB90C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088783; cv=none; b=bOwvrhuaeiBsmlwLEPoTZHoZauxLMZnNgOMYWAsvyC11jSWtmzL2M0+4G7Kl3JC2G1p3yChtgCl7tFRmPpi8BrgUWKQOtpTpvZIOJKrrIgTRM4z8vuPn+S5CdsOiz1RTBMjZ20ZXPIIkdiOzSLPgqRFfJlYvXU59f1OArR+Od1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088783; c=relaxed/simple;
	bh=ECtqWYTcAPckF0WWaeMAUT+FoPOcYaVoMlu+OHa+850=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALTP9WkOI3EoAFN33sZ/M6OPQYRVMrQEH87vIXkmUV/X8TMLFZWFpdnv0bqhuMI74t/JPvCa99b6NRYN2JiMo3sG5nzqweojz9Vq6uIgqZAfihYVWmhWLPk8fFxHWrpOWuoeSlsLdBk5pKAv7kMUV/CM7LvB1wD8leSlirNYHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 168B924000C;
	Thu,  4 Jul 2024 10:26:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 02/12] shared/shell: Free w.we_wordv on early function exit
Date: Thu,  4 Jul 2024 12:24:33 +0200
Message-ID: <20240704102617.1132337-3-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def38] [important]
bluez-5.76/src/shared/shell.c:519:2: alloc_arg: "parse_args" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:523:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
521|			"Unable to parse mandatory command arguments: %s", man );
522|		free(man);
523|->		return -EINVAL;
524|	}
525|

Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
bluez-5.76/src/shared/shell.c:539:2: alloc_arg: "parse_args" allocates memory that is stored into "w.we_wordv".
bluez-5.76/src/shared/shell.c:543:3: leaked_storage: Variable "w" going out of scope leaks the storage "w.we_wordv" points to.
541|			"Unable to parse optional command arguments: %s", opt);
542|		free(opt);
543|->		return -EINVAL;
544|	}
545|
---
 src/shared/shell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index add4fa131c7a..878be140c336 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -525,6 +525,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 		print_text(COLOR_HIGHLIGHT,
 			"Unable to parse mandatory command arguments: %s", man );
 		free(man);
+		wordfree(&w);
 		return -EINVAL;
 	}
 
@@ -545,6 +546,7 @@ optional:
 		print_text(COLOR_HIGHLIGHT,
 			"Unable to parse optional command arguments: %s", opt);
 		free(opt);
+		wordfree(&w);
 		return -EINVAL;
 	}
 
-- 
2.45.2

