Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF5C41513
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 00:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJNAyq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 20:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJNAyq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 20:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B8691
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 17:54:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38192C433C7;
        Sat, 14 Oct 2023 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697244884;
        bh=btX4q00tpa3kANjZqjMhb8YjMQR4zKgNcnsAX/WbXJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QwTU0M1Il4XW5GQ3r52HgZ7nvJBAVq9eoymPC23J/loMDxlIsI/4HO/hz8ahpQb75
         dWWbTu5Lx/EnIMLfXYwY+IkKxWvm+/xOra/knpRLifvmskpTglU8sINe5NbZwgXLgh
         CGRSq0UTGq3JeES2hYC135VPRdPE/Xmg2gV5uvK4o7Dvr04rJB7F9qx1KPdaik3yYR
         gtjMHTZEmFKCg0jgq62+SHKRfGnaK1OjPozVUO6o0G57C3hkDwiupYJxRnZVmHRyYM
         X4dH8EuSL9/WEHLg8x0YZLGzyYPfTnROa3Gwij6K7vf8K5h+OFPO8c2zOYGX9GMZUU
         APLJbBckyIkzA==
Date:   Fri, 13 Oct 2023 17:54:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-10-11
Message-ID: <20231013175443.5cb5c2ce@kernel.org>
In-Reply-To: <20231011191524.1042566-1-luiz.dentz@gmail.com>
References: <20231011191524.1042566-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 11 Oct 2023 12:15:24 -0700 Luiz Augusto von Dentz wrote:
>  - Fix race when opening vhci device
>  - Avoid memcmp() out of bounds warning
>  - Correctly bounds check and pad HCI_MON_NEW_INDEX name
>  - Fix using memcmp when comparing keys
>  - Ignore error return for hci_devcd_register() in btrtl
>  - Always check if connection is alive before deleting
>  - Fix a refcnt underflow problem for hci_conn

Commit: fc11ae648f03 ("Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name")
	Fixes tag: Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: 6f0ff718ed67 ("Bluetooth: avoid memcmp() out of bounds warning")
	Fixes tag: Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: b03f32b195df ("Bluetooth: hci_event: Fix coding style")
	Fixes tag: Fixes: d70e44fef862 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: a9500f272b3b ("Bluetooth: hci_event: Fix using memcmp when comparing keys")
	Fixes tag: Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore NULL link key")
	Has these problem(s):
		- Target SHA1 does not exist

:(
