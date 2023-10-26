Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64892C25B67
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 17:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjJZRpi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjJZRph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 13:45:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0B90
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 10:45:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b5220ea82cso729379b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698342333; x=1698947133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkLSupdDvMvAe2I+qVt33vur0lkfpBGzaamu36hWBLs=;
        b=S23+cr5FLpM1bYkGUDG4mI8ByVAbQQBJPqncFLA8J75sNIaNeigk3+eik1/TKzS9gK
         FFvYvAuNXFfHx0rc9LckVQS81hFRRyjdS4xU5mLJyoelYI4UXzYnp7AZEHstugDvXeJp
         fbwVNQmpYq+JuAHysjbdaZt9jH8WsaDX81QCmgHuEaxGs6qRGRNMwwQ7wqj7KJE+zI0L
         O4RpkM9nSxzXmFQ2njvzQe+Gyro4K3XZQSdET8ZSXj+f7frlk7ATf+uFiKv2jMK5jnVr
         8YxeEi/8L/dxlxQthlVZKFTW/ccHZHL6T3C/btGgGUwP/MDzzsznTp/Um1DeGykdNw6E
         Bp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342333; x=1698947133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkLSupdDvMvAe2I+qVt33vur0lkfpBGzaamu36hWBLs=;
        b=Px4jcQLpOUHrDXrMr1n9Jl6MdmB+ZZiKUycLnJid+MuKyKNKKE3dqzyxAMwXrisI2a
         aUkNiM4fusTWjfZFIexjLllAON7zIagD+ww0r7yt3VKlLmglM17Kb8ugBhgvIkxFzMHH
         kxAZKWo4Y9Wa0LS1T4Wf1N3AN/829ILXi2uXg1XAndVivlk2d08ANNG6ktvZnJRJhe8d
         8DwsY1LiN5ST5GIBWdgTP3Gh9nSjGZQ0v2kjQROciTmRkHJseO62is7d3/8Pd48/boVA
         +YazlimGaMdpyOO9hhpED+6dxaf2sZk3xIswfLQ6GHYo+9vY5DFHKgRKbUw/OukiMdZo
         OlXg==
X-Gm-Message-State: AOJu0Yw7JSbvrhYqh3PgxtCAIHPqxHWcIgCsg+7nhY6F3Hgu3RwPZjeg
        0wcJPGLYaDZtmjvGWhZLggBEKQQDsYg=
X-Google-Smtp-Source: AGHT+IE6p8qX0B2+AwcIt5CEyYeL+WiLB6nGx/MivESVnJLiehdJ7R7mw1fiD4+Z0u3B5srmV/E5iw==
X-Received: by 2002:a05:6808:102:b0:3ae:4ca9:cae5 with SMTP id b2-20020a056808010200b003ae4ca9cae5mr63739oie.21.1698342333621;
        Thu, 26 Oct 2023 10:45:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.179.115])
        by smtp.gmail.com with ESMTPSA id t9-20020a05680800c900b003af569ad2c6sm2847482oic.3.2023.10.26.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:45:33 -0700 (PDT)
Message-ID: <653aa5bd.050a0220.81f15.2562@mx.google.com>
Date:   Thu, 26 Oct 2023 10:45:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2885135190013552161=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20231026145047.4637-2-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2885135190013552161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=796846

---Test result---

Test Summary:
CheckPatch                    PASS      3.65 seconds
GitLint                       PASS      1.79 seconds
BuildEll                      PASS      33.84 seconds
BluezMake                     PASS      1085.99 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      215.11 seconds
CheckValgrind                 PASS      325.67 seconds
CheckSmatch                   PASS      449.76 seconds
bluezmakeextell               PASS      143.73 seconds
IncrementalBuild              PASS      5540.16 seconds
ScanBuild                     PASS      1243.12 seconds



---
Regards,
Linux Bluetooth


--===============2885135190013552161==--
