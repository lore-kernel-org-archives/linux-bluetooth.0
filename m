Return-Path: <cyrus@holtmann.org>
From: Tracey Dent <tdent48227@gmail.com>
To: davem@davemloft.net
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	sjur.brandeland@stericsson.com,
	socketcan@hartkopp.net,
	urs.thuermann@volkswagen.de,
	socketcan-core@lists.berlios.de,
	sage@newdream.net,
	ceph-devel@vger.kernel.org,
	wang840925@gmail.com,
	jlayton@redhat.com,
	kaber@trash.net,
	pekkas@netcore.fi,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	netfilter@vger.kernel.org,
	samuel@sortiz.org,
	Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH 16/17] Net: sunrpc: auth_gss: Makefile: Remove deprecated kbuild goal definitions
Date: Sun, 21 Nov 2010 20:03:27 -0500
Message-Id: <1290387808-2239-17-git-send-email-tdent48227@gmail.com>
In-Reply-To: <1290387808-2239-1-git-send-email-tdent48227@gmail.com>
References: <1290387808-2239-1-git-send-email-tdent48227@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Changed Makefile to use <modules>-y instead of <modules>-objs
because -objs is deprecated and not mentioned in
Documentation/kbuild/makefiles.txt.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 net/sunrpc/auth_gss/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/Makefile b/net/sunrpc/auth_gss/Makefile
index 7350d86..9e4cb59 100644
--- a/net/sunrpc/auth_gss/Makefile
+++ b/net/sunrpc/auth_gss/Makefile
@@ -4,10 +4,10 @@
 
 obj-$(CONFIG_SUNRPC_GSS) += auth_rpcgss.o
 
-auth_rpcgss-objs := auth_gss.o gss_generic_token.o \
+auth_rpcgss-y := auth_gss.o gss_generic_token.o \
 	gss_mech_switch.o svcauth_gss.o
 
 obj-$(CONFIG_RPCSEC_GSS_KRB5) += rpcsec_gss_krb5.o
 
-rpcsec_gss_krb5-objs := gss_krb5_mech.o gss_krb5_seal.o gss_krb5_unseal.o \
+rpcsec_gss_krb5-y := gss_krb5_mech.o gss_krb5_seal.o gss_krb5_unseal.o \
 	gss_krb5_seqnum.o gss_krb5_wrap.o gss_krb5_crypto.o gss_krb5_keys.o
-- 
1.7.3.2.245.g03276
