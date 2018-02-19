Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix probing service twice
Date: Mon, 19 Feb 2018 17:49:51 +0200
Message-Id: <20180219154952.24339-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is already a service for a given profile there is no point in
probing it again.
---
 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1acecce33..0da4184f6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4202,6 +4202,7 @@ static struct btd_service *probe_service(struct btd_device *device,
 						struct btd_profile *profile,
 						GSList *uuids)
 {
+	GSList *l;
 	struct btd_service *service;
 
 	if (profile->device_probe == NULL)
@@ -4210,6 +4211,10 @@ static struct btd_service *probe_service(struct btd_device *device,
 	if (!device_match_profile(device, profile, uuids))
 		return NULL;
 
+	l = find_service_with_profile(device->services, profile);
+	if (l)
+		return l->data;
+
 	service = service_create(device, profile);
 
 	if (service_probe(service)) {
-- 
2.14.3

