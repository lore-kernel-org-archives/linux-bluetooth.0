Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140110200624.GA25318@molly.amr.corp.intel.com>
References: <CAOVeLGSGAf9LmsEcaAiECh+zL-7bg-gZJnue4TqzbBCNFfMj3w@mail.gmail.com>
	<20140110200624.GA25318@molly.amr.corp.intel.com>
Date: Fri, 17 Jan 2014 13:26:37 -0800
Message-ID: <CAOVeLGRu9p4xBTneujvavfASMwq2_X7Bmmm37VN4QKvmdocDDA@mail.gmail.com>
Subject: Re: Compilation using clang
From: Donald Carr <sirspudd@gmail.com>
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=047d7b4728167581ae04f031325c
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b4728167581ae04f031325c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hola,

Thanks for the rapid response :)

I am simply attaching a patch, probably in complete defiance of some
standardized announcement/submission pattern.

Yours sincerely,
Donald

On Fri, Jan 10, 2014 at 12:06 PM, Vinicius Costa Gomes
<vcgomes@gmail.com> wrote:
> Hi Donald,
>
> On 09:57 Fri 10 Jan, Donald Carr wrote:
>> Top of the morning,
>>
>> qtconnectivity currently contains a kludge which is required due to
>> the use of the GCC typeof extension in bluetooth.h which is breaking
>> with Clang compilation against the cxx11 spec.
>
> Another kludge that I have seen is putting a
> "#define typeof(x) __tupeof__(x)" before including bluetooth.h.
>
>>
>> The kludge in question involves molesting the standard (eg -std=3Dcxx11)
>> specified to the compiler (explicitly away from cxx11 toward g++0x)
>> and hence I am hoping to be able to murder its intrusive self. I am
>> not entirely clear on the nuances though:
>>
>> This is the offending section:
>>
>> #define bt_get_unaligned(ptr)                   \
>> ({                                              \
>>         struct __attribute__((packed)) {        \
>>                 typeof(*(ptr)) __v;         \
>>         } *__p =3D (typeof(__p)) (ptr);               \
>>         __p->__v;                               \
>> })
>>
>> #define bt_put_unaligned(val, ptr)              \
>> do {                                            \
>>         struct __attribute__((packed)) {        \
>>                 typeof(*(ptr)) __v;         \
>>         } *__p =3D (typeof(__p)) (ptr);               \
>>         __p->__v =3D (val);                       \
>> } while(0)
>>
>> and changing typeof to __typeof__ has been verified to succeed in the
>> stated circumstance. I don't know whether this is the ideal solution,
>> or whether decltype or so other designator would be a closer/better
>> match.
>
> I would vote for changing it to __typeof__.
>
>>
>> Any feedback would be greatly appreciated, I am using this change
>> locally and I think it could be of broader use to people.
>
> Please send a patch and let's see what others think.
>
>>
>> Yours sincerely,
>> Donald Carr
>>
>>
>> --
>> -------------------------------
>>  =B0v=B0  Donald Carr
>> /(_)\ Vaguely Professional Penguin lover
>>  ^ ^
>>
>> Cave canem, te necet lingendo
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers,
> --
> Vinicius



--=20
-------------------------------
 =B0v=B0  Donald Carr
/(_)\ Vaguely Professional Penguin lover
 ^ ^

Cave canem, te necet lingendo

--047d7b4728167581ae04f031325c
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluez-Move-off-gcc-typeof-extension.patch"
Content-Disposition: attachment;
	filename="0001-Bluez-Move-off-gcc-typeof-extension.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqjyis9i0

RnJvbSA4NDZiODQxNDNlZTQyNDAyNThiMmFlZTZhYWQzY2Q5NTU2NWNhZWZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEb25hbGQgQ2FyciA8c2lyc3B1ZGRAZ21haWwuY29tPgpEYXRl
OiBGcmksIDE3IEphbiAyMDE0IDEzOjIwOjM5IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXo6
IE1vdmUgb2ZmIGdjYyB0eXBlb2YgZXh0ZW5zaW9uCgpDaGFuZ2UtSWQ6IEk2M2M3MGM5YjQzYWY2
YTI5YWE2OWVkMTFhNzIwYzQ1YzEwODVkY2U5Ci0tLQogYmx1ZXRvb3RoL2JsdWV0b290aC5oIHwg
OCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9ibHVldG9vdGgvYmx1ZXRvb3RoLmggYi9ibHVldG9vdGgvYmx1ZXRv
b3RoLmgKaW5kZXggNjFjMWY5YS4uYmM5YjM1ZSAxMDA2NDQKLS0tIGEvYmx1ZXRvb3RoL2JsdWV0
b290aC5oCisrKyBiL2JsdWV0b290aC9ibHVldG9vdGguaApAQCAtMTU4LDE2ICsxNTgsMTYgQEAg
ZW51bSB7CiAjZGVmaW5lIGJ0X2dldF91bmFsaWduZWQocHRyKQkJCVwKICh7CQkJCQkJXAogCXN0
cnVjdCBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKSB7CVwKLQkJdHlwZW9mKCoocHRyKSkgX192OwkJ
XAotCX0gKl9fcCA9ICh0eXBlb2YoX19wKSkgKHB0cik7CQlcCisJCV9fdHlwZW9mX18oKihwdHIp
KSBfX3Y7CQlcCisJfSAqX19wID0gKF9fdHlwZW9mX18oX19wKSkgKHB0cik7CQlcCiAJX19wLT5f
X3Y7CQkJCVwKIH0pCiAKICNkZWZpbmUgYnRfcHV0X3VuYWxpZ25lZCh2YWwsIHB0cikJCVwKIGRv
IHsJCQkJCQlcCiAJc3RydWN0IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpIHsJXAotCQl0eXBlb2Yo
KihwdHIpKSBfX3Y7CQlcCi0JfSAqX19wID0gKHR5cGVvZihfX3ApKSAocHRyKTsJCVwKKwkJX190
eXBlb2ZfXygqKHB0cikpIF9fdjsJCVwKKwl9ICpfX3AgPSAoX190eXBlb2ZfXyhfX3ApKSAocHRy
KTsJCVwKIAlfX3AtPl9fdiA9ICh2YWwpOwkJCVwKIH0gd2hpbGUoMCkKIAotLSAKMS44LjUuMwoK
--047d7b4728167581ae04f031325c--
