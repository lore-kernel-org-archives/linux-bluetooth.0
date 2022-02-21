Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 22:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiBUWic (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:38:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiBUWib (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 17:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8FC8E71
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645483087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yNyqavxJK7ZHgL6rDzOdeF37q+fW4SE+roeR8B04wWM=;
        b=CdX3eogj6KDAB297R8RjHvvm4I9JS+sS6DEWrwn7cmbk8plfkmW3Co4mlkbu0k12BedbaB
        SBBUw0ED1ljleKJIaXDpKXpSa3vjoHSs4ZfI+7u/iAb/aTZSW4+6/TRimx0x40ewJ4kUAS
        0wUiqdYPqT3iNlsTdIgqWgorydQSYlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-vCutpY0QOMuN_yAa3ikUkg-1; Mon, 21 Feb 2022 17:38:03 -0500
X-MC-Unique: vCutpY0QOMuN_yAa3ikUkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FA0F2F47;
        Mon, 21 Feb 2022 22:38:02 +0000 (UTC)
Received: from starship (unknown [10.40.195.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002C2519B3;
        Mon, 21 Feb 2022 22:38:00 +0000 (UTC)
Message-ID: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
Subject: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 22 Feb 2022 00:37:59 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Today I updated to a new kernel and I am bisecting few regressions:

I noticed that if I open GNOME's bluetooth setting, it hangs for like minute or so,
and then shows only the paired devices and no scan results.

I bisected this to this commit.

For reference I am running fairly old fedora 32 on this machine, and thus I have
bluez 5.55 and stock GNOME from fedora 32.

I can provide any more info on anything if required and/or test patches.

I wasn't able tor revert this commit as it is part of a bigger rewrite of scanning
which makes sense.

I tried merging bluetooth-next master as of today,
into my kernel but no noticeable improvement.


Best regards,
	Maxim Levitsky

