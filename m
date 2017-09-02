Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <367b3f96-3e2b-3951-70a2-ddf4cefd0fd3@jp.fujitsu.com>
References: <20170901035615.95402-1-yunhanw@google.com> <a4eb008e-5c19-c13c-bb35-ac840f80be42@jp.fujitsu.com>
 <CALvjcs-3W8skPEH0TyHgwX=TSzrKcMy5ptjeHPbR+kY7x8hVvw@mail.gmail.com> <367b3f96-3e2b-3951-70a2-ddf4cefd0fd3@jp.fujitsu.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Fri, 1 Sep 2017 20:54:13 -0700
Message-ID: <CALvjcs_4NM-h-U4046CF9j_PBLhn_5bpZ_qx_rbz2TduG1KHDA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix default_ctrl change when new adapter is found
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, ERAMOTO

On Fri, Sep 1, 2017 at 12:59 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Yunhan,
>
> Thanks for your explanation.
>
> Btw, could you also tell me about the following fix.

default_ctrl would be set as NULL in disconnect_handler. Therefore I
remove this redundant one.


> bluetoothclt sometimes do core dump when I detach the adapter of default_ctrl
> and run show command.

Could you share your reproduce step for this issue? Could it be
constantly reproduced?

thanks
best wishes
yunhan
