Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301052849.7592.15.camel@mattotaupa>
References: <1298226004.3712.1.camel@mattotaupa>
	<1298320304.6159.21.camel@snowflake>
	<ik00pv$8d8$1@dough.gmane.org>
	<1298374409.3861.32.camel@mattotaupa>
	<1298403438.6736.26.camel@snowflake>
	<1300531488.6875.3.camel@snowflake>
	<1301052849.7592.15.camel@mattotaupa>
Date: Mon, 28 Mar 2011 18:41:22 +0300
Message-ID: <AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] [PATCH] sbc_math.h: add explicit check for
 ARMv6 instructions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: General PulseAudio Discussion
	<pulseaudio-discuss@mail.0pointer.de>
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=20cf303b40758af1a5049f8cc63f
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf303b40758af1a5049f8cc63f
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Fri, Mar 25, 2011 at 1:34 PM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear Arun,
>
>
> Am Samstag, den 19.03.2011, 16:14 +0530 schrieb Arun Raghavan:
>
>> On Wed, 2011-02-23 at 01:07 +0530, Arun Raghavan wrote:
>> [...]
>> > The correct fix for this, imo, is in bluez (there is a new
>> > sbc_primitives_armv6.h that can probably be used at least as a
>> > template). We need to do an sbc-udpate on the PA side anyway, and can
>> > pull this when we do.
>>
>> Could you see if the attached patch works for you? If it does, I can
>> push this to the bluez folks.
>
> My tag on the other thread [1] is ambiguous. The error is indeed caused
> by your patch. I will try to implement your recommended changes but will
> probably not get to it before Sunday.

Im including Siarhei Siamashka since he did most, if not all, of this
code and linux-bluetooth to cc.

Btw, the sbc subdir should be in sync with sbc subdir in BlueZ tree.


-- 
Luiz Augusto von Dentz
Computer Engineer

--20cf303b40758af1a5049f8cc63f
Content-Type: text/x-patch; charset=US-ASCII; name="thumb2-fix.patch"
Content-Disposition: attachment; filename="thumb2-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gltmmliw1

ZGlmZiAtLWdpdCBhL3NyYy9tb2R1bGVzL2JsdWV0b290aC9zYmMvc2JjX21hdGguaCBiL3NyYy9t
b2R1bGVzL2JsdWV0b290aC9zYmMvc2JjX21hdGguaAppbmRleCBiODdiYzgxLi4zNWQ1ZGNjIDEw
MDY0NAotLS0gYS9zcmMvbW9kdWxlcy9ibHVldG9vdGgvc2JjL3NiY19tYXRoLmgKKysrIGIvc3Jj
L21vZHVsZXMvYmx1ZXRvb3RoL3NiYy9zYmNfbWF0aC5oCkBAIC0yMyw2ICsyMyw4IEBACiAgKgog
ICovCiAKKyNpbmNsdWRlICJzYmNfcHJpbWl0aXZlc19hcm12Ni5oIgorCiAjZGVmaW5lIGZhYnMo
eCkgKCh4KSA8IDAgPyAtKHgpIDogKHgpKQogLyogQyBkb2VzIG5vdCBwcm92aWRlIGFuIGV4cGxp
Y2l0IGFyaXRobWV0aWMgc2hpZnQgcmlnaHQgYnV0IHRoaXMgd2lsbAogICAgYWx3YXlzIGJlIGNv
cnJlY3QgYW5kIGV2ZXJ5IGNvbXBpbGVyICpzaG91bGQqIGdlbmVyYXRlIG9wdGltYWwgY29kZSAq
LwpAQCAtNDcsNyArNDksNyBAQCB0eXBlZGVmIGludDMyX3Qgc2JjX2ZpeGVkX3Q7CiAKICNkZWZp
bmUgU0JDX0ZJWEVEXzAodmFsKSB7IHZhbCA9IDA7IH0KICNkZWZpbmUgTVVMKGEsIGIpICAgICAg
ICAoKGEpICogKGIpKQotI2lmZGVmIF9fYXJtX18KKyNpZmRlZiBTQkNfSEFWRV9USFVNQjIKICNk
ZWZpbmUgTVVMQShhLCBiLCByZXMpICh7CQkJCVwKIAkJaW50IHRtcCA9IHJlczsJCQlcCiAJCV9f
YXNtX18oCQkJCVwKZGlmZiAtLWdpdCBhL3NyYy9tb2R1bGVzL2JsdWV0b290aC9zYmMvc2JjX3By
aW1pdGl2ZXNfYXJtdjYuaCBiL3NyYy9tb2R1bGVzL2JsdWV0b290aC9zYmMvc2JjX3ByaW1pdGl2
ZXNfYXJtdjYuaAppbmRleCAxODYyYWVkLi5lNzA0NjlhIDEwMDY0NAotLS0gYS9zcmMvbW9kdWxl
cy9ibHVldG9vdGgvc2JjL3NiY19wcmltaXRpdmVzX2FybXY2LmgKKysrIGIvc3JjL21vZHVsZXMv
Ymx1ZXRvb3RoL3NiYy9zYmNfcHJpbWl0aXZlc19hcm12Ni5oCkBAIC0zOCw2ICszOCwxMiBAQAog
I2RlZmluZSBTQkNfSEFWRV9BUk1WNiAxCiAjZW5kaWYKIAorI2lmIGRlZmluZWQoX19BUk1fQVJD
SF82VDJfXyApIHx8IGRlZmluZWQoX19BUk1fQVJDSF83X18pIHx8IFwKKwlkZWZpbmVkKF9fQVJN
X0FSQ0hfN0FfXykgfHwgZGVmaW5lZChfX0FSTV9BUkNIXzdSX18pIHx8IFwKKwlkZWZpbmVkKF9f
QVJNX0FSQ0hfN01fXykKKyNkZWZpbmUgU0JDX0hBVkVfVEhVTUIyIDEKKyNlbmRpZgorCiAjaWYg
IWRlZmluZWQoU0JDX0hJR0hfUFJFQ0lTSU9OKSAmJiAoU0NBTEVfT1VUX0JJVFMgPT0gMTUpICYm
IFwKIAlkZWZpbmVkKF9fR05VQ19fKSAmJiBkZWZpbmVkKFNCQ19IQVZFX0FSTVY2KSAmJiBcCiAJ
ZGVmaW5lZChfX0FSTV9FQUJJX18pICYmICFkZWZpbmVkKF9fdGh1bWJfXykgJiYgXAo=
--20cf303b40758af1a5049f8cc63f--
