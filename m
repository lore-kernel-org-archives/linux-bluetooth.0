Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <9a119b3c0711230400l2885eccei3b32efb152ddec0@mail.gmail.com>
Date: Fri, 23 Nov 2007 13:00:40 +0100
From: "=?ISO-8859-1?Q?Csillag_Krist=F3f?=" <csillag.kristof@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1c9b31320711220913r1f89aafgcf88c0927bfb1c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23511_22209433.1195819240831"
References: <9a119b3c0711220826u405b3845pb1101fcfb2c42e3c@mail.gmail.com>
	<1c9b31320711220913r1f89aafgcf88c0927bfb1c1@mail.gmail.com>
Subject: Re: [Bluez-users] Using AVRCP with current BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_Part_23511_22209433.1195819240831
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Johan,

2007/11/22, Johan Hedberg <johan.hedberg@gmail.com>:
> I don't think there is any proper documentation yet. bluez-utils-3.22
> has some preliminary AVRCP support but by default it's disabled. You
> need to add a line "Enable=3DControl" to the General section in
> /etc/bluetooth/audio.conf to enable it. Currently no D-Bus signals or
> or methods are supported. Instead, the audio service uses the kernel
> uinput interface (you need to have the uinput module loaded) to inject
> keypress events to the kernel input subsystem. You can see what kind
> of AVRCP->keycode mappings are used by looking in the audio/control.c
> file from bluez-utils.

Thanks, now it works great!

One more question: what was the reason to use

KEY_NEXT and KEY_PREVIOUS, instead of
KEY_NEXTSONG and KEY_PREVIOUSSONG?

The latter are below-256 keycodes (like KEY_PLAYPAUSE,
which is used by BlueZ for pause) handled nicely by
all applications (like keytouch), where the former, which
are currently used, are extended codes, mostly unsupported
in user-space.

As far as I am interested, I changed the codes in my local
BlueZ installation so that I do not have to change keytouch.

Now it works nice with keytouch and hence audacious.

Thank you:

    Krist=F3f

ps. Here is a patch, if anybody is interested.

------=_Part_23511_22209433.1195819240831
Content-Type: text/x-diff; name=keycode_change.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9cnvolu
Content-Disposition: attachment; filename=keycode_change.patch

LS0tIGNvbnRyb2wuY34JMjAwNy0xMC0yNiAwMTowOToxNS4wMDAwMDAwMDAgKzAyMDAKKysrIGNv
bnRyb2wuYwkyMDA3LTExLTIzIDEyOjM0OjUyLjAwMDAwMDAwMCArMDEwMApAQCAtNDQ3LDggKzQ0
Nyw4IEBACiAKIAlpb2N0bChmZCwgVUlfU0VUX0tFWUJJVCwgS0VZX1BMQVlQQVVTRSk7CiAJaW9j
dGwoZmQsIFVJX1NFVF9LRVlCSVQsIEtFWV9TVE9QKTsKLQlpb2N0bChmZCwgVUlfU0VUX0tFWUJJ
VCwgS0VZX05FWFQpOwotCWlvY3RsKGZkLCBVSV9TRVRfS0VZQklULCBLRVlfUFJFVklPVVMpOwor
CWlvY3RsKGZkLCBVSV9TRVRfS0VZQklULCBLRVlfTkVYVFNPTkcpOworCWlvY3RsKGZkLCBVSV9T
RVRfS0VZQklULCBLRVlfUFJFVklPVVNTT05HKTsKIAlpb2N0bChmZCwgVUlfU0VUX0tFWUJJVCwg
S0VZX1JFV0lORCk7CiAJaW9jdGwoZmQsIFVJX1NFVF9LRVlCSVQsIEtFWV9GT1JXQVJEKTsKIApA
QCAtNTYwLDExICs1NjAsMTEgQEAKIAkJYnJlYWs7CiAJY2FzZSBORVhUX09QOgogCQlkZWJ1Zygi
QVZSQ1A6IE5FWFQgJXMiLCBzdGF0dXMpOwotCQlzZW5kX2tleShzZXNzaW9uLT51aW5wdXQsIEtF
WV9ORVhULCBwcmVzc2VkKTsKKwkJc2VuZF9rZXkoc2Vzc2lvbi0+dWlucHV0LCBLRVlfTkVYVFNP
TkcsIHByZXNzZWQpOwogCQlicmVhazsKIAljYXNlIFBSRVZfT1A6CiAJCWRlYnVnKCJBVlJDUDog
UFJFViAlcyIsIHN0YXR1cyk7Ci0JCXNlbmRfa2V5KHNlc3Npb24tPnVpbnB1dCwgS0VZX1BSRVZJ
T1VTLCBwcmVzc2VkKTsKKwkJc2VuZF9rZXkoc2Vzc2lvbi0+dWlucHV0LCBLRVlfUFJFVklPVVNT
T05HLCBwcmVzc2VkKTsKIAkJYnJlYWs7CiAJY2FzZSBSRVdJTkRfT1A6CiAJCWRlYnVnKCJBVlJD
UDogUkVXSU5EICVzIiwgc3RhdHVzKTsKLS0tIGJsdWV6LXV0aWxzLTMuMjIvYXVkaW8vY29udHJv
bC5jfgkyMDA3LTEwLTI2IDAxOjA5OjE1LjAwMDAwMDAwMCArMDIwMAorKysgYmx1ZXotdXRpbHMt
My4yMi9hdWRpby9jb250cm9sLmMJMjAwNy0xMS0yMyAxMjozNDo1Mi4wMDAwMDAwMDAgKzAxMDAK
QEAgLTQ0Nyw4ICs0NDcsOCBAQAogCiAJaW9jdGwoZmQsIFVJX1NFVF9LRVlCSVQsIEtFWV9QTEFZ
UEFVU0UpOwogCWlvY3RsKGZkLCBVSV9TRVRfS0VZQklULCBLRVlfU1RPUCk7Ci0JaW9jdGwoZmQs
IFVJX1NFVF9LRVlCSVQsIEtFWV9ORVhUKTsKLQlpb2N0bChmZCwgVUlfU0VUX0tFWUJJVCwgS0VZ
X1BSRVZJT1VTKTsKKwlpb2N0bChmZCwgVUlfU0VUX0tFWUJJVCwgS0VZX05FWFRTT05HKTsKKwlp
b2N0bChmZCwgVUlfU0VUX0tFWUJJVCwgS0VZX1BSRVZJT1VTU09ORyk7CiAJaW9jdGwoZmQsIFVJ
X1NFVF9LRVlCSVQsIEtFWV9SRVdJTkQpOwogCWlvY3RsKGZkLCBVSV9TRVRfS0VZQklULCBLRVlf
Rk9SV0FSRCk7CiAKQEAgLTU2MCwxMSArNTYwLDExIEBACiAJCWJyZWFrOwogCWNhc2UgTkVYVF9P
UDoKIAkJZGVidWcoIkFWUkNQOiBORVhUICVzIiwgc3RhdHVzKTsKLQkJc2VuZF9rZXkoc2Vzc2lv
bi0+dWlucHV0LCBLRVlfTkVYVCwgcHJlc3NlZCk7CisJCXNlbmRfa2V5KHNlc3Npb24tPnVpbnB1
dCwgS0VZX05FWFRTT05HLCBwcmVzc2VkKTsKIAkJYnJlYWs7CiAJY2FzZSBQUkVWX09QOgogCQlk
ZWJ1ZygiQVZSQ1A6IFBSRVYgJXMiLCBzdGF0dXMpOwotCQlzZW5kX2tleShzZXNzaW9uLT51aW5w
dXQsIEtFWV9QUkVWSU9VUywgcHJlc3NlZCk7CisJCXNlbmRfa2V5KHNlc3Npb24tPnVpbnB1dCwg
S0VZX1BSRVZJT1VTU09ORywgcHJlc3NlZCk7CiAJCWJyZWFrOwogCWNhc2UgUkVXSU5EX09QOgog
CQlkZWJ1ZygiQVZSQ1A6IFJFV0lORCAlcyIsIHN0YXR1cyk7Cg==
------=_Part_23511_22209433.1195819240831
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------=_Part_23511_22209433.1195819240831
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_23511_22209433.1195819240831--
