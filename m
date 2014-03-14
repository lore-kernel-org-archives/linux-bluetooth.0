Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 3/3] bnep: avoid use of caddr_t
Date: Fri, 14 Mar 2014 09:59:27 +0000
Message-Id: <1394791167-29933-4-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
References: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

caddr_t is legacy BSD and should be avoided.

This fixes the following compile error on Alpine Linux with musl libc:
profiles/network/bnep.c: In function 'bnep_if_up':
profiles/network/bnep.c:205:33: error: 'caddr_t' undeclared (first use in this function)
  err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
---

For more details please see:
http://stackoverflow.com/questions/6381526/what-is-the-significance-of-caddr-t-and-when-is-it-used

 profiles/network/bnep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index ece979f..b93027a 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -204,7 +204,7 @@ static int bnep_if_up(const char *devname)
 	ifr.ifr_flags |= IFF_UP;
 	ifr.ifr_flags |= IFF_MULTICAST;
 
-	err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
+	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
 
 	close(sk);
 
@@ -229,7 +229,7 @@ static int bnep_if_down(const char *devname)
 	ifr.ifr_flags &= ~IFF_UP;
 
 	/* Bring down the interface */
-	err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
+	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
 
 	close(sk);
 
-- 
1.9.0

