Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 29/60] Fix missed state transition in MCAP
Date: Thu, 22 Jul 2010 10:56:22 +0200
Message-Id: <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

MCL should transite to properly state when a create_mdl_req is
not SUCCESS
---
 mcap/mcap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index cf92368..1dfe083 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1260,6 +1260,7 @@ fail:
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	g_free(mdl);
 	g_error_free(gerr);
+	update_mcl_state(mcl);
 	return close;
 }
 
-- 
1.6.3.3

