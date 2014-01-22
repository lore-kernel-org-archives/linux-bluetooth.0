Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <natanael.copa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2 2/3] bnep: avoid use of caddr_t
Date: Wed, 22 Jan 2014 13:50:19 +0000
Message-Id: <1390398620-1916-3-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
 <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

caddr_t is legacy BSD and should be avoided.

This fixes the following compile error with musl libc:
profiles/network/bnep.c: In function 'bnep_if_up':
profiles/network/bnep.c:205:33: error: 'caddr_t' undeclared (first use in this function)
  err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
---
 profiles/network/bnep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 2a74016..4f9b801 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -202,7 +202,7 @@ static int bnep_if_up(const char *devname)
 	ifr.ifr_flags |= IFF_UP;
 	ifr.ifr_flags |= IFF_MULTICAST;
 
-	err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
+	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
 
 	close(sk);
 
@@ -227,7 +227,7 @@ static int bnep_if_down(const char *devname)
 	ifr.ifr_flags &= ~IFF_UP;
 
 	/* Bring down the interface */
-	err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
+	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
 
 	close(sk);
 
-- 
1.8.5.3

