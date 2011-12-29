Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: anderson.lizardo@openbossa.org, johan.hedberg@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Add wiimote plugin to bootstrap-configure
Date: Thu, 29 Dec 2011 18:19:09 +0100
Message-Id: <1325179149-26554-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <CAJdJm_PJPx7tze9zioH4kT-d9_9j7jHFqmW-H4ufDfVHB_kE3A@mail.gmail.com>
References: <CAJdJm_PJPx7tze9zioH4kT-d9_9j7jHFqmW-H4ufDfVHB_kE3A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 bootstrap-configure |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 94da969..89ea156 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -34,5 +34,6 @@ fi
 		--enable-cups \
 		--enable-sap \
 		--enable-thermometer \
+		--enable-wiimote \
 		--disable-pcmcia \
 		--disable-datafiles $*
-- 
1.7.8.1

