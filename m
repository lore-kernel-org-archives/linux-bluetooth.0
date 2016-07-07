Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Invalid file descriptor gatttool of bluez 5.32
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <55B5DA6E.9060100@tobias.preclik.de>
 <CABBYNZ+XERxap9yH0avT_QtxcJ8hYwFBpWqqinJzODADNmcAGA@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Tobias Preclik <linux-bluetooth@tobias.preclik.de>
Message-ID: <6307fb08-a7b4-243e-e1b9-cb51d2d0ebf8@tobias.preclik.de>
Date: Thu, 7 Jul 2016 15:36:19 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+XERxap9yH0avT_QtxcJ8hYwFBpWqqinJzODADNmcAGA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------D8619A7E3BB27FE5F66D9853"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D8619A7E3BB27FE5F66D9853
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Luiz et al.,

thanks for your answer and sorry for digging that thread up again. At 
least for the reference:

The invalid file descriptor warning stems from the g_io_channel_shutdown 
call in attrib/interactive.c:disconnect_io. Afaict the 
g_io_channel_shutdown call is redundant and thus causes the glib 
warning. When establishing the connection gatttool uses approximately 
the following call sequence.

attrib/utils.c:gatt_connect
  > btio/btio.c:bt_io_connect
     > btio/btio.c:create_io
        > **socket**
     > btio/btio.c:l2cap_connect
        > **connect**

In btio/btio.c:create_io the socket is created, a corresponding glib IO 
channel is created in a call to g_io_channel_unix_new and the IO channel 
is instructed to close the socket as soon as the last IO channel 
reference is dropped in a call to g_io_channel_set_close_on_unref.

When disconnecting in gatttool, the last reference to the glib IO 
channel seems to be dropped somewhere at the end of the following call 
sequence (after the last reference to the ATT object is dropped in 
bt_att_unref):

attrib/interactive.c:disconnect_io
  > attrib/gattrib.c:g_attrib_unref
     > src/shared/att.c:bt_att_unref
        > src/shared/att.c:bt_att_free
           > ...

In a nutshell: Afaict the g_io_channel_unref call in disconnect_io is 
redundant since the last IO channel reference is dropped in 
g_attrib_unref before this call. Since the IO channel is instructed to 
close the socket when the last reference is dropped, the call to 
g_io_channel_shutdown is also redundant (see attached patch). Applying 
the patch will indeed get rid of the glib warning. Can somebody second 
that this the correct way of fixing the cleanup sequence?

Regards,
Tobias

On 27/07/15 10:27, Luiz Augusto von Dentz wrote:
> Hi Tobias,
>
> On Mon, Jul 27, 2015 at 10:14 AM, Tobias Preclik
> <linux-bluetooth@tobias.preclik.de> wrote:
>> Hello,
>>
>> it seems the cleanup process when disconnecting from a bluetooth LE device
>> changed in bluez 5.32 but gatttool (attrib/interactive.c:disconnect_io)
>> wasn't updated.
>>
>> $ ./gatttool -I
>> [                 ][LE]> connect FF:A7:8C:98:46:B6 random
>> Attempting to connect to FF:A7:8C:98:46:B6
>> Connection successful
>> [FF:A7:8C:98:46:B6][LE]> disconnect
>>
>> (gatttool:20949): GLib-WARNING **: Invalid file descriptor.
>>
>> [FF:A7:8C:98:46:B6][LE]> exit
>>
>> What's the right way to do it in gatttool/bluez 5.32?
>
> There are new tools to use with GATT, bluetoothctl/bluetoothd is the
> preferred since with that you have GAP, etc, but if want to use a
> stand alone tool then I suggest you use btgatt-client.
>
>

--------------D8619A7E3BB27FE5F66D9853
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="interactive.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="interactive.patch"

ZGlmZiAtY3JCIGJsdWV6LTUuNDAtb3JpZy9hdHRyaWIvaW50ZXJhY3RpdmUuYyBibHVlei01
LjQwL2F0dHJpYi9pbnRlcmFjdGl2ZS5jCioqKiBibHVlei01LjQwLW9yaWcvYXR0cmliL2lu
dGVyYWN0aXZlLmMJMjAxNi0wNy0wNyAxNToyMDoxMy45NTUxMDMyODAgKzAyMDAKLS0tIGJs
dWV6LTUuNDAvYXR0cmliL2ludGVyYWN0aXZlLmMJMjAxNi0wNy0wNyAxNToyMDoyMy4xNzA5
MjY0MTQgKzAyMDAKKioqKioqKioqKioqKioqCioqKiAxOTEsMTk5ICoqKioKICAJZ19hdHRy
aWJfdW5yZWYoYXR0cmliKTsKICAJYXR0cmliID0gTlVMTDsKICAJb3B0X210dSA9IDA7Ci0g
Ci0gCWdfaW9fY2hhbm5lbF9zaHV0ZG93bihpb2NoYW5uZWwsIEZBTFNFLCBOVUxMKTsKLSAJ
Z19pb19jaGFubmVsX3VucmVmKGlvY2hhbm5lbCk7CiAgCWlvY2hhbm5lbCA9IE5VTEw7CiAg
CiAgCXNldF9zdGF0ZShTVEFURV9ESVNDT05ORUNURUQpOwotLS0gMTkxLDE5NiAtLS0tCg==
--------------D8619A7E3BB27FE5F66D9853--
