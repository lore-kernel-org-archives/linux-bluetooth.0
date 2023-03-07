Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBCC678D4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjCGTLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjCGTLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 14:11:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C006AF2BC
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 10:55:34 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c18so15523935qte.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678215332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v5KIEV9K6PW79n+o24t5oaLi3SL+IhA1grdn3Dci7FY=;
        b=cC0zStUZ0gee0PHcvmLDU79EiU1a3RauRuBV2fTzVJy+6qGsPdmNRRL2HcgO7MifeY
         ec6J7bGjj/CS4LuyX0RHZi5IQys95uoZNuNKyR6nu/1eSIKYJz+yZzQTKIgjDb0oV2a6
         dzRf7kVg5LC8ea7JHyCp0qG8oYx1OgWPbX3yz68xhNZQUTYwFdY5DW2msKfDHCBCW8ri
         ix/0/W8Bne3BbqV7gPF2RC6t5N+ABh+/1uFCLcrk1cbz3cuqbZCqv/ohhn5V+2qPNOyt
         wSMopGan9kyXf2Am55wmb64tUomJMfivZCuTEXFcr4dNw6grGLtrOu1UqRAk8OlfNPxg
         /HCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678215332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5KIEV9K6PW79n+o24t5oaLi3SL+IhA1grdn3Dci7FY=;
        b=ivuVEoUn/CMD6gOMgnHUpcpOmcqG7pxNqLip017Zs9JaBSYwao3GDbQ3IdQnmtx86u
         mQTQcrK6LAg8nnuhtsU57NUvlEsPSn+nSdkZTAat0BAc4rJm8T6eboqxCv7jDZ0SBmgm
         2DHYDLf0DzQ8j8LS2l0QlHd91d/F7F56VS8XlfEyVA1cql+/iTqvxWIVYwBVlwDhPTu+
         i5v0npQfRRZK7lUHdk5UGlcQl0z8VtjgafvY+zMuwAkv1/fyPCr5FnPIoVTQEeZOmt8t
         1Bhi9mnrE588ky8aGfAOMjEli+JNx6AU6fVqHADpJ7IC060xvnyJ8L6V9YSiQ9ZD76JE
         OLfg==
X-Gm-Message-State: AO0yUKWAI121VGw/6LoBti56kFQXqfjsygeGJXhrXmGjx8QyTGqVjd5j
        /cGKELOJrabhH8k0hq4394kMXNPJ5CFpfg==
X-Google-Smtp-Source: AK7set/yHqeGZKh6Gg6Y6y8uDx1eA/x8PnBDh2Q2RIGxigxM28hiLw1riMl33jFKN6eHd6IENRZS6A==
X-Received: by 2002:a05:622a:11d0:b0:3bf:dc7d:2221 with SMTP id n16-20020a05622a11d000b003bfdc7d2221mr26001828qtk.47.1678215331770;
        Tue, 07 Mar 2023 10:55:31 -0800 (PST)
Received: from [172.17.0.2] ([20.44.102.34])
        by smtp.gmail.com with ESMTPSA id v25-20020ac87499000000b003bfc0cca1b7sm10039940qtq.49.2023.03.07.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:55:31 -0800 (PST)
Message-ID: <640788a3.c80a0220.bc13b.1179@mx.google.com>
Date:   Tue, 07 Mar 2023 10:55:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7296179944474602656=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
Subject: RE: [6.1,213/885] Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds
In-Reply-To: <20230307170011.338040639@linuxfoundation.org>
References: <20230307170011.338040639@linuxfoundation.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7296179944474602656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1983
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7296179944474602656==--
