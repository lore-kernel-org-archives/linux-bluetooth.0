Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/mixed; boundary=----------H7XKyR0bwZcKqZWLWLtjh9
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ovasik@redhat.com" <ovasik@redhat.com>
Subject: Re: [PATCH 2/8] Missing comma
References: <op.v0av2bteh52hc0@dhcp-25-209.brq.redhat.com>
 <CAMOw1v5S+hcmvBW=_6h1RUsXt9af7fUm_eVmcdBP1vrif_t-Fg@mail.gmail.com>
Date: Tue, 23 Aug 2011 08:06:09 +0200
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0nkkjwsh52hc0@dhcp-25-209.brq.redhat.com>
In-Reply-To: <CAMOw1v5S+hcmvBW=_6h1RUsXt9af7fUm_eVmcdBP1vrif_t-Fg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------------H7XKyR0bwZcKqZWLWLtjh9
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi Lucas,

>> Missing comma in static array chassis_map definition between
>> "Blade" and "Blade Enclosure" field.
>>
>> Typing error fixed.
>>
>> ....
>>
>> -       "CompactPCI",            "unknonw",
>> +       "CompactPCI",            "unknown",
>>        "AdvancedTCA",           "unknown",
>>        "Blade",                 "server",
>> -       "Blade Enclosure"        "unknown", /* 0x1D */
>> +       "Blade Enclosure",       "unknown", /* 0x1D */

> Lucas De Marchi wrote:
>
> Nice catch, but because of errors like this, I think it'd be better to
> use a struct with 2 "char *" fields, isn't it?

You are right but anyway is this really necessary to make quite big change
in struct/control code? There is possible to make other "switch-line"
errors when 2 "char *" arrays used.

Attaching previous patch again due to possible corruption by my email
client.

Pavel
------------H7XKyR0bwZcKqZWLWLtjh9
Content-Disposition: attachment; filename=0002-Missing-comma.patch
Content-Type: application/octet-stream; name=0002-Missing-comma.patch
Content-Transfer-Encoding: Base64

RnJvbSA1MGM0NDI3ODk1ZTBlYTk5YTJkNTBhZjU3MzJiZWM1OTc1OGRlYzBkIE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBSYWlza3VwIDxwcmFp
c2t1cEByZWRoYXQuY29tPgpEYXRlOiBUaHUsIDExIEF1ZyAyMDExIDEzOjUyOjAw
ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzhdIE1pc3NpbmcgY29tbWEKCk1pc3Np
bmcgY29tbWEgaW4gc3RhdGljIGFycmF5IGNoYXNzaXNfbWFwIGRlZmluaXRpb24g
YmV0d2VlbgoiQmxhZGUiIGFuZCAiQmxhZGUgRW5jbG9zdXJlIiBmaWVsZC4KClR5
cGluZyBlcnJvciBmaXhlZC4KLS0tCiBwbHVnaW5zL2Zvcm1mYWN0b3IuYyB8ICAg
IDQgKystLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy9mb3JtZmFjdG9yLmMgYi9w
bHVnaW5zL2Zvcm1mYWN0b3IuYwppbmRleCAzYjMxOTI3Li4wZTE5YWM2IDEwMDY0
NAotLS0gYS9wbHVnaW5zL2Zvcm1mYWN0b3IuYworKysgYi9wbHVnaW5zL2Zvcm1m
YWN0b3IuYwpAQCAtNzMsMTAgKzczLDEwIEBAIHN0YXRpYyBjb25zdCBjaGFyICpj
aGFzc2lzX21hcFtdID0gewogCSJSYWNrIE1vdW50IENoYXNzaXMiLCAgICAidW5r
bm93biIsCiAJIlNlYWxlZC1jYXNlIFBDIiwgICAgICAgICJ1bmtub3duIiwKIAki
TXVsdGktc3lzdGVtIiwgICAgICAgICAgInVua25vd24iLAotCSJDb21wYWN0UENJ
IiwgICAgICAgICAgICAidW5rbm9udyIsCisJIkNvbXBhY3RQQ0kiLCAgICAgICAg
ICAgICJ1bmtub3duIiwKIAkiQWR2YW5jZWRUQ0EiLCAgICAgICAgICAgInVua25v
d24iLAogCSJCbGFkZSIsICAgICAgICAgICAgICAgICAic2VydmVyIiwKLQkiQmxh
ZGUgRW5jbG9zdXJlIiAgICAgICAgInVua25vd24iLCAvKiAweDFEICovCisJIkJs
YWRlIEVuY2xvc3VyZSIsICAgICAgICJ1bmtub3duIiwgLyogMHgxRCAqLwogCU5V
TEwKIH07CiAKLS0gCjEuNy40LjQKCg==

------------H7XKyR0bwZcKqZWLWLtjh9--

