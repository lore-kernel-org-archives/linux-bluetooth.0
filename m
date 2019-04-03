Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA57C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9432084C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 06:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjmDPu+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDCGyv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:54:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43365 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCGyu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 02:54:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so18015218qtc.10;
        Tue, 02 Apr 2019 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWc/zluHnOPwihJ0Ve6rW6/iBVNxXxnAvUJpMJoVxHA=;
        b=DjmDPu+ixcEWYIwmwAPwucFQ7K8ECUyNXzWNXYxCbOkgd9Rf6+Ao1YcS17lMHyBQ+A
         TpNRzbLyAfUyE6WohVhXxnbWOp2nhY6T+/ar9Xn2wia86Trdnnhn3CgAyv6S7uvEhd2w
         RbEEWo+WYlNQbsBOuYAD8Eqbf0Te8XAHCQnBHEHRQIFkJOhlrRI0kohbTaO9NPHiP2yd
         o0erH0vm9YX8+yqZBxOtp2zVktaylSGB9EkCd55Qm0ifktU9IOq3bbf5qWZBbX1oobWO
         mCSZfHNrb+Z8k/eG8QNqysIuBrrzoVRqcM+vCSWIn2SRJhHat7O+ci6c+5L+TiUjDCQp
         Lp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWc/zluHnOPwihJ0Ve6rW6/iBVNxXxnAvUJpMJoVxHA=;
        b=dXJVNXs8Z5sVKYB/BmQ458g10EakJ7qLHaYs2t0n7VDXB7OI5Gdre0TiD19psUHi/p
         RYjL/WhM/EO0Ef35QCuRColZc70MUlyY00d2wGftl7wYPYff5OXBrE0w3QOUHAkZ5HNi
         cPhAHyjSTYlp8r4GCHYTE7bBR3kKou0q+KJJe5zaFrliFG6MXAlo+gSptYG7vfkdkCIf
         CgJJ+ze49gkzceSdfvh9XRTClfND612KJsbvNCUFMSXVbv4nKXUFMce4RQWg7K2MnMPg
         nWWcuoUnendJ8j/ZKZNShHGQRrVhZyFIjO6C4RxAlITciH8qgmvQdIXWWxVZNkYryKwo
         HT8Q==
X-Gm-Message-State: APjAAAWtvCdjeK8Yuqh37WE70HmD7UvhljiYT7HnfLNwySmJxtFikvPz
        /GVYpwsgePAr0uZWkRFR+36++74oxCXh92qk5Fc=
X-Google-Smtp-Source: APXvYqyX8XUM46wRIViBH6SYw5StYwTNnYjwTjBBF4CMg1yaT3fL6PawbPOI2mTMU6WMLdRY8gzwsgiUvbRnSSEgURI=
X-Received: by 2002:a0c:c16c:: with SMTP id i41mr45977521qvh.183.1554274489935;
 Tue, 02 Apr 2019 23:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <b2a2b63a-c5f0-5d03-7516-668df6049c95@gmail.com> <20190401063215.GC32590@kadam>
 <d1b5afe2-8760-55eb-8b6f-28c31b3c3658@gmail.com>
In-Reply-To: <d1b5afe2-8760-55eb-8b6f-28c31b3c3658@gmail.com>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Wed, 3 Apr 2019 12:24:38 +0530
Message-ID: <CAJzH+bpwaLhjbUtsCMTzGn6VvAoiSZ3WSAV0exqhteToBuiOVg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Apr 1, 2019 at 10:54 PM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
>
> On 4/1/19 8:32 AM, Dan Carpenter wrote:
> > On Sat, Mar 30, 2019 at 11:44:29PM +0100, Tomas Bortoli wrote:
> >> Hi,
> >>
> >> sorry for the multiple emails but I have checked again the code and
> >> looks like process_adv_report() reads from ev->data for a size of
> >> ev->length.
> >>
> >> I attach a patch that applies the bound check to both
> >> hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().
> >>
> >
> > You're right that both need to be fixed.
> >
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index 609fd6871c5a..275926e0753e 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -5345,6 +5345,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >>  {
> >>      u8 num_reports = skb->data[0];
> >>      void *ptr = &skb->data[1];
> >> +    u8 *end = &skb->data[skb->len - 1];
> >                              ^^^^^^^^^^^^
> >>
> >>      hci_dev_lock(hdev);
> >>
> >> @@ -5352,6 +5353,9 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >>              struct hci_ev_le_advertising_info *ev = ptr;
> >>              s8 rssi;
> >>
> >> +            if (ev->data + ev->length > end)
> >
> > No, this isn't right.  You've removed the + 1 and you've introduced an
> > additional "sbk->len - 1" so we're off by two...  The test is supposed
> > to be:
> >
> >       start + length_read > start + length_of_buffer
> >
>
> afaict: ev->data = start and length_read = ev->length
> and the right side of the condition is the upper limit. "end" as defined
> in my patch is the last readable byte of skb->data (or am I wrong on
> this too?)
>
> > So the end has to be &skb->data[skb->len].  The "+ 1" comes from later
> > in the function when we do:
> >
> >               ptr += sizeof(*ev) + ev->length + 1;
> >                                                ^^^^
> >
> > I don't where the "+ 1" comes from, but I know the condition and the
> > increment should match.  We could use ev->data instead of
> > "ptr + sizeof(*ev)" but to me, because the mysterious "+ 1" then it
> > seems more readable to match the increment exactly...
>
> We really have to first understand why there is that + 1 there. I agree
> that the condition and the increment should match, otherwise or there is
> a mistake in the error condition or the increment just skips 1 byte, not
> reading the last per each cycle, for no reason (very unlikely).
>
> Reading process_adv_report() I spotted some memcpy() and other reads of
> the memory area that begins at data (ev->data) and ends at (ev->data +
> length).
>
> Could anybody clarify the logic of that inc ?
>
"+ 1" is required in adv_report_evt since there is one more field
"rssi" after data
so you need + 1 to point to next report, where as it is not required
in ext_adv_report_evt
since rssi is present before data. I have already raised a patch to
fix it the in ML.

Thanks,
Jaganath
