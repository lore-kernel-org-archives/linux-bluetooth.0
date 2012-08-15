Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 17:22:07 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Gustavo Padovan <gustavo@padovan.org>
cc: Masatake YAMATO <yamato@redhat.com>,
	andrei.emeltchenko.news@gmail.com, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 8/8] Added /proc/net/sco via bt_procfs_init()
In-Reply-To: <20120726042411.GA3226@joana>
Message-ID: <alpine.LNX.2.01.1208151721380.19409@frira.zrqbmnf.qr>
References: <20120716.222018.2029110835026223294.yamato@redhat.com> <20120725001214.GP20029@joana> <20120725003507.GR20029@joana> <20120726.013012.2228722667223437938.yamato@redhat.com> <20120726042411.GA3226@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 2012-07-26 06:24, Gustavo Padovan wrote:

>Hi Masatake,
>
>* Masatake YAMATO <yamato@redhat.com> [2012-07-26 01:30:12 +0900]:
>
>> Added /proc/net/sco via bt_procfs_init().
>> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>  net/bluetooth/sco.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>
>All 8 patches have been applied to bluetooth-next. Thanks.

It may have been raised before, but: should not the info be exported 
over netlink rather than the oldfashioned and overabused procfs?
