Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18630C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 07:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D80218E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwNp4LtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCVHBZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:01:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33673 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVHBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 03:01:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so874293pgk.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P0BB8X0AFBff4VBY6TK+SCP5T3sAekoVXz1dmhKIDqM=;
        b=FwNp4LtIXpIjGSQvkC+GApraO+nJY9cW88PsDDkgUKHRtpT0ZPYZquQ71H5z2NKjS8
         x+RKLhmiKVAGhmftGzjXQh2l0sOl/CzuyQgftGHZz5TK/eINQTqqyAeWw5hXO11IxGP6
         tKlAlY2YAX5yatvwqeORVFMBEEcMfaCSYzFg/upMrknPxzPHnT0CKe8+FFjq7GeeAFAr
         7yZ+0PqcZUNf+2YtC2/edp9EFFE47mFaOnW/10M4f6H8FqPRdx8NtQp+UM/oGNRS00of
         +do9Qy33tjUGInKcmt2GVhf/9mZtr3Wr+rX32gLtdbJzKC6+a5ErhIAsKJK/akzsWaeZ
         TDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P0BB8X0AFBff4VBY6TK+SCP5T3sAekoVXz1dmhKIDqM=;
        b=MCUZhbnxNrTzcUJOA8v9QWmren3Ep15q7Vje2WiQbTshK9y1SZH8zi7EbZvD8wHWoB
         aOSWjMnb5YblEcR3kDHkxfqTiccAoRA2HGeAEct+Qk1t+YFp4Xwb0vW0G43nbQyT5efu
         qI8BV9rSlIONebHD9yQfOoX8m/DeMsC+D/lGGA0HrKEUYCTQdsw8snxhJAirl7vbNTB3
         f/uqjCS3q0l3obykn5fbovDiAsZsshDr7aXUen1YKlK2h5/fFqLY9DBB0bnLnokK6wLw
         yuDgu3sYvLh9aU1KSB+EXBvEugYK078Aj8w4h3w1d9wJ+Dtd8IUXH465cLWuOAyovQgH
         HXiw==
X-Gm-Message-State: APjAAAXlS0ipvv8K7ndKLawewFf2Mu1kpyyoOemyj9yderugr4RSSChX
        BbjauLS9ZCXXazYpcdxixJoX2zigTgYWJQ==
X-Google-Smtp-Source: APXvYqzIknIprnk1zks1Q//EvLz986RZrKS5besy0FJUwHsnU1ZIhl+ilFxy0V0K3JMttT39eBFILw==
X-Received: by 2002:a63:5858:: with SMTP id i24mr7321744pgm.222.1553238084133;
        Fri, 22 Mar 2019 00:01:24 -0700 (PDT)
Received: from dgeissle-mobl.ger.corp.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id j71sm14330961pfc.6.2019.03.22.00.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 00:01:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20190322034927.6247-1-inga.stotland@intel.com>
Date:   Fri, 22 Mar 2019 09:01:18 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        "Gix, Brian" <brian.gix@intel.com>,
        Luiz Von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com>
References: <20190322034927.6247-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 22 Mar 2019, at 5.49, Inga Stotland <inga.stotland@intel.com> wrote:
> +#       5 - on/off model client menu
> +#       6 - send raw message
> +#       7 - exit

Please don=E2=80=99t use numeric identifiers for commands in interactive =
tools. Use intuitive, human readable strings like we do in the other =
interactive tools in the tree. Numbers might be convenient for =
computers, but they=E2=80=99re not particularly human friendly :)

Johan
