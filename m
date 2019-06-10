Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01108C31E41
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 16:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C703820820
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyuQcYv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391449AbfFJQG6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:06:58 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34615 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391372AbfFJQG6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 12:06:58 -0400
Received: by mail-wm1-f49.google.com with SMTP id w9so251124wmd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CaGA49BNdswYorM8WQAqFGos1AkNpcg/BifLW9C5DQU=;
        b=jyuQcYv+DCYRfmdPMZ1akl+AWVbWE0jQtVwOuBD9Flebp3TK6pOGhL7wfD37RTu/bv
         fxCS2Qu10JmZMfjryujJq0gcxxZUdgnhgnw5vpz+XRkEKIErAC49apqtL8VXDt0hJsd3
         /FKps9Y5Dt/YDjVFsmQ8jzv8Q9C73Ka8iEqGxpVj0jwtdN0Szq44EaDt641b423iRgHz
         1p4wcICd4occAQh5xGMEt8oot7pSBDXmSCdbItfBe0rEc+eYS0tW77n2xzY4ZQ7r8MyX
         N6Rvjv6A0dPJsJTWRafFn98Gwy2PDt4PpCOWQ8ow4NAIJOyJ08OPO6U8UnIuHBh0e3mn
         z6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CaGA49BNdswYorM8WQAqFGos1AkNpcg/BifLW9C5DQU=;
        b=b2G1SvyTx8kv4YbCYfLrJYpd07xWMFVIt3aUTn9VynAl0XbsvgD2jVP36m87otu4L/
         XR21hum+8VAbYLB1pdpC0SXAroyEGLYIme5Kh+Smfb1jghGIdrvPrjVqOwlVdYHZ2fiY
         2L7CbuqR3xVgK1ejQQcmo6HwXNWgrlbjnxUR0D/nhVFhLfN1nlsdbOgpvRPpX+jLx30d
         5p/kLv1qLqzGrm22M1HFhcbNN+9kX5z/lXGMQbBGOID+sGwVOtvQPIOzbGNPhhGMIytk
         x+s5NiHVOLSVC/iXt1tVTisS7eOdEoFq+0/HbF2Q8h9XOpF5TwDHuQdNgm3WAGf4CuCZ
         bnLQ==
X-Gm-Message-State: APjAAAWlsmmxAzPJ7cqN9sH+K9Q/h5s9OXAs+BMHHaQCtoVqckBwD8vp
        y881uJsodheovFYxlyT0BZeI2Vnu
X-Google-Smtp-Source: APXvYqwHY0MIBU39Z4KOxM/BeXXLSa85bGxVrou/Ptj7ZUnqqASr4pP8w9yWTu4dkHBPsi/AHI33Zg==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr14467644wmb.142.1560182815697;
        Mon, 10 Jun 2019 09:06:55 -0700 (PDT)
Received: from [192.168.102.9] (97.205.83.79.rev.sfr.net. [79.83.205.97])
        by smtp.gmail.com with ESMTPSA id l8sm4022942wrg.40.2019.06.10.09.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:06:54 -0700 (PDT)
From:   =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: bluez A2DP socket reliability
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190518190618.m7rdkthvpz4agxd2@pali>
 <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
 <20190519122223.gabew7qfftihlbic@pali> <20190607130021.ntd3dfd6nzmuy3m3@pali>
 <CABBYNZKQ0WYTH4Oa_eFv11Ok8=42oY_GPFzN-D6UqfeNsvaXug@mail.gmail.com>
 <20190610105130.un3muj4knwoua5cb@pali>
Message-ID: <b7e5978c-7ebc-82ad-2c44-878712cd14cd@gmail.com>
Date:   Mon, 10 Jun 2019 18:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610105130.un3muj4knwoua5cb@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Le 10/06/2019 à 12:51, Pali Rohár a écrit :
> On Friday 07 June 2019 18:23:41 Luiz Augusto von Dentz wrote:
>> Hi Pali,
>>
>> On Fri, Jun 7, 2019 at 4:00 PM Pali Rohár<pali.rohar@gmail.com>  wrote:
>>> On Sunday 19 May 2019 14:22:23 Pali Rohár wrote:
>>>> On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
>>>>> Hi Pali,
>>>>>
>>>>> On Sat, May 18, 2019 at 11:12 PM Pali Rohár<pali.rohar@gmail.com>  wrote:
>>>>>> Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
>>>>>> transfer configured in bluez? It is reliable with big/infinite
>>>>>> retransmit count? Or in best-effort manner and some packets may be
>>>>>> dropped? And it is possible to change between these two modes for
>>>>>> application which uses bluez DBUS API? I'm asking because some A2DP
>>>>>> audio codecs are designed to deal with packet loss and for those codecs
>>>>>> it would be probably better to configure L2CAP socket to unreliable
>>>>>> mode.
>>>>> We don't use ERTM with AVDTP, both signaling and transport sockets are
>>>>> using basic mode which don't support retransmissions, there the
>>>>> concept of flush timeout which iirc we don't currently it.
>>>> On bluez.org site there is no information how to use bluez sockets and
>>>> the only documentation/tutorial which I found on internet was this:
>>>>
>>>>    https://people.csail.mit.edu/albert/bluez-intro/x559.html
>>>>
>>>> I do not know how up-to-date it is, but seems that by default bluez
>>>> L2CAP sockets are reliable and to change them to unreliable mode it is
>>>> needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
>>>> request. As default is zero = infinity = reliable connection.
>>>>
>>>> I do not understand low level bluetooth details, but is ERTM related to
>>>> OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?
>>>>
>>>> So what are default settings for L2CAP socket used by AVDTP/A2DP
>>>> profiles which are transferred to user application via DBUS?
>>> Hi! Do you have any idea about OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT? It is
>>> related to ERTM or not?
>> The OCF usually describes an HCI command which may affect the entire
>> ACL connection, ERTM is a L2CAP channel mode that includes
>> retransmissions. The A2DP stream transport doesn't ERTM so no
>> retransmissions shall take place.
> Fine, no retransmission is good for A2DP.

I am not sure there is no retransmission with current implementation.
AFAIU, ERTM and automatic flush timeout are not linked. ERTM operates at 
L2CAP level while automatic flush timeout [1] operates at ACL level.
When I read the automatic flush timeout set for an A2DP SBC connection 
it returns 0, which means that the connection uses an infinite timeout. 
So, even if higher levels set packets as flushable, the ACL policy 
requests baseband to indefinitely try to send data [3]:
   "The default Flush Timeout shall be infinite,
     i.e. re-transmissions are carried out until
     physical link loss occurs. This is also
     referred to as a 'reliable channel.'"

[1] Bluetooth core Vol 2, Part E, 6.19
[2] Bluetooth core Vol 2, Part E, 7.3.29
[3] Bluetooth core Vol 2, Part B, 7.6.3

-- 
Frédéric Danis                       Embedded Linux Consultant
frederic.danis.oss@gmail.com

