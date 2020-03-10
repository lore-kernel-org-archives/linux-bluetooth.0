Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FBC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431521655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYtFblX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJPMU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:12:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44631 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgCJPMU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 11:12:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id i10so11175498lfg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffFsGHQKCrM+k+AAH4wRMnJ9KmvOVqGp5I1ZgWySh0s=;
        b=KYtFblX4akO0gVG+NdooTmuJ6XwFjalBC59uCIPBO3tXP8HsDPDLP+ukp+LLviXwti
         e+ozy88h20VnmlgaDRyvCQQo8mzxl5MupUD2Tfg2HQYgSr6Oz2iu9rq++JHjiU9JX2fR
         u6xx55K6FAQv62EeiQIUrAaJMJUl9g7b8ab1wY+anarHISffMOvJ4uOXTpIFDAkURshg
         YNJ5UIiQUUkBqwns+h5txcYq3xByunKUBCpSEsjzvXYj3t/wim23Oc+gUEGmPTZKhh5z
         VJXB7pZ22YR79JXRwT3ls2TQhqXPi8zRQkmw7UHKmNebXlJv5uyh5DEuOgMbPeZ1loM+
         ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffFsGHQKCrM+k+AAH4wRMnJ9KmvOVqGp5I1ZgWySh0s=;
        b=DQGfL81tH+r3svfhAMj15NEnkeNyTb5v3hAwa8tlJINSKWLM2PcMCp+/L0mEgGfwvb
         2M4UmGfSz5J60sFf8PYAmwllHa9g8IAmkKfR/hNmd2STeZ6GjzTbdBxeLiirmrJS8rI1
         YPinfYdSU5SwJW3ZGu2O85JP6R725QqIdeoSNXS/toiZnShTDhjgUi4e4gHWEb5uluLy
         zT15IMrZM1G+eQRmSnUnKDENHGTAvgB9Y+etBpfE+Ymh3Fcz4D135+cxPERR/2CIGbVE
         /W5mcrS+2GTxp9j/6yeBhV9JJxkr8AHZ9w0j53OLwhgMxYn85iOKyER/92uUzG5ajMZY
         irOA==
X-Gm-Message-State: ANhLgQ1HM+lH76t1UTxUy0pBIME8SSmMxrjFm+yD5neRIg/yXQAZPQDN
        YnkQOpVTkcQMtwAVytcL1Wb80iZKx1jEvJcG74onFsQt
X-Google-Smtp-Source: ADFU+vvzEqaGgYdqArcs8CvWSYOkYhjkVJxjcRivvBZfbL2qiu5by0rDa/v97AjetyyqcNuFzGSQjleyb8cWO+h8IFI=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr12790759lfb.69.1583853137630;
 Tue, 10 Mar 2020 08:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200309214810.431559-1-marcel@holtmann.org>
In-Reply-To: <20200309214810.431559-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 11:12:06 -0400
Message-ID: <CALWDO_XXjbdjSXBsE2kSoW3ppgRu2jQhENRxTZqsbUWhURC_8A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use bt_dev_err for RPA generation failure message
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Mon, Mar 9, 2020 at 5:48 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> When the RPA generation fails, indicate the error with a device specifc
> error message.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_request.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 2a1b64dbf76e..53179ae856ae 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1499,7 +1499,7 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
>
>                 err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
>                 if (err < 0) {
> -                       BT_ERR("%s failed to generate new RPA", hdev->name);
> +                       bt_dev_err(hdev, "failed to generate new RPA");
>                         return err;
>                 }
>
> --
> 2.24.1
>

LGTM.
