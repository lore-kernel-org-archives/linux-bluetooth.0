Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C76CEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 09:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFWJT3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFWJT2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 05:19:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEDC2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 02:19:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b52132181aso1968745ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687511964; x=1690103964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l6rmEQm3qNJebN6tmwoHp9xN6WFYgN2G+KnrMDSzJfs=;
        b=sIQTR3twfjCfyxjUFpBjzkBNUjcEZqmwdVJmVUQESFMh6iKW6t0RGO1ibW77sSGWDJ
         yCZjvKxjqstrP0oB1ad0kR2NMYij4m2cJYK9e+IfgXPopuH91svSefZ0roWPGHDOhyag
         OZWE2COcDomFieY8SNoRbamEfIMNOfXQJ9i25+h2hc9YRRGIrsZgznxyW3QoR15+ULg0
         loWCP9LhMiS08aR+lLYlSm72Klm5BkAMWMiP7vCS0hmHr1FJuesob57SR6u4YDH5xGuq
         o3BqPWu+fi6kwd+z2UJgy/HstaLCOQfSGAsop/G8Z3ZuIVyhPrEHtRANQDl9ru9LUA8Y
         dkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687511964; x=1690103964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6rmEQm3qNJebN6tmwoHp9xN6WFYgN2G+KnrMDSzJfs=;
        b=X1Bb4PLZnnKVPDRZo98wGDAA+e/8Wk69k/ttqH73cgfckibUVdKWJuuFgJ2sOKeQFq
         DVileH7ahVDIjk45FGDAHkcklpOYnNlfkpL8uZDPWU4KI1KVWDLPo619Ow+VKF/zIXWc
         vYrEjU4rBZTqT/rusSLezEBYpu01lYf9Kk+CwMRrJhucihgu2lTgYN1RJL1GlGUFIHsG
         QGILO2YOM2ki2vNaBr4ZWTvshf6fyI92dIBSVtvwOH/RjHoO4TWdIuaVdiZG0j8H2J5W
         YW+fgjCkwkqK5KeTjZG6aQodF1xOs9VQ/EbEZTOA4Oez24xmqiz2vjcY8KAlCaBa8rFi
         zRRA==
X-Gm-Message-State: AC+VfDzIxSOHfm1ZGhUeBsIBSwiBOJOhKFH4d7Sn2B6Zlpz25WVB8io7
        ALZTCZ7RRJ0iQ4aEzzRAxNlGXNQ2XdA=
X-Google-Smtp-Source: ACHHUZ6IABsgrGlU89YBVv4xXzejeTkNoTZzccLfNumgIjxIBpiIW9juA21j20pW45zviRUo/2sV0A==
X-Received: by 2002:a17:902:e889:b0:1b6:97d9:c74d with SMTP id w9-20020a170902e88900b001b697d9c74dmr6910214plg.32.1687511964622;
        Fri, 23 Jun 2023 02:19:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.193])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001b3c2f4c9casm6700499plw.253.2023.06.23.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:19:24 -0700 (PDT)
Message-ID: <6495639c.170a0220.476c3.effd@mx.google.com>
Date:   Fri, 23 Jun 2023 02:19:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0337900880623644880=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: isotest: Add check after accepting connection
In-Reply-To: <20230623074406.16522-2-iulia.tanasescu@nxp.com>
References: <20230623074406.16522-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0337900880623644880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759716

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      27.68 seconds
BluezMake                     PASS      884.65 seconds
MakeCheck                     PASS      12.42 seconds
MakeDistcheck                 PASS      159.39 seconds
CheckValgrind                 PASS      262.54 seconds
CheckSmatch                   PASS      340.96 seconds
bluezmakeextell               PASS      103.63 seconds
IncrementalBuild              PASS      715.11 seconds
ScanBuild                     PASS      1093.68 seconds



---
Regards,
Linux Bluetooth


--===============0337900880623644880==--
