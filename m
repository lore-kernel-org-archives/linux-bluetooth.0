Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1268096416.3712.34.camel@localhost.localdomain>
References: <508e92ca1002260126r600ff956hb18c333504fe6525@mail.gmail.com>
	 <1268096416.3712.34.camel@localhost.localdomain>
Date: Tue, 9 Mar 2010 10:34:51 +0200
Message-ID: <508e92ca1003090034y53871120n928f62573f56417d@mail.gmail.com>
Subject: Re: lockdep warns: inconsistent lock state ({IN-SOFTIRQ-W} ->
	{SOFTIRQ-ON-W})
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On Tue, Mar 9, 2010 at 3:00 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Andrei,
>
>> Enabling locking debug we have triggered warning below:
>>
>> [ 2917.827178] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ 2917.833068] [ INFO: inconsistent lock state ]
>> [ 2917.837432] 2.6.32 #54
>> [ 2917.841125] ---------------------------------
>> [ 2917.845520] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>> [ 2917.851562] krfcommd/1516 [HC0[0]:SC0[0]:HE1:SE1] takes:
>> [ 2917.856903] =A0(slock-AF_BLUETOOTH){+.?...}, at: [<bf057b50>]
>> rfcomm_sk_state_change+0x78/0x160 [rfcomm]
>> [ 2917.866363] {IN-SOFTIRQ-W} state was registered at:
>> [ 2917.871276] =A0 [<c008d33c>] mark_lock+0x298/0x630
>> [ 2917.875946] =A0 [<c008ed3c>] __lock_acquire+0x5f4/0x175c
>> [ 2917.881134] =A0 [<c008ff0c>] lock_acquire+0x68/0x7c
>> [ 2917.885864] =A0 [<c036938c>] _spin_lock+0x48/0x58
>> [ 2917.890441] =A0 [<bf025960>] l2cap_conn_start+0x80/0x388 [l2cap]
>> [ 2917.896362] =A0 [<bf028f44>] l2cap_recv_frame+0x1c58/0x2fe0 [l2cap]
>> [ 2917.902526] =A0 [<bf02a3cc>] l2cap_recv_acldata+0x100/0x350 [l2cap]
>> [ 2917.908691] =A0 [<bf0035a8>] hci_rx_task+0x244/0x478 [bluetooth]
>> [ 2917.914642] =A0 [<c006c4d0>] tasklet_action+0x78/0xd8
>> [ 2917.919555] =A0 [<c006cc34>] __do_softirq+0xa8/0x154
>> [ 2917.924407] =A0 [<c006cd40>] irq_exit+0x60/0xb4
>> [ 2917.928802] =A0 [<c0030078>] asm_do_IRQ+0x78/0x90
>> [ 2917.933380] =A0 [<c0030af0>] __irq_svc+0x50/0xbc
>> [ 2917.937866] =A0 [<c0043c74>] omap3_enter_idle_bm+0x1d0/0x238
>> [ 2917.943389] =A0 [<c029ee94>] cpuidle_idle_call+0xb4/0x114
>> [ 2917.948669] =A0 [<c00320b0>] cpu_idle+0x58/0xac
>> [ 2917.953063] =A0 [<c0360b18>] rest_init+0x70/0x84
>> [ 2917.957550] =A0 [<c00089fc>] start_kernel+0x2b4/0x318
>> [ 2917.962493] =A0 [<80008034>] 0x80008034
>> [ 2917.966186] irq event stamp: 312
>> [ 2917.969421] hardirqs last =A0enabled at (312): [<c03691ac>]
>> _spin_unlock_irqrestore+0x44/0x70
>> [ 2917.977844] hardirqs last disabled at (311): [<c036947c>]
>> _spin_lock_irqsave+0x24/0x68
>> [ 2917.985809] softirqs last =A0enabled at (261): [<c006ccc8>]
>> __do_softirq+0x13c/0x154
>> [ 2917.993438] softirqs last disabled at (244): [<c006cde8>]
>> do_softirq+0x54/0x78
>> [ 2918.000732]
>> [ 2918.000732] other info that might help us debug this:
>> [ 2918.007293] 2 locks held by krfcommd/1516:
>> [ 2918.011413] =A0#0: =A0(rfcomm_mutex){+.+.+.}, at: [<bf054df4>]
>> rfcomm_run+0x1f0/0xb00 [rfcomm]
>> [ 2918.019805] =A0#1: =A0(&d->lock){+.+...}, at: [<bf055220>]
>> rfcomm_run+0x61c/0xb00 [rfcomm]
>> [ 2918.027832]
>> [ 2918.027832] stack backtrace:
>> [ 2918.032226] Backtrace:
>> [ 2918.034729] [<c00348d0>] (dump_backtrace+0x0/0x110) from [<c036616c>]
>> (dump_stack+0x18/0x1c)
>> [ 2918.043212] =A0r7:dc8f6c00 r6:c0425252 r5:00000001 r4:00000001
>> [ 2918.048950] [<c0366154>] (dump_stack+0x0/0x1c) from [<c008d060>]
>> (print_usage_bug+0x178/0x1bc)
>> [ 2918.057617] [<c008cee8>] (print_usage_bug+0x0/0x1bc) from [<c008d408>=
]
>> (mark_lock+0x364/0x630)
>> [ 2918.066284] [<c008d0a4>] (mark_lock+0x0/0x630) from [<c008edcc>]
>> (__lock_acquire+0x684/0x175c)
>> [ 2918.074951] [<c008e748>] (__lock_acquire+0x0/0x175c) from [<c008ff0c>=
]
>> (lock_acquire+0x68/0x7c)
>> [ 2918.083709] [<c008fea4>] (lock_acquire+0x0/0x7c) from [<c036938c>]
>> (_spin_lock+0x48/0x58)
>> [ 2918.091949] =A0r7:dba9402c r6:dba5c3c0 r5:dba9402c r4:bf057b50
>> [ 2918.097717] [<c0369344>] (_spin_lock+0x0/0x58) from [<bf057b50>]
>> (rfcomm_sk_state_change+0x78/0x160 [rfcomm])
>> [ 2918.107696] =A0r5:dba94000 r4:00000000
>> [ 2918.111358] [<bf057ad8>] (rfcomm_sk_state_change+0x0/0x160 [rfcomm]) =
from
>> [<bf055238>] (rfcomm_run+0x634/0xb00 [rfcomm])
>> [ 2918.122283] =A0r7:dba5c450 r6:dba5d6c0 r5:dba5c3c0 r4:dba5c430
>> [ 2918.128051] [<bf054c04>] (rfcomm_run+0x0/0xb00 [rfcomm]) from [<c007c=
c10>]
>> (kthread+0x88/0x90)
>> [ 2918.136749] [<c007cb88>] (kthread+0x0/0x90) from [<c006a86c>]
>> (do_exit+0x0/0x678)
>> [ 2918.144256] =A0r7:00000000 r6:00000000 r5:00000000 r4:00000000
>
> is this still present with 2.6.34-rc1 kernel?

We are using 2.6.32-XX kernel so far.

Regards,
Andrei
