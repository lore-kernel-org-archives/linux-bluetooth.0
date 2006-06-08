Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
Date: Thu, 8 Jun 2006 14:07:02 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1149718288.22472.71.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6045_20657184.1149786422942"
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_6045_20657184.1149786422942
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> it would help a lot. I am a little bit worried of such off-by-one
> errors, because as I said, the SDP code is a strange code. You might
> break some other part of the code that rely on this being wrong. Don't
> get me wrong, it is still a bug, but we need to take care to fix both
> places. And I have seen such stuff in the SDP code before. This is why I
> am extra careful.
ok. This is a simple program that has the bug:
----------------------------------------------------------
#include <sdp.h>
#include <sdp_lib.h>

int main() {
        uint8_t     dtd = SDP_URL_STR8;
        char     *value = "abc";

        sdp_data_t *d = sdp_data_alloc(dtd, value);

        sdp_buf_t buf;
        uint8_t   data[1000];
        buf.data      = data;
        buf.buf_size  = sizeof(data);
        buf.data_size = 0;

        sdp_gen_pdu(&buf, d);
        return 0;
}
-------------------------------------------------------------------

> Send in a patch. I will check it.
Attached.

> Regards
>
> Marcel

Best Regards,
Rafael

------=_Part_6045_20657184.1149786422942
Content-Type: application/octet-stream; name=sdp.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo7d3uy5
Content-Disposition: attachment; filename="sdp.patch"

LS0tIHRlbXAvYmx1ZXotbGlicy0yLjI0L3NyYy9zZHAuYwkyMDA1LTEyLTI0IDE0OjAzOjM4LjAw
MDAwMDAwMCAtMDMwMAorKysgc2RwLmMJMjAwNi0wNi0wOCAxNDowNDoxMS4wMDAwMDAwMDAgLTAz
MDAKQEAgLTQzMywxOCArNDMzLDggQEAKIAogCQkJaWYgKGxlbmd0aCA8PSBVQ0hBUl9NQVgpIHsK
IAkJCQlkLT51bml0U2l6ZSArPSBzaXplb2YodWludDhfdCk7Ci0JCQkJaWYgKGR0ZCAhPSBTRFBf
VVJMX1NUUjggJiYgZHRkICE9IFNEUF9URVhUX1NUUjgpIHsKLQkJCQkJaWYgKGR0ZCA9PSBTRFBf
VVJMX1NUUjE2KQotCQkJCQkJZHRkID0gU0RQX1VSTF9TVFI4OwotCQkJCQllbHNlCi0JCQkJCQlk
dGQgPSBTRFBfVEVYVF9TVFI4OwotCQkJCX0KIAkJCX0gZWxzZSB7CiAJCQkJZC0+dW5pdFNpemUg
Kz0gc2l6ZW9mKHVpbnQxNl90KTsKLQkJCQlpZiAoZHRkID09IFNEUF9URVhUX1NUUjgpCi0JCQkJ
CWR0ZCA9IFNEUF9URVhUX1NUUjE2OwotCQkJCWVsc2UKLQkJCQkJZHRkID0gU0RQX1VSTF9TVFIx
NjsKIAkJCX0KIAkJfSBlbHNlIHsKIAkJCVNEUEVSUigiU3RyaW5ncyBvZiBzaXplID4gVVNIUlRf
TUFYIG5vdCBzdXBwb3J0ZWRcbiIpOwo=
------=_Part_6045_20657184.1149786422942
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_6045_20657184.1149786422942
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_6045_20657184.1149786422942--
