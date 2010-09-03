Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Fri, 3 Sep 2010 15:21:04 +0300
Subject: RE: [PATCH] Fix clean-local target
Message-ID: <99B09243E1A5DA4898CDD8B70011144809792199F7@EXMB04.eu.tieto.com>
References: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <AANLkTim8+D6muD0EV+MW5CTTkark0aO4ch=syiOOUKMA@mail.gmail.com>
In-Reply-To: <AANLkTim8+D6muD0EV+MW5CTTkark0aO4ch=syiOOUKMA@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="_002_99B09243E1A5DA4898CDD8B70011144809792199F7EXMB04eutieto_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_99B09243E1A5DA4898CDD8B70011144809792199F7EXMB04eutieto_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Removed.=20

Thanks,
/Waldek

>-----Original Message-----
>From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]=20
>Sent: Friday, September 03, 2010 2:13 PM
>To: Rymarkiewicz Waldemar
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: [PATCH] Fix clean-local target
>
>Hi,
>
>On Fri, Sep 3, 2010 at 2:33 PM, Waldemar Rymarkiewicz=20
><waldemar.rymarkiewicz@tieto.com> wrote:
>> The fix avoids failure of the second consequent call of 'make clean'.
>>
>> Signed-off-by: Waldemar Rymarkiewicz=20
><waldemar.rymarkiewicz@tieto.com>
>> ---
>> =A0Makefile.am | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am index 5684e99..2fa03e1 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -385,5 +385,5 @@ lib/bluetooth/%.h: lib/%.h
>> =A0 =A0 =A0 =A0$(AM_V_at)$(MKDIR_P) lib/bluetooth
>> =A0 =A0 =A0 =A0$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>>
>> -clean-local: lib/bluetooth
>> - =A0 =A0 =A0 @$(RM) -r $<
>> +clean-local:
>> + =A0 =A0 =A0 $(RM) -r lib/bluetooth
>> \ No newline at end of file
>> --
>> 1.7.0.4
>
>Could you please remove the Signed-off-by, we don't use it on=20
>userspace.
>
>--
>Luiz Augusto von Dentz
>Computer Engineer
>=

--_002_99B09243E1A5DA4898CDD8B70011144809792199F7EXMB04eutieto_
Content-Type: application/octet-stream;
	name="0001-Fix-clean-local-target.patch"
Content-Description: 0001-Fix-clean-local-target.patch
Content-Disposition: attachment;
	filename="0001-Fix-clean-local-target.patch"; size=720;
	creation-date="Fri, 03 Sep 2010 15:19:20 GMT";
	modification-date="Fri, 03 Sep 2010 15:19:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMzM0Mjk2MmVmZjNmNDQyYmQ0ZDM0OWFkNzRlYjhhOTFlMzBkMzg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYWxkZW1hciBSeW1hcmtpZXdpY3ogPHdhbGRlbWFyLnJ5bWFy
a2lld2ljekB0aWV0by5jb20+CkRhdGU6IEZyaSwgMyBTZXAgMjAxMCAxMzoyMDowOCArMDIwMApT
dWJqZWN0OiBbUEFUQ0hdIEZpeCBjbGVhbi1sb2NhbCB0YXJnZXQKClRoZSBmaXggYXZvaWRzIGZh
aWx1cmUgb2YgdGhlIHNlY29uZCBjb25zZXF1ZW50IGNhbGwgb2YgJ21ha2UgY2xlYW4nLgotLS0K
IE1ha2VmaWxlLmFtIHwgICAgNCArKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZS5hbSBiL01ha2VmaWxlLmFt
CmluZGV4IDU2ODRlOTkuLjJmYTAzZTEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLmFtCisrKyBiL01h
a2VmaWxlLmFtCkBAIC0zODUsNSArMzg1LDUgQEAgbGliL2JsdWV0b290aC8lLmg6IGxpYi8lLmgK
IAkkKEFNX1ZfYXQpJChNS0RJUl9QKSBsaWIvYmx1ZXRvb3RoCiAJJChBTV9WX0dFTikkKExOX1Mp
ICQoYWJzX3RvcF9zcmNkaXIpLyQ8ICRACiAKLWNsZWFuLWxvY2FsOiBsaWIvYmx1ZXRvb3RoCi0J
QCQoUk0pIC1yICQ8CitjbGVhbi1sb2NhbDoKKwkkKFJNKSAtciBsaWIvYmx1ZXRvb3RoClwgTm8g
bmV3bGluZSBhdCBlbmQgb2YgZmlsZQotLSAKMS43LjAuNAoK

--_002_99B09243E1A5DA4898CDD8B70011144809792199F7EXMB04eutieto_--
