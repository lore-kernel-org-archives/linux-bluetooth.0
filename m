Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20151023083319.GA31574@t440s.lan>
References: <000d01d10d6c$cca43e40$65ecbac0$@samsung.com>
	<20151023083319.GA31574@t440s.lan>
Date: Mon, 26 Oct 2015 06:24:20 +0530
Message-ID: <CAFBvHidsObrcX6S3fxfP14MhE0=TW_CD1r8593ej=B623mHv7A@mail.gmail.com>
Subject: Re: Kernel panic observed during sco-connection-disconnection
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>,
	User Name <linux-bluetooth@vger.kernel.org>,
	Anurag B <biradar.a@samsung.com>,
	Sreeraj Mohan <sreeraj.mk@samsung.com>,
	Nagaraj DR <nagaraj.dr@samsung.com>,
	=?UTF-8?B?67CV7LCs7Je0?= <chanyeol.park@samsung.com>,
	jy0214.kim@samsung.com,
	=?UTF-8?B?7ISc7Zi47LKg?= <hocheol.seo@samsung.com>,
	kubax.t.pawlak@intel.com, Sang-Ki Park <sangki79.park@samsung.com>,
	ravi.g@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Kuba,

On Fri, Oct 23, 2015 at 2:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Syam,
>
> On Fri, Oct 23, 2015, s.syam@samsung.com wrote:
>> We have observed one kernel panic during the sco close.
>> The panic logs has been given below. Further analysis we could see that  invalid memory access is happening at
>> sco_pi(sk)->conn->hcon = NULL; in __sco_sock_close().
>>
>> It will be great if someone analyses and provide the fix/clue for this issue.
>> Thanks for your time.
>>
>>
>> Code:
>> static void __sco_sock_close(struct sock *sk)
>> {
>>       BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
>>
>>       switch (sk->sk_state) {
>>       case BT_LISTEN:
>>               sco_sock_cleanup_listen(sk);
>>               break;
>>
>>       case BT_CONNECTED:
>>       case BT_CONFIG:
>>               if (sco_pi(sk)->conn->hcon) {
>>                       sk->sk_state = BT_DISCONN;
>>                       sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
>>                       hci_conn_drop(sco_pi(sk)->conn->hcon);
>>                       sco_pi(sk)->conn->hcon = NULL; //Invalid memory access happen here.
>>               } else
>>                       sco_chan_del(sk, ECONNRESET);
>>               break;
>>
>>       case BT_CONNECT2:
>>       case BT_CONNECT:
>>       case BT_DISCONN:
>> ...
>> ...
>>       }
>> }
>>
>> Logs:
>> Oct 21 23:35:12 alert Kernel: [  175.323507] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> .....
>> Oct 21 23:35:12 warn Kernel: [  175.338344] [<c0866be4>] (__sco_sock_close+0x1ec/0x230) from [<c0866d20>] (sco_sock_close+0x20/0x34)
>> Oct 21 23:35:12 warn Kernel: [  175.338478] [<c0866d20>] (sco_sock_close+0x20/0x34) from [<c0866d78>] (sco_sock_release+0x44/0x100)
>> Oct 21 23:35:12 warn Kernel: [  175.338614] [<c0866d78>] (sco_sock_release+0x44/0x100) from [<c0721ad0>] (sock_release+0x20/0xc4)
>> Oct 21 23:35:12 warn Kernel: [  175.338745] [<c0721ad0>] (sock_release+0x20/0xc4) from [<c07221e4>] (sock_close+0x20/0x2c)
>> Oct 21 23:35:12 warn Kernel: [  175.338874] [<c07221e4>] (sock_close+0x20/0x2c) from [<c02741d0>] (fput+0x11c/0x230)
>> Oct 21 23:35:12 warn Kernel: [  175.338994] [<c02741d0>] (fput+0x11c/0x230) from [<c0270fa8>] (filp_close+0x70/0x7c)
>> Oct 21 23:35:12 warn Kernel: [  175.339110] [<c0270fa8>] (filp_close+0x70/0x7c) from [<c0271064>] (sys_close+0xb0/0xf0)
>> Oct 21 23:35:12 warn Kernel: [  175.339232] [<c0271064>] (sys_close+0xb0/0xf0) from [<c0105d9c>] (__sys_trace_return+0x0/0x24)
>
> You'll probably want to take a look at the SCO socket patch set that
> Kuba sent in the beginning of this month:
>
>         [PATCH 0/5] Few proposed fixes to stop crashes on fast SCO disconnec
>
> Particularly his second patch looks like something that could be related
> to this.
>

Thanks for your guidance. We will try with Kuba's patch sets. Few of
them has already applied to bluetooth-next a couple of hours back.
Look like his Patch 1/5 fixes the one time issue which I reported 3
months back with subject "Sco connection disconnection panic happen".
Thanks Johan & Kuba.

Regards,
Syam.
