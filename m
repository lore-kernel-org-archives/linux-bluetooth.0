Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 25/32] Create new structure to manage data channels in HDP
Date: Wed,  2 Jun 2010 15:19:21 +0200
Message-Id: <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp_types.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/health/hdp_types.h b/health/hdp_types.h
index 5db8e0d..6d41e2b 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -115,6 +115,13 @@ struct hdp_link {
 	uint32_t		id;		/* Health link id */
 };
 
+struct hdp_dc {
+	struct hdp_link		*hdpl;		/* Health link */
+	struct mcap_mdl		*mdl;		/* MCAP MDL structure */
+	uint8_t			conf;		/* Requested conf */
+	uint16_t		mdlid;		/* MDL id */
+};
+
 struct hdp_device {
 	DBusConnection		*conn;		/* For name listener handling */
 	struct btd_device	*dev;		/* Device reference */
-- 
1.6.3.3

