Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F93C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13B920791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwZwlBvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ2XGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o11so1729400pgj.21
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lcQI8c2L4RzrSzx8LBB04nbS9XIOWhnktjSc8NnfV70=;
        b=vwZwlBvWfdaMHKFocCheVni0/Lc4zbNeRhl8gOQPm5h1ZRP2v0Nl6wzFbF97h7xXn5
         zq0Yb6TGXpwVmp8A+RPz0DyJSlrNWorjfu6+nerTxcCrrD9BkD7oAsj2Pp+GuhudAz0q
         zfbFehX9SA+3W3MB3hqgtkMRgB1gMR92o2+2tMWfpZDuC71x18S3H71wE5xx1e6VkqP7
         Dk8dA0vflmW1sksvQryFlKl9ztfQQYgD31QlFfQlf9T0Zt1oI6iFDYp2pZ1YE0IIkR9g
         Quy4uvCs2TiBqbFFT29MJaVKfhHyycgbpyb0Xs2l/aACZt7YoHe+LdIMj0U73QPTxVAb
         DFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lcQI8c2L4RzrSzx8LBB04nbS9XIOWhnktjSc8NnfV70=;
        b=uNb+9QPtsZODGNRxK87s9yFBtHL8YWrFtWxwHLzoH+6TWbTHwNFMXASJHf5hdgzHBe
         wTdMTXsor8pPpWsy04TXu600sX7GpseyQYDkqr21ibHy8fLoe3bf1YX7srPuQVlrycaW
         90WitU4NmR5Z/Q1Gcj2Tp0Vvrt+jmVMqSNfexf311PD4KCWfV8FOxI5kajlSkX8JOClu
         hsdQ0zYvbqu4x2Kw0zswynSGdaIOO6EMX8KZDnhkkuDxpjZI+W0zMQKhTWzM8mX1iqgN
         6bcdIywO+UB7NwsmbjH6g1efbVLSYA/SYhCET8TxEJfi/CLu6SpPZ0V4YAl0m+OgND2C
         H5Mg==
X-Gm-Message-State: AOAM533RzbI6yibEbK157+FmttgaDDyH3ww48BvzimJP3izgktPAK7vH
        PWVnA8jLZkFGyYKEq8/kU5ltiU2VEUus77K3iClp
X-Google-Smtp-Source: ABdhPJxohdysptvLGCiJxo+aWLN/84PNHmNuJ1bXfkZblh3mFntBt43W0auCVC5KOwi7QtWwGwf6vMPV6SUDElQutRqG
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:868f:0:b029:155:dcd2:7320 with
 SMTP id d15-20020aa7868f0000b0290155dcd27320mr6500610pfo.53.1604012791461;
 Thu, 29 Oct 2020 16:06:31 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:13 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 01/10] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the advertising documentation to include the following
features:

LE Advertising Manager:
- New SupportedCapabilities property

LE Advertisement:
- New min/max interval properties
- New tx power property

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v6: None
Changes in v5:
- Changed interval API from jiffies to milliseconds for clarity
- Changed new dbus endpoints to be experimental

Changes in v4: None
Changes in v3: None
Changes in v2: None

 doc/advertising-api.txt | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..541c57004 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -138,6 +138,31 @@ Properties	string Type
 					"2M"
 					"Coded"
 
+		uint32 MinInterval [Experimental]
+
+			Minimum advertising interval to be used by the
+			advertising set, in milliseconds. Acceptable values
+			are in the range [20ms, 10,485s]. If the provided
+			MinInterval is larger than the provided MaxInterval,
+			the registration will return failure.
+
+		uint32 MaxInterval [Experimental]
+
+			Maximum advertising interval to be used by the
+			advertising set, in milliseconds. Acceptable values
+			are in the range [20ms, 10,485s]. If the provided
+			MinInterval is larger than the provided MaxInterval,
+			the registration will return failure.
+
+		int16 TxPower [Experimental]
+
+			Requested transmission power of this advertising set.
+			The provided value is used only if the "CanSetTxPower"
+			feature is enabled on the Advertising Manager. The
+			provided value must be in range [-127 to +20], where
+			units are in dBm.
+
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -209,3 +234,26 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		dict SupportedCapabilities [Experimental]
+
+			Enumerates Advertising-related controller capabilities
+			useful to the client.
+
+			Possible Values:
+
+				byte MaxAdvLen
+
+					Max advertising data length
+
+				byte MaxScnRspLen
+
+					Max advertising scan response length
+
+				int16 MinTxPower
+
+					Min advertising tx power (dBm)
+
+				int16 MaxTxPower
+
+					Max advertising tx power (dBm)
-- 
2.29.1.341.ge80a0c044ae-goog

