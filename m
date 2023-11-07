Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109D28F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium.com header.i=@essensium.com header.b="cGWxc2/W"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C357BD
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 00:46:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-542d654d03cso8903978a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google; t=1699346786; x=1699951586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxKyP2S9f1DOUxfY65N9kPb3WEuj9sAJfhvqSEmvD7c=;
        b=cGWxc2/WslTzLBCzV46zqYnIpGn/I6YA9W+Ib0AkQWqrPll7rbxpj6Al9Sc8CJ6KSB
         vhs92glKZQbJEemLEYn1wshF8gv3E4hoBAXT5X8IaUh5L04zS1aiN8JYiPE6Suz00zFz
         aplIwcU/3KgtwP2o+4GEH5fRvcXuZLjghh75ChmFOM1KX75amDRKaxf5Ki4fcBs8IQon
         52G/hCpmsYo+AKnePlZbaMktCi+Z3Njjm5kKUio1DbnoFK4yUnWS2qzYZt1VYpD/4mtZ
         yarK8eDix5iAlb97TVQbOtk3it/1S+Tgk7R5g/VY75CuNasflGpFyLWpnxB6QILOVrqr
         Bk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699346786; x=1699951586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxKyP2S9f1DOUxfY65N9kPb3WEuj9sAJfhvqSEmvD7c=;
        b=nEx/ugw5AwTMWJvherZKe4406Eg2Uxl+FH0u7o28duUCqDjNWDw9KIE3bL/JJxRmyR
         ojHpQezNw4Zu6taASh+w2oC4TAsIGXXGiBwqFre/9uMYCAxWBa82TXAejwKrbY2Wmq+9
         9CivO+hCBhgRgfRviD5HAn4pIQk9/5JEE5S3Dnezgsd0QNFuZZ8o2nqWhUi2t7L3nuSZ
         9HUE7d/aJd7e1N1mJammcoJ04gy3ZFAI/DuHRq7TER4+XRnoAD363ADYjzzJ+quRcZOq
         pL+tLpTEdwmqWWKtTFXn3opsHrKhHG2u1A1R1rBQnCJzVibxvdU8u/O3OFqgQPg7ijVS
         pXTw==
X-Gm-Message-State: AOJu0YyK6vaPpktrPjRLsGfig0FSkOePrbhqva7vq8jp34Lvzopucooj
	wvVHFgu4n70NgVli7mu7IDecyJk2b5lNr6vFHPAeGw==
X-Google-Smtp-Source: AGHT+IHwOsy76D8iLkAvngZoJin1GfioloX61UNmRRNEGrRaohVbVBAbSuM8xJ5kAjuEcR51oFawYA==
X-Received: by 2002:a17:906:3010:b0:9e2:af47:54c9 with SMTP id 16-20020a170906301000b009e2af4754c9mr326613ejz.19.1699346785911;
        Tue, 07 Nov 2023 00:46:25 -0800 (PST)
Received: from [10.1.0.108] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id f14-20020a05640214ce00b0053db0df6970sm5120663edx.54.2023.11.07.00.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 00:46:25 -0800 (PST)
From: Marleen Vos <marleen.vos@essensium.com>
X-Google-Original-From: Marleen Vos <marleen.vos@mind.be>
Message-ID: <8325a09c-c944-4a6a-a815-0407edb9baa0@mind.be>
Date: Tue, 7 Nov 2023 09:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 Olivier L'Heureux <olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
 <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
 <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be>
 <CABBYNZ+LopfJdjzBocxKTzbA1Qq8A8Y-t182cvqLe5cH0mM2Wg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+LopfJdjzBocxKTzbA1Qq8A8Y-t182cvqLe5cH0mM2Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Because Olivier has been and still is being swamped with other work, I'm 
kind of trying to take over these patches. So far I can reproduce the 
memleak on a recent kernel without the patches.

Olivier told me you added tests to check for the memleak in 
l2cap-tester. Can you point me towards more info on how exactly you run 
these tests, as the info I find on the web is rather minimal.

 From what I read in the thread, it looks like your tests don't catch 
the memleak?

Kind regards,

Marleen


On 14/09/2023 23:17, Luiz Augusto von Dentz wrote:
> Hi Olivier,
>
> On Wed, Sep 13, 2023 at 3:25 PM Olivier L'Heureux
> <olivier.lheureux@mind.be>  wrote:
>> Hello Luiz,
>>
>> Thanks for your review.
>>
>> On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
>>> Hi Olivier,
>>>
>>> On Mon, Sep 4, 2023 at 3:12 PM Olivier L'Heureux
>>> <olivier.lheureux@mind.be>  wrote:
>>>> Request for Comments
>> [...]
>>>> The "ble-memleak-repro" program reproduces the memory leak, if the
>>>> kernel is not patched. Its source is in
>>>> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
>>> We should probably create a test in l2cap-tester using SO_SNDTIMEO
>>> first, so we can make sure CI test such case and we are able to detect
>>> if the problem is reintroduced later:
>>>
>>> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
>> I didn't know about "l2cap-tester.c". Agree, it would be great to
>> integrate my test app into it. I could try, but I don't know the test
>> framework yet.
>>
>>>> Memory Leak Fix
>>>> ===============
>>>>
>>>> We have fixed the memory leak, see the patch series in
>>>> "patches/linux/":
>>>>
>>>>    1. The first patch
>>>>       "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch" [11]
>>>>       enables Bluetooth on the DK2.
>>> This above should probably be sent separately.
>>>
>>>>    2. The second patch
>>>>       "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch" [12]
>>>>       adds many dynamic debug traces that help understand the kernel
>>>>       behaviour and freeing problems.
>>> I'm fine with this change, but we better use the likes of bt_dev_dbg
>>> instead of BT_DBG.
>> This commit intended to increase the visibility during debugging, and
>> I was not intending it for a permanent presence in the kernel.
>> But if you find it useful, I can submit a patch RFC v2 with
>> "bt_dev_dbg()" instead of "BT_DBG()". Note that there is currently no
>> "bt_dev_dbg()" in "l2cap_core.c" yet.
>>
>>>>       "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch" [13]
>>>>       and
>>>>       "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch" [14]
>>>>       fix the memory leak.
>>>>    4. Patches
>>>>       "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch" [15],
>>>>       "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch" [16]
>>>>       and
>>>>       "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" [17]
>>>>       fixes the use-after-free that appears when the "struct l2cap_conn"
>>>>       [5] and "struct hci_conn" [6] objects are freed.
>>> These I'm not very comfortable applying as they are, I'm afraid there
>>> could be regressions if they are not accompanied with proper tests,
>>> besides I think there are less intrusive ways to cleanup l2cap_conn,
>>> see below.
>>>
>>>> The commit messages explain why the commit is needed, which problem
>>>> the commit solves, and how.
>>>>
>>>> The first and second patches are present for the memory leak
>>>> reproduction only, they should not be part of a final fix.
>>>>
>>>> Patch Status
>>>> ============
>>>>
>>>> As of writing, the memory leak is fixed. The fix opened the door to
>>>> other problems, especially use-after-free, sometimes followed by
>>>> crashes due to NULL dereferences. We think there are weak references
>>>> (i.e. pointers that don't increment the refcounter) previously
>>>> pointing to memory that was never freed, but now is freed. On kernels
>>>> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
>>>> use-after-free and NULL dereferences, but not on kernel v6.5 yet.
>>> I think the problem is that the lifetime of l2cap_conn shall be hooked
>>> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_del
>>> don't actually trigger l2cap_conn_del, which imo is the culprit here,
>>> because connect_cfm/disconnect_cfm is not called when the connection
>>> procedure has been aborted prematurely, so perhaps we shall get rid of
>>> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do the
>>> cleanup with in the following order:
>>> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_del,
>>> that way we avoid having multiple code paths attempting to cleanup
>>> objects associated with hci_conn/hci_chan.
>> I fully agree with your analysis, which correspond to mine: we should
>> call "l2cap_conn_del()", it would properly clean the allocations in
>> "l2cap_conn_add()".
>> I have tried but it was not obvious to find the right place to call
>> "l2cap_conn_del()" with the proper locking.
>> As you write, connect_cfm/disconnect_cfm is not called when the
>> connection is aborted, and that is the root cause of the memory leak.
> Btw, I was trying to reproduce it with the following test set, but at
> least kmemleak was not able to detect leaks of l2cap_conn:
>
> https://patchwork.kernel.org/project/bluetooth/list/?series=784343
>
>> Your proposal is most probably the best way to go.
>>
>>> I'd change hci_chan_create to take a del callback to avoid having
>>> circular dependencies on one another though.
>> Interesting, could you explain how you would do it? Perhaps point on
>> a callback example?
>>
>>>> Reproducing with Buildroot
>>>> ==========================
>>>>
>>>> We have reproduced and fixed the memory leak with Buildroot [7] and a
>>>> "ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4].
>>>>
>>>> The "ble-memleak-repro" repository [1] contains the sources of a
>>>> complete external Buildroot customisation [8], with the patches, a
>>>> README, and more explanations to reproduce the problem with Buildroot
>>>> on a DK2.
>>>>
>>>> References:
>>>> ===========
>>>>
>>>> - [1]:<https://gitlab.com/essensium-mind/ble-memleak-repro.git>
>>>>          "ble-memleak-repro repository"
>> [...]
>>
>> --
>> Olivier L'Heureux
