Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCD205E0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763313; cv=none; b=gzsO64l5hrRdSh6UqQ8KOufbH7vcQcgl3H8GvbCmm+9u5LVCpDIpj9+1Ptbbh7xZDwdr6Xjae5TOuiceudrpw0d9/KhhoSnvF7ZA/4UpLFGKzCZW+B6GQKX85Ug9YN2eqQpgjGxYL5jGjEzmAiJmhEiuKqLW8Mqc04s9izThDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763313; c=relaxed/simple;
	bh=T/NcASZftci7FSHnqwrp58FQHO1HXdH30Xb9qD7G4uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd03jCZH6elMi/pa15Bzrxoeou2EEs/oq2Arz1133CnIpeXwf9a6mo7/gAMX6mAIsMKwJ7iqb6nzT/EQkmYB8hElBijeiIBGjYz2afVCNtX27B+wyGVYts3oZ+3boU5c0c9FQGVrWk9ZDZncJ28S7SIIf3ii+4cc/paiieJxe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=gwrTseo+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="gwrTseo+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e8fce77bb2so15490235ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 22:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713763311; x=1714368111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7Z06VeD8cQ0KXBNTBIgXyaOqqJtB1q0llbjsp1zjhQ=;
        b=gwrTseo+1G4XIllRkdrlCs6BBrQ4FN9LECJE2abhVZLqvhAXwBN4qzPDVjvxnCZYfh
         l1OMwx8gZSg6Moqof6YV3Nov8DUqPq+fi7huMG8Djo2/d+yLDo+9Jd16CFLzfgIIMjIq
         U6wozxHu4ycPR0hjy1zrEIuReKVNqSwnJjW5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763311; x=1714368111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Z06VeD8cQ0KXBNTBIgXyaOqqJtB1q0llbjsp1zjhQ=;
        b=qrBch0l7fw4IDrMhPepD6mrChrbQHUrU6KDpVVPG9b6sbgde09pb5s0iecF8UR00WZ
         mAO6NqAecnWSeRR4fSKUTehTuNrSLtnEFJmYNq5xpwMAgHD6FOmYJRuplt9Im3vcv7ju
         zLAzGguQK4naAz8FPo381Q0f0c2eL/UfvpFYk25b+m7sx1q0/zFTAdeOcpJm1Tihgnus
         4Gdy0r7gBkfYnbJI14P1D9oZEpBWMiPImd5yatuHNBfjH8rIuCJwSe8QKav44IVqMXiU
         phBVtgmWaTd5xD32o437sGMfsuhiyqUgsPY9rNbnjBQI82xbzqFp1zYz6BQ1IFIyeZ4j
         SnRA==
X-Gm-Message-State: AOJu0Yx/++6muZmzDk/Zs2dT7byP3v/njg+WxifzZeBbfAvuuxfjZ/nQ
	XvRI6p83pGU9Yh7qw5GQGWiWdVJXR/yAldszafz+j0Rrx5xsvnyVzDxCazzHIQ==
X-Google-Smtp-Source: AGHT+IEMBPaI2+FfLIUF+sin06BR1OqJPSuzQuJmS83JK/DgHa2+Ub2sxhz0jUPO7EtujWK77ugqNQ==
X-Received: by 2002:a17:902:d4c7:b0:1dc:cf38:3a77 with SMTP id o7-20020a170902d4c700b001dccf383a77mr12006756plg.55.1713763310723;
        Sun, 21 Apr 2024 22:21:50 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170903070300b001e3d8432052sm7155450plb.275.2024.04.21.22.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:21:50 -0700 (PDT)
Message-ID: <dc17aea1-9399-4c2b-8775-fa0a7f602035@penguintechs.org>
Date: Sun, 21 Apr 2024 22:21:48 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 regressions@lists.linux.dev
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
 <a6ae69ad-b602-4cfc-9f76-8932f357d30b@kernel.org>
 <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 5:14 PM, quic_zijuhu wrote:
> On 4/22/2024 2:41 AM, Krzysztof Kozlowski wrote:
>> On 21/04/2024 09:44, Wren Turkal wrote:
>>> On 4/20/24 3:06 PM, Zijun Hu wrote:
>>>> This patch series are to fix below 2 regression issues for QCA controllers
>>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>
>>> @Zijun @Krzysztof and @Bartosz Would it be helpful for me to test these
>>> to ensure they fix the issues I reported?
>>>
>>
>> I look forward to someone testing these on other hardware, not yours. On
>> the hardware where the original issues were happening leading to this
>> changes, e.g. RB5.
>>
>> Anyway, the problem here is poor explanation of the problem which did
>> not improve in v3 and v4. Instead I receive explanations like:
>>
>> "this is shutdown of serdev and not hdev's shutdown."
>> Not related...
>>
> this is the reply for secondary issue. i believe i have given much
> explain for my fix for the 2nd issue as shown by below links.
> let me add a bit more explanation within the ending "For the 2nd issue"
> section, supposed you known much for generic flag
> HCI_QUIRK_NON_PERSISTENT_SETUP, otherwise, see header comment for the
> quirk. also supposed you see commit history to find why
> qca_serdev_shutdown() was introduced for QCA6390.
> https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/
>> "now. you understood why your merged change as shown link of 4) have
>> problems and introduced our discussed issue, right?"
>>
> this is the reply for the first issue as shown by below link. it almost
> have the same description as the following "For 1st issue:" section.
> i believe it have clear illustration why the commit have bugs.
> https://lore.kernel.org/all/2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org/
>> No. I did not understand and I feel I am wasting here time.
>>> Code could be correct, could be wrong. Especially second patch looks
>> suspicious. But the way Zijun Hu explains it and the way Zijun Hu
>> responds is not helping at all.
>>
>> Sorry, with such replies to review, it is not worth my time.
>>
>> Best regards,
>> Krzysztof
>>
> Hi luiz,marcel
> 
> it is time for me to request you give comments for our discussion
> and for my fixes, Let me explain the 1st issue then 2nd one.
> 
> For 1st issue:
> 1) the following commit will cause serious regression issue for QCA
> controllers, and it has been merged with linus's mainline kernel.
> 
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()").

As the user who originally reported thes issue, I can confirm this. I 
was introduced to this regression because I use Fedora Rawhide on my 
laptop, which builds and pushes kernels based on mainline very regularly.

Here is my description of the regression: After the reverted change, the 
BT hardware in my laptop (qca6390) will only work after a cold boot when 
the hardware has only be enabled once by the driver. Once the hardware 
is enabled, the process of disabling/re-enabling fails. Also, the 
hardware cannot be enabled after a warm boot of the laptop.

Among other things, this makes logging into KDE Plasma break my 
bluetooth mouse. The cause of this breakage appears to be that Plasma 
disables/re-enables bluetooth hardware upon login.

GNOME operates slightly less badly in that bluetooth stays enabled. 
However, if I manually disable the bluetooth via the ui or by restarting 
the bluetooth service with systemctl, the mouse fails in the same way as 
happens with Plasma.

Once the bluetooth has failed, the only way to fix is a cold boot and 
only enable the hardware once. I cannot remove the modules (btqca, 
hci_uart, and bluetooth) and re-modprobe them to fix it. I can't restart 
the bluetooth service. I can't do both of those things. I haven't found 
any way to re-enable the hardware beyond cold boot with bluetooth 
service enabled.

If I disable the bluetooth service and cold boot the laptop, there also 
appears to be some kind of race condition as not enabling bluetooth 
service very soon after loading the hci_uart and btqca modules during 
boot puts the system in a state where I can never enable bluetooth. I do 
not know what causes this specifically, but my theory is that not 
starting the bluetooth service immediately puts the driver in a similar 
state as when the service is started immediately. Maybe some kind of 
lazy initialization that is forced to happen more quickly when the 
bluetooth service is enabled?

Any way, this reversion by itself (which I manually did after a 
discussion with Zijun before getting his test patches applying to my 
kernel for test). However, this reversion did not get the hardware 
working after a warm boot.

> 2) the regression issue is described by [PATCH v4 1/2] commit message
>    as following:
>    BT can't be enabled after below steps:
>    cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
> failure if property enable-gpios is not configured within DT|ACPI for
> QCA_QCA6390.
>    i will verify and confirm if QCA_QCA2066 and QCA_ROME also are impacted.

I can confirm this. Without this change (and with the #1 change), I can 
cold boot the laptop and disable/re-enable the hardware as many times as 
I want. However, warm booting will not allow the hardware to work. I 
believe that a similar problem existed before the 6.8 kernel (if memory 
serves), as I had been having issues of this sort for some time. I was 
able to reproduce a similar issue as far back as 5.19. I tested that and 
every intervening release until 6.8.0. I did not realize that the warm 
boot problem was separate from the enable/disable issue until working 
with Zijun.

> 3) let me explain the bug point for commit mentioned by 1), its
>     commit message and bug change applet are shown below.
> 
> The optional variants for the gpiod_get() family of functions return
> NULL if the GPIO in question is not associated with this device. They
> return ERR_PTR() on any other error. NULL descriptors are graciously
> handled by GPIOLIB and can be safely passed to any of the GPIO consumer
> interfaces as they will return 0 and act as if the function succeeded.
> If one is using the optional variant, then there's no point in checking
> for NULL.
> 
>   		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>   					       GPIOD_OUT_LOW);
> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +		if (IS_ERR(qcadev->bt_en)) {
>   			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>   			power_ctrl_enabled = false;
>   		}
>     3.1) we only need to discuss how to handle case "qcadev->bt_en ==
> NULL" since this is only difference between the commit and BT original
> design.
>     3.2) BT original design are agree with the point of above commit
> message that case "qcadev->bt_en == NULL" should not be treated as
> error, so BT original design does not do error return for the case and
> use dev_warn() instead of dev_err() to give.
>     3.3) the commit misunderstands BT original design and wrongly think
> BT original design take "qcadev->bt_en == NULL" as error case,
> so change the following flag power_ctrl_enabled set logic and cause
> discussed issue.
> 
> For the 2nd issue:
> 1) the following commit will cause below regression issue for QCA_QCA6390.
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>      serdev")
> 
> 2) the regression issue is described by [PATCH v4 2/2] commit message
>    as following:
>    BT can't be enabled after below steps:
>    cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
> failure if property enable-gpios is not configured within DT|ACPI for
> QCA_QCA6390.
> 
> 3) qca_serdev_shutdown() is serdev's shutdown and not hdev's shutdown()
> it should not and also never get chance to be invoked even if BT is
> disabled at above 2) step.  qca_serdev_shutdown() need to send the VSC
> to reset controller during warm reset phase of above 2) steps.

It was Zijun who realized that #1 and #2 these were two separate but 
related issues. He really dug in and found the problem and produced test 
patches. It was impressive, and he should be given credit for finding 
that these were the issues so quickly.

The only reason I'm involved here is that I am squeaky wheel that 
happened to be running Rawhide and got hurt by the kernel. I am a 
glorified beta tester who got unlucky, and I was hoping the find help in 
the kernel community. Zijun stepped up.

The only other thing that I am wondering about this patch set is if 
Zijun or some other party should be listed as the maintainer of the 
btqca module and hci_qca.c and btqca.* files so that they can be found 
more easily with the get_maintainer.pl script.

wt
-- 
You're more amazing than you think!
