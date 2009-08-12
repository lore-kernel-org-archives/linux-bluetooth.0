Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1250028527.30166.30.camel@localhost.localdomain>
References: <113d36d80908071126j521df37aked5fec76df09006c@mail.gmail.com>
	 <1249670135.30166.14.camel@localhost.localdomain>
	 <113d36d80908072104m777fdf95q9db99ffb863744dc@mail.gmail.com>
	 <1249706140.30166.17.camel@localhost.localdomain>
	 <113d36d80908110600y1232945br2bdb10de24f62bff@mail.gmail.com>
	 <1250028527.30166.30.camel@localhost.localdomain>
Date: Wed, 12 Aug 2009 11:24:45 +0800
Message-ID: <113d36d80908112024o98f836aybfdd0cb104720ba3@mail.gmail.com>
Subject: Re: sco connection issue for BlueZ 4.x on kernel 2.6.29
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/8/12 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>> >> >> Can not accept incoming SCO connection. Kernel version 2.6.29. Ker=
nel
>> >> >> log is as below. Is this a kernel bug? Is there any fix already fo=
r
>> >> >> this?
>> >> >>
>> >> >> <6>[ =A0158.339691] sco_connect_ind: hdev hci0, bdaddr CA:D3:10:55=
:0C:00
>> >> >> =A0 =A0 -------// receive incoming sco
>> >> >> <6>[ =A0158.518554] sco_connect_cfm: hcon cf18ee00 bdaddr CA:D3:10=
:55:0C:00 status
>> >> >> <6>[ =A0158.721160] sco_connect_cfm: hcon cf149c00 bdaddr CA:D3:10=
:55:0C:00 status
>> >> >> <6>[ =A0158.728851] sco_conn_add: hcon cf149c00 conn cc772640
>> >> >> <6>[ =A0158.734313] sco_conn_ready: conn cc772640
>> >> >> -----------// handle sco connection complete
>> >> >> <6>[ =A0158.738800] sco_sock_init: sk cf18c400
>> >> >> -----------// start handle sco socket
>> >> >> <6>[ =A0158.742858] __sco_chan_add: conn cc772640
>> >> >> <6>[ =A0159.693023] sco_sock_accept: sk ccfdf400 timeo 0
>> >> >> <6>[ =A0159.708038] sco_sock_accept: new socket cf18c400
>> >> >> <6>[ =A0159.713073] sco_sock_getsockopt: sk cf18c400
>> >> >> <6>[ =A0159.717834] sco_sock_getsockopt_old: sk cf18c400
>> >> >> <6>[ =A0159.722839] sco_sock_getsockopt_old: mtu 180
>> >> >> <6>[ =A0159.727661] sco_sock_getname: sock ce9d80a0, sk cf18c400
>> >> >> <6>[ =A0159.733398] sco_sock_getname: sock ce9d80a0, sk cf18c400
>> >> >> <6>[ =A0159.739166] sco_sock_release: sock ce9d80a0, sk cf18c400
>> >> >> -----------// don't know why it call sco_sock_release
>> >> >> <6>[ =A0159.745025] sco_sock_clear_timer: sock cf18c400 state 1
>> >> >> <6>[ =A0159.750671] sco_sock_close: sk cf18c400 state 1 conn cc772=
640 socket ce9d8
>> >> >> <6>[ =A0159.758453] sco_chan_del: sk cf18c400, conn cc772640, err =
104
>> >> >> <6>[ =A0159.764770] sco_sock_kill: sk cf18c400 state 9
>> >> >> <6>[ =A0159.769592] sco_sock_destruct: sk cf18c400
>> >> >> ------------// destruct sco socket, and disconnect SCO connection
>> >> >> <6>[ =A0159.782745] l2cap_disconn_ind: hcon cf149c00
>> >> >> <6>[ =A0159.787384] hci_acl_disconn: cf149c00
>> >> >> <6>[ =A0159.950805] hci_disconn_complete_evt: hci0 status 0
>> >> >> <6>[ =A0159.956207] l2cap_disconn_cfm: hcon cf149c00 reason 22
>> >> >> <6>[ =A0159.961730] sco_disconn_cfm: hcon cf149c00 reason 22
>> >> >> -------------// sco disconnected
>> >> >> <6>[ =A0159.967102] sco_conn_del: hcon cf149c00 conn cc772640, err=
 103
>> >> >> <6>[ =A0162.130523] hci_disconn_complete_evt: hci0 status 0
>> >> >> <6>[ =A0162.136291] l2cap_disconn_cfm: hcon cf18ee00 reason 19
>> >> >> <6>[ =A0162.149871] sco_disconn_cfm: hcon cf18ee00 reason 19
>> >> >> <4>[ =A0165.382141] done EDISCO CTRL ENABLE
>> >> >> <7>[ =A0165.386077] sholes-panel: =A0edisco_ctrl_enable_te
>> >> >
>> >> > what kind of program are you using?
>> >> >
>> >>
>> >> This issue was found when testing HFP on android platform with a
>> >> Bluetooth carkit which is not support eSCO. At first android tries to
>> >> establish eSCO with carkit, carkit response with error that eSCO is
>> >> not supported. Then carkit send SCO connect request to android
>> >> automatically, android accepted this connection but disconnect it
>> >> immediately.
>> >
>> > I think we fixed all of these. Try a 2.6.31-rc5 kernel. Also you would
>> > need to include the output of hcidump -X -V.
>>
>> I think there is a bug in the function sco_sock_getsockopt_old() in sco.=
c.
>>
>> I changed the code like below and then test sco again, incoming sco
>> connection can be created successfully now.
>>
>> @@ -719,7 +715,10 @@ static int sco_sock_getsockopt_old(struct socket *s=
ock, int
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0if (err !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0}
>> =A0 =A0 =A0 =A0 return err;
>
> that is not it for sure. The release_sock() is the unlock function and
> your patch create a locking imbalance.
>
> Regards
>
> Marcel
>
>
>

This issue is fixed by Johan's commit of "Don't enable the SCO server
socket when not necessary"
(http://git.kernel.org/?p=3Dbluetooth/bluez.git;a=3Dcommit;h=3Dcd6678404659=
a1bf6449b5b1d48b17883d895aef)

Thanks,
Zhu Lan
