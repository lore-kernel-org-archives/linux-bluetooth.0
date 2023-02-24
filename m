Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D44DC7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 22:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXWiC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBXWiA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 17:38:00 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F370812
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 14:37:34 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1720600a5f0so1161205fac.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPIaWXPFHo0fd67ol/Y3q7iwZBF+ha9D9KhIm0046cs=;
        b=aH6oRAehs/bQJ6pfKcAcemuaekXsVwUnREED4H9pfNRq3UNgFIlhUlELHi5WmN5dbu
         c9y0mNPdhBCUeYmsDEEl/bcYWZJCgeDXGP/A7yqAXZ87O4KnCQMPPd9jmZU8GE5f44fx
         UaZ86ICYsNlATe+XNPSGXkPpodmcSCf/3xPoSNoiNlXQ5xXWbSCVNWuNBb+YS7B075Ln
         rVJAp3Ytv7HNJrFtGI6PlFefRg4ghIs5BMP84nzguD93iVTb1uQnWYUu6rQ8+3bPVWRW
         xVGdDZ/UAYwCnHQjdBx8A0wjQ46L12jJK51y0zM+8NznpgSVXzG7zEinmFqW7/DktR+M
         zGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPIaWXPFHo0fd67ol/Y3q7iwZBF+ha9D9KhIm0046cs=;
        b=2xJGbjtWPCESUyKlguSDPqe/w2M1XEMrChDSkv4+uq9g/wiHmZXGtloEL88AxV14Cz
         vlTJSMRrp8R29uJgT+OfLr8mWvSc3HhpUapqAHvM/p63h6YLSvL9BcHY078Da+7PqI3C
         tsoSHNAJmjdCDIyPX8hiYX3rpbfftaW+rL2wY8PzGIl5AMElNj/HPVmTzsMQ22t4Ec0l
         6oqo6dOeP739Tt8PTf2SOhy/nXoILQR3saDUBnawt9OFiXhlhTWNz/QFHmhGMXXRGUYd
         KuKACPARUitH3hRQo/aRedd318Y9pI4Oy0gdJxXQnf8zGOitLW/YeDGgwuj+7SoJNURw
         Uc6g==
X-Gm-Message-State: AO0yUKUFO6J/Z62E2LeicrldnmsQBWwbIaZR7L9lOBONAC769j0E8bnj
        CLeGZ8aeaWXyt7n8FEJqviMG1Ed1YPFH/ezMOMxtRw==
X-Google-Smtp-Source: AK7set/BdUClvmyebte8R/H/NeiEx9CQ6WND0VkVnkP+D0I65/lrj6l+4kZ5jy4ogNFoM1rzOtG6Yo19gkDklYbUDfI=
X-Received: by 2002:a05:6870:5a8a:b0:16e:4db:be3f with SMTP id
 dt10-20020a0568705a8a00b0016e04dbbe3fmr1461921oab.0.1677278252069; Fri, 24
 Feb 2023 14:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20230224195313.1877313-1-jiangzp@google.com> <20230224115310.kernel.v2.1.If0578b001c1f12567f2ebcac5856507f1adee745@changeid>
 <CABBYNZ+yVWssa09NB+ahp-N87sLXRqYF58-GJK-Vx8jn-Sa5Uw@mail.gmail.com>
In-Reply-To: <CABBYNZ+yVWssa09NB+ahp-N87sLXRqYF58-GJK-Vx8jn-Sa5Uw@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Fri, 24 Feb 2023 14:37:19 -0800
Message-ID: <CAB4PzUrO32Z1AF-3UJviYqTr3YvachGgJ7NiqkNW46ioWigtfw@mail.gmail.com>
Subject: Re: [kernel PATCH v2 1/1] Bluetooth: hci_sync: clear workqueue before
 clear mgmt cmd
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        mmandlik@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Any particular reason why you are not using hci_cmd_sync_clear
> instead?

That is a good question and we used hci_cmd_sync_clear in the first
version, but it will clear the queue and also close the timer. As a
result, when the adapter is turned on again, the timer will not
schedule any new jobs. So the option is to use hci_cmd_sync_clear and
re-initiate the queue or to write a new function which only clears the
queue.

> We also may want to move the clearing logic to
> hci_dev_close_sync since it should be equivalent to
> hci_request_cancel_all.

I actually have a question here. I saw
"drain_workqueue(hdev->workqueue)" in hci_dev_close_sync and thought
it should force clearing the cmd_sync queue. But it seems cannot
prevent the use-after-free situation.

Any suggestions to improve the solution?

Thanks,
Zhengping


On Fri, Feb 24, 2023 at 1:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Zhengping,
>
> On Fri, Feb 24, 2023 at 11:53 AM Zhengping Jiang <jiangzp@google.com> wrote:
> >
> > Clear cmd_sync_work queue before clearing the mgmt cmd list to avoid
> > racing conditions which cause use-after-free.
> >
> > When powering off the adapter, the mgmt cmd list will be cleared. If a
> > work is queued in the cmd_sync_work queue at the same time, it will
> > cause the risk of use-after-free, as the cmd pointer is not checked
> > before use.
> >
> > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > ---
> >
> > Changes in v2:
> > - Add function to clear the queue without stop the timer
> >
> > Changes in v1:
> > - Clear cmd_sync_work queue before clearing the mgmt cmd list
> >
> >  net/bluetooth/hci_sync.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 117eedb6f709..b70365dfff0c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -636,6 +636,23 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
> >         INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
> >  }
> >
> > +static void hci_pend_cmd_sync_clear(struct hci_dev *hdev)
> > +{
> > +       struct hci_cmd_sync_work_entry *entry, *tmp;
> > +
> > +       mutex_lock(&hdev->cmd_sync_work_lock);
> > +       list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
> > +               if (entry->destroy) {
> > +                       hci_req_sync_lock(hdev);
> > +                       entry->destroy(hdev, entry->data, -ECANCELED);
> > +                       hci_req_sync_unlock(hdev);
> > +               }
> > +               list_del(&entry->list);
> > +               kfree(entry);
> > +       }
> > +       mutex_unlock(&hdev->cmd_sync_work_lock);
> > +}
> > +
> >  void hci_cmd_sync_clear(struct hci_dev *hdev)
> >  {
> >         struct hci_cmd_sync_work_entry *entry, *tmp;
> > @@ -4842,8 +4859,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >
> >         if (!auto_off && hdev->dev_type == HCI_PRIMARY &&
> >             !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> > -           hci_dev_test_flag(hdev, HCI_MGMT))
> > +           hci_dev_test_flag(hdev, HCI_MGMT)) {
> > +               hci_pend_cmd_sync_clear(hdev);
>
> Any particular reason why you are not using hci_cmd_sync_clear
> instead? We also may want to move the clearing logic to
> hci_dev_close_sync since it should be equivalent to
> hci_request_cancel_all.
>
> >                 __mgmt_power_off(hdev);
> > +       }
> >
> >         hci_inquiry_cache_flush(hdev);
> >         hci_pend_le_actions_clear(hdev);
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
>
>
> --
> Luiz Augusto von Dentz
