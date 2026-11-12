Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503060;
	b=oaolLxMl/CrY1hTmxf8at6faTGJP3ZNUTsSjqlo/givAmP8ih3U0GNBq1F70hjU+AAA4
	 Gsm4zyon57Jqtd6hecdKnUv7d4Yt+yvGFZ7PhoP2svZ5FnEeyxM6AB/KdQA1ui9wFp67u
	 8v53ffMB7DG/5kFnGz274+6DX2O+WIW2GcyaF3dRkgHgybLTJ5pDLCGRpmcxgX++XHIhT
	 +1Tk/G1d/S0MuJ7TWJhLSVWKzSoNlgI/SfChWFz9IF+jhSACY3AdavmvCOo2xBAV/QcDB
	 qyjd33wJ0WLse0d/P5vjVW26DOWCsVbk8dajFkUtWGOwXPzBJNbfY+BcA/p19q6Vsqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503060;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-KATA-Status:X-KSMG-LinksScanning:X-KSMG-Message-Action:
	 X-KSMG-Rule-ID;
	bh=zR8RGDnbixYP/plFNMMoYKI+puSLpuGBwnaIdEA3hZM=;
	b=OfCS78EOvUKliAtFqygMwT5ixvFASx4zHt+RtGPwGw6R8DOWFSo8w4dUaVWhTsHcbBzu
	 ncNC87RZJmjcOkzWeCVBgwsFqcXZ8NtK8yuYb8IzoGnQBD2jmXilpmZjJ6CrOaHjIq3FC
	 t7uYSqVW161J6QOx3TDvpM51k5grgLELGa87b7rK6L2dUjYtX19ZGFl53CK+tUecrsON5
	 eBsnJaqqDbZMXkVgeD1ivOv6+g7yaAB761t3f/bwkhUAjU1k0wNw/QQCovZXw/HdUYj+w
	 qSEZwuGeocCRUqXdH+89H8QyGvakOnzhDNa84BNc82r3DMOELeJ2v7sRZndqLFGMS6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=salutedevices.com;
	spf=pass smtp.mailfrom=salutedevices.com;
	dkim=pass header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=Cg20gLh2;
	arc=none smtp.remote-ip=95.181.183.35
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8C606A32E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C8C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=Cg20gLh2
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id BB4DD240010
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:04:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru BB4DD240010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1794503049;
	bh=zR8RGDnbixYP/plFNMMoYKI+puSLpuGBwnaIdEA3hZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Cg20gLh2VLWPiUGpDxAwFA/28fo2kjqoT1DN5qA9rrW1La4IOCW48rYNALyY/w9cQ
	 hCWPckBxnXS3WBoeCFhPlkrXUxgHOouPDDB+UN4ns/8ga1EAutDNKl/uKGfLLe9UAE
	 xYR0M21Jqoza0aVdrBZ4Wiil5P12PuE65hSpSPW3P8Fym6XCw8Hl+XXXlyciTLGh0O
	 rFqEpdFJGoukmFGJdZqZ+U/pzD6bznEDARe5VKq0z5I1FxHaA2Fkga43sPTJgaoui/
	 mU3KkAnv//tu+EsNF8MUP1fcKpnr79OkgZxIzbNUfO2I0sVKt0nX7/+guBEHJO94tm
	 yuIoXsqpDuI3w==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m2.sberdevices.ru [172.16.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.sberdevices.ru", Issuer "Russian Trusted Sub CA" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:04:09 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [RFC PATCH BlueZ 0/1] advertising: Fix double-free in client_free
Date: Thu, 12 Nov 2026 20:03:54 +0300
Message-ID: <20261112170355.22011-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-s-m2.sberdevices.ru (172.16.210.3)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207453 [Nov 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/11/12 14:02:00 #28858911
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

bluetoothd 5.79 aborts with SIGABRT in client_free() while freeing
client->owner, called from client_free_idle_cb(). The crash shows up
at random intervals. I cannot force it by hand.

The frames that match the 5.79 tree are:

  client_free (advertising.c:150)
  client_free_idle_cb (advertising.c:161)

Line 150 is g_free(client->owner), and glibc reports a double free.
The minidump also contains unrelated frames from a bad unwind
(open_cfm, _init). Those are not this path.

No commit on origin/master since 5.79 stops the second idle free.
0d57c12f5aca ("advertising: Fix leaking clients that exit while
registering") installs the disconnect watch during
RegisterAdvertisement, and the remove and failure paths still each
queue a free. We cannot leave 5.79 yet: buildroot pins that release.

Please comment on both changes. The diff below is what we apply on
5.79. It does not apply to current master: client_remove() takes
struct btd_adv_client *, and the disconnect watch is set from
RegisterAdvertisement. Patch 1/1 is that fix rebased on origin/master.

--- 5.79 example, not for application on master ---

    diff --git a/src/advertising.c b/src/advertising.c
    index bd121e525..45fdb5b43 100644
    --- a/src/advertising.c
    +++ b/src/advertising.c
    @@ -88,6 +88,7 @@ struct btd_adv_client {
     	uint32_t max_interval;
     	int8_t tx_power;
     	mgmt_request_func_t refresh_done_func;
    +	bool pending_destroy;
     };
 
     struct dbus_obj_match {
    @@ -200,6 +201,12 @@ static void client_remove(void *data)
     	struct btd_adv_client *client = data;
     	struct mgmt_cp_remove_advertising cp;
 
    +	/* Prevent double-free if client_remove is called multiple times */
    +	if (client->pending_destroy)
    +		return;
    +
    +	client->pending_destroy = true;
    +
     	g_dbus_client_set_proxy_handlers(client->client, NULL, NULL, NULL,
     									client);
     	g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
    @@ -1265,6 +1272,12 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
     		return;
 
     	if (status) {
    +		/* Prevent double-free if already pending destroy */
    +		if (client->pending_destroy)
    +			return;
    +
    +		client->pending_destroy = true;
    +
     		reply = btd_error_failed(client->reg,
     					"Failed to register advertisement");
     		queue_remove(client->manager->clients, client);
    @@ -1286,6 +1299,10 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 
     	client->add_adv_id = 0;
 
    +	/* Client is already being destroyed, skip processing */
    +	if (client->pending_destroy)
    +		return;
    +
     	if (status)
     		goto done;
 
    @@ -1332,6 +1349,10 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 
     	client->add_adv_id = 0;
 
    +	/* Client is already being destroyed, skip processing */
    +	if (client->pending_destroy)
    +		return;
    +
     	if (status)
     		goto fail;
 
    @@ -1509,6 +1530,12 @@ static void client_proxy_added(GDBusProxy *proxy, void *data)
     	if (!reply)
     		return;
 
    +	/* Prevent double-free if already pending destroy */
    +	if (client->pending_destroy)
    +		return;
    +
    +	client->pending_destroy = true;
    +
     	/* Failed to publish for some reason, remove. */
     	queue_remove(client->manager->clients, client);
 

Pavel Bozhko (1):
  advertising: Fix double-free in client_free

 src/advertising.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 10 deletions(-)

base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
-- 
2.50.1 (Apple Git-155)
