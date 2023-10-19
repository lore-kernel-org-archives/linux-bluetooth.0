Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7C7CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 16:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjJSQhO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJSQhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 12:37:13 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4765F131
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:37:12 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6cd33d51852so1004270a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733431; x=1698338231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pRGsz/gTZaBNfr+bAoPkYF4koXU3PbOG5crL+kLX8aU=;
        b=fuhgPT4ICUfvCUgH/2HKvKLf1AK5a1DBgXVpO7W+G4sxw1f6Edey5lKmtG3g3rGxmo
         TakJjtmjDt646u/GUhUTtGe4RVEp92kFIz2rQ0Kq5ePeKR1UOZEkSYVDHILClEt1gxkw
         4n0MXDgKUdlwTn3D7xUPZzmXPH5Uw3ecfvd7rJ1nn9nGKX/GzfgMmn7crcpzmoYlSSzu
         Au5EQhfgEeFqUR5uVn2aW6D9c+jxOGz6VyRXyXaKeXYCoB969uQh1ELh5TgW8zZ5BH2G
         8+PafUvQKbtoi3d6H6w4ZsKgSIaQgFYUv5uHLyWleT1XiKlePXvCU61FT1crkfGAmLmg
         f0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733431; x=1698338231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRGsz/gTZaBNfr+bAoPkYF4koXU3PbOG5crL+kLX8aU=;
        b=VFtXgLGQx9+xXiB53fY1XDlE6gYRds62MsiToCzveqa743bd/6xQ+/Qu2LF6XSquGd
         HBqQQBeoKFqiBqYUQRwP8n2EzVC0n88tnguUQkkRdkNhEq/ccz5lngCDq9gPFpOCVQGm
         5gkOK2eykKyflnJbSlLwVTTHHX1ygEjRZkc3ynmhTCFR2+ZCwhoxtGns79ao6+E/mZQe
         LYjs/HgDNQax365bjGvMRZYsDvIIbmRPW/IOjiopB2m31zAv5DoaZ/HIEL/BDnLecdFv
         XhIVsDi/kIwG9dwMnixJFpkhk6V/WycBs1UUjFLp9iiUfy9Ur0O1OCq1HICwX8D4inSJ
         9KtA==
X-Gm-Message-State: AOJu0YwLIC/Q3TPZ+7cDZAE5OX47XcO7oaHcRiDY0RB/oXW3BRPFdYt6
        gfJlIvnTDeGPtve3zEz30ckashfGphM=
X-Google-Smtp-Source: AGHT+IHhCDSPpcpoAtChr+np6v7iI/1WCWsxHKr6I1RV3L+EI62cddUwIjBTOXc2AXlsB+9i/RMSjQ==
X-Received: by 2002:a05:6830:d0:b0:6c4:ac5b:aaea with SMTP id x16-20020a05683000d000b006c4ac5baaeamr2866610oto.25.1697733431169;
        Thu, 19 Oct 2023 09:37:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.139.244])
        by smtp.gmail.com with ESMTPSA id m9-20020a056830328900b006ce2db9e6c4sm161477ott.36.2023.10.19.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:37:10 -0700 (PDT)
Message-ID: <65315b36.050a0220.25da4.257e@mx.google.com>
Date:   Thu, 19 Oct 2023 09:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4195097325114967910=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: btio: Allow binding a bcast listener before accept
In-Reply-To: <20231019145226.4879-2-iulia.tanasescu@nxp.com>
References: <20231019145226.4879-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4195097325114967910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794780

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      35.85 seconds
BluezMake                     PASS      1190.48 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      225.22 seconds
CheckValgrind                 PASS      337.52 seconds
CheckSmatch                   PASS      468.80 seconds
bluezmakeextell               PASS      149.45 seconds
IncrementalBuild              PASS      1075.92 seconds
ScanBuild                     PASS      1427.41 seconds



---
Regards,
Linux Bluetooth


--===============4195097325114967910==--
