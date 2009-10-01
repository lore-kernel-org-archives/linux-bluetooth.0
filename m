Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH] Don't force dirs on bootstrap-configure
Date: Wed, 30 Sep 2009 23:14:38 -0300
Message-Id: <1254363278-20735-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes a problem with ./bootstrap-configure --prefix=some/dir.
bootstrap-configure was forcing dirs configuration like mandir and
sysconfdir unless user pass all its desired dirs on
./bootstrap-configure.
---
 bootstrap-configure |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 5414518..1a48fa9 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -11,11 +11,6 @@ fi
 ./bootstrap && \
     ./configure --enable-maintainer-mode \
 		--enable-debug \
-		--prefix=/usr \
-		--mandir=/usr/share/man \
-		--sysconfdir=/etc \
-		--localstatedir=/var \
-		--libexecdir=/lib \
 		--enable-netlink \
 		--enable-tools \
 		--enable-bccmd \
-- 
1.6.3.3

