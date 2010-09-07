Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <u.kleine-koenig@pengutronix.de>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Tue, 7 Sep 2010 12:09:56 +0300
Subject: RE: [PATCH] Fix clean-local target
Message-ID: <99B09243E1A5DA4898CDD8B700111448097958128E@EXMB04.eu.tieto.com>
References: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20100903191937.GA29821@pengutronix.de>
In-Reply-To: <20100903191937.GA29821@pengutronix.de>
Content-Type: multipart/mixed;
	boundary="_002_99B09243E1A5DA4898CDD8B700111448097958128EEXMB04eutieto_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_99B09243E1A5DA4898CDD8B700111448097958128EEXMB04eutieto_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Uwe,
There is no intention behind that. Have updated the patch.

@Johan:  Will you consider to push it to upstream ?

/Waldek

=20

>-----Original Message-----
>From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]=20
>Sent: Friday, September 03, 2010 9:20 PM
>To: Rymarkiewicz Waldemar
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: [PATCH] Fix clean-local target
>
>Hello Waldemar,
>
>On Fri, Sep 03, 2010 at 01:33:33PM +0200, Waldemar Rymarkiewicz wrote:
>> The fix avoids failure of the second consequent call of 'make clean'.
>>=20
>> Signed-off-by: Waldemar Rymarkiewicz=20
><waldemar.rymarkiewicz@tieto.com>
>> ---
>>  Makefile.am |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Makefile.am b/Makefile.am index 5684e99..2fa03e1 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -385,5 +385,5 @@ lib/bluetooth/%.h: lib/%.h
>>  	$(AM_V_at)$(MKDIR_P) lib/bluetooth
>>  	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>> =20
>> -clean-local: lib/bluetooth
>> -	@$(RM) -r $<
>> +clean-local:
>> +	$(RM) -r lib/bluetooth
>> \ No newline at end of file
>Is the missing newline at eof on purpose?
>
>Best regards
>Uwe
>
>--=20
>Pengutronix e.K.                           | Uwe Kleine-K=F6nig =20
>          |
>Industrial Linux Solutions                 |=20
>http://www.pengutronix.de/  |
>=

--_002_99B09243E1A5DA4898CDD8B700111448097958128EEXMB04eutieto_
Content-Type: application/octet-stream;
	name="0001-Fix-clean-local-target.patch"
Content-Description: 0001-Fix-clean-local-target.patch
Content-Disposition: attachment;
	filename="0001-Fix-clean-local-target.patch"; size=695;
	creation-date="Tue, 07 Sep 2010 12:09:34 GMT";
	modification-date="Tue, 07 Sep 2010 12:09:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NmI5Mzk1NjA3MGQ0NWUzZjcwYmEwNTc5YTQ0ZDc1N2EzYmE5OTRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYWxkZW1hciBSeW1hcmtpZXdpY3ogPHdhbGRlbWFyLnJ5bWFy
a2lld2ljekB0aWV0by5jb20+CkRhdGU6IEZyaSwgMyBTZXAgMjAxMCAxMzoyMDowOCArMDIwMApT
dWJqZWN0OiBbUEFUQ0hdIEZpeCBjbGVhbi1sb2NhbCB0YXJnZXQKClRoZSBmaXggYXZvaWRzIGZh
aWx1cmUgb2YgdGhlIHNlY29uZCBjb25zZXF1ZW50IGNhbGwgb2YgJ21ha2UgY2xlYW4nLgotLS0K
IE1ha2VmaWxlLmFtIHwgICAgNSArKystLQogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUuYW0gYi9NYWtlZmlsZS5h
bQppbmRleCA5YTc4NzgwLi40OTgxNWFmIDEwMDY0NAotLS0gYS9NYWtlZmlsZS5hbQorKysgYi9N
YWtlZmlsZS5hbQpAQCAtNDAzLDUgKzQwMyw2IEBAIGxpYi9ibHVldG9vdGgvJS5oOiBsaWIvJS5o
CiAJJChBTV9WX2F0KSQoTUtESVJfUCkgbGliL2JsdWV0b290aAogCSQoQU1fVl9HRU4pJChMTl9T
KSAkKGFic190b3Bfc3JjZGlyKS8kPCAkQAogCi1jbGVhbi1sb2NhbDogbGliL2JsdWV0b290aAot
CUAkKFJNKSAtciAkPAorY2xlYW4tbG9jYWw6CisJJChSTSkgLXIgbGliL2JsdWV0b290aAorCi0t
IAoxLjcuMC40Cgo=

--_002_99B09243E1A5DA4898CDD8B700111448097958128EEXMB04eutieto_--
