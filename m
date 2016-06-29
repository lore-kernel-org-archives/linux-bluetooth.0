Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160629133159.GA28159@arthur-bzh>
References: <20160629133159.GA28159@arthur-bzh>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Wed, 29 Jun 2016 15:39:51 +0200
Message-ID: <CADwkJj+fmSoOsyeg4txjdPUS7ajb4tHL25ZDZS3e-w=kU6iN4Q@mail.gmail.com>
Subject: Re: gatt server and reset of hci device
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> [arthur * dev] uname -a
> Linux arthur-bzh 3.13.0-88-generic #135-Ubuntu SMP Wed Jun 8 21:10:42 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
That kernel doesn't support the MGMT_OP_READ_ADV_FEATURES. You should
try updating your kernel. Ubuntu 14.04.4 uses kernel 4.2.
