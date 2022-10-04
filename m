Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJDIEV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDIEU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:04:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1B2E69A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:04:18 -0700 (PDT)
Received: from [192.168.0.243] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MulVd-1pVOWa207X-00rsOX; Tue, 04 Oct 2022 10:02:39 +0200
Message-ID: <4fc40766-6e8d-1683-b370-1417aeab1db7@green-communications.fr>
Date:   Tue, 4 Oct 2022 10:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] Bluetooth: Add a workaround for SCO over USB HCI
 design defect
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
 <f083fce1-7ad3-0c5c-843a-3e14eb7ff4d6@molgen.mpg.de>
Content-Language: fr
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <f083fce1-7ad3-0c5c-843a-3e14eb7ff4d6@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NKpXDTZuFtYJfr7xC4usihWHelHNkyKV+MVC9fccrl5WTmSUnl3
 gbs4k+kc4T35Pl9s6NmhaZkvzR+t4Sd0S5SkPLJXDf/PloVZgvupCjCF1b56RvaAxZziDtF
 yYdOZAhTUIE70anzu6moeuAC346GnUBFeZcqtgB0ZxhUsThdiV2UTYdxQ3zwOdN3gAc/O1a
 4X6H3s9b0DQfjdym56Q3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z4aWIQ0p9zU=:aSOLid1Uu87nGYSuv3Y8N7
 VGGrFo6wqRJ9RJFVgAjSYEy9eCb3VXZ8r1KEqjkvknt4pthdXOk5mGeX4KYA4cZcTriKhQwC0
 rX3dVUsmMXtiCAU0dIFQzwXUaKx0R+zURAkQXVnPojW5AG4sZf3sxVJzkOi1ONeoGo2FiFMuS
 pX49NeyOREK2xIgf66HRGHekHBEu4TYwAet76L3WPILnItac/aGV8G0OtF7KPyeUFwN60gMEM
 NZL0o6n0os1EzlRoWgwWTVz/ZcWyrvOzHMkgQUkzfJOsmfDyzLSrIehJuYvR8zAkdjkN85UDL
 5Y1U1IhMlqAiMygLsSoMYsF8UPbFbHTn83BDeM36uL4YPaBvwcSLy1NWZfKeOvZo2rkaQ46IP
 VP7Ra/UWA6990IrTWOqMAd/j5Z2hoxKKW+MryaJ2yAaq82o0ZHpz/Dd00ZLYe6I6JiMor8K1F
 Dnrng3kHIoQ1616x8QQdBxyWEE1IuVDuhSHBHbnv1MvcSGElTEOv0DcgjnVZJrNLEEJbQtun2
 VvKEoD+qpBkLJL+kkaPOtyDssAtPzXEzmoLyYBpCF7XHEiwFaVmXOk/+/ZBBWdcsXD9RBW3q/
 Bg+4CRa366H4cc+N2oXdJZMVa7QiweKXKR6AlseuEaEbrfGgxBJcgq7h6cBeU+KovAzYVfr2q
 YirkszpPhu6yFrcjrQkyub4AACeGoHTHqNySgS6bWniwMmJq+07GrPPedkeeiefipQaSz6+jS
 eZ9NjZC8wHkXjiQbn6E4Mo576UoVjCtHpsJvvUGsWkdPJVJqrDponaUl8ApUuwiXdBXUmp2VL
 fAZIHO+x93wyPAtZOYUcLH2G0LmP5OZqpbk9XBIKqOkajODePA=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 03/10/2022 17:14, Paul Menzel wrote:
> Dear Nicolas,
> 
> 
> Thank you for the patch. Just a small suggestion to make the 
> summary/title shorter:
> 
> Work around SCO over USB HCI design defect
> 
> Am 03.10.22 um 16:25 schrieb Nicolas Cavallari:
>> The USB interface between the host and the bluetooth adapter used for
>> SCO packets uses an USB isochronous endpoint with a fragmentation scheme
>> that does not tolerate errors.  Except USB isochronous transfers do
>> not provide a reliable stream with guaranteed delivery (There is no
>> retry on error, see USB spec v2.0 5.6 and 8.5.5).
> 
> I’d put the dot/period after delivery, and inside the brackets after 8.5.5.
> 
>> To fragment a packet, the bluetooth HCI simply split it in parts and
> 
> split*s*
> 
>> transfer them as-is.  The receiver is expected to reconstruct the packet
>> by assuming the first fragment contains the header and parsing its size
>> field.  There is no error detection either.
>>
>> If a fragment is lost, the end result is that the kernel is no longer
>> synchronized and will pass malformed data to the upper layers, since it
>> has no way to tell if the first fragment is an actual first fragment or
>> a continuation fragment.  Resynchronization can only happen by luck and
>> requires an unbounded amount of time.
>>
>> The typical symptom for a HSP/HFP bluetooth headset is that the
>> microphone stops working and dmesg contains piles of rate-limited
>> "Bluetooth: hci0: SCO packet for unknown connection handle XXXX"
>> errors for an undeterminate amount of time, until the kernel accidently
> 
> indeterminate, accidentally
> 

Thanks for the typos, will fix them in v2.

>> resynchronize.
>>
>> A workaround is to ask the upper layer to prevalidate the first fragment
>> header.  This is not possible with user channels so this workaround is
>> disabled in this case.
> 
> Please document your test setup.

My current worst case is a ath3k (AR3012) on an imx6 board (GW52xx)
running 5.19.8. The issue does not depend on the hfp/hsp headset.

It should be noted that the AR3012 is an USB1 device and it is plugged 
into a USB2 root hub. This is already a special case for USB.

What happens when looking at the usbmon traces is that around every 
~2s-3s, what should be a 9 byte fragment is replaced by a 0 byte 
fragment, which is still reported as successfully transfered.

> Please excuse my ignorance, but I have a few more questions:
> 
> 1.  Does that also happen with Android?

I haven't tested to run android on this platform, but is the android 
kernel that different from a vanilla linux ?

> 2.  Is it possible to reproduce in QEMU for example?

This platform is probably not powerful enough to run qemu.
