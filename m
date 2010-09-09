Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik3Lr0NqDyn1Rpi=X3dvGTGcVuUbYnr7_+weaBD@mail.gmail.com>
References: <AANLkTik3Lr0NqDyn1Rpi=X3dvGTGcVuUbYnr7_+weaBD@mail.gmail.com>
Date: Thu, 9 Sep 2010 15:03:14 +0530
Message-ID: <AANLkTi=FZxtKiPAYCsAnpRUAQ-Ek4OB4uP1oFsN5_cMX@mail.gmail.com>
Subject: Bluez 4.70 Compiling issues
From: steven bluez <steven.bluez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan\"" <gustavo@padovan.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all ,

=A0=A0=A0=A0=A0=A0=A0 While I compile Bluez4.70 in my lucidlynx (ubuntu 10.=
04
&10.10). I am facing issues please do suggest on how to compile the
same & i have attached the logs
>
> =A0 CC=A0=A0=A0=A0 src/manager.o
> =A0 CC=A0=A0=A0=A0 src/adapter.o
> =A0 CC=A0=A0=A0=A0 src/device.o
> =A0 CC=A0=A0=A0=A0 src/dbus-common.o
> =A0 CC=A0=A0=A0=A0 src/dbus-hci.o
> =A0 GEN=A0=A0=A0 audio/telephony.c
> =A0 CC=A0=A0=A0=A0 audio/telephony.o
> =A0 GEN=A0=A0=A0 src/bluetooth.exp
> =A0 GEN=A0=A0=A0 src/bluetooth.ver
> =A0 CCLD=A0=A0 src/bluetoothd
> src/attrib-server.o: In function `send_notification':
> attrib-server.c:(.text+0x21d): undefined reference to `enc_notification'
> attrib-server.c:(.text+0x272): undefined reference to `g_attrib_send'
> src/attrib-server.o: In function `connect_event':
> attrib-server.c:(.text+0x9bc): undefined reference to `g_attrib_new'
> attrib-server.c:(.text+0x9e7): undefined reference to `g_attrib_register'
> src/attrib-server.o: In function `channel_destroy':
> attrib-server.c:(.text+0xa31): undefined reference to `g_attrib_unregiste=
r_all'
> attrib-server.c:(.text+0xa3c): undefined reference to `g_attrib_unref'
> src/attrib-server.o: In function `.L59':
> attrib-server.c:(.text+0xaf4): undefined reference to `dec_read_by_grp_re=
q'
> attrib-server.c:(.text+0xb2e): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xb6d): undefined reference to `g_attrib_send'
> src/attrib-server.o: In function `.L58':
> attrib-server.c:(.text+0xb9e): undefined reference to `dec_read_req'
> attrib-server.c:(.text+0xc05): undefined reference to `enc_read_resp'
> src/attrib-server.o: In function `.L57':
> attrib-server.c:(.text+0xc3c): undefined reference to `dec_read_by_type_r=
eq'
> attrib-server.c:(.text+0xe09): undefined reference to `enc_read_by_type_r=
esp'
> attrib-server.c:(.text+0xe1d): undefined reference to `att_data_list_free=
'
> src/attrib-server.o: In function `.L56':
> attrib-server.c:(.text+0xe5f): undefined reference to `dec_find_info_req'
> attrib-server.c:(.text+0x102a): undefined reference to `enc_find_info_res=
p'
> attrib-server.c:(.text+0x1038): undefined reference to `att_data_list_fre=
e'
> attrib-server.c:(.text+0x12da): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1314): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x134c): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1382): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x13b5): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x13dc): undefined reference to `enc_read_by_grp_r=
esp'
> attrib-server.c:(.text+0x13f0): undefined reference to `att_data_list_fre=
e'
> attrib-server.c:(.text+0x145a): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x148f): undefined reference to `enc_error_resp'
> collect2: ld returned 1 exit status
> make[1]: *** [src/bluetoothd] Error 1
> make: *** [all] Error 2

Regards,
Steven
