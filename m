Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <a172fe730903302245k1bb2209ag371e07d4a0cbbb80@mail.gmail.com>
References: <a172fe730903302245k1bb2209ag371e07d4a0cbbb80@mail.gmail.com>
Date: Tue, 31 Mar 2009 13:53:02 +0800
Message-ID: <a172fe730903302253j6f137249g10c51d85488bd608@mail.gmail.com>
Subject: Re: eSCO or SCO link?
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
  I made a mistake when writing the email, I have not complete my question.

2009/3/31 ±åÀÚ <mykofzone@gmail.com>:
> Hi All,
>  I have a stlc2500c which is a Bluetooth 1.2 chip. When debuging
> function 'hci_connect', i found the hci link type of the arguments was
> SCO_LINK, because i enabled 'lmp_esco_capable' in my kernel, it call
> 'hci_setup_sync' to setup eSCO link.

But when i check connection by 'hcitool con', the hcitool show it was
a SCO link. So, is it a SCO link or eSCO link? Thanks.

> struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t
> *dst, __u8 auth_type)
> {
>        .....
>        if (lmp_esco_capable(hdev))
>        {
>                hci_setup_sync(sco, acl->handle);
>        }
>        else
>        {
>                hci_add_sco(sco, acl->handle);
>        }
>
> }
>
