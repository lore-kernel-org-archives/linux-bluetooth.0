Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954CC0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGMMG1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGMMGX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 08:06:23 -0400
Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B61FCD
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1689249981;
        bh=icaI2sA2mQeQ7RP6RhUdFzJpvMJVByhclve3jzvNMCc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=B/0s7Nzc5BbWDzc1fz2/w0tQ3NfUPaYBJJqelc2qorfngqAvEIgbTQwSJJS/3ik5/
         2wZU+Gdk+ANgzBG1GXtI9pJwSvEmJT1eHpL3paqLkfQcXRPmLd5mAT9TS80G8ndo0i
         Db/vm63H9IfDW96GPGmX4UZVXBvrNbcNtRC9slcSDZevimRtJl1ncAn8Ucla55fRbl
         qPVeReJowlFLIZoV8jLIB7RK+NIVz1koJV/E2w+HdDynQ2r2+x81sGtDqbzz9oLU9j
         7ZKJ5H0OKnIkwBdR33BWW7kMjrnUVngQZR8tDjlSKbEAM+WTVGQQz0GvJ6st3vIMIV
         z7D6ndkTvobtg==
Received: from [192.168.61.229] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id 374244401FE;
        Thu, 13 Jul 2023 12:06:21 +0000 (UTC)
Message-ID: <7b461780-8ae3-0444-9d43-83177f07f4f3@icloud.com>
Date:   Thu, 13 Jul 2023 08:06:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014
To:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@nordicsemi.no>,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     =?UTF-8?Q?Carles_Cuf=c3=ad?= <carles.cufi@nordicsemi.no>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
Content-Language: en-US
From:   John Holland <johnbholland@icloud.com>
In-Reply-To: <20230713102514.699277-1-tomasz.mon@nordicsemi.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: APE3mmAdXJxVX-CDm0afCcD-TS5whVNE
X-Proofpoint-ORIG-GUID: APE3mmAdXJxVX-CDm0afCcD-TS5whVNE
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F03:2022-01-11=5F01,2022-01-12=5F03,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307130107
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


> Commit c13380a55522 ("Bluetooth: btusb: Do not require hardcoded
> interface numbers") inadvertedly broke bluetooth on Intel Macbook 2014.
> The intention was to keep behavior intact when BTUSB_IFNUM_2 is set and
> otherwise allow any interface numbers. The problem is that the new logic
> condition omits the case where bInterfaceNumber is 0.
>
> Fix BTUSB_IFNUM_2 handling by allowing both interface number 0 and 2
> when the flag is set.
>
> Fixes: c13380a55522 ("Bluetooth: btusb: Do not require hardcoded interface numbers")
> Reported-by: John Holland <johnbholland@icloud.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217651
> Signed-off-by: Tomasz Moń <tomasz.mon@nordicsemi.no>
> ---
>   drivers/bluetooth/btusb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d844fb8e7cb7..ab7d62538b48 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4258,6 +4258,7 @@ static int btusb_probe(struct usb_interface *intf,
>   	BT_DBG("intf %p id %p", intf, id);
>   
>   	if ((id->driver_info & BTUSB_IFNUM_2) &&
> +	    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
>   	    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
>   		return -ENODEV;
>   

Tested-by: John Holland<johnbholland@icloud.com>

