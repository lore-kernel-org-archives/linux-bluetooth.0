Return-Path: <SRS0=vtF+=5N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C327C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F9C2074A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kYIK8Ljp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgC1AMQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:12:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36905 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgC1AMP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 20:12:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id u20so5679970oic.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8SKf147sx6Up652j5vl0kFkxoWFi/Cb8UYi+eKKoUfU=;
        b=kYIK8LjpUahfNDPSTbiSCu5D3zrANEpLCCreZLcRCD6oJ76tKT50UwlXSTpZEcWOiK
         tjzbDD2ymLsIjsUKCJ+1LwYZEtR2ovNheRXyvlO8NOUdIE5xaTmfSgmD/xSXoS0wyl32
         lEg6i0W5v+ya1Gyx9DhDDk0l+h0B1028rtcy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8SKf147sx6Up652j5vl0kFkxoWFi/Cb8UYi+eKKoUfU=;
        b=UOgXYlb7MAlBr4vSZ3BQohkuAk1qeeIHDJBAg6DAFjWSwUXOtW5mzUO17jdynUPIp2
         QiPqwbaGVX+OcSujoSkEFSM+Gu2Zn+IECyd8aCCJ902Dz+/4jCI3HD7CtcxFkB9faA5F
         Qz09upumARWFompC2EV+LFmDwlYaeH55OGN37HiSoOocjK6RsYTJ33KSDzGY9156zVIJ
         plziFQkryvqeLDX6OuBAltXJk0l7hMJlG5GgExYCvP4uw3X01C3GZpPSNdmyaxhhlz93
         W6bK7vRu6FhPAFu/mbJhsDuBwNjq3r4SvntyghLyWNfb48sljxYM3mIFbFgVugfz8CvR
         zt2A==
X-Gm-Message-State: ANhLgQ3QE/XYkz6vlbUX/yaneXlOenJNh10rImdswi8cELUqsLtaHY/s
        0QyEBsjqjVv3PzTMr9IXItQbbKqS8BRCL9szBcQ6p4VAPzg=
X-Google-Smtp-Source: ADFU+vts6BJjO0esw+kVtwbmbbBhomZMVlyQKUy95iyKfTrJCec72jLVXHnbsHI80GM88sjrC3btv2vG0v7RV76vdPA=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr99769oig.27.1585354334867;
 Fri, 27 Mar 2020 17:12:14 -0700 (PDT)
MIME-Version: 1.0
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 27 Mar 2020 17:12:04 -0700
Message-ID: <CAOxioNkrxDEKuX4AeHWkDSHrwmsBqYXKRi-UtyUqfs1Rw7pePg@mail.gmail.com>
Subject: [PATCH] core/device: Handle Just-Works auto-accept
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The kernel starts to always request confirmation to BlueZ daemon for
Just-Works pairing. In this patch the daemon does auto-accept if the
client has clearly indicated a pairing intent by calling the Pair()
D-Bus API.
---
 src/device.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 69f98e488..db14cc129 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6168,12 +6168,22 @@ int device_confirm_passkey(struct btd_device
*device, uint8_t type,

  auth->passkey = passkey;

- if (confirm_hint)
+ if (confirm_hint) {
+ if (device->bonding != NULL) {
+ /* We know the client has indicated the intent to pair
+ * with the peer device, so we can auto-accept. */
+ btd_adapter_confirm_reply(device->adapter,
+  &device->bdaddr,
+  type, TRUE);
+ return 0;
+ }
+
  err = agent_request_authorization(auth->agent, device,
  confirm_cb, auth, NULL);
- else
+ } else {
  err = agent_request_confirmation(auth->agent, device, passkey,
  confirm_cb, auth, NULL);
+ }

  if (err < 0) {
  if (err == -EINPROGRESS) {
-- 
2.17.1
