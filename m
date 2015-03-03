Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 3 Mar 2015 10:32:24 -0800
Message-ID: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com>
Subject: Patch to bluez/src/shared/att.c
From: =?UTF-8?B?0JLQvtC70L7QtNC40LzQuNGAINCe0YHRgtCw0L8=?=
	<volodymyr.ostap@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a113366d45a55bf0510668e13
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113366d45a55bf0510668e13
Content-Type: text/plain; charset=UTF-8

Hi All,

Fix of thread racing in bt_att_send()

In case bt_att_send() is called from other thread, internal thread
could complete
just added operation before  bt_att_send() returns. So, the function
return 0 as in error case.

--001a113366d45a55bf0510668e13
Content-Type: text/x-patch; charset=US-ASCII;
	name="09-shared-att-fixed-thread-racing.patch"
Content-Disposition: attachment;
	filename="09-shared-att-fixed-thread-racing.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6tmt8w80

LS0tIGJsdWV6LTUuMjgub3JnL3NyYy9zaGFyZWQvYXR0LmMJMjAxNS0wMi0wMSAyMDo1NDoxOS4w
MDAwMDAwMDAgLTA4MDAKKysrIGJsdWV6LTUuMjgvc3JjL3NoYXJlZC9hdHQuYwkyMDE1LTAyLTIz
IDE4OjMxOjQ4LjY0NTQ2MDIzOCAtMDgwMApAQCAtNzMsNyArNzQsNyBAQAogCXVpbnQ4X3QgKmJ1
ZjsKIAl1aW50MTZfdCBtdHU7CiAKLQl1bnNpZ25lZCBpbnQgbmV4dF9zZW5kX2lkOwkvKiBJRHMg
Zm9yICJzZW5kIiBvcHMgKi8KKwl2b2xhdGlsZSB1bnNpZ25lZCBpbnQgbmV4dF9zZW5kX2lkOwkv
KiBJRHMgZm9yICJzZW5kIiBvcHMgKi8KIAl1bnNpZ25lZCBpbnQgbmV4dF9yZWdfaWQ7CS8qIElE
cyBmb3IgcmVnaXN0ZXJlZCBjYWxsYmFja3MgKi8KIAogCWJ0X2F0dF90aW1lb3V0X2Z1bmNfdCB0
aW1lb3V0X2NhbGxiYWNrOwpAQCAtMTAwNiw3ICsxMDA4LDggQEAKIHsKIAlzdHJ1Y3QgYXR0X3Nl
bmRfb3AgKm9wOwogCWJvb2wgcmVzdWx0OwotCisJdW5zaWduZWQgaW50IGlkOworCQogCWlmICgh
YXR0IHx8ICFhdHQtPmlvKQogCQlyZXR1cm4gMDsKIApAQCAtMTAxOCw3ICsxMDIxLDcgQEAKIAlp
ZiAoYXR0LT5uZXh0X3NlbmRfaWQgPCAxKQogCQlhdHQtPm5leHRfc2VuZF9pZCA9IDE7CiAKLQlv
cC0+aWQgPSBhdHQtPm5leHRfc2VuZF9pZCsrOworCWlkID0gb3AtPmlkID0gYXR0LT5uZXh0X3Nl
bmRfaWQrKzsKIAogCS8qIEFkZCB0aGUgb3AgdG8gdGhlIGNvcnJlY3QgcXVldWUgYmFzZWQgb24g
aXRzIHR5cGUgKi8KIAlzd2l0Y2ggKG9wLT50eXBlKSB7CkBAIC0xMDQ2LDcgKzEwNDksNyBAQAog
CiAJd2FrZXVwX3dyaXRlcihhdHQpOwogCi0JcmV0dXJuIG9wLT5pZDsKKwlyZXR1cm4gaWQ7CiB9
CiAKIHN0YXRpYyBib29sIG1hdGNoX29wX2lkKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIp
Cg==
--001a113366d45a55bf0510668e13--
