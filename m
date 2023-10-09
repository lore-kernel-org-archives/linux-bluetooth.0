Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0410CD6131
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 19:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378455AbjJITsW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJITsV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 15:48:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAFE94
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 12:48:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-694ed84c981so3633064b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696880899; x=1697485699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=e23yKq1wv/lY0x9LjebsVqZvLDC3yPdbjBtEyEgGrIxa5/qW5r8N3OKAZN6Fe4AI2C
         iBYNB18joJFFK+/Of93yr1coecNoCqRoHQOzFzxtTQvgQzAVc+JKy3yXUm0PscC5TDD8
         VyIz40oa3DURNPKhXQnNorxfjCrCgHOEwuaXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880899; x=1697485699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnnGBorqi/0sryABcLeiVXw4usVlXXVKQE9toG3inJM=;
        b=T4pQqrojYvcQK5/GCGSPdFUmsjPt+1wPuY8cSC4EkuiM0IHo7518gcH/UtBoru1FZN
         LXCx5kzecLwsC9nix/1mtk0Ikm90zBxz61KgE+RQsDYsOllefTg2ENkVmKbACWO/pO3E
         t+GhVdSK/gVg6uNUwZIiTAOvx1H5JfhcXaFN5Y3XzbGHfuOfDZHgxw6vsAon0N0sGGs0
         e0HZUQ3F0zyKygqmI1fXV0VzyhtzXiJNaAcjWY+5uies2NU9/PbARMj/+6I72sp2aci3
         PAX3PGAzrx9TGUpOsRf+U4ujmIQW8lVnhtD2qM3jlaWVkD1pb/tGfmWwO0twX4JeovO/
         k7ag==
X-Gm-Message-State: AOJu0YzSzV4PWzModJwCMkju1eJKpm8x3jGgktRBsglFf2CfO+aNSUpO
        DQznekC5h7otnW3ED2nxYXC9dA==
X-Google-Smtp-Source: AGHT+IH/EU8sCax66tncCUgtwE24oZqKUnAw5nHePbac/qTNhw0neUzqI+uVELgQYBYwoASCkEKRUQ==
X-Received: by 2002:a05:6a00:1516:b0:691:da6:47b with SMTP id q22-20020a056a00151600b006910da6047bmr16111870pfu.10.1696880898803;
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn27-20020a056a002fdb00b00688435a9915sm6820661pfb.189.2023.10.09.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:48:18 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:48:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chun-Yi Lee <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310091246.ED5A2AFB21@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
 <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> >> 
> >> Sorry, I have to retract this, something went wrong on my
> >> testing and I now see the same problem in some configs regardless
> >> of whether the patch is applied or not.
> >
> > Perhaps turn them into macros instead?
> 
> I just tried that and still see the problem even with the macro,
> so whatever gcc is doing must be a different issue. Maybe it
> has correctly found a codepath that triggers this?
> 
> If you are able to help debug the issue better,
> see these defconfigs for examples:
> 
> https://pastebin.com/raw/pC8Lnrn2
> https://pastebin.com/raw/yb965unC

This seems like a GCC bug. It is complaining about &hdev->bdaddr for
some reason. This silences it:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6f4409b4c364..509e86b36576 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3266,6 +3266,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
+	bdaddr_t a;
 	__u8 flags = 0;
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
@@ -3273,7 +3274,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
+	a = hdev->bdaddr;
+	if (!bacmp(&a, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);

:(

-- 
Kees Cook
