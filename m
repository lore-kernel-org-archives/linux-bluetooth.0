Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A8A0118.8070000@linpus.com>
References: <4A88B9F0.7040407@linpus.com> <4A8A0118.8070000@linpus.com>
Date: Tue, 18 Aug 2009 00:41:39 -0300
Message-ID: <2a9506370908172041h785648c9nc9e830191d172944@mail.gmail.com>
Subject: Re: how to make a2dp device works after chroot?
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: bourne <bournewang@linpus.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bourne,

2009/8/17 bourne <bournewang@linpus.com>:
> Hi:
> I met a problem about chroot.
> After connect the computer with my bluetooth earphone, I can hear the
> music from a2dp bluetooth earphone, but when I chroot to /root-A, and
> use "aply" command to play some sounds, I can't hear anything from the
> earphone.
>
> My question is:
> how can I use the a2dp device after chroot?
>

Probably this is not related to BlueZ, but to something missing from
your chroot, the following should do the job:

mount -o rbind /dev /root-A/dev
mount -o bind /sys  /root-A/sys
mount -t proc none /root-A/proc

(the rbind option and mounting /proc are to be on the safe side)

>
> Thanks
>
> Regards
> Bourne
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia
