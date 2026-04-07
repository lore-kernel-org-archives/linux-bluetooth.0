Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF113DBA0;
	Tue,  7 Apr 2026 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574842; cv=none; b=QdKEMoXXL2gmzfJxKP9iMhT/i7Y8Boc7ta3Qw7vz/X/kM10TzdgUTaWdn68kxm8H+yuoB6mmssElUvWfaqptlMvw+r9oo/uMWH4ydthTLt2kPGNv8vADRYTw9mDoY1Bc1KjwV9Vlh71NkzB/Ka1nyrGAgAHhq/FP5sQZ4x5YZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574842; c=relaxed/simple;
	bh=VC7jsNAs9QZh8ziLQ1KaaOM+a4C6+0jnsTlBljF2OTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzyDwIuRVpC2XTZmF96bgincFo166Kx4kzGVrANdorjh6h7QZou1v04llC2CmHRx7CdKSpmv6xYRlKWzf5+Q9R8RBzwKcKYAR72awP40xlkegZXG8iRW82hSHwWRxxw64ugyztn/rwHbwnZuIRqiRF0VqgZFj0TDCFe8RyaQvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=3oXHwoeq; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="3oXHwoeq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=q3E9RpQIFAshZuQuM1y0ZwcAbjG07hubtATqv00A1AE=; b=3oXHwoeqqtD+j+iEuUVu+iTkkP
	lNr/muZjxStgPMApjdBX+AXpwVypfE2IXRp1HlzPokufMgJ7CN2No/0R1mnxjMMTmGrcGLdnXK6Vg
	xFm8t/h+IRRBkaHUXopI22V0YYtj6hO+yJOICXcibxarx827H9IY0VRRk5gad81TL17YiEt+FC1sr
	oTJJ3k1FBdvD/AmdkHDERdfUa5yMA4khW81gyZ6DbjXi2NjcolXxsFQWJKXlrkrnj/eFR1rO503x8
	/d6zdEgBKxaq96ldERM8/k+IJVN61AURXmmG27oZZ7G2Pnic+prWS5gKaxwj41EjU8iGxo1E/m3kN
	vhIl4BwHkInORATH3AzS2MMBCeoXP1FiM0+xMliKe1P6KYIv2+zCz6My0jacp2e+USSstH8ifylU1
	zaUHnduBtqmcrdcl8o1LjTLOYpcx7FMsxmaUEv7gXZzQvjscVd+LH8sJ2cOAUPXouKu/A647p+ql0
	v7AOKR1HNklZJiXCwZoEK1aE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA87o-00000007X39-3dSB;
	Tue, 07 Apr 2026 15:13:57 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-bluetooth@vger.kernel.org
Cc: metze@samba.org,
	Michal Luczaj <mhal@rbox.co>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec
Date: Tue,  7 Apr 2026 17:13:45 +0200
Message-ID: <20260407151345.126999-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_struct_from_sockptr() fill 'buffer' in
sco_sock_setsockopt() with zeros, so there's no
real problem.

But it actually looks strange to do this,
without checking all of codecs->codecs[0]
really comes from userspace:

  sco_pi(sk)->codec = codecs->codecs[0];

As only optlen < sizeof(struct bt_codecs) is checked
and codecs->num_codecs is not checked against != 1,
but only <= 1, and the space for the additional struct bt_codec
is not checked.

Note I don't understand bluetooth and I didn't do any runtime
tests with this! I just found it when debugging a problem
in copy_struct_from_sockptr().

I just added this to check the size is as expected:

  BUILD_BUG_ON(struct_size(codecs, codecs, 0) != 1);
  BUILD_BUG_ON(struct_size(codecs, codecs, 1) != 8);

And made sure it still compiles using this:

  make CF=-D__CHECK_ENDIAN__ W=1ce C=1 net/bluetooth/sco.o

Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malformed user input")
Cc: Michal Luczaj <mhal@rbox.co>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: David Wei <dw@davidwei.uk>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 net/bluetooth/sco.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b84587811ef4..359eabf7dddb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1045,7 +1045,13 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		codecs = (void *)buffer;
 
-		if (codecs->num_codecs > 1) {
+		if (codecs->num_codecs != 1) {
+			hci_dev_put(hdev);
+			err = -EINVAL;
+			break;
+		}
+
+		if (optlen < struct_size(codecs, codecs, codecs->num_codecs)) {
 			hci_dev_put(hdev);
 			err = -EINVAL;
 			break;
-- 
2.43.0

