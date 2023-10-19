Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE075CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 08:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjJSIou (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJSIod (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 04:44:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC08134
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 01:44:11 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d0ceba445so45513356d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 01:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697705050; x=1698309850; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Szi7k25JZMtb7lkakQYl+fKj5uxQLsi67I0m61u7byc=;
        b=IHiyM7CvgSDuCcsbk+m4epR7nYWbi3qNRT6rsiH3F0Dc8tCZ4W8mkbY1fX37/CgC8I
         afxqRG0tXvs4u1dHGChejkhBH8r32vI2UPeJ3wNkZjqEF6J/btyz3LP/LFnAx//ZYd5q
         fygnFHE2KGlmYjls0UySggwNrnHfDSC6CP1qzWFEZO0jCpaQDnbpSCymID19rqrB2iEK
         ZDU8qFQNNXz7KwGRk6anVY8jYzItEg3SgwMIrOjsjDRmoAZJ5lMDQrnAEP9AHkciLHmS
         KRtkAVlLw9Xy+97Ko3Ekr8dY4BqXbYAhaR/IL9+6v80dJXZaJhVxqGaDMiq51XhQHmqg
         us7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705050; x=1698309850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szi7k25JZMtb7lkakQYl+fKj5uxQLsi67I0m61u7byc=;
        b=o0TTEXO+PZ5G6lAlceMvfxCDZP36wSAzqOTfzdwp7mh6+3uQtXsvh9+gRdFDWKMNC/
         HtxTphEXeDGt8FL3jsIuGCDOhrqhLCjo7+sbIFjO5C1tW5nArtAeEydZh+VfwkQ1+u1c
         qd8goN7CUBddvJ40eEvwJAKgCplk2RfhJBBo8YIXSaqlL8uZ2gHT2s209pQEdVrUrkYJ
         sKmHivqcksKq7JbCfHl9Ke4i7kNv8y0uZd6vsBbTYFNEl0WmEDxpLy+g63hVY8gga5IT
         ZtgY4xjaAeB8PdWT4VOLR+tE1yjItBAKjw83IQp73ozB4y9/svmQ0emUPDE3/nMRFBZp
         yB9g==
X-Gm-Message-State: AOJu0YyQPBqJLXaEnVydrMqAwRS8IpIvV8CcGc7NX1ic9714uFZOJBOv
        iImV/JvQ3aZwIpycdKaNOgPfvMHSPUc=
X-Google-Smtp-Source: AGHT+IETQqZ11Mbs6/KWARxr9VkjlJQlS6VmvBkz27unMcPAj6J/oh3+aabP+heEB1N7kZDfraiulA==
X-Received: by 2002:ad4:5ae8:0:b0:66d:4569:9941 with SMTP id c8-20020ad45ae8000000b0066d45699941mr1672125qvh.45.1697705049953;
        Thu, 19 Oct 2023 01:44:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.175])
        by smtp.gmail.com with ESMTPSA id t16-20020a0cef10000000b0065b1f90ff8csm631115qvr.40.2023.10.19.01.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:44:09 -0700 (PDT)
Message-ID: <6530ec59.0c0a0220.313ab.3024@mx.google.com>
Date:   Thu, 19 Oct 2023 01:44:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0808572569003409397=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, purendra.singh@nxp.com
Subject: RE: Changed Obex default timeout
In-Reply-To: <20231019071651.4773-2-purendra.singh@nxp.com>
References: <20231019071651.4773-2-purendra.singh@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0808572569003409397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794595

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      29.22 seconds
BluezMake                     PASS      1046.14 seconds
MakeCheck                     PASS      12.19 seconds
MakeDistcheck                 PASS      178.48 seconds
CheckValgrind                 PASS      277.44 seconds
CheckSmatch                   PASS      367.49 seconds
bluezmakeextell               PASS      119.40 seconds
IncrementalBuild              PASS      854.28 seconds
ScanBuild                     PASS      1126.69 seconds



---
Regards,
Linux Bluetooth


--===============0808572569003409397==--
