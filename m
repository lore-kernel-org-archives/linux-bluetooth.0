Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 8 Sep 2010 17:29:16 +0530
Message-ID: <AANLkTikKOqHfb-rK_JypBHA6xDdPPTJNa846cmu0jQk0@mail.gmail.com>
Subject: Compiling Issues
From: steven bluez <steven.bluez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan\"" <gustavo@padovan.org>
Content-Type: multipart/alternative; boundary=0016e68ea5062eba92048fbe3e72
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e68ea5062eba92048fbe3e72
Content-Type: text/plain; charset=ISO-8859-1

Hi all ,

        While I compile Bluez4.70 in my lucidlynx (ubuntu 10.04 &10.10). I
am facing issues please do suggest on how to compile the same & i have
attached the logs

  CC     src/manager.o
>   CC     src/adapter.o
>   CC     src/device.o
>   CC     src/dbus-common.o
>   CC     src/dbus-hci.o
>   GEN    audio/telephony.c
>   CC     audio/telephony.o
>   GEN    src/bluetooth.exp
>   GEN    src/bluetooth.ver
>   CCLD   src/bluetoothd
> src/attrib-server.o: In function `send_notification':
> attrib-server.c:(.text+0x21d): undefined reference to `enc_notification'
> attrib-server.c:(.text+0x272): undefined reference to `g_attrib_send'
> src/attrib-server.o: In function `connect_event':
> attrib-server.c:(.text+0x9bc): undefined reference to `g_attrib_new'
> attrib-server.c:(.text+0x9e7): undefined reference to `g_attrib_register'
> src/attrib-server.o: In function `channel_destroy':
> attrib-server.c:(.text+0xa31): undefined reference to
> `g_attrib_unregister_all'
> attrib-server.c:(.text+0xa3c): undefined reference to `g_attrib_unref'
> src/attrib-server.o: In function `.L59':
> attrib-server.c:(.text+0xaf4): undefined reference to `dec_read_by_grp_req'
> attrib-server.c:(.text+0xb2e): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0xb6d): undefined reference to `g_attrib_send'
> src/attrib-server.o: In function `.L58':
> attrib-server.c:(.text+0xb9e): undefined reference to `dec_read_req'
> attrib-server.c:(.text+0xc05): undefined reference to `enc_read_resp'
> src/attrib-server.o: In function `.L57':
> attrib-server.c:(.text+0xc3c): undefined reference to
> `dec_read_by_type_req'
> attrib-server.c:(.text+0xe09): undefined reference to
> `enc_read_by_type_resp'
> attrib-server.c:(.text+0xe1d): undefined reference to `att_data_list_free'
> src/attrib-server.o: In function `.L56':
> attrib-server.c:(.text+0xe5f): undefined reference to `dec_find_info_req'
> attrib-server.c:(.text+0x102a): undefined reference to `enc_find_info_resp'
> attrib-server.c:(.text+0x1038): undefined reference to `att_data_list_free'
> attrib-server.c:(.text+0x12da): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1314): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x134c): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x1382): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x13b5): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x13dc): undefined reference to
> `enc_read_by_grp_resp'
> attrib-server.c:(.text+0x13f0): undefined reference to `att_data_list_free'
> attrib-server.c:(.text+0x145a): undefined reference to `enc_error_resp'
> attrib-server.c:(.text+0x148f): undefined reference to `enc_error_resp'
> collect2: ld returned 1 exit status
> make[1]: *** [src/bluetoothd] Error 1
> make: *** [all] Error 2
>

Regards,
Steven

--0016e68ea5062eba92048fbe3e72
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all ,<br><br>=A0=A0=A0=A0=A0=A0=A0 While I compile Bluez4.70 in my lucid=
lynx=20
(ubuntu 10.04 &amp;10.10). I am facing issues please do suggest on how=20
to compile the same &amp; i have attached the logs<br><br><blockquote style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;" class=3D"gmail_quote">

=A0 CC=A0=A0=A0=A0 src/manager.o<br>=A0 CC=A0=A0=A0=A0 src/adapter.o<br>=A0=
 CC=A0=A0=A0=A0 src/device.o<br>=A0 CC=A0=A0=A0=A0 src/dbus-common.o<br>=A0=
 CC=A0=A0=A0=A0 src/dbus-hci.o<br>=A0 GEN=A0=A0=A0 audio/telephony.c<br>=A0=
 CC=A0=A0=A0=A0 audio/telephony.o<br>=A0 GEN=A0=A0=A0 src/bluetooth.exp<br>


=A0 GEN=A0=A0=A0 src/bluetooth.ver<br>=A0 CCLD=A0=A0 src/bluetoothd<br>src/=
attrib-server.o: In function `send_notification&#39;:<br>attrib-server.c:(.=
text+0x21d): undefined reference to `enc_notification&#39;<br>attrib-server=
.c:(.text+0x272): undefined reference to `g_attrib_send&#39;<br>


src/attrib-server.o: In function `connect_event&#39;:<br>attrib-server.c:(.=
text+0x9bc): undefined reference to `g_attrib_new&#39;<br>attrib-server.c:(=
.text+0x9e7): undefined reference to `g_attrib_register&#39;<br>src/attrib-=
server.o: In function `channel_destroy&#39;:<br>


attrib-server.c:(.text+0xa31): undefined reference to `g_attrib_unregister_=
all&#39;<br>attrib-server.c:(.text+0xa3c): undefined reference to `g_attrib=
_unref&#39;<br>src/attrib-server.o: In function `.L59&#39;:<br>attrib-serve=
r.c:(.text+0xaf4): undefined reference to `dec_read_by_grp_req&#39;<br>


attrib-server.c:(.text+0xb2e): undefined reference to `enc_error_resp&#39;<=
br>attrib-server.c:(.text+0xb6d): undefined reference to `g_attrib_send&#39=
;<br>src/attrib-server.o: In function `.L58&#39;:<br>attrib-server.c:(.text=
+0xb9e): undefined reference to `dec_read_req&#39;<br>


attrib-server.c:(.text+0xc05): undefined reference to `enc_read_resp&#39;<b=
r>src/attrib-server.o: In function `.L57&#39;:<br>attrib-server.c:(.text+0x=
c3c): undefined reference to `dec_read_by_type_req&#39;<br>attrib-server.c:=
(.text+0xe09): undefined reference to `enc_read_by_type_resp&#39;<br>


attrib-server.c:(.text+0xe1d): undefined reference to `att_data_list_free&#=
39;<br>src/attrib-server.o: In function `.L56&#39;:<br>attrib-server.c:(.te=
xt+0xe5f): undefined reference to `dec_find_info_req&#39;<br>attrib-server.=
c:(.text+0x102a): undefined reference to `enc_find_info_resp&#39;<br>


attrib-server.c:(.text+0x1038): undefined reference to `att_data_list_free&=
#39;<br>attrib-server.c:(.text+0x12da): undefined reference to `enc_error_r=
esp&#39;<br>attrib-server.c:(.text+0x1314): undefined reference to `enc_err=
or_resp&#39;<br>


attrib-server.c:(.text+0x134c): undefined reference to `enc_error_resp&#39;=
<br>attrib-server.c:(.text+0x1382): undefined reference to `enc_error_resp&=
#39;<br>attrib-server.c:(.text+0x13b5): undefined reference to `enc_error_r=
esp&#39;<br>


attrib-server.c:(.text+0x13dc): undefined reference to `enc_read_by_grp_res=
p&#39;<br>attrib-server.c:(.text+0x13f0): undefined reference to `att_data_=
list_free&#39;<br>attrib-server.c:(.text+0x145a): undefined reference to `e=
nc_error_resp&#39;<br>


attrib-server.c:(.text+0x148f): undefined reference to `enc_error_resp&#39;=
<br>collect2: ld returned 1 exit status<br>make[1]: *** [src/bluetoothd] Er=
ror 1<br>make: *** [all] Error 2<br></blockquote><br>Regards,<br><font colo=
r=3D"#888888">Steven</font>

--0016e68ea5062eba92048fbe3e72--
