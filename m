Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD179C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42820718
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQkz/dKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAWSE4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:04:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37101 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgAWSEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so4625323ljg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2020 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a08LVG9+Lsyi+E6ZLEWEdllKYc3SbNtfX2SodbbsPxM=;
        b=mQkz/dKvrn1QLzhx/n1rxTpLL/ufvx37lPd2oyLkEx35FsyO2FYYTDAqTS7oEoAqrx
         pKnJsE+Te1lxG+kGvGwIvFLIZfXdth54Ryxph3prEZKuuHlMZ5x9Vc2UbNFgi9ohLjeg
         3mcsBtDAnrRUVXE/hnKIrP2l/4YDiVqcI15DW08QavJPjKkdyPzZsXSwNob4rfHGKuwj
         RntwOL4rO5kFAXIfYnE23EEZ6sr31d5V6VlnRjMEFpRPyDFmHLIWfHTcrB+EuBjWXC7K
         q1XPqG7XM1Ud7SdiLl4LZ5zcuR3E+HxntCk6mvV4mSicnq7rYhffpLEJF0Q/Q1zwdnvO
         ydwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a08LVG9+Lsyi+E6ZLEWEdllKYc3SbNtfX2SodbbsPxM=;
        b=C8MXA6h7sy8Go5OqVdaeUVRmMxl4li3maf+ytvHCgX+bD8dUE8tb9ivq0CQfovVfAh
         bc/mUME5UFTtIL7ZPO/UKvukyASKT2Z0HTBF1BmfjA2h44MqQjBXVkPB0qWY06HAkNUW
         1cJsOxj7bsz1hmAwIiYO26LdkcIrJK3XPlKc8WZTyJZk3AQxzTBC6O6sI8kIjTPi4srb
         tqLRVXhChHYVuY4dglYtyalgZsOSJIK6wjWAP/4wLMlFfwZZRx7mcdoidaXP8IrNe3sY
         ulrefZR/F+X28OuRoa92baxnqEOlipXryyRQlw+TOkKNOxGQJWVV8MiKG8W/LyQ3/yef
         SP6A==
X-Gm-Message-State: APjAAAXKHaU2QB7HVzz6hyzDT0VbSFuoOp9Gqqt+UGIgqO2f8xF2cSE3
        AYOznmtnaUKICBxTg/UZ8y8VfU6VusfVKo1hJ9uHpNK/Sr4=
X-Google-Smtp-Source: APXvYqzYzvCWynYUWlmdLuv45iBly59kfN1n+hJ0Y45Iq7ai87ihmg1T6hiAB1kr2MohIspZ815zeG7Nip0XRNNFWcA=
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr24305273ljh.28.1579802691963;
 Thu, 23 Jan 2020 10:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com> <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
 <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org> <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
 <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org>
In-Reply-To: <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 23 Jan 2020 13:04:40 -0500
Message-ID: <CALWDO_Vqboxt4JfV9yGVd5Jv5jZ-vwtOghh4tffpQpQzHuq6NQ@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

From a high level, this looks good for me although I agree, this is an
order of magnitude bigger in terms of scope.  Can you suggest perhaps
an interactive way to deliver this over a period of time, perhaps
prioritizing the BT_DEBUG kernel messages first? :)

Thanks,
Alain

On Thu, Jan 23, 2020 at 12:44 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Alain,
>
> >>> Thanks for your patience.  After further research dynamic_debug is no=
t
> >>> available on retail chromium os user systems for a variety of reasons=
,
> >>> some of which you can find in this trail:
> >>> https://bugs.chromium.org/p/chromium/issues/detail?id=3D188825.
> >>>
> >>> Given we need to be able to diagnose things in the field, this is not
> >>> a good option for this.
> >>>
> >>> I hope this helps explain or justify the need for this interface.
> >>
> >> the reasoning from Kees is 6 years old. Are his issues still valid?
> >>
> >> So I have been looking into pushing bt_{info,warn,err} into the btmon =
traces. That is why we have bt_dev_* etc. error macro and have changed a lo=
t of code to use them. This will hopefully allow us to have errors and warn=
ings directly in the btmon traces. For bluetoothd errors and warnings this =
already works btw.
> >>
> >> I don=E2=80=99t believe that I want to duplicate the dynamic_debug fun=
ctionality and push even more info into dmesg ring buffer that then needs t=
o be collected and aligned with btmon traces. The big advantage is if you g=
et a btmon trace and that has the actual message right in it at the right p=
lace with the right timestamp.
> >>
> >> If we push bt_{info,warn,err} into btmon, it might be simpler to do th=
e same for BT_DBG, but it will of course require extra work since our BT_DB=
G statements are meant to be compiled out if dynamic_debug is disabled.
> >
> > The rational is all still relevant today.  To give you some additional
> > background, here's how a version of this is currently used:
> >
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/1697851
> >
> > Note that I don't expect us to upstream this as is, in particular,
> > it'd expect we'd also want to forward to pr_debug to support
> > dynamic_debug for systems where it makes sense to use.
>
> if we do something like this, then I want to do it a lot more integrated.=
 So far I came up with this:
>
> 1) We want to be able to start btmon -d and btmon-logger -d and then debu=
gging gets enabled in the kernel and bluetoothd and all of them will be inc=
luded in the btmon trace files. So a customer can just create a log files t=
hat includes kernel messages, bluetoothd messages and also HCI traces and i=
f enabled (and supported by the specific hardware) LMP traces.
>
> 2) When enabled in the kernel, then bluetoothd should follow the debug le=
vel. I think it makes no sense if we end up having to restart bluetoothd. E=
specially since bluetoothd also has internally =E2=80=9Cdynamic_debug=E2=80=
=9D like statements that can be switched at runtime (and per statement actu=
ally).
>
> 3) We need an option to disable this and compile it out. Switching on dyn=
amic_debug and extra debug statements for our own =E2=80=9Cdynamic_debug=E2=
=80=9D causes an overhead that we can not really accept. We might even go t=
his far as making it mutually exclusive.
>
> 4) Wherever possible we want debug statements that can be related to the =
given hciX interface index.
>
> 5) There needs to be an option to limit the scope of the debug messages s=
ince otherwise you get lost in the noise.
>
> 6) I don=E2=80=99t want to touch every BT_DBG statement or debug statemen=
t in bluetoothd. Developers should be able to just add a debug and the rest=
 will be taken care of for them.
>
> This needs a bit more time to be planed out, but I am roughly thinking so=
mething like this:
>
> Read Debugging Categories Command
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         Command Code:           TBD
>         Controller Index:       <controller id>
>         Command Parameters:
>         Return Parameters:      Num_Supported_Categories (2 Octets)
>                                 Num_Enabled_Categories (2 Octets)
>                                 Supported_Category1 (2 Octets)
>                                 ..
>                                 Enabled_Category1 (2 Octets)
>                                 ..
>
> Set Debugging Categories Command
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>         Command Code:           TBD
>         Controller Index:       <controller id>
>         Command Parameters:     Category_Count (2 Octets)
>                                 Category1 (2 Octets)
>                                 ..
>
> Debugging Categories Changed Event
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         Event Code:             TBD
>         Controller Index:       <controller id>
>         Event Parameters:       Category_Count (2 Octets)
>                                 Category1 (2 Octets)
>                                 ..
>
>
> With this bluetoothd can check the enabled categories and just enable the=
m when it starts, but it can also monitor the change in enabled categories =
and change the debug statements accordingly.
>
> This would be independent of btmon and btmon-logger, but these two comman=
ds could also use the monitor socket to enable additional categories via a =
socket option. Or maybe this is better done just one way. I need to think a=
bout this a bit more.
>
> Anyhow this is just the API that I would look into doing. The heavy lifti=
ng has to be done in the kernel and bluetoothd to use it correctly. That is=
 actually a bit more complicated.
>
> Regards
>
> Marcel
>
