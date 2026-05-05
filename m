Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3C313534
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971479; cv=none; b=KWah//7cM/3EXWlPkMQgZRX8iYdAc8H9ajhRtdrLZnIbLPYlEpfPgH3gdZXZNF1pbjcvBEj3yiLtlcdqaKZRhazG0PU4ql0lsCZwWncJSaGEmfPRD/v64skl2/uzxVLZ+RBF3hFmpwUsUjHgeONvqaG1hzDDzalTCbLWNLOcc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971479; c=relaxed/simple;
	bh=hgCJjDmFJ46K0Wts4HcnPqsmiOiKg3DZuamhGfcCd7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VG3Y6SDc3X8+ygzn0BOU82F9R2cDEKnHIlhF13tdWZv2smqiHm3afBsP88Xav3sBusDJazIGnagX6IlfM8J2LQ3gW1qgKInaIQ6GqxQAfbGAEIbaYv/K5wkrAAQG2SsmcW26JP9aDhB6Mx6dIf4WljQJ41ckb04HUJgGOQLRUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91A9A3EBC9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:50 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 03/16] build: Add support for building with libical 4.x
Date: Tue,  5 May 2026 10:45:09 +0200
Message-ID: <20260505085741.2497401-4-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTGjXtlQIlUmPF5ZXUGZM6qk1yZnk/OvLodKm+PT9xQmLbo4lWCvuRPK6rd/W7JZbm9ANaFy6YkNqzL8cuHsapuoAjh0kaOBWfgwxF48hbGU2dwc7LqzJ5rhrFlmx9Gt9Fpzi/66M0G6a19AC+1gogg93fCjR/LKliyISowTJiZh1AUsvMCOl96WSe7qaqXDb5h3CLP61k/MbQB1cly7ieREwWQQRFPIkRVf5/Pm7UkotjZqhnXiVaWObgisugPZd8mmXNNN5REKFj+sCcCQX5CEFvusQxloKS10WETh9uESxmEmETwXXRK/SYzv8XEsOQh2f2J78360yZZFT0U3Ik7aqDRxZsYBwjqctMh7sQXgjDUQ2KAaYcK3/ePVhQHH6K6Bi9cAiVMzhYACJOg4int5FgMT38Nf0ZzD82Z1BZ5RbQHrjVCHO4Ky2es57I5AgorcsOsOmeg7PPlMHve/XT9xDAj1A+udvjq4UtGRkacRXgT2btAgf4bF/A9yE+NAry8XbW0xXOkr0PljrRB7BOuu/CFKkQgfPbOJ+856TxEMtojKuBT8hO1VAj3Vzo2RZSy4JXWpQ+4FhqksbyacQREKEWo0eYhrAhIp8C91b8xh36KZudjz079N45+XNcQme05r7O955IbLvui8EZnTAfGr37L/2/N1V9ycExzBbt/Qug

Some functions were moved to libicalvcal, use that library if we're
building against libical 4.0 or newer.

See https://github.com/bluez/bluez/issues/2090
---
 meson.build       | 6 ++++++
 obexd/meson.build | 1 +
 2 files changed, 7 insertions(+)

diff --git a/meson.build b/meson.build
index d3c43d79141f..15508a868636 100644
--- a/meson.build
+++ b/meson.build
@@ -134,6 +134,12 @@ cups_dep = dependency('cups', required: get_option('cups'))
 jsonc_dep = dependency('json-c', version: '>= 0.13', required: get_option('mesh'))
 alsa_dep = dependency('alsa', required: get_option('midi'))
 ical_dep = dependency('libical', required: get_option('obex'))
+ical4_dep = dependency('libical', version: '>= 4.0', required: false)
+if ical_dep.found() and ical4_dep.found()
+  icalvcal_dep = dependency('libicalvcal', required: get_option('obex'))
+else
+  icalvcal_dep = dummy_dep
+endif
 readline_dep = dependency('readline',
   required: get_option('client').enabled() or
     get_option('mesh').enabled())
diff --git a/obexd/meson.build b/obexd/meson.build
index baddafcd8873..2270a10cb423 100644
--- a/obexd/meson.build
+++ b/obexd/meson.build
@@ -100,6 +100,7 @@ executable('obexd',
     libgdbus_internal_dep,
     libshared_glib_dep,
     ical_dep,
+    icalvcal_dep,
     dbus_dep,
     ebook_dep,
     edataserver_dep,
-- 
2.54.0

