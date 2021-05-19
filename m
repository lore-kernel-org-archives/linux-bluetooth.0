Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B146C43460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B4361364
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhESAL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 20:11:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:41857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhESAL7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 20:11:59 -0400
IronPort-SDR: N/iz48kWDa8+O1LC7ARLftXZc7ZOf0eAFZHenQnJKj+s5nvXtwTc5GJ3LmlT4U1mkQfPvhehe7
 x+7rnDGpFwYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200900090"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200900090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:36 -0700
IronPort-SDR: v1XDgDXXgjrmfhBxQjqao+1kDJMwHQhTJjfLEgMbRa3vKpG2LJBOjdAUMj5mbJmyMlJXj+A/Rq
 a7lmcZLZsVHw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439707711"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.0.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:34 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 2/4] nesh: Normalize endian of public/private ECC keys
Date:   Tue, 18 May 2021 17:10:25 -0700
Message-Id: <20210519001027.1540720-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519001027.1540720-1-brian.gix@intel.com>
References: <20210519001027.1540720-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Mesh profile specification defines a Mesh byte order of Big Endian
for Public keys used to calculate shared secrets. Further the
specification sample data also show this same byte order for Private
keys.  However, our internal ECDH shared secret calculation requires
Little Endian byte ordering. This fixes our DBus interface, and
debugging output to use Mesh Byte Ordering (Big Endian) for all human
readable input/output.
---
 mesh/prov-acceptor.c  | 8 +++++++-
 mesh/prov-initiator.c | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index e806b12ef..8df9eee9f 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -223,7 +223,11 @@ static bool acp_credentials(struct mesh_prov_acceptor =
*prov)
=20
 	print_packet("PublicKeyProv", prov->conf_inputs.prv_pub_key, 64);
 	print_packet("PublicKeyDev", prov->conf_inputs.dev_pub_key, 64);
+
+	/* Normaize for debug out -- No longer needed for calculations */=0D
+	swap_u256_bytes(prov->private_key);
 	print_packet("PrivateKeyLocal", prov->private_key, 32);
+
 	print_packet("ConfirmationInputs", &prov->conf_inputs,
 						sizeof(prov->conf_inputs));
 	print_packet("ECDHSecret", prov->secret, 32);
@@ -307,11 +311,13 @@ static void priv_key_cb(void *user_data, int err, uin=
t8_t *key, uint32_t len)
 		return;
 	}
=20
+	/* API delivers Mesh byte order, switch to little endian */
+	swap_u256_bytes(key);
 	memcpy(prov->private_key, key, 32);
 	ecc_make_public_key(prov->private_key,
 			prov->conf_inputs.dev_pub_key);
=20
-	/* Convert to Mesh byte order */
+	/* Convert Public key to Mesh byte order */
 	swap_u256_bytes(prov->conf_inputs.dev_pub_key);
 	swap_u256_bytes(prov->conf_inputs.dev_pub_key + 32);
=20
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index ae9c646de..c62577523 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -222,6 +222,9 @@ static bool int_credentials(struct mesh_prov_initiator =
*prov)
=20
 	print_packet("PublicKeyProv", prov->conf_inputs.prv_pub_key, 64);
 	print_packet("PublicKeyDev", prov->conf_inputs.dev_pub_key, 64);
+
+	/* Print DBG out in Mesh order */
+	swap_u256_bytes(prov->private_key);
 	print_packet("PrivateKeyLocal", prov->private_key, 32);
 	print_packet("ConfirmationInputs", &prov->conf_inputs,
 						sizeof(prov->conf_inputs));
--=20
2.25.4

