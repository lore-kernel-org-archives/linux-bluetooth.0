Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B078FC07545
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjJYQmV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQmR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 12:42:17 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12060128
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 09:42:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3579c8f3054so2639055ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698252135; x=1698856935; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+3xASwmZGKSUzMXiUI6qYT3N+e/75Ybfl5GnOPizCE=;
        b=ktJK23iJ89Q7XOYZ2sqnjW3LrCp16fiNrx+5fhGJUn1gNV+Y1SBFIFxc8NVW3W6HBA
         6iwoLb+BrdsoDuAHvy3b3TGPFvlQzTmvTbnlAZl6NdrcVT2DjyUyay8OpBE/LvuJsGdg
         En6CSD+wn7ZgeNpHAWYdUaForV1juUZDLlmE6Iyaj0E3BZ/KeXGcyK0933rgZa6acUA2
         M3c3RiaFZ0AT/7Q3BML66a5Tp+F4Oc7K3YnXL6Rt9KJ3imsFVo86T8UGK8BgC7cKw1oH
         IuMIyypP05GZzdOOpQp6P4RXEjm16UhFlzkwjZ9zj2ziEovCL0NW1zIUzJcYvsGkYLOE
         zFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252135; x=1698856935;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+3xASwmZGKSUzMXiUI6qYT3N+e/75Ybfl5GnOPizCE=;
        b=mp9reohI+qeoMzyUv5T5fkmtMcV3qZEwTXmTT33Prd+/Pyp7ZaY52J08x2+BZCoSN1
         1dm+mYxUyFHiOwmCTafbQ/WqmQIvR69F3IRPJ3qFiECGJrdGc5m61MVsqS2lKkGld8lD
         RR9WBb20NNkVG77EN7d0uVhAVECSkYsxJY+CrkkKzHjyyAzLQKhHxe6ms75Na4MyWHIP
         gQ+U/1+SlyelPqQaKCxvhKrLliyyTzFDdb1+Ujl2wZ9jr8IYrQ+AxDpTXs1lSHYV/9+I
         lloJK3cB6wW5++pMzdnJUOe2ZAw0rouVANflGw5g+BuiA6/CbvlQXGfH8WI11RMsT7aZ
         0M5Q==
X-Gm-Message-State: AOJu0YytyI2aHf571Dlop7BTn37qitiygl6T7jd4wER6azBOmFWsWo0g
        Dz3qgNDzC3aiAxdQGFbHLJGTgEDdkTA=
X-Google-Smtp-Source: AGHT+IGAO86mcBtXNcmdzbjSAIaElA77AuX7RzsEBUKUn6FSmBmCLRPN22WEu/gaDPUazRVSTqVFUg==
X-Received: by 2002:a05:6e02:5cc:b0:358:219:bfb0 with SMTP id l12-20020a056e0205cc00b003580219bfb0mr214075ils.11.1698252135235;
        Wed, 25 Oct 2023 09:42:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.197.255])
        by smtp.gmail.com with ESMTPSA id w18-20020a92c892000000b0034f37a27bb4sm3803109ilo.72.2023.10.25.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 09:42:14 -0700 (PDT)
Message-ID: <65394566.920a0220.34f9d.4824@mx.google.com>
Date:   Wed, 25 Oct 2023 09:42:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8349964560586381592=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Move io handling out of src/shared
In-Reply-To: <20231025145411.2923-2-iulia.tanasescu@nxp.com>
References: <20231025145411.2923-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8349964560586381592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=796496

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      39.21 seconds
BluezMake                     PASS      1285.89 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      237.63 seconds
CheckValgrind                 PASS      356.32 seconds
CheckSmatch                   PASS      495.92 seconds
bluezmakeextell               PASS      155.13 seconds
IncrementalBuild              PASS      1134.47 seconds
ScanBuild                     PASS      1529.12 seconds



---
Regards,
Linux Bluetooth


--===============8349964560586381592==--
