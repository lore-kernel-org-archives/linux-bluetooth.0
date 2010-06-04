Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 25/32] Create new structure to manage data channels in HDP
Date: Fri,  4 Jun 2010 10:30:18 +0200
Message-Id: <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
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

