Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 30/60] Fix missed state transition in MCAP on reconnections
Date: Thu, 22 Jul 2010 10:56:23 +0200
Message-Id: <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
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
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

MCL should transite to properly state when a reconnect_mdl_req is
not SUCCESS.
---
 mcap/mcap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 1dfe083..34fd43b 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1303,6 +1303,7 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	mcl->cb->mdl_deleted(mdl, mcl->cb->user_data);
 	g_free(mdl);
+	update_mcl_state(mcl);
 
 	return close;
 }
-- 
1.6.3.3

