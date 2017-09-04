Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: Re: [PATCH BlueZ] client: Fix default_ctrl change when new adapter is
 found
To: Yunhan Wang <yunhanw@google.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20170901035615.95402-1-yunhanw@google.com>
 <a4eb008e-5c19-c13c-bb35-ac840f80be42@jp.fujitsu.com>
 <CALvjcs-3W8skPEH0TyHgwX=TSzrKcMy5ptjeHPbR+kY7x8hVvw@mail.gmail.com>
 <367b3f96-3e2b-3951-70a2-ddf4cefd0fd3@jp.fujitsu.com>
 <CALvjcs_4NM-h-U4046CF9j_PBLhn_5bpZ_qx_rbz2TduG1KHDA@mail.gmail.com>
Message-ID: <683fdd05-468d-5b70-86f6-f71c5d504c98@jp.fujitsu.com>
Date: Mon, 4 Sep 2017 09:48:01 +0900
MIME-Version: 1.0
In-Reply-To: <CALvjcs_4NM-h-U4046CF9j_PBLhn_5bpZ_qx_rbz2TduG1KHDA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On 09/02/2017 12:54 PM, Yunhan Wang wrote:
> Hi, ERAMOTO
> 
> On Fri, Sep 1, 2017 at 12:59 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Hi Yunhan,
>>
>> Thanks for your explanation.
>>
>> Btw, could you also tell me about the following fix.
> 
> default_ctrl would be set as NULL in disconnect_handler. Therefore I
> remove this redundant one.
> 

It seems g_dbus_client_unref() calls disconnect_handler() when g_main_loop_run()
is exited by quit command etc.. So I think here defautl_ctrl should be set as 
NULL in interactive mode.

> 
>> bluetoothclt sometimes do core dump when I detach the adapter of default_ctrl
>> and run show command.
> 
> Could you share your reproduce step for this issue? Could it be
> constantly reproduced?

It is always reproduced with the following steps:

  1. Attach an adapter.
  2. Run bluetoothctl.
  3. Detach this adapter.
  4. Run device command in bluetootctl.


Regards,
Eramoto

> 
> thanks
> best wishes
> yunhan
> 
> 

