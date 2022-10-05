Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8EAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 09:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEJZN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJEJZM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 05:25:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03C186E9
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 02:25:10 -0700 (PDT)
Received: from [192.168.0.243] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MC2wN-1oTeht0IKD-00COc1; Wed, 05 Oct 2022 11:25:08 +0200
Message-ID: <2e7025f4-e63c-070a-08e0-a1fb2469ee49@green-communications.fr>
Date:   Wed, 5 Oct 2022 11:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] Bluetooth: Work around SCO over USB HCI design defect
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
 <CABBYNZJwti_jYq2ctGfgAeh3OS5ed7WqxwBhPhoxrL51Cciy2w@mail.gmail.com>
Content-Language: fr, en-US
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <CABBYNZJwti_jYq2ctGfgAeh3OS5ed7WqxwBhPhoxrL51Cciy2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YkOrtBntXcJzOX0Zy8PENSu654ENjI50ZW/oo9sEBItFpg3wCZI
 mfV3O494TpKNSf/Gy9L8QXeglzlSF4rruBiC/i24T3Mxb/aXULQsEDsdwcVEhSKfXIDEeNg
 7IRV9cKgnaI7YkihpC0AYARBEUtb7qzzQX5Kc0fZlHPRB7mbHHdJxcUR1TSlMqwOZYvd6wj
 /QBXxGok3pwQB0aSjSzGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3OMEzfxFs8=:v5/Dv4+1wCjCp589GGHga1
 74+5td5MDFSCyYjQqHoT3m6sRa+0wdZZzkdg9L9gJY94HsZ8nKr3zvzfJYQcl4+149Q5PPO4H
 EzZ03QTW7yWrkBw2s3oBtgjBwJVAEBDkkZe2CfLhHKSyeZ10TcPDS1UcvJZ+eZp61W1TMmc0m
 fWol+2V7CK0ghqed4DoWxkPuVcRdRiMgp7HRAJOLM212pGcSeJD8F3G6pOsgw6Hu1Fn9DxmFI
 QG6vYo0S9TCzn8nqXVDrjiBHQN6PQ8BQ97Nrx3/+D2eNYkQVI8lk8wV5zNQe8JvMfIUwmd2VT
 r4G9L5Pzx6IlqZVDiXpKvELo0ntkycboCYPyYwm/Dehfe0onj2u0/0XI6KlGc79skLlHf7A3G
 4vhaGeXbAGk3Zc0USfX23CTh1PRgjRT5mZz+n3ChVhzmXjpBiGvYaAOrKMQcF5IKrCCnCslVl
 9NS+mPRsPN8tuxEQ1EhymnFL6gxljWZUPuE+gHYy1Wr56cOdBnsmVWL0GtEvz8a/2OLY7F6jo
 WqSvzZI0As7abXKE3MfZhhkoZBSksnAeKsw+2ZHooYShkVsJKvFb2lry1Dz7bHNQXbZuBE5uu
 XEXMnVZoF3yKIgPQAuhVEbyKlUYduJykSJAM6D4UDIpwyUaCRaYCCpg2MS+BaLFneGgYq4yzC
 fsuw0GR4I5fAeqJJk+JMxyzHL26xRIfSeESGjp5pInnoF3R4JHA/dWQaSWW1FiC/7sHCNjgyO
 /4MgYMZt3Tgv8o2UgnaXmRm+zaxvtsQrOSlfqfWxt63N7Aaed3Bn4bt/Af2jIf+ukuMzzfVvl
 94k7NbxzCYTWj4QLAemoJWzOct5adjbAPoHFTtmS2TBu8RvdOg=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 05/10/2022 01:46, Luiz Augusto von Dentz wrote:
> Hi Nicolas,
> 
> On Tue, Oct 4, 2022 at 7:54 AM Nicolas Cavallari
> <nicolas.cavallari@green-communications.fr> wrote:
>>
>> The USB interface between the host and the bluetooth adapter used for
>> SCO packets uses an USB isochronous endpoint with a fragmentation scheme
>> that does not tolerate errors.  Except USB isochronous transfers do
>> not provide a reliable stream with guaranteed delivery. (There is no
>> retry on error, see USB spec v2.0 5.6 and 8.5.5.)
>>
>> To fragment a packet, the bluetooth HCI simply splits it in parts and
>> transfer them as-is.  The receiver is expected to reconstruct the packet
>> by assuming the first fragment contains the header and parsing its size
>> field.  There is no error detection either.
>>
>> If a fragment is lost, the end result is that the kernel is no longer
>> synchronized and will pass malformed data to the upper layers, since it
>> has no way to tell if the first fragment is an actual first fragment or
>> a continuation fragment.  Resynchronization can only happen by luck and
>> requires an unbounded amount of time.
>>
>> The typical symptom for a HSP/HFP bluetooth headset is that the
>> microphone stops working and dmesg contains piles of rate-limited
>> "Bluetooth: hci0: SCO packet for unknown connection handle XXXX"
>> errors for an indeterminate amount of time, until the kernel accidentally
>> resynchronize.
>>
>> A workaround is to ask the upper layer to prevalidate the first fragment
>> header.  This is not possible with user channels so this workaround is
>> disabled in this case.
>>
>> This problem is the most severe when using an ath3k adapter on an i.MX 6
>> board, where packet loss occur regularly, possibly because it is an USB1
>> device connected on an USB2 hub and this is a special case requiring
>> split transactions.
> 
> Interesting, but does this actually make it work if with the packet losses?

All userspace hsp/hfp implementations have packet loss concealment, I 
think, so they can tolerate losing one or two packets there and there. 
In any case it is much more usable than before. Without this patch, the 
number of packet lost is in the 10-1000 range and it is much harder to 
conceal that.

With this patch, given this sequence 01230123, if the first fragment (0) 
is lost, then only one packet is lost. If anything else than the first 
fragment, say (2) is lost, then 0130 is forwarded to the upper layer and 
  the remaining 123 is dropped.

With my ath3k I see that dropped fragments are replaced by zero-length 
fragments. I have a patch that treats zero-length fragments as an error 
and drops the current packet when it occurs, but I can't be certain that 
this won't cause any regression for other adapters, so didn't submit it.

>> [...]
>>
>> +static inline bool hci_conn_prevalidate_sco_hdr(struct hci_dev *hdev,
>> +                                               struct hci_sco_hdr *hdr)
>> +{
>> +       __u16 handle;
>> +
>> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
>> +               // Can't validate, userspace controls everything.
>> +               return true;
>> +
>> +       handle = hci_handle(__le16_to_cpu(hdr->handle));
>> +
>> +       switch (hci_conn_lookup_type(hdev, handle)) {
>> +       case SCO_LINK:
>> +       case ESCO_LINK:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +}
> 
> Don't really like to have this in hci_core.h, it is sort of messy
> already beside this is probably too specific to USB so I'd go with
> something like btusb_validate_sco_handle and add a comment explaining
> why this is necessary.

Will move that into btusb.c then.

