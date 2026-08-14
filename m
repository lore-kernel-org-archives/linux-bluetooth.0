Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F33F5BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684327; cv=none; b=dinyNoclNbV8MkCdKK6sk7TqoeaM82mh16nCLGlKnzF+EWbqjhHaunnWFRv4e5hSxC2CTdNU/6JSV68oXfHpnbJALnU0lAZYO5/PxoRyqhxZ9594TA7Im7MRYb3Tml285RYAAr9YeLOPqkRwICcdjQF3a72LItkv5J3SZ9HBB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684327; c=relaxed/simple;
	bh=TByO2Uty1NfqFut2b7KCB1KZeOGWhGPLKZlOR6p59HY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAVsyjitrpm83sbpoBqen8TidNpmJV+Ii4I5Vna4VSIbpWdq4QL3Na7kspEqosIkGuTkmNqsTfLzPGIQlH+bGXnxc4/cPCRSCdon7M4hsrW3K0KajWDuEQ8RCMSnlafJpbgd7VGTB4MowTSbDrmctOvAr4SgzP+vrCiJ0k4qngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hblMPGze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hblMPGze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786684325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FqPi3XTldwe7VcLNCmU8PsGjqWkbsvrYhfzHnBTTpW4=;
	b=hblMPGzeLT4tR1tkLH/mO272BHM25oviXNleSxrGa4iT8BFCRSbJ6rmVOQuv1f01vYLHLM
	RbEtGU2klb20ErPNyX+LVaO+AP6jQPoQc77I/K/kQcBr/UqwOmaXpu5oLNSfB/h59Qohxr
	Cagrx9uV7BOasZqp24JLrLbgj/9jinY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-SRPlC_KVOdi93qYFJou9HA-1; Fri,
 14 Aug 2026 01:11:56 -0400
X-MC-Unique: SRPlC_KVOdi93qYFJou9HA-1
X-Mimecast-MFC-AGG-ID: SRPlC_KVOdi93qYFJou9HA_1786684315
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0BE71956095;
	Fri, 14 Aug 2026 05:11:54 +0000 (UTC)
Received: from dmarlin-na.rmtustn.csb (unknown [10.22.80.249])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1A3418005BC;
	Fri, 14 Aug 2026 05:11:53 +0000 (UTC)
From: David Marlin <dmarlin@redhat.com>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Marlin <dmarlin@redhat.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Bluetooth: hci-core: fix "declaration does not declare anything" error
Date: Fri, 14 Aug 2026 00:10:12 -0500
Message-ID: <20260814051032.261320-1-dmarlin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A recent build attempt, using gcc-14.4 on RHEL-10, produced the
following errors:

In file included from ./include/net/bluetooth/hci_core.h:35,
                 from net/bluetooth/hci_core.c:39:
./include/net/bluetooth/hci.h:1476:34: error: declaration does not
declare anything [-Werror]
  1476 |         struct hci_std_codecs_hdr;
       |                                  ^
./include/net/bluetooth/hci.h:1477:17: error: flexible array member in a
struct with no named members
  1477 |         __u8    codec[];
       |                 ^~~~~

./include/net/bluetooth/hci.h:1516:37: error: declaration does not
declare anything [-Werror]
  1516 |         struct hci_std_codecs_v2_hdr;
       |                                     ^
./include/net/bluetooth/hci.h:1517:33: error: flexible array member in a
struct with no named members
  1517 |         struct hci_std_codec_v2 codec[];
       |                                 ^~~~~

cc1: all warnings being treated as errors

Adding a variable name (e.g., 'num') to each of the above struct definitions
avoids the error without changing the layout of the struct.

Fixes: a0cff16d0f6e ("Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings")

Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: David Marlin <dmarlin@redhat.com>
---
 include/net/bluetooth/hci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda..5ccc4545e380 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1472,7 +1472,7 @@ struct hci_std_codecs_hdr {
 } __packed;
 
 struct hci_std_codecs {
-	struct hci_std_codecs_hdr;
+	struct hci_std_codecs_hdr num;
 	__u8	codec[];
 } __packed;
 
@@ -1512,7 +1512,7 @@ struct hci_std_codecs_v2_hdr {
 } __packed;
 
 struct hci_std_codecs_v2 {
-	struct hci_std_codecs_v2_hdr;
+	struct hci_std_codecs_v2_hdr num;
 	struct hci_std_codec_v2 codec[];
 } __packed;
 
-- 
2.55.0

