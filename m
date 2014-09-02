Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000101cfc66e$00719660$0154c320$@samsung.com>
References: <000001cfb169$e4d01bc0$ae705340$@samsung.com>
	<CABBYNZKTc7DYz5OSJOYm8uTDRzOOzfLMaOPGg-U7TTneaRiH_A@mail.gmail.com>
	<002101cfb550$afb1f400$0f15dc00$@samsung.com>
	<CABBYNZL5OBA6iNhzTkpKTmSEj+5R_oU5KLOAsFcK0ZDHvridMw@mail.gmail.com>
	<006d01cfc5e0$6b4df110$41e9d330$@samsung.com>
	<CABBYNZJnyVNyw2-odAPV621k-aiw8x83WNju7FZXW0=_5VUotw@mail.gmail.com>
	<000101cfc66e$00719660$0154c320$@samsung.com>
Date: Tue, 2 Sep 2014 11:28:38 +0300
Message-ID: <CABBYNZJK37SuBuHqxjGO8aobBDukjiOOExciOoQZkGnp-1rGeA@mail.gmail.com>
Subject: Re: Query regarding MAP 1.2 implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=089e013cba22fb6946050210e7fa
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--089e013cba22fb6946050210e7fa
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Sep 2, 2014 at 8:22 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
>
> Hi Luiz,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> Sent: Monday, September 01, 2014 6:37 PM
>> To: Gowtham Anandha Babu
>> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda
>> Subject: Re: Query regarding MAP 1.2 implementation
>>
>> Hi,
>>
>> On Mon, Sep 1, 2014 at 3:29 PM, Gowtham Anandha Babu
>> <gowtham.ab@samsung.com> wrote:
>>
>> > The current message-dummy.c looks like, it is creating a virtual folder in the
>> system (Ex. Home/PC-NAME/map-messages/).
>> > So, I created the map-messages directory in home/PC-NAME/. Then I tried
>> SETPATH (mentioned in the previous thread).
>> > The output is...
>> >
>> >  obexd[29146]: obexd/src/obex.c:cmd_setpath()
>> > obexd[29146]: SETPATH(0x5), (null)(0xffffffff)
>> > obexd[29146]: obexd/src/obex.c:parse_name() NAME:
>> > obexd[29146]: obexd/plugins/mas.c:mas_setpath() SETPATH: name
>> nonhdr
>> > 0x20
>> > obexd[29146]: SETPATH(0x5), SUCCESS(0x20)
>> >
>> > But When I tried to call GetFolderListing() The output is...
>> >
>> > obexd[29146]: obexd/src/obex.c:cmd_get() session 0x1008c40
>> > obexd[29146]: GET(0x3), (null)(0xffffffff)
>> > obexd[29146]: obexd/src/obex.c:parse_type() TYPE:
>> > x-obex/folder-listing
>> > obexd[29146]: obexd/plugins/mas.c:mas_get() GET: name (null) type
>> > x-obex/folder-listing mas 0x1015c00
>> > obexd[29146]: obexd/plugins/mas.c:get_params() Error when parsing
>> parameters!
>> > obexd[29146]: GET(0x3), BAD_REQUEST(0x40)
>> >
>> > But I had few folders created inside the map-messages.
>>
>> Bad request is normally when there is something wrong with the command
>> itself, the error comes from here:
>>
>> mas->inparams = g_obex_apparam_decode(buffer, size);
>> if (mas->inparams == NULL) {
>>     DBG("Error when parsing parameters!");
>>     return -EBADR;
>> }
>>
>> I suspect the problem is that there is no application parameters set which is
>> fine since all the parameters of GetFolderListing are optional, please try with
>> the attached patch I will send it shortly as a proper patch to the mailing list.
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> I applied the patch which was attached in the previous reply. Still I am getting the same error.
> I tried printing the "size" inside the get_params function. Its value is '0' for GetFolderListing request.
> If size=0, then g_obex_apparam_decode()  function always return NULL, which leads to "Error when parsing parameters!".

My bad, the check should be size <= 0 otherwise it will still cause
this problem.


-- 
Luiz Augusto von Dentz

--089e013cba22fb6946050210e7fa
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-obexd-mas-Fix-parsing-of-application-parameters.patch"
Content-Disposition: attachment;
	filename="0001-obexd-mas-Fix-parsing-of-application-parameters.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzkz4wx90

RnJvbSBlOTBkYWJhOWEyMDJmMDcyZDYyNmYzNDA0YzdiMDE4MWE0YWEzYWMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMSBTZXAgMjAxNCAxNjowMTo0MCArMDMwMApTdWJqZWN0
OiBbUEFUQ0ggQmx1ZVpdIG9iZXhkL21hczogRml4IHBhcnNpbmcgb2YgYXBwbGljYXRpb24gcGFy
YW1ldGVycwoKU29tZSBjb21tYW5kcyBkb24ndCBoYXZlIGFueSBtYW5kYXRvcnkgYXBwbGljYXRp
b24gcGFyYW1ldGVyIHdoaWNoIG1lYW5zCmlucGFyYW1zIGNhbiBiZSBOVUxMIHdoaWNoIHNob3Vs
ZCBub3QgYmUgdHJlYXRlZCBhcyBhIGJhZCByZXF1ZXN0LgotLS0KIG9iZXhkL3BsdWdpbnMvbWFz
LmMgfCAyNCArKysrKysrKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL29iZXhkL3BsdWdpbnMvbWFz
LmMgYi9vYmV4ZC9wbHVnaW5zL21hcy5jCmluZGV4IDU3MjljMjIuLjI0YjI2YWUgMTAwNjQ0Ci0t
LSBhL29iZXhkL3BsdWdpbnMvbWFzLmMKKysrIGIvb2JleGQvcGx1Z2lucy9tYXMuYwpAQCAtODMs
OCArODMsOCBAQCBzdGF0aWMgaW50IGdldF9wYXJhbXMoc3RydWN0IG9iZXhfc2Vzc2lvbiAqb3Ms
IHN0cnVjdCBtYXNfc2Vzc2lvbiAqbWFzKQogCXNzaXplX3Qgc2l6ZTsKIAogCXNpemUgPSBvYmV4
X2dldF9hcHBhcmFtKG9zLCAmYnVmZmVyKTsKLQlpZiAoc2l6ZSA8IDApCi0JCXNpemUgPSAwOwor
CWlmIChzaXplIDw9IDApCisJCXJldHVybiAwOwogCiAJbWFzLT5pbnBhcmFtcyA9IGdfb2JleF9h
cHBhcmFtX2RlY29kZShidWZmZXIsIHNpemUpOwogCWlmIChtYXMtPmlucGFyYW1zID09IE5VTEwp
IHsKQEAgLTI0OSw3ICsyNDksOSBAQCBzdGF0aWMgdm9pZCBnZXRfbWVzc2FnZXNfbGlzdGluZ19j
Yih2b2lkICpzZXNzaW9uLCBpbnQgZXJyLCB1aW50MTZfdCBzaXplLAogCQlyZXR1cm47CiAJfQog
Ci0JZ19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQxNihtYXMtPmlucGFyYW1zLCBNQVBfQVBfTUFYTElT
VENPVU5ULCAmbWF4KTsKKwlpZiAobWFzLT5pbnBhcmFtcykKKwkJZ19vYmV4X2FwcGFyYW1fZ2V0
X3VpbnQxNihtYXMtPmlucGFyYW1zLCBNQVBfQVBfTUFYTElTVENPVU5ULAorCQkJCQkJCQkJJm1h
eCk7CiAKIAlpZiAobWF4ID09IDApIHsKIAkJaWYgKCFlbnRyeSkKQEAgLTM5Nyw3ICszOTksOSBA
QCBzdGF0aWMgdm9pZCBnZXRfZm9sZGVyX2xpc3RpbmdfY2Iodm9pZCAqc2Vzc2lvbiwgaW50IGVy
ciwgdWludDE2X3Qgc2l6ZSwKIAkJcmV0dXJuOwogCX0KIAotCWdfb2JleF9hcHBhcmFtX2dldF91
aW50MTYobWFzLT5pbnBhcmFtcywgTUFQX0FQX01BWExJU1RDT1VOVCwgJm1heCk7CisJaWYgKG1h
cy0+aW5wYXJhbXMpCisJCWdfb2JleF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5pbnBhcmFtcywg
TUFQX0FQX01BWExJU1RDT1VOVCwKKwkJCQkJCQkJCSZtYXgpOwogCiAJaWYgKG1heCA9PSAwKSB7
CiAJCWlmIChlcnIgIT0gLUVBR0FJTikKQEAgLTQ5Myw4ICs0OTcsMTIgQEAgc3RhdGljIHZvaWQg
KmZvbGRlcl9saXN0aW5nX29wZW4oY29uc3QgY2hhciAqbmFtZSwgaW50IG9mbGFnLCBtb2RlX3Qg
bW9kZSwKIAogCURCRygibmFtZSA9ICVzIiwgbmFtZSk7CiAKLQlnX29iZXhfYXBwYXJhbV9nZXRf
dWludDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9NQVhMSVNUQ09VTlQsICZtYXgpOwotCWdfb2Jl
eF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5pbnBhcmFtcywgTUFQX0FQX1NUQVJUT0ZGU0VULCAm
b2Zmc2V0KTsKKwlpZiAobWFzLT5pbnBhcmFtcykgeworCQlnX29iZXhfYXBwYXJhbV9nZXRfdWlu
dDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9BUF9NQVhMSVNUQ09VTlQsCisJCQkJCQkJCQkmbWF4KTsK
KwkJZ19vYmV4X2FwcGFyYW1fZ2V0X3VpbnQxNihtYXMtPmlucGFyYW1zLCBNQVBfQVBfU1RBUlRP
RkZTRVQsCisJCQkJCQkJCSZvZmZzZXQpOworCX0KIAogCSplcnIgPSBtZXNzYWdlc19nZXRfZm9s
ZGVyX2xpc3RpbmcobWFzLT5iYWNrZW5kX2RhdGEsIG5hbWUsIG1heCwKIAkJCQkJb2Zmc2V0LCBn
ZXRfZm9sZGVyX2xpc3RpbmdfY2IsIG1hcyk7CkBAIC01MjYsNiArNTM0LDkgQEAgc3RhdGljIHZv
aWQgKm1zZ19saXN0aW5nX29wZW4oY29uc3QgY2hhciAqbmFtZSwgaW50IG9mbGFnLCBtb2RlX3Qg
bW9kZSwKIAkJcmV0dXJuIE5VTEw7CiAJfQogCisJaWYgKCFtYXMtPmlucGFyYW1zKQorCQlnb3Rv
IGRvbmU7CisKIAlnX29iZXhfYXBwYXJhbV9nZXRfdWludDE2KG1hcy0+aW5wYXJhbXMsIE1BUF9B
UF9NQVhMSVNUQ09VTlQsICZtYXgpOwogCWdfb2JleF9hcHBhcmFtX2dldF91aW50MTYobWFzLT5p
bnBhcmFtcywgTUFQX0FQX1NUQVJUT0ZGU0VULCAmb2Zmc2V0KTsKIAlnX29iZXhfYXBwYXJhbV9n
ZXRfdWludDgobWFzLT5pbnBhcmFtcywgTUFQX0FQX1NVQkpFQ1RMRU5HVEgsCkBAIC01NDgsNiAr
NTU5LDcgQEAgc3RhdGljIHZvaWQgKm1zZ19saXN0aW5nX29wZW4oY29uc3QgY2hhciAqbmFtZSwg
aW50IG9mbGFnLCBtb2RlX3QgbW9kZSwKIAlnX29iZXhfYXBwYXJhbV9nZXRfdWludDgobWFzLT5p
bnBhcmFtcywgTUFQX0FQX0ZJTFRFUlBSSU9SSVRZLAogCQkJCQkJJmZpbHRlci5wcmlvcml0eSk7
CiAKK2RvbmU6CiAJKmVyciA9IG1lc3NhZ2VzX2dldF9tZXNzYWdlc19saXN0aW5nKG1hcy0+YmFj
a2VuZF9kYXRhLCBuYW1lLCBtYXgsCiAJCQlvZmZzZXQsIHN1YmplY3RfbGVuLCAmZmlsdGVyLAog
CQkJZ2V0X21lc3NhZ2VzX2xpc3RpbmdfY2IsIG1hcyk7Ci0tIAoxLjkuMwoK
--089e013cba22fb6946050210e7fa--
