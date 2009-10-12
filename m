Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4AD2D155.8040008@pardus.org.tr>
References: <4AB94E32.8060703@pardus.org.tr> <4AD2D155.8040008@pardus.org.tr>
Date: Mon, 12 Oct 2009 14:07:41 +0530
Message-ID: <8b5debfa0910120137o70880775le9dfcdede454d40f@mail.gmail.com>
Subject: Re: Undefined symbols in netlink plugin
From: alok barsode <alokbarsode@gmail.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: multipart/mixed; boundary=000e0cd23d98c5b9860475b8d71d
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd23d98c5b9860475b8d71d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ozan,

On Mon, Oct 12, 2009 at 12:18 PM, Ozan =C3=87a=C4=9Flayan <ozan@pardus.org.=
tr> wrote:
> Ozan =C3=87a=C4=9Flayan wrote On 23-09-2009 01:22:
>
>> Hi,
>>
>> I'm getting the following when I launch bluetoothd with -n -d:
>>
>> ..
>> Can't load plugin /usr/lib/bluetooth/plugins/netlink.so:
>> /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
>> ..
>>
>> AFAIK, those libtool plugins are allowed to have undefined symbols after
>> linking as they will probably be resolved during runtime loading but the
>> warning above wasn't present on previous versions like 4.41 for example.
>>
>> # ldd -u -r /usr/lib/bluetooth/plugins/netlink.so
>> =C2=A0 =C2=A0 =C2=A026771: =C2=A0 =C2=A0 /usr/lib/bluetooth/plugins/netl=
ink.so: error: symbol
>> lookup error: undefined symbol: g_io_channel_unix_new (continued)
>> undefined symbol: g_io_channel_unix_new
>> (/usr/lib/bluetooth/plugins/netlink.so)
>> =C2=A0 =C2=A0 =C2=A026771: =C2=A0 =C2=A0 /usr/lib/bluetooth/plugins/netl=
ink.so: error: symbol
>> lookup error: undefined symbol: debug (continued)
>> undefined symbol: debug (/usr/lib/bluetooth/plugins/netlink.so)
>> =C2=A0 =C2=A0 =C2=A026771: =C2=A0 =C2=A0 /usr/lib/bluetooth/plugins/netl=
ink.so: error: symbol
>> lookup error: undefined symbol: g_io_add_watch (continued)
>> undefined symbol: g_io_add_watch
>> (/usr/lib/bluetooth/plugins/netlink.so)
>> =C2=A0 =C2=A0 =C2=A026771: =C2=A0 =C2=A0 /usr/lib/bluetooth/plugins/netl=
ink.so: error: symbol
>> lookup error: undefined symbol: info (continued)
>> undefined symbol: info =C2=A0(/usr/lib/bluetooth/plugins/netlink.so)
>> =C2=A0 =C2=A0 =C2=A026771: =C2=A0 =C2=A0 /usr/lib/bluetooth/plugins/netl=
ink.so: error: symbol
>> lookup error: undefined symbol: g_io_channel_unref (continued)
>> undefined symbol: g_io_channel_unref
>> (/usr/lib/bluetooth/plugins/netlink.so)
>> Unused direct dependencies:
>>
>>
>> So we have 3 undefined symbol from glib and 2 internal symbols from
>> logging.c: debug() and info(). There's no difference if I install the
>> libtool la file or not. Since glib is already needed by bluez daemon,
>> those undefined symbols seems harmless but AFAIK the internal ones
>> should have been linked against the static logging.o.
>>
>> Or do I miss something?
>>

The following patch fixes this issue but I am not sure if its the right way=
.
Let Marcel take a call on this.

>>
>> Thanks,
>> Ozan Caglayan
>>
>>
>
> Still an issue on bluez 4.56. CC'ing Marcel Holtmann.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

Cheers,
Alok.

--000e0cd23d98c5b9860475b8d71d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-Fix-undefined-symbol-errors-in-netlink-plugin.patch"
Content-Disposition: attachment;
	filename="0001-Fix-undefined-symbol-errors-in-netlink-plugin.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0oz00cj0

RnJvbSBmODcxNjI0NGQxM2U1NmE4ZDkxMTZmNjU0MDAxYjk0MmY5MmUyMGNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbG9rIEJhcnNvZGUgPGFsb2suYmFyc29kZUBhemluZ28uY29t
PgpEYXRlOiBNb24sIDEyIE9jdCAyMDA5IDE0OjA1OjIwICswNTMwClN1YmplY3Q6IFtQQVRDSCAx
LzFdIEZpeCB1bmRlZmluZWQgc3ltYm9sIGVycm9ycyBpbiBuZXRsaW5rIHBsdWdpbi4KCi0tLQog
TWFrZWZpbGUuYW0gfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5hbQpp
bmRleCBkMzYwYWNiLi5mYTI0OTdiIDEwMDY0NAotLS0gYS9NYWtlZmlsZS5hbQorKysgYi9NYWtl
ZmlsZS5hbQpAQCAtOTAsNyArOTAsOCBAQCBlbmRpZgogaWYgTkVUTElOSwogcGx1Z2luX0xUTElC
UkFSSUVTICs9IHBsdWdpbnMvbmV0bGluay5sYQogCi1wbHVnaW5zX25ldGxpbmtfbGFfTElCQURE
ID0gQE5FVExJTktfTElCU0AKK3BsdWdpbnNfbmV0bGlua19sYV9TT1VSQ0VTID0gcGx1Z2lucy9u
ZXRsaW5rLmMgc3JjL2xvZ2dpbmcuaCBzcmMvbG9nZ2luZy5jCitwbHVnaW5zX25ldGxpbmtfbGFf
TElCQUREID0gQEdMSUJfTElCU0AgQE5FVExJTktfTElCU0AKIHBsdWdpbnNfbmV0bGlua19sYV9M
REZMQUdTID0gLW1vZHVsZSAtYXZvaWQtdmVyc2lvbiAtbm8tdW5kZWZpbmVkCiBwbHVnaW5zX25l
dGxpbmtfbGFfQ0ZMQUdTID0gLWZ2aXNpYmlsaXR5PWhpZGRlbiBAREJVU19DRkxBR1NAIFwKIAkJ
CQkJQEdMSUJfQ0ZMQUdTQCBATkVUTElOS19DRkxBR1NACi0tIAoxLjUuNi4zCgo=
--000e0cd23d98c5b9860475b8d71d--
