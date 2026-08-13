Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45532FFFA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612796; cv=none; b=ADWJuIZzkfagklEUXAbzmuL4Y9p2TWFK/ZGmED7Atcg0BXgCmDp7aQ3wRxwcshT0QC33cgzhSyPbloPdQvCNVpzgqNZW0aDh396o21E0Fw/hyG9DlQCpAvbq7s6O7xqXa6AOlDQrB6YW+z7db3CHuFRjuYL4eXf2GxjTB+kVrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612796; c=relaxed/simple;
	bh=8hD5Vf+sPWiBoIWjFKV8yf3k13nVGkfnrnaBdS2WzW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YaOZnHKNK9sA8JyFBOk7wuJNo82/O2GWei6rZ0AwuNAJH+aLuI7N5SQR69xp76UWca9xgjWsoWX+XFnciKdyH3n+CTnbp199M0hYY9hAFtvMwORipRJuSuBYz2Gg+Uw72fn1865xQNbFObK002RS6qLgmcp1kT0lRrGFpGiglsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29E663E9F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 0/2] adv_monitor: Fix buffer overflow caused by integer overflow
Date: Thu, 13 Aug 2026 11:16:56 +0200
Message-ID: <20260813091937.2600061-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGOCV5RnZ5rG9iNtdESZReOjQguI+DsrwmKz3A/znCBmxwqAVt+QtxNU2MjS8wAJOfaNqW5Rg+gYpxVH8X0AsPpFU7i70Gfpto7zbuhFnRjA8wkcQzyy0IgN2RbvG1OAhyhAEKjH6LXifsNk1qu43Hb3gddnmuG5S0/qpTu8m/HbD/17neVyMerXwa60cTTBm6G5YkKQN0s20qGnmmfVJUJTmUyP4cEEHv0J2XoaYlf9OPIZdUSzydWJza1k3cTj9WGJR1KMPv1NiBN4hJvPJTEEPluA3cFnzTMSelaKlYLYik4XMbs28et7A7h7kW8S6PEStEPF5vQlZwj5Nrpaa/sQnypZ2VlIMntzeszq+Y0bwGrtLAJYakBY23Tx0PkW936GLM8ZoTxHJv1frHItg6kZUkzR9T6W+vpd5CMrYPPabymNys9si3fOfpGVCWT6SCkyByy/EokxzkcvPwoYRsdi0u1vXtV0mEp566EMOXgmPGlWfXgxi1t/JonJQbWdjmNJmP76y/xohmN1Ug8nRDsHc+Uqn6V5RprSSXEw4yNvvG1lzxbtMJRvfyMXLd0kqM2uhHy0WLJF6dHo/F9YjnzTZPMcLQs9j2d7y8yxedH4BZQG0lJuo78V8jIBu5IFpOz57QvzwCnFIpdue5+ItpOsrR2Ni15oGI6U8gopmQC1Q
X-GND-State: clean
X-GND-Score: 0

Those issues were originally reported as security issues, but we not
deemed worthy of a security advisory as they impacted an experimental
feature.

Bastien Nocera (2):
  adv_monitor: Fix buffer overflow caused by integer overflow
  adv_monitor: Ignore additional patterns past what's supported

 src/adv_monitor.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.55.0

