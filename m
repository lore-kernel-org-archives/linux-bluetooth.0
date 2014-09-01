Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
	<CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
	<002101cfb550$afb1f400$0f15dc00$@samsung.com>
	<CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
	<006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
Date: Mon, 1 Sep 2014 16:07:22 +0300
Message-ID: <CABBYNZJnyVNyw2-odAPV621k-aiw8x83WNju7FZXW0=_5VUotw@mail.gmail.com>
Subject: Re: Query regarding MAP 1.2 implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: multipart/mixed; boundary=001a113403d0f6da31050200aed0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113403d0f6da31050200aed0
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Sep 1, 2014 at 3:29 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:

> The current message-dummy.c looks like, it is creating a virtual folder in the system (Ex. Home/PC-NAME/map-messages/).
> So, I created the map-messages directory in home/PC-NAME/. Then I tried SETPATH (mentioned in the previous thread).
> The output is...
>
>  obexd[29146]: obexd/src/obex.c:cmd_setpath()
> obexd[29146]: SETPATH(0x5), (null)(0xffffffff)
> obexd[29146]: obexd/src/obex.c:parse_name() NAME:
> obexd[29146]: obexd/plugins/mas.c:mas_setpath() SETPATH: name  nonhdr 0x20
> obexd[29146]: SETPATH(0x5), SUCCESS(0x20)
>
> But When I tried to call GetFolderListing()
> The output is...
>
> obexd[29146]: obexd/src/obex.c:cmd_get() session 0x1008c40
> obexd[29146]: GET(0x3), (null)(0xffffffff)
> obexd[29146]: obexd/src/obex.c:parse_type() TYPE: x-obex/folder-listing
> obexd[29146]: obexd/plugins/mas.c:mas_get() GET: name (null) type x-obex/folder-listing mas 0x1015c00
> obexd[29146]: obexd/plugins/mas.c:get_params() Error when parsing parameters!
> obexd[29146]: GET(0x3), BAD_REQUEST(0x40)
>
> But I had few folders created inside the map-messages.

Bad request is normally when there is something wrong with the command
itself, the error comes from here:

mas->inparams = g_obex_apparam_decode(buffer, size);
if (mas->inparams == NULL) {
    DBG("Error when parsing parameters!");
    return -EBADR;
}

I suspect the problem is that there is no application parameters set
which is fine since all the parameters of GetFolderListing are
optional, please try with the attached patch I will send it shortly as
a proper patch to the mailing list.


-- 
Luiz Augusto von Dentz

--001a113403d0f6da31050200aed0
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-obexd-mas-Fix-parsing-of-application-parameters.patch"
Content-Disposition: attachment;
	filename="0001-obexd-mas-Fix-parsing-of-application-parameters.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzjtmvsr0

RnJvbSBmZjY3ZDg0YjZhMDdlMDUyMmVkZTMyYmI1YzY3ZjhlZjkxNDg4MWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMSBTZXAgMjAxNCAxNjowMTo0MCArMDMwMApTdWJqZWN0
OiBbUEFUQ0ggQmx1ZVpdIG9iZXhkL21hczogRml4IHBhcnNpbmcgb2YgYXBwbGljYXRpb24gcGFy
YW1ldGVycwoKU29tZSBjb21tYW5kcyBkb24ndCBoYXZlIGFueSBtYW5kYXRvcnkgYXBwbGljYXRp
b24gcGFyYW1ldGVyIHdoaWNoIG1lYW5zCmlucGFyYW1zIGNhbiBiZSBOVUxMIHdoaWNoIHNob3Vs
ZCBub3QgYmUgdHJlYXRlZCBhcyBhIGJhZCByZXF1ZXN0LgotLS0KIG9iZXhkL3BsdWdpbnMvbWFz
LmMgfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9vYmV4ZC9wbHVnaW5zL21hcy5j
IGIvb2JleGQvcGx1Z2lucy9tYXMuYwppbmRleCA1NzI5YzIyLi42ZDc4NzFhIDEwMDY0NAotLS0g
YS9vYmV4ZC9wbHVnaW5zL21hcy5jCisrKyBiL29iZXhkL3BsdWdpbnMvbWFzLmMKQEAgLTg0LDcg
Kzg0LDcgQEAgc3RhdGljIGludCBnZXRfcGFyYW1zKHN0cnVjdCBvYmV4X3Nlc3Npb24gKm9zLCBz
dHJ1Y3QgbWFzX3Nlc3Npb24gKm1hcykKIAogCXNpemUgPSBvYmV4X2dldF9hcHBhcmFtKG9zLCAm
YnVmZmVyKTsKIAlpZiAoc2l6ZSA8IDApCi0JCXNpemUgPSAwOworCQlyZXR1cm4gMDsKIAogCW1h
cy0+aW5wYXJhbXMgPSBnX29iZXhfYXBwYXJhbV9kZWNvZGUoYnVmZmVyLCBzaXplKTsKIAlpZiAo
bWFzLT5pbnBhcmFtcyA9PSBOVUxMKSB7CkBAIC0yNDksNyArMjQ5LDkgQEAgc3RhdGljIHZvaWQg
Z2V0X21lc3NhZ2VzX2xpc3RpbmdfY2Iodm9pZCAqc2Vzc2lvbiwgaW50IGVyciwgdWludDE2X3Qg
c2l6ZSwKIAkJcmV0dXJuOwogCX0KIAotCWdfb2JleF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5p
bnBhcmFtcywgTUFQX0FQX01BWExJU1RDT1VOVCwgJm1heCk7CisJaWYgKG1hcy0+aW5wYXJhbXMp
CisJCWdfb2JleF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5pbnBhcmFtcywgTUFQX0FQX01BWExJ
U1RDT1VOVCwKKwkJCQkJCQkJCSZtYXgpOwogCiAJaWYgKG1heCA9PSAwKSB7CiAJCWlmICghZW50
cnkpCkBAIC0zOTcsNyArMzk5LDkgQEAgc3RhdGljIHZvaWQgZ2V0X2ZvbGRlcl9saXN0aW5nX2Ni
KHZvaWQgKnNlc3Npb24sIGludCBlcnIsIHVpbnQxNl90IHNpemUsCiAJCXJldHVybjsKIAl9CiAK
LQlnX29iZXhfYXBwYXJhbV9nZXRfdWludDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9NQVhMSVNU
Q09VTlQsICZtYXgpOworCWlmIChtYXMtPmlucGFyYW1zKQorCQlnX29iZXhfYXBwYXJhbV9nZXRf
dWludDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9NQVhMSVNUQ09VTlQsCisJCQkJCQkJCQkmbWF4
KTsKIAogCWlmIChtYXggPT0gMCkgewogCQlpZiAoZXJyICE9IC1FQUdBSU4pCkBAIC00OTMsOCAr
NDk3LDEyIEBAIHN0YXRpYyB2b2lkICpmb2xkZXJfbGlzdGluZ19vcGVuKGNvbnN0IGNoYXIgKm5h
bWUsIGludCBvZmxhZywgbW9kZV90IG1vZGUsCiAKIAlEQkcoIm5hbWUgPSAlcyIsIG5hbWUpOwog
Ci0JZ19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQxNihtYXMtPmlucGFyYW1zLCBNQVBfQVBfTUFYTElT
VENPVU5ULCAmbWF4KTsKLQlnX29iZXhfYXBwYXJhbV9nZXRfdWludDE2KG1hcy0+aW5wYXJhbXMs
IE1BUF9BUF9TVEFSVE9GRlNFVCwgJm9mZnNldCk7CisJaWYgKG1hcy0+aW5wYXJhbXMpIHsKKwkJ
Z19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQxNihtYXMtPmlucGFyYW1zLCBNQVBfQVBfTUFYTElTVENP
VU5ULAorCQkJCQkJCQkJJm1heCk7CisJCWdfb2JleF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5p
bnBhcmFtcywgTUFQX0FQX1NUQVJUT0ZGU0VULAorCQkJCQkJCQkmb2Zmc2V0KTsKKwl9CiAKIAkq
ZXJyID0gbWVzc2FnZXNfZ2V0X2ZvbGRlcl9saXN0aW5nKG1hcy0+YmFja2VuZF9kYXRhLCBuYW1l
LCBtYXgsCiAJCQkJCW9mZnNldCwgZ2V0X2ZvbGRlcl9saXN0aW5nX2NiLCBtYXMpOwpAQCAtNTI2
LDYgKzUzNCw5IEBAIHN0YXRpYyB2b2lkICptc2dfbGlzdGluZ19vcGVuKGNvbnN0IGNoYXIgKm5h
bWUsIGludCBvZmxhZywgbW9kZV90IG1vZGUsCiAJCXJldHVybiBOVUxMOwogCX0KIAorCWlmICgh
bWFzLT5pbnBhcmFtcykKKwkJZ290byBkb25lOworCiAJZ19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQx
NihtYXMtPmlucGFyYW1zLCBNQVBfQVBfTUFYTElTVENPVU5ULCAmbWF4KTsKIAlnX29iZXhfYXBw
YXJhbV9nZXRfdWludDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9TVEFSVE9GRlNFVCwgJm9mZnNl
dCk7CiAJZ19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQ4KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9TVUJK
RUNUTEVOR1RILApAQCAtNTQ4LDYgKzU1OSw3IEBAIHN0YXRpYyB2b2lkICptc2dfbGlzdGluZ19v
cGVuKGNvbnN0IGNoYXIgKm5hbWUsIGludCBvZmxhZywgbW9kZV90IG1vZGUsCiAJZ19vYmV4X2Fw
cGFyYW1fZ2V0X3VpbnQ4KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9GSUxURVJQUklPUklUWSwKIAkJ
CQkJCSZmaWx0ZXIucHJpb3JpdHkpOwogCitkb25lOgogCSplcnIgPSBtZXNzYWdlc19nZXRfbWVz
c2FnZXNfbGlzdGluZyhtYXMtPmJhY2tlbmRfZGF0YSwgbmFtZSwgbWF4LAogCQkJb2Zmc2V0LCBz
dWJqZWN0X2xlbiwgJmZpbHRlciwKIAkJCWdldF9tZXNzYWdlc19saXN0aW5nX2NiLCBtYXMpOwot
LSAKMS45LjMKCg==
--001a113403d0f6da31050200aed0--
