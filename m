Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447885;
	b=zIrxHsyWAZlUjMer5Ny/GrFXXf1c6ymFoOU+uPTMmW2MB85+guFsE4K7XD2ig1QjX9KN
	 XgcafYVor6GavEaPzgnD6UAJ2/vmj8iIOIL9bj7a0QZRqqkm7ZbvvZVh3FrhdCzUAHGwi
	 nY1NFAHwUiIRAqTd25wnpHf+vpWHd2OZgQXqg4PiftxxYCJ8tRERl8JDDHniJYwqjdXOU
	 QAtQZYRvCCzm9Q9/vwZBLFp4JvyrMnVnRgIvY5KpHGsuUL6mO6txJ34fDA9cIRB1keHfN
	 9Xm5JuFoA9JQqcUxUjo0mc6sPW8sKdOOu4L7jHBVIkMlq/8ZvK2dHiHoFfOWm+SyO+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447885;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=9UsNO6UbkkCs3hh76I+gDpoWwMXf6veQEiKkrU7kzZc=;
	b=QwDYMrSrgBeaa3P9xxuNwS1FscWPuQ2lRViDfbqZP+LHxR4meWgoxKeWdE6yJXsEodES
	 zfhuyCQOGSSdhF/NpcjjfhAFZarOzFyMpZkzGQLD3k8hUKQvh4wJYQY99DE9dh4PcD6Jr
	 49h0nTD/NYqOyrwK+cqCgmPI7XSI8rQ9eQgUzRcnMTpdvEdSHwuwi9xoa3gHpg1xOC5Qw
	 o/9GcpfecB2P7TYbf/pw54CFIvdJ9xQZhVOJfHycjcgIVZ6j6F+dJ0T8JW+R0gLXt0Q1z
	 77VGGrl+3atmbVer1vhOUaZswyiQps1eK/k9E8zTwmbQPbZt+H1g+dxVOyuLMKW8jTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="TQooI/li";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3853606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3853606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TQooI/li
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795447883;
	bh=l/P66P5OnDGhvfa/EXvZZ4xSzj2u8lW8qA60+12m2nw=;
	h=From:To:Subject:Date:From;
	b=TQooI/libC81m1vfsWrXUAK/spWsTadIMkV8eHoSDPPcc9QrmPkS8TXEVtwmi1R8h
	 IgJ5FAXUhJZyHOs1k7MoBKEjNQP7FFxVCK7T4UpARXAox3gaHM+FIyQacJC0JrRxFP
	 gd8Lt1wIwsfuyX1pxXt0ZB367AXRtsD5kAFYEEtvwlfuNdca7fRvsOg+dCkfwb8Ph3
	 MTp7U2haFl1iWfKjoqcu/H301urBLFzqNIJqN0QLlxTRC5wdvumKLIHEMOhYK6JoI4
	 8KNh89VeEkNP9/6aE6zZjbPrZnHDfnrSCKhGxm+yMnWBIUDq5Xvh0BYbMunRsUa8tf
	 IM5lf9ipFgMmQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DAA0117E031C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:31:22 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] client/btpclient: Security Level reporting
Date: Mon, 23 Nov 2026 16:31:14 +0100
Message-ID: <20261123153117.135583-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Set org.bluez.Device SecurityLevel and EncryptionType properties to
optional so application can access them only when they are meaningful.

Send BTP_EV_GAP_SEC_LEVEL_CHANGED event from SecurityLevel property
changes once the device's services are resolved, matching the BTP levels
expected by auto-pts.
This reduces connection time for the BAP tests.

Frédéric Danis (3):
  device: Provide Security Level related props when supported by kernel
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

 client/btpclient/gap.c   | 52 ++++++++++++++++++++++++++++++++++++++++
 doc/org.bluez.Device.rst |  8 +++----
 src/adapter.c            |  4 ++++
 src/adapter.h            |  1 +
 src/device.c             | 13 ++++++++--
 src/shared/btp.h         | 11 +++++++++
 6 files changed, 83 insertions(+), 6 deletions(-)

-- 
2.43.0

