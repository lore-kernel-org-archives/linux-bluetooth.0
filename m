Return-Path: <cyrus@holtmann.org>
Message-ID: <551C51E2.7060806@message-id.googlemail.com>
Date: Wed, 01 Apr 2015 22:15:30 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: BlueZ devel list <linux-bluetooth@vger.kernel.org>,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: Re: unit/test-gatt broken again (as always :-)
References: <551BD9BD.9040501@message-id.googlemail.com> <CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
In-Reply-To: <CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040005010202040505080504"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040005010202040505080504
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Luiz,

Am 01.04.2015 um 14:08 schrieb Luiz Augusto von Dentz:

> This is actually a fault in our code that the test uncovered which is
> good but we failed to see it happening, I actually have some plans to

Ok. Then it's good that the openSUSE Buildservice setup has these
parameters set as default for building :-)

> have a check-valgrind target to catch this type of problems or maybe
> there is a way to add MALLOC_CHECK_=3 MALLOC_PERTURB_=69 directly.

I can help with that, see attached patch (sorry for the attachment, but
making thunderbird behave well is out of scope for now :-)

Best regards,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537

--------------040005010202040505080504
Content-Type: text/x-patch;
 name="0001-enable-glibc-s-malloc-checks-for-the-test-suite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-enable-glibc-s-malloc-checks-for-the-test-suite.patch"

>From f76391a35bd168a31d62ab0ea16dfdc3bdeb52e1 Mon Sep 17 00:00:00 2001
From: Stefan Seyfried <seife+dev@b1-systems.com>
Date: Wed, 1 Apr 2015 22:04:41 +0200
Subject: [PATCH] enable glibc's malloc checks for the test suite

Setting MALLOC_CHECK_=3 causes additional checks in glibc for malloc()
usage errors, abort()ing the test if those trigger. MALLOC_PERTURB_=69
causes free()'d memory to be poisoned with 0x45, leading to crashes in
case of use-after-free.
Together, both are useful for spotting more errors during "make check"

Signed-off-by: Stefan Seyfried <seife+dev@b1-systems.com>
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 2255ce8..b6beb42 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -413,6 +413,7 @@ noinst_PROGRAMS += $(unit_tests)
 endif
 
 TESTS = $(unit_tests)
+AM_TESTS_ENVIRONMENT = MALLOC_CHECK_=3 MALLOC_PERTURB_=69
 
 pkgconfigdir = $(libdir)/pkgconfig
 
-- 
2.3.3


--------------040005010202040505080504--
