Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1951C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbhKYHMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353171AbhKYHKH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:10:07 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE37C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:56 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id az44-20020a05620a172c00b0046a828b4684so5301050qkb.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=INm7pXDA0xyOS7X6mzWYKK1ZwjPVf1vUklVBZrsNc+k=;
        b=R82DHbFP06+V5YN3Esyqr6BcOyWB/UIEfyijXnz1vHpDKH3byYfRrHaEf6Ec2AzIeO
         CmoFr0HiLSOHWFkDBUmuXH8AU5WdXVGG7vJUXwadQVskF76nnpVTPDkfNaSPPMmSWBZ1
         qKrlo/l4hfn6cTk/4B6iZbSYxZKz3WkukO91GGzPBNmX6pWexcxufuOlmKZnk3bU7Oip
         GVW9igHfoFzyg4jR7BsrS0eNBa1X1dDCno3XKySMSBURS1zdra5JWqvARNM0pJBKcvUv
         H3o7lssoPuk/Wtlbhyt1yBy23VFgGjmrJHH9ctaEMnVFWX5pKI+xH3NM24We8mOzyhtb
         YE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=INm7pXDA0xyOS7X6mzWYKK1ZwjPVf1vUklVBZrsNc+k=;
        b=joULibcu9MIpSu5Sh4sX+5QIyKB1OL9L7sNDQ962tP/rLEUKIkcE70i9uwHfN5KQlv
         cVy4Y3b14nNYudTA8g08aDus5RLCbbsGy1sYCqCG2eQjsDjoMsR3H4dQBYP6Jr/t5I+I
         76OTUbv1PgRS03YJqMRt9aCyGMLQTL2BPqZeGjwnP2+6TpEZhoNNUZ/rkRwU6NGsUKCa
         j5MjEXY753Fqe6rzMkmeDqqpwBwo8F7gdrMTRWaJL1dK9UkKgz1pJrMROQhHMEQOalwo
         7kMit+nO2bfY5vgacSiM67NXgEVS6GyIQ53U1xZv5SJ5tERLSFUdcl9q8+192feqoIkJ
         JMOw==
X-Gm-Message-State: AOAM533tOxtezPqeRDSeq2b2wBVnnzyO8eKBmVqivh6bcsJoso26OVVY
        58Pjn/2/t/jwej658z0yJ1g28WHirzvR/UfhW4uRHtRmOKCUy0bIv4jmRXM2zaoso8b7dhkDqf+
        ytK94SZhbAsc30etL5JRvc9zOP3DWcbcnbPTHX0pc8OxetvGhcwm8FhomnTIDseJWSu7FxPg1XR
        WT
X-Google-Smtp-Source: ABdhPJzTt3iUw9VBzajdS/omoIZ67rTg8S70JKJs38eoSuBxkexh9H5QuJjcBX2ErdeSM0lQ5uAgkOI4EyLw
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:a25:cccf:: with SMTP id
 l198mr4048148ybf.238.1637824015751; Wed, 24 Nov 2021 23:06:55 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:06:27 +0800
In-Reply-To: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Message-Id: <20211125150558.Bluez.v4.5.I29367ca288fc8f4fcc3b4063425b791501c6534c@changeid>
Mime-Version: 1.0
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [Bluez PATCH v4 5/5] doc: Add Name Request Fail flag in device found event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Userspace should use this new flag to decide whether to do the remote
name resolving or not.
---

Changes in v4:
* Add information about NameResolving cache

Changes in v3:
* Update the flag name to be more inlined with the spec.

Changes in v2:
* Update docs to reflect not sending DONT_CARE flag behavior.

 doc/mgmt-api.txt         |  7 +++++++
 doc/settings-storage.txt | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1ab513eb17..ebe56afa44 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4090,6 +4090,7 @@ Device Connected Event
 		1	Legacy Pairing
 		2	Reserved (not in use)
 		3	Initiated Connection
+		4	Reserved (not in use)
 
 
 Device Disconnected Event
@@ -4264,6 +4265,7 @@ Device Found Event
 		1	Legacy Pairing
 		2	Not Connectable
 		3	Reserved (not in use)
+		4	Name Request Failed
 
 	For the RSSI field a value of 127 indicates that the RSSI is
 	not available. That can happen with Bluetooth 1.1 and earlier
@@ -4286,6 +4288,11 @@ Device Found Event
 	accept any connections. This can be indicated by Low Energy
 	devices that are in broadcaster role.
 
+	The Name Request Failed flag indicates that name resolving
+	procedure has ended with failure for this device. The user space
+	should use this information to determine when is a good time to
+	retry the name resolving procedure.
+
 
 Discovering Event
 =================
diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 3c637c3521..26584f2015 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -179,7 +179,7 @@ Cache directory file format
 ============================
 
 Each file, named by remote device address, may includes multiple groups
-(General, ServiceRecords, Attributes, Endpoints).
+(General, ServiceRecords, Attributes, Endpoints, NameResolving).
 
 In ServiceRecords, SDP records are stored using their handle as key
 (hexadecimal format).
@@ -193,6 +193,9 @@ In "Endpoints" group A2DP remote endpoints are stored using the seid as key
 an entry which key is set to "LastUsed" which represented the last endpoint
 used.
 
+In "NameResolving", information regarding remote name resolving are stored to
+prevent wasting time resolving name for unresponsive devices.
+
 [General] group contains:
 
   Name		String		Remote device friendly name
@@ -247,6 +250,12 @@ Sample Attributes section:
 					local and remote seids as hexadecimal
 					encoded string.
 
+[NameResolving] group contains:
+
+  FailedTime	Integer		The last time  we failed to complete name
+				resolving procedure, measured from an
+				arbitrary, fixed point in the past.
+
 Info file format
 ================
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

