Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 14:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7494360ED4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Aug 2021 14:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhH2OyH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Aug 2021 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhH2OyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Aug 2021 10:54:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2BC061575;
        Sun, 29 Aug 2021 07:53:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so8233224pjx.5;
        Sun, 29 Aug 2021 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gZ/nenUcj9mad1OmYCCfvZwnAJEnEhtMP/nmkyY6NOM=;
        b=SqRgue5J5BHXPuOWjfah7o4X0Mg0vV+2AHpa9GzTTbkeNGDaZCsDmBehausz0MNYaF
         bHhlG8PxIgz2iW1Cmo83vEep3rsZzrKGQSKmJLNtqciTub6iPZW9hUbN2m663tEGgJJ/
         /FnW4ospoz5MU7i3+pu/Rn6ETpJgnh5Ywarwg0YaqydcTOfpuKuZX3F+mPTZSHzvgRV8
         x8i94JuHtgJkk1kdp7CTFd7iUM9edyroXd9FcO8Pmmv59kNgxtwFLk+NiyqaQhUmhco1
         kVpiVNfRaNOiiBQ4WMphk+v0OpjwgoSfhPhLYWwbBMkHC0HirYofOnTJ1TNX/V5LhaCN
         eUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZ/nenUcj9mad1OmYCCfvZwnAJEnEhtMP/nmkyY6NOM=;
        b=UO+wcUt/hCekNK7lyRaPmyAyEywyV7oGP8rZN6s+gNdq2M6cc3C1KftphMTs30Adnn
         J85ctOm1eRTlL7atHDwwHmHw8UrwyuH39enYaSAz+XQbxjdGDyiU/Dp7tremsSHahaGc
         AyGoKhZnhLOSAeApLdDXpJjiNQHrygspbr21MqsFa64qHiNszWw/ZitsHipeAAcUNt9D
         iMWSCu+UgxfuTfWVVpQg+783jU7zhpS1xewf4l1GRDFHMUnnuJKMBHQcQjfmbdCPNrDm
         cmgvDCxFGSRlcA+bpQYK9xzxg1DzhOaNQhTtbjN8FO6SE8uYTYDstnX+r1m0un6beLUW
         TspQ==
X-Gm-Message-State: AOAM533gz1+KhrhVMaUalwxRvZKwIQqcqG8buBLDyRt5Tk8Z0VHZO8Md
        gz5MfpB5VmLnHHbhbOGkyNg=
X-Google-Smtp-Source: ABdhPJxPHa7w5kquVU9Z/WHTw75OhAcL/7ILjKvG07d436dAB8mEf1pFhEPpzpbaTarZaI0AdPgPxg==
X-Received: by 2002:a17:90a:e001:: with SMTP id u1mr30902387pjy.183.1630248794241;
        Sun, 29 Aug 2021 07:53:14 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id n14sm19456487pjm.5.2021.08.29.07.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 07:53:13 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com,
        syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000b2725705ca78de29@google.com>
 <20210827011931.2323-1-hdanton@sina.com>
 <20210829082929.2897-1-hdanton@sina.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <11a30bc1-574f-aa1a-21d6-b886de9fc981@gmail.com>
Date:   Sun, 29 Aug 2021 22:53:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210829082929.2897-1-hdanton@sina.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/8/21 4:29 pm, Hillf Danton wrote:
> On Fri, 27 Aug 2021 15:58:34 +0800 Desmond Cheong Zhi Xi wrote:
>> On 27/8/21 9:19 am, Hillf Danton wrote:
>>> On Thu, 26 Aug 2021 09:29:24 -0700
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    e3f30ab28ac8 Merge branch 'pktgen-samples-next'
>>>> git tree:       net-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13249c96300000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a29ea9300000
>>>>
>>>> The issue was bisected to:
>>>>
>>>> commit e1dee2c1de2b4dd00eb44004a4bda6326ed07b59
>>>> Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>>>> Date:   Tue Aug 10 04:14:10 2021 +0000
>>>>
>>>>       Bluetooth: fix repeated calls to sco_sock_kill
> 
> To fix the uaf, grab another hold to sock to make the timeout work safe.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git e3f30ab28ac8
> 
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -190,15 +190,14 @@ static void sco_conn_del(struct hci_conn
>   	sco_conn_unlock(conn);
>   
>   	if (sk) {
> -		sock_hold(sk);
>   		lock_sock(sk);
>   		sco_sock_clear_timer(sk);
>   		sco_chan_del(sk, err);
>   		release_sock(sk);
> -		sock_put(sk);
>   
>   		/* Ensure no more work items will run before freeing conn. */
>   		cancel_delayed_work_sync(&conn->timeout_work);
> +		sock_put(sk);

Hi Hillf,

Saw that this passed the reproducer. But on closer inspection, I think 
what's happening is that sco_conn_del is never run.

So the extra sock_hold prevents a UAF, but that's because now the 
reference count never goes to 0. In my opinion, something closer to your 
previous proposal (+ also addressing other calls to __sco_sock_close) 
where we call cancel_delayed_work_sync after the channel is deleted 
would address the root cause better.

Just my two cents.

>   	}
>   
>   	hcon->sco_data = NULL;
> @@ -212,6 +211,8 @@ static void __sco_chan_add(struct sco_co
>   
>   	sco_pi(sk)->conn = conn;
>   	conn->sk = sk;
> +	/* make timeout_work safe; will be put in  sco_conn_del() */
> +	sock_hold(sk);
>   
>   	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
>   
> --
> 

