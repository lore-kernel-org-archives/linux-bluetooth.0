Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6aeb672b1002080126n6ba526f1g7490cc832a59add6@mail.gmail.com>
References: <6aeb672b1002080126n6ba526f1g7490cc832a59add6@mail.gmail.com>
Date: Wed, 10 Feb 2010 10:17:07 +0800
Message-ID: <6aeb672b1002091817q159a8f42na7ace1f132842031@mail.gmail.com>
Subject: Re: Read default link policy from main.conf
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anyone could advice? Thanks.

2010/2/8 Liang Bao <tim.bao@gmail.com>:
> Hi,
>
> We noticed that currently BlueZ doesn't read link policy settings from
> main.conf as it does for other things such as General.Name or
> General.Class. It just enable everything in parse_config()
> (src/main.c). Is this just due to lack of use case or BlueZ does this
> intentionally for some reason? Thanks.
>
>
> 86 static void parse_config(GKeyFile *config)
> 87 {
> .....
> 206         main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
> 207                                                 HCI_LP_HOLD | HCI_LP_PARK;
> 208 }
>
