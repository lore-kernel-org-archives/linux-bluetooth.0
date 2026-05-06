Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3C480DCA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077959; cv=none; b=djBakd8XBt5jU8eSKoAtYRnmusUmRy9J19nrWizugFB/s64g4PEFyx5U7rP57JtA6/oGQUpKyYKPv04uRAJLuPyElA6+gCX2yjxgptqkK4iWMeBL7Vz6ltjEKG3Tvbwb8ti2hQpME8UdDW3lKUdUytLBj7Dp/1vFgaYWx2hhisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077959; c=relaxed/simple;
	bh=S9HKRHM76k3gxQn4K+NYuGC460wT8J2owPTsu53BYLE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PnzhZIBAU4CWzaza9eVb7JyZ/Wy5R5D1ds6nS3dULnRNKLUedcTrDSNmr2k9zrRRDandsUW5HBe/ZtmKnOlF1ru1QaEy2yO9SUILifGr7oCukqsbcaUH0UFjKXeD9FKYtZA90pqzDblDhOLRUgovexKmapAZuXM/x+d9bGlcw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB86C3EC94
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 14:32:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 0/5] Add helper for "cleanup" variable attribute
Date: Wed,  6 May 2026 16:30:54 +0200
Message-ID: <20260506143220.3076135-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
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
X-GND-Cause: dmFkZTFWzEkuNE6yelzkianBdYaydE4naj07ADclHSkddMWgMQul62pvgasBkY9xPSMuY3glCSm1mlSzVa8jjraWlBW/3czvnekja2m878mGupBrU7peC6sJALTpOaXEhUlY5lIxeQ5DOhn6ExhQdcccRafHNGPYbJen9rV8E00d61Ukr1wUkdnlcVJSgthSnnjV0Ke4bFsarzinA9I9akLMMzZqYXUIKUVTHb3J4kqfAzQVmhRpaEh9w4i7KvvqO69j2yIQvcjbCNbYGhmofqBwL2hraKfGHh3gsQDHIY4F25pJhoFNghse7/Ga19Q9JxuUc8xQRAvVZGlvKvt9YJz6eQOISFX5kL0Xs6PQiL+vebsIBpuTt+udxCYxgZGkm6vOB8erpimL+XnfrGiWlzE2ytD3fjqpX48gzYdVZ8xdh5WofZ9KCFL+wM8nNr+7QjlmsaRPADeWL+lYY7y2Y+4uwq4MgrBCyn3XuTlbn9uMkjFH9PLOwF8R/lynCZWT8j/2oV1+IS866IRgPmIJUalLGTePiuna4PwaIOg/Mh2SbDo0qVJjYsspxvc//G2S750s4R93M2Lp6QYdbmwAM5d1OG1lQEEhyLyt9IzlMnps0PEpYc2sWyOUusqZ2H9fjAhURPAIeciENhnVOHTHlcwuU/wdzlEkzdF0YdSeOmek3ka5tQ

As discussed in:
https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net/

Implement a cleanup helper.

The MIN/MAX fix is here because it touches the same hunk in src/main.c
as the other patches. Feel free to pick it up straight away while the
rest is discussed.

Changes since v1:
- Fixed checkpatch warnings

Bastien Nocera (5):
  all: Remove more unneeded MIN/MAX macro definition
  shared/util: Add helper for "cleanup" variable attribute
  doc: Recommend using _cleanup_ and friends
  main: Use _cleanup_() to simplify configuration parsing
  main: Use _cleanup_() to simplify GError-handling

 doc/maintainer-guidelines.rst |   3 +
 lib/bluetooth/hci.c           |   4 --
 src/main.c                    | 102 +++++++++++-----------------------
 src/shared/gatt-server.c      |   8 ---
 src/shared/util.h             |   8 +++
 5 files changed, 43 insertions(+), 82 deletions(-)

-- 
2.54.0

