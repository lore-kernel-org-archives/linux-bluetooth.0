Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=YeYGdojmXt-0gRdXPafsupP6CZc4r7dj2ufAg@mail.gmail.com>
References: <AANLkTin+CRVwKgC+UaDK6q4PRrw9eGi3c7++PSxWODcu@mail.gmail.com>
	<20100820125948.GA16376@jh-x301>
	<AANLkTi=YeYGdojmXt-0gRdXPafsupP6CZc4r7dj2ufAg@mail.gmail.com>
Date: Fri, 20 Aug 2010 14:39:07 +0100
Message-ID: <AANLkTim9y59pMzPGSkZi431oTAjEjdiEtQHnt_-D2z85@mail.gmail.com>
Subject: Re: [PATCH] Remove dup VCard2.1 SDP format for OPP
From: Tom Counihan <tomcounihan@googlemail.com>
To: Tom Counihan <tomcounihan@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=00163646bbdc49247f048e416cf6
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--00163646bbdc49247f048e416cf6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Johan,

Attaching patch as an attachment - hopefully all should be fine now.

Warm Regards
Tom.

On Fri, Aug 20, 2010 at 2:32 PM, Tom Counihan
<tomcounihan@googlemail.com> wrote:
> On Fri, Aug 20, 2010 at 1:59 PM, Johan Hedberg <johan.hedberg@gmail.com> =
wrote:
>> Hi Tom,
>>
>> On Fri, Aug 20, 2010, Tom Counihan wrote:
>>> OPP SDP record appears to have a duplicate
>>> entry for Supported Formats List.
>>>
>>> ---
>>> =A0plugins/opp.c | =A0 =A01 -
>>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> The patch looks fine but doesn't apply against latest git:
>>
>> error: patch failed: plugins/opp.c:83
>> error: plugins/opp.c: patch does not apply
>> Patch failed at 0001 Remove dup VCard2.1 SDP format for OPP
>>
>> Could you make sure that it applies cleanly to latest git and then
>> resend? Thanks.
>
> I'll send again - I'm assuming that the cause here is we had a race
> condition between inbound patches?
>>
>> Johan
>>
>

--00163646bbdc49247f048e416cf6
Content-Type: application/octet-stream;
	name="0001-Remove-dup-VCard2.1-SDP-format-for-OPP.patch"
Content-Disposition: attachment;
	filename="0001-Remove-dup-VCard2.1-SDP-format-for-OPP.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd32tmvt0

RnJvbSBhYjdkN2ZiZjYwYTAxNmI0OTEyMDBmNGM1ZWFmMTAwMTg4ZGQ1ZDdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb20gQ291bmloYW4gPHRvbWNvdW5paGFuQGdvb2dsZW1haWwu
Y29tPgpEYXRlOiBGcmksIDIwIEF1ZyAyMDEwIDE0OjIwOjUzICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gUmVtb3ZlIGR1cCBWQ2FyZDIuMSBTRFAgZm9ybWF0IGZvciBPUFAKCk9QUCBTRFAgcmVjb3Jk
IGFwcGVhcnMgdG8gaGF2ZSBhIGR1cGxpY2F0ZQplbnRyeSBmb3IgU3VwcG9ydGVkIEZvcm1hdHMg
TGlzdC4KLS0tCiBwbHVnaW5zL29wcC5jIHwgICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wbHVnaW5zL29wcC5jIGIv
cGx1Z2lucy9vcHAuYwppbmRleCBjZDQ2NDY0Li4wNWY5NDRmIDEwMDY0NAotLS0gYS9wbHVnaW5z
L29wcC5jCisrKyBiL3BsdWdpbnMvb3BwLmMKQEAgLTgzLDcgKzgzLDYgQEAKICAgPGF0dHJpYnV0
ZSBpZD1cIjB4MDMwM1wiPgkJCQkJXAogICAgIDxzZXF1ZW5jZT4JCQkJCQkJXAogICAgICAgPHVp
bnQ4IHZhbHVlPVwiMHgwMVwiLz4JCQkJCVwKLSAgICAgIDx1aW50OCB2YWx1ZT1cIjB4MDFcIi8+
CQkJCQlcCiAgICAgICA8dWludDggdmFsdWU9XCIweDAyXCIvPgkJCQkJXAogICAgICAgPHVpbnQ4
IHZhbHVlPVwiMHgwM1wiLz4JCQkJCVwKICAgICAgIDx1aW50OCB2YWx1ZT1cIjB4MDRcIi8+CQkJ
CQlcCi0tIAoxLjcuMS4xCgo=
--00163646bbdc49247f048e416cf6--
