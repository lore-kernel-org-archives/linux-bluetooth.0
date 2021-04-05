Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15137613C6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhDEUju (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236543AbhDEUjt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 16:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9pT04HFS6m2DAVcuINr+EcsKi1hIY98jB9f+EJVDaQ=;
        b=gB9n+d4JIlrxDocBFrQvoK5sSNGvwQu9c3U3G4ZZzSKI5SWRQ7G8Ml9CcAMp96WCn2XY72
        M8HBnCeHBIY+XUVWMlsGtFlsYJDQsWMaRwhx+tV8WeUJwgK2mPMltUWodiEdKPByF47106
        Od2/gxrllQCkxBry5bLTys+z3JkQGFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-hKNKnrT3Nd2mWRrtJM56VA-1; Mon, 05 Apr 2021 16:39:41 -0400
X-MC-Unique: hKNKnrT3Nd2mWRrtJM56VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173CA1853025;
        Mon,  5 Apr 2021 20:39:40 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B6860861;
        Mon,  5 Apr 2021 20:39:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 resend 2/2] iio: documentation: Document accelerometer label use
Date:   Mon,  5 Apr 2021 22:39:33 +0200
Message-Id: <20210405203933.17282-3-hdegoede@redhat.com>
In-Reply-To: <20210405203933.17282-1-hdegoede@redhat.com>
References: <20210405203933.17282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
have 2 accelerometers, 1 in their base and 1 in their display.

In many cases the kernel can detect the location of each accelerometer
based on e.g. information from the ACPI tables.

It is important for userspace to know the location of the 2 accelerometers.
Rather then adding a new sysfs-attribute for this we can relay this
information to userspace by using standardized label strings for this.
This mirrors how this is done for proximity sensors.

This commit documents 2 new standardized label strings for this purpose:
"accel-base"
"accel-display"

Note the "base" and "display" suffixes were chosen to match the values
used for the systemd/udev hwdb.d/60-sensor.hwdb file's ACCEL_LOCATION
property.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson@lenovo.com>
Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7379e40d862d..b7529bca83f5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -72,6 +72,13 @@ Description:
 		calculated by firmware from other sensor readings, rather then
 		being a raw sensor reading.
 
+		For accelerometers used in 2-in-1s with 360° (yoga-style) hinges,
+		which have an accelerometer in both their base and their display,
+		the following standardized labels are used:
+
+		* "accel-base"
+		* "accel-display"
+
 What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.2

