Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <OF2953F661.C5E1B3A9-ON4825786C.000D1F6C-4825786C.000D35E6@cn.ibm.com>
References: <OF2953F661.C5E1B3A9-ON4825786C.000D1F6C-4825786C.000D35E6@cn.ibm.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Fri, 8 Apr 2011 09:04:37 +0200
Message-ID: <BANLkTim72aKHWTvQOjfbFwyxP1j4v2MFWg@mail.gmail.com>
Subject: Re: HDP, can't read data from fd which Acquire from HealthChannel
To: Yi Hui Fan <yihuifan@cn.ibm.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/4/8 Yi Hui Fan <yihuifan@cn.ibm.com>:
> Dears
>
> I'd like to build a demo for HDP sink. I try to use the DBUS API provided
> by Bluez. But there is a problem with unix fd to receive data.
>
> I can get fd by calling HealthChannel.Acquire method.  following is the
> code I write to read data according the sock I got.
>
>        fd_set rfds;
>        struct timeval tv;
>        int rv;
>        char buff[1024];
>
>        FD_ZERO(&rfds);
>        FD_SET(sock, &rfds);
>        tv.tv_sec = 10;
>        tv.tv_usec = 500;
>
>        rv = select(sock+1, &rfds, NULL, NULL, &tv);
>
>        rv = recv(sock, buff, 1024, 0);
>
> rv is always return 0 when I call select method. I can't get anything.
>
> Any problem with these codes?

It seems that you don't have a valid file descriptor. How are you
getting the file descriptor? Are you using Dbus 1.4?


>
> Thanks &
> Best regards,

Regards

Jose.

>
> Yihui,Fan
