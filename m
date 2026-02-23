Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23EF4F1
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881406; cv=none; b=mtprWm9i0vNqgpEJEkK+oCD8kBtIRrnse7Sp0PMtu7H5x9VgQw2VSeWL/3jgNbx1+Iw+AlHgp5pxqR4V0p0VVmhBbk+fSQ16Dzp9NTRro4d5UPDDza9y1+AHZZSnZdDhAN2TOk12n0OC4pZnh3gilQ96tzPkA82NO4hNHhfV/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881406; c=relaxed/simple;
	bh=SuMpt0QlF9//RjYRU0EAIFvFxE4wNASoqWyJvJuQBn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4VEQC3SA987WZ9oVVpYCCfr+pu+COP4o93E+qAeYa/etaGLL4AV7c21PrzzlGCx+i+dI7RD8MhD/xZnTQZ17qTkeEbYXDQV5wGoY+3VITjnHxyZGx+91EgLzHRotRGOl7IqqwLn+UpuazOcJZTGY1jc6Z+HvJh2s3bgPoIQnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI0TTOx3; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI0TTOx3"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so3473347241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771881404; x=1772486204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJYHWnzDVdlbIgz9CaQNBWll7r0bpnHvy9pTXHf6yyQ=;
        b=iI0TTOx3gDadha61L7Ga0CorERJUbRkrF19eDVR79px/a+ly2Y04aylqONTEZYGlgn
         mH+7fSNtpPh43G8KSMLFGNpABeVm4KgXvuw293Dlj/LFTQTW3g0L5jSXDiSKjUb8bBKM
         cKLTaNFlhR+QBsi4NjTeCD05pJU17TG/LwSLHv5txnx2GN1gythtGsgcLTl6gIqFx3Sd
         CczYbioUJZRqzCsjFa2LyFQR4T+OuR1mruv5vRo8SC053Out/wOG4wC+bo5aNxJWInBQ
         vqE6M/CABIKiYxaFwOCrLVTNA5kPmJHM6HvApWwxaQbHMqMoeYCWvzppWaAdxWSZ7kyp
         iKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881404; x=1772486204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJYHWnzDVdlbIgz9CaQNBWll7r0bpnHvy9pTXHf6yyQ=;
        b=tkTZHZobGk2J0dPMUDucZ7WabsFMY74hUGDNZFUGCM1hu21+lUWoXejUsResf34FTN
         CUt9NWg3utmSbLf4STFqbmUE5jR4tJk95taQ8NLrdCxZQXAUfLUAIkQPiPrK5gObu/z+
         uaenqO4wOXsXaULrXcNJu+Xi0F+mEqLNIyuO+jiuo80Sf9DjVSmnSNZqL6D+NFMVmujx
         NqUhPPbUzwect0fNSMo+S0PmlWMfW/XQJs5e9W2ZTv2I6SYbDdUGOXKYhHXSkVtN7IO3
         0RJc59LfGGF9aw0/gyrfbpEhp/g7wSVF4N+1gvuGvX5H/vyho4rogXGC2ZAm9bHBX44Z
         DtaA==
X-Gm-Message-State: AOJu0YxyY5yX6ROv2WIR48gCtZ0wM1pJTZoXMBcN1WjgCYKuLCZUDnTa
	lh/3xAtYEK7aNZc9uwAEw3ge/Yp1R4uVkDkBu20tIunR3Jc1/UqUrOHJoYHcFg==
X-Gm-Gg: ATEYQzx13GeisjY3oM9djTBWrfxYOajHAiy7IH68Zs18pHCa0HCIawVeVlp1YoOCuml
	n3ddSPEuPMfq++65rh22frdnpkyW3kCLbbeptBDjr2+B5jB49OYdlMqcg8EFEh9b/1x0mcxk3Wr
	FrDyRswaQ4U00ki7mAmEf7tBcjDB1DS0NaQv9NHDvO79+QOl0cX5kOzzOqBGxnPmiGVNIr8m/3d
	H+lT6/rLsH2X4JPlfCPkKyI8uSaGCGD8JTgv47ltIScSXv5OmxnxaX9gkteCR45k/kLq3bwaTWV
	f0OF4KnmgvjskA9iQFP9Wmc4h1jeYzw39GG2JGDv8WBXm2d8p/iZQDUCrtaL6kwPSz7iwQiBT+0
	wzmb7heLF19SkTvN9XsE9ABVWegAAZMsnS14hDhv6cDHkkFKHfMrDy3bUthJpWV0pCIhZZNgXhG
	dbaOQbzINFyN32ESofQZXtdZqk39ItKpw8kiwXYx3htm50NPy/ovXEHgn7HCNGbmXOtB3Fomish
	BIMkgUQd182QFgPMmmrkEwSCoop
X-Received: by 2002:a05:6102:161f:b0:5f9:4d6c:9917 with SMTP id ada2fe7eead31-5feb3449eadmr4342132137.0.1771881404282;
        Mon, 23 Feb 2026 13:16:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb61fde14sm9025331137.3.2026.02.23.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:16:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-02-23
Date: Mon, 23 Feb 2026 16:16:34 -0500
Message-ID: <20260223211634.3800315-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d4f687fbbce45b5e88438e89b5e26c0c15847992:

  ovpn: tcp - fix packet extraction from stream (2026-02-21 07:04:08 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-02-23

for you to fetch changes up to 138d7eca445ef37a0333425d269ee59900ca1104:

  Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ (2026-02-23 16:08:15 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - purge error queues in socket destructors
 - hci_sync: Fix CIS host feature condition
 - L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
 - L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
 - L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
 - hci_qca: Cleanup on all setup failures

----------------------------------------------------------------
Heitor Alves de Siqueira (1):
      Bluetooth: purge error queues in socket destructors

Jinwang Li (1):
      Bluetooth: hci_qca: Cleanup on all setup failures

Luiz Augusto von Dentz (5):
      Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
      Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
      Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ

Mariusz Skamra (1):
      Bluetooth: Fix CIS host feature condition

 drivers/bluetooth/hci_qca.c   | 24 ++++++-----
 include/net/bluetooth/l2cap.h |  8 ++--
 net/bluetooth/hci_sock.c      |  1 +
 net/bluetooth/hci_sync.c      |  2 +-
 net/bluetooth/iso.c           |  1 +
 net/bluetooth/l2cap_core.c    | 95 +++++++++++++++++++++++++++++++------------
 net/bluetooth/l2cap_sock.c    | 16 ++++++--
 net/bluetooth/sco.c           |  1 +
 8 files changed, 105 insertions(+), 43 deletions(-)
