Return-Path: <SRS0=a/5L=X5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE9EC47404
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 08:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A752084D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 08:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="d/yX8/HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfJDIti (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:49:38 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:37094 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDIth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Oct 2019 04:49:37 -0400
Received: by mail-io1-f49.google.com with SMTP id b19so11895844iob.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2019 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tX6VZ4eniB7HdltK+Af7/NESXTg758tFbNVFG3n0XCU=;
        b=d/yX8/HU2ObmqzVkvhFKplbTwIW+W+9UsLcwF5kGz+GfovENGpoVPN0nVgZDCP8Edq
         Zr5PDFRoOGFtumJSYQ2gAJUmkGWvXXUx4IDmPTgGIhysFZ/s5brRbsmB9Si1KcKkqNAP
         XzzAi9tNQ6z/To9tK9C9lZeEPBc2+NHQM+SRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tX6VZ4eniB7HdltK+Af7/NESXTg758tFbNVFG3n0XCU=;
        b=kkR3orAnVv7vojDvaEZSwwRO+3fnDH1ZkZoP5cVhyXeKLLn7hwn11qBhvqJ+aZG0YP
         OSFPpsUWVT5Yz8XvcaZGi7B3wOD+ulki/lOy1KhI/hyQl+0eO0aEVKnjrV526q5AEdQx
         JYkjW3zePq6WnY5RC9gO6hf7gFaCLBgYHr1rTtO0vN/Hwiw9uk9Np/aBk44aR18lOeRK
         y/ioCWYPxGcJKdI7UNPqpvhK4stxtky2JyH7qZ+rIYVhSQ4qfuW52ti3bLdqvWRV+Ru/
         nJ+xx89qqZAHxRHaq5K93OFY71Ww3c7dUe9LT72xSDq9vEwJKr1MDv63shOXDb906Gp/
         ruKQ==
X-Gm-Message-State: APjAAAUJdAckWLbBEzG+15VnI+POIoYwcOvRTuXMhlI+SbxxO85dhyM/
        p6ecLRjdI9gCJKh1hanOFR8mN31tTkq+jK2P4FUT7+khRtJPcmqS
X-Google-Smtp-Source: APXvYqzHhXFGh8YROt+Z3ZQSi5zUUaTtnrIIcXoRCs0d374tdwqWu1fbv4EQIW5vDvRJrvidzeNxx/KdBywhg6VPB7Q=
X-Received: by 2002:a05:6e02:4cf:: with SMTP id f15mr13419486ils.284.1570178976608;
 Fri, 04 Oct 2019 01:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
In-Reply-To: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
From:   Pavel Nikulin <pavel@noa-labs.com>
Date:   Fri, 4 Oct 2019 14:49:29 +0600
Message-ID: <CAG-pW8GvMEcKmdquREi1ruDBHLYmgsVjk34NTmYgsmvmx5cX-w@mail.gmail.com>
Subject: Re: Battery readouts on dbus for GATT battery service
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Here is the BTMON capture

http://s000.tinyupload.com/index.php?file_id=97528277907598647906
