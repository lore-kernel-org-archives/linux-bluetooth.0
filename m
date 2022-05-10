Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbiEJShX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349009AbiEJShU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 14:37:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515A5B3D9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 11:37:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so17521269plk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S0M97+fGWZ4Zm2UuDpJS6uMaKwk3LrToAvnoGx8kZDk=;
        b=Wt7+tzfkXVpQQbdZRK8MtizAie+ImzB24FmCixJXRZ9IfVo4d2kvmvi8VUK3f11m0y
         R5rQxXb0gIBfP1pJWqXgQhRVd15HVTvpEuuLp2HnNvY0QU5jtDwkbU46qlnZxaA8bq5W
         hk1fBVhDIDDJOb5GnI2Csa9N2sS3IAjUCiuPfKL6oFPWjz3Bw1IKXHxqT18N7/N/02px
         U7PK7MDZIvXbZF4kE6gDvRokeKAhBRgyxyJl0QIhel1qe0MzNa+Fs8zcMFDcXTKImX+/
         GSFJtDzOidpA8lIvM2TJswPMV6wOqFn3G9TOvUTCVNUYwotsZdzGveTXUDV2XfLL1/HF
         vhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S0M97+fGWZ4Zm2UuDpJS6uMaKwk3LrToAvnoGx8kZDk=;
        b=yOZ72CctORoqjI4T92DDxhTqJgP+Lli0FjJE04WoCRGV+QcrwlKTIuuJk23RSGzwXY
         xLwsCA9lw03J96gQU/0hGbEeBRWdfvqVn7kooFwQViwiiKcIcyZfsiFWyye69Qc3d0Z6
         nnw2vBPDQNaDsNervpYm6XJbVsSUBuiMptOPL0u07PkFob7AOysZzKuDTzvlJjrRlmLx
         5EPOp2nw4PCH0AmbfknFU/BsDI/43meq5e20a8UWPBSrjN9RHUByugjorG9A+FQHjZ3r
         tvciMvpTgIimdMmmlTgtQVJKHbzpX/26NNkpUqwPpjwEUjK/D2vqFSaBIVdrcaWwE0fm
         9mbA==
X-Gm-Message-State: AOAM532DVX3lDmjMhWAAFAAVjlf8e7ADZyd4soevtQaCJHLEMC0wudC6
        PDUM112a1Q8XBNEJso+n0yocyaHsjczSe+B0Ayk=
X-Google-Smtp-Source: ABdhPJxBy3Pa6TQJdMx/A2L4V62XXDrBn/sCo0/f8AAnMw+U3W8Iar1mMIhtCHvlbnix90LQj+dDYA9dFO+J2X6K1gc=
X-Received: by 2002:a17:90b:4b83:b0:1dc:4cc8:16d9 with SMTP id
 lr3-20020a17090b4b8300b001dc4cc816d9mr1269773pjb.4.1652207832018; Tue, 10 May
 2022 11:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR04MB8404AB7E63BB4533852BB4C992C99@AS8PR04MB8404.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8404AB7E63BB4533852BB4C992C99@AS8PR04MB8404.eurprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 May 2022 11:37:00 -0700
Message-ID: <CABBYNZJFJN42XgTKG9ZFv9Eyen7kypcpmEaf+9ztjz1rzray7w@mail.gmail.com>
Subject: Re: observe the kernel panic (use-after-free in hci_le_conn_failed)
 when connect the BLE device failed on L5.17.0-rc8
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sherry,

On Tue, May 10, 2022 at 2:47 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Hi, Bluetooth community:
>
> When I try to connect the BLE device to i.MX8mm platform on L5.17.0-rc8 k=
ernel, sometimes BLE connection may fail, at which point I can observe an k=
ernel panic (Unable to handle kernel paging request at virtual address 0007=
8024e000003b), then I enabled the KASAN, found there is a use-after-free is=
sue in hci_le_conn_failed(), check the following error logs for details.
> There is no such issue with the L5.15 kernel. Has anyone observed the sim=
ilar issue on L5.17.0-rc8 kernel? Or have any idea regarding this issue? Ma=
ny thanks.

Interesting, this might be a problem with the controller generating a
different event than expected:

/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2261:
*
* If this event is unmasked and the HCI_LE_Connection_Complete event
* is unmasked, only the HCI_LE_Enhanced_Connection_Complete event is
* sent when a new connection has been created.
*/
err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
       sizeof(cp), &cp,
       use_enhanced_conn_complete(hdev) ?
       HCI_EV_LE_ENHANCED_CONN_COMPLETE :
       HCI_EV_LE_CONN_COMPLETE,
       conn->conn_timeout, NULL);

So if the event is different than expected the event would be
processed _before_ create_le_conn_complete which would likely timeout,
so perhaps we need a special handling to match multiple events instead
of just one, though it worth checking if this is allowed by the spec
given that:

/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 1789:
 *
 * C24: Mandatory if the LE Controller supports Connection State and either
 * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supporte=
d
 */
#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
ext_adv_capable(dev))

Perhaps this is not enough since it appears we are getting the
enhanced version even if this evaluates to false so perhaps we should
test something else, that said we also do:

/* If the controller supports LL Privacy feature or LE Extended Adv,
* enable the corresponding event.
*/
if (use_enhanced_conn_complete(hdev))
events[1] |=3D 0x02; /* LE Enhanced Connection Complete */

So it looks like the controller is generating LE Enhanced Connection
Complete even when the host has not unmasked it.

> Error logs:
> [bluetooth]# connect E3:BD:5B:22:90:68
> Attempting to connect to E3:BD:5B:22:90:68
> [bluetooth]# [  552.446716] Bluetooth: hci0: Opcode 0x200d failed: -110
> Failed to connect: org.bluez.Error.Failed
> [  552.467725] Bluetooth: hci0: request failed to create LE connection: e=
rr -110
> [  552.481726] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  552.488966] BUG: KASAN: use-after-free in hci_le_conn_failed+0x4b0/0x5=
a0
> [  552.495695] Read of size 8 at addr ffff0000126da570 by task kworker/u9=
:0/73
> [  552.502667]
> [  552.504169] CPU: 2 PID: 73 Comm: kworker/u9:0 Tainted: G           O  =
    5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
> [  552.515834] Hardware name: FSL i.MX8MM EVK board (DT)
> [  552.520894] Workqueue: hci0 hci_cmd_sync_work
> [  552.525275] Call trace:
> [  552.527727]  dump_backtrace.part.0+0x210/0x220
> [  552.532190]  show_stack+0x18/0x6c
> [  552.535518]  dump_stack_lvl+0x68/0x84
> [  552.539199]  print_report+0x160/0x5bc
> [  552.542878]  kasan_report+0xa4/0xf0
> [  552.546378]  __asan_report_load8_noabort+0x3c/0x50
> [  552.551185]  hci_le_conn_failed+0x4b0/0x5a0
> [  552.555378]  create_le_conn_complete+0x60/0xb0
> [  552.559836]  hci_cmd_sync_work+0x128/0x210
> [  552.563945]  process_one_work+0x60c/0xf04
> [  552.567971]  worker_thread+0x3bc/0xe1c
> [  552.571731]  kthread+0x278/0x2e0
> [  552.574976]  ret_from_fork+0x10/0x20
> [  552.578568]
> [  552.580065] Allocated by task 518:
> [  552.583474]  kasan_save_stack+0x2c/0x54
> [  552.587323]  __kasan_kmalloc+0x90/0xbc
> [  552.591086]  hci_conn_add+0x70/0xe50
> [  552.594670]  hci_connect_le_scan+0x23c/0x71c
> [  552.598952]  l2cap_chan_connect+0xbe8/0x11ec
> [  552.603238]  l2cap_sock_connect+0x298/0x57c
> [  552.607434]  __sys_connect+0x1e4/0x240
> [  552.611198]  __arm64_sys_connect+0x6c/0xa0
> [  552.615306]  invoke_syscall+0x6c/0x260
> [  552.619073]  el0_svc_common.constprop.0+0x17c/0x280
> [  552.623962]  do_el0_svc+0xa0/0xd0
> [  552.627292]  el0_svc+0x4c/0x8c
> [  552.630360]  el0t_64_sync_handler+0xa4/0x130
> [  552.634649]  el0t_64_sync+0x18c/0x190
> [  552.638325]
> [  552.639821] Freed by task 476:
> [  552.642882]  kasan_save_stack+0x2c/0x54
> [  552.646731]  kasan_set_track+0x2c/0x40
> [  552.650494]  kasan_set_free_info+0x28/0x50
> [  552.654603]  __kasan_slab_free+0xec/0x13c
> [  552.658625]  kfree+0xd4/0x280
> [  552.661605]  bt_link_release+0x2c/0x3c
> [  552.665366]  device_release+0xe4/0x1f0
> [  552.669131]  kobject_put+0x130/0x244
> [  552.672722]  put_device+0x18/0x30
> [  552.676049]  hci_conn_cleanup+0x230/0x4d4
> [  552.680068]  hci_conn_del+0x46c/0x4a4
> [  552.683740]  hci_le_conn_failed+0x318/0x5a0
> [  552.687935]  le_conn_complete_evt.part.0+0x778/0x15a0
> [  552.693008]  hci_le_enh_conn_complete_evt+0x224/0x330
> [  552.698075]  hci_le_meta_evt+0x1cc/0x40c
> [  552.702011]  hci_event_packet+0x3e0/0x165c
> [  552.706123]  hci_rx_work+0x2e0/0x580
> [  552.709715]  process_one_work+0x60c/0xf04
> [  552.713735]  worker_thread+0x3bc/0xe1c
> [  552.717495]  kthread+0x278/0x2e0
> [  552.720739]  ret_from_fork+0x10/0x20
> [  552.724330]
> [  552.725824] Last potentially related work creation:
> [  552.730708]  kasan_save_stack+0x2c/0x54
> [  552.734557]  __kasan_record_aux_stack+0xa0/0xd0
> [  552.739100]  kasan_record_aux_stack_noalloc+0x14/0x20
> [  552.744168]  __queue_work+0x428/0xd14
> [  552.747846]  __queue_delayed_work+0x144/0x220
> [  552.752216]  queue_delayed_work_on+0xa0/0xe0
> [  552.756498]  l2cap_chan_del+0x4b8/0xb50
> [  552.760343]  l2cap_conn_del+0x254/0x694
> [  552.764187]  l2cap_connect_cfm+0x698/0xb10
> [  552.768299]  hci_le_conn_failed+0x2c4/0x5a0
> [  552.772494]  le_conn_complete_evt.part.0+0x778/0x15a0
> [  552.777565]  hci_le_enh_conn_complete_evt+0x224/0x330
> [  552.782630]  hci_le_meta_evt+0x1cc/0x40c
> [  552.786567]  hci_event_packet+0x3e0/0x165c
> [  552.790680]  hci_rx_work+0x2e0/0x580
> [  552.794273]  process_one_work+0x60c/0xf04
> [  552.798292]  worker_thread+0x3bc/0xe1c
> [  552.802056]  kthread+0x278/0x2e0
> [  552.805295]  ret_from_fork+0x10/0x20
> [  552.808883]
> [  552.810380] Second to last potentially related work creation:
> [  552.816133]  kasan_save_stack+0x2c/0x54
> [  552.819984]  __kasan_record_aux_stack+0xa0/0xd0
> [  552.824526]  kasan_record_aux_stack_noalloc+0x14/0x20
> [  552.829592]  __queue_work+0x428/0xd14
> [  552.833264]  delayed_work_timer_fn+0x68/0xa0
> [  552.837546]  call_timer_fn.constprop.0+0x54/0x15c
> [  552.842269]  __run_timers.part.0+0x3f4/0x604
> [  552.846553]  run_timer_softirq+0x78/0x110
> [  552.850580]  _stext+0x29c/0x7d8
> [  552.853734]
> [  552.855229] The buggy address belongs to the object at ffff0000126da00=
0
> [  552.855229]  which belongs to the cache kmalloc-2k of size 2048
> [  552.867759] The buggy address is located 1392 bytes inside of
> [  552.867759]  2048-byte region [ffff0000126da000, ffff0000126da800)
> [  552.879683]
> [  552.881180] The buggy address belongs to the physical page:
> [  552.886761] page:00000000bc19f159 refcount:1 mapcount:0 mapping:000000=
0000000000 index:0x0 pfn:0x526d8
> [  552.896083] head:00000000bc19f159 order:3 compound_mapcount:0 compound=
_pincount:0
> [  552.903576] flags: 0x3fffc0000010200(slab|head|node=3D0|zone=3D0|lastc=
pupid=3D0xffff)
> [  552.910910] raw: 03fffc0000010200 dead000000000100 dead000000000122 ff=
ff000008002900
> [  552.918663] raw: 0000000000000000 0000000080080008 00000001ffffffff 00=
00000000000000
> [  552.926413] page dumped because: kasan: bad access detected
> [  552.931989]
> [  552.933486] Memory state around the buggy address:
> [  552.938285]  ffff0000126da400: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  552.945518]  ffff0000126da480: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  552.952752] >ffff0000126da500: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  552.959980]                                                           =
   ^
> [  552.966862]  ffff0000126da580: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  552.974093]  ffff0000126da600: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  552.981323] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  552.988700] Disabling lock debugging due to kernel taint
> [  552.994223] hci0 hcon 00000000c12ea080 handle 65535
> [  552.994267] Unable to handle kernel paging request at virtual address =
00078024e000003b
> [  553.007176] Mem abort info:
> [  553.009986]   ESR =3D 0x96000004
> [  553.013078]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  553.018460]   SET =3D 0, FnV =3D 0
> [  553.021615]   EA =3D 0, S1PTW =3D 0
> [  553.024845]   FSC =3D 0x04: level 0 translation fault
> [  553.029772] Data abort info:
> [  553.032726]   ISV =3D 0, ISS =3D 0x00000004
> [  553.036617]   CM =3D 0, WnR =3D 0
> [  553.039651] [00078024e000003b] address between user and kernel address=
 ranges
> [  553.046850] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  553.052450] Modules linked in: moal(O) mlan(O)
> [  553.056948] CPU: 3 PID: 73 Comm: kworker/u9:0 Tainted: G    B      O  =
    5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
> [  553.056965] Hardware name: FSL i.MX8MM EVK board (DT)
> [  553.056974] Workqueue: hci0 hci_cmd_sync_work
> [  553.073677] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  553.085004] pc : hci_conn_cleanup+0x128/0x4d4
> [  553.085019] lr : hci_conn_cleanup+0x42c/0x4d4
> [  553.093734] sp : ffff80000d797ae0
> [  553.093740] x29: ffff80000d797ae0 x28: ffff00000e85f938 x27: 000000000=
0000002
> [  553.104206] x26: 1fffe00001d0bf27 x25: ffff000010a78000 x24: ffff00001=
0a78000
> [  553.104227] x23: dfff800000000000 x22: ffff0000126da0e8 x21: ffff00000=
f98d000
> [  553.104249] x20: ffff0000126da000 x19: a0400127000001dc x18: 000000000=
0000000
> [  553.118534] x17: ffff80000ac1f008 x16: ffff80000ac1ed74 x15: 000000000=
0000007
> [  553.132821] x14: 0000000000000000 x13: 0000000000000007 x12: ffff60000=
24db41d
> [  553.139981] x11: 1fffe000024db41c x10: ffff6000024db41c x9 : dfff80000=
0000000
> [  553.140000] x8 : ffff0000126da0e4 x7 : 0000000000000001 x6 : 000000000=
0000004
> [  553.154287] x5 : ffff0000126da0e4 x4 : 0000000000000000 x3 : ffff80000=
ab714cc
> [  553.154318] x2 : 0000000000000001 x1 : 14080024e000003b x0 : dfff80000=
0000000
> [  553.168614] Call trace:
> [  553.168625]  hci_conn_cleanup+0x128/0x4d4
> [  553.175094]  hci_conn_del+0x46c/0x4a4
> [  553.178775]  hci_le_conn_failed+0x318/0x5a0
> [  553.182970]  create_le_conn_complete+0x60/0xb0
> [  553.187425]  hci_cmd_sync_work+0x128/0x210
>
> Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
> : Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  553.201344]  process_one_work+0x60c/0xf04
> [  553.205379]  worker_thread+0x3bc/0xe1c
> [  553.209137]  kthread+0x278/0x2e0
> [  553.212378]  ret_from_fork+0x10/0x20
> [  553.215973] Code: d343fe61 d2d00000 f2fbffe0 f90006b3 (38e06820)
> [  553.222079] ---[ end trace 0000000000000000 ]---
>
> Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
> : Code: d343fe61 d2d00000 f2fbffe0 f90006b3 (38e06820)
>
> Best regards
> Sherry
>


--=20
Luiz Augusto von Dentz
