Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C82D0B.8F273AD2"
Date: Thu, 22 Nov 2007 15:28:24 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803AF043B@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] bluez-utils/audio/pcm_bluetooth.c:
	audio-makefile.am-add-linkage-to-librt
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82D0B.8F273AD2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20 Nov 2007, Vehmanen Kai wrote:
>here's a patch that fixes linking of pcm_bluetooth.c now that=20
>it uses clock_gettimeofday() (which is in librt in glibc).

updated to latest CVS, recreated, renamed and attached.

--=20
first.surname@nokia.com (Kai Vehmanen)

------_=_NextPart_001_01C82D0B.8F273AD2
Content-Type: application/octet-stream;
	name="patch-20071122-kv-audio-makefile.am-add-linkage-to-librt.diff"
Content-Transfer-Encoding: base64
Content-Description: patch-20071122-kv-audio-makefile.am-add-linkage-to-librt.diff
Content-Disposition: attachment;
	filename="patch-20071122-kv-audio-makefile.am-add-linkage-to-librt.diff"

LS0tIGF1ZGlvL01ha2VmaWxlLmFtCTIxIE5vdiAyMDA3IDIwOjI0OjExIC0wMDAwCTEuNDEKKysr
IGF1ZGlvL01ha2VmaWxlLmFtCTIyIE5vdiAyMDA3IDEyOjUwOjU4IC0wMDAwCkBAIC0yNSw3ICsy
NSw3IEBACiAKIGxpYmFzb3VuZF9tb2R1bGVfcGNtX2JsdWV0b290aF9sYV9TT1VSQ0VTID0gcGNt
X2JsdWV0b290aC5jIHJ0cC5oIGlwYy5oIGlwYy5jCiBsaWJhc291bmRfbW9kdWxlX3BjbV9ibHVl
dG9vdGhfbGFfTERGTEFHUyA9IC1tb2R1bGUgLWF2b2lkLXZlcnNpb24gLWV4cG9ydC1zeW1ib2xz
LXJlZ2V4IFtfXSpzbmRfcGNtXy4qCi1saWJhc291bmRfbW9kdWxlX3BjbV9ibHVldG9vdGhfbGFf
TElCQUREID0gQFNCQ19MSUJTQCBAQUxTQV9MSUJTQAorbGliYXNvdW5kX21vZHVsZV9wY21fYmx1
ZXRvb3RoX2xhX0xJQkFERCA9IEBTQkNfTElCU0AgQEFMU0FfTElCU0AgLWxydAogbGliYXNvdW5k
X21vZHVsZV9wY21fYmx1ZXRvb3RoX2xhX0NGTEFHUyA9IEBBTFNBX0NGTEFHU0AgQFNCQ19DRkxB
R1NACiAKIGxpYmFzb3VuZF9tb2R1bGVfY3RsX2JsdWV0b290aF9sYV9TT1VSQ0VTID0gY3RsX2Js
dWV0b290aC5jIHJ0cC5oIGlwYy5oIGlwYy5jCg==

------_=_NextPart_001_01C82D0B.8F273AD2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------_=_NextPart_001_01C82D0B.8F273AD2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C82D0B.8F273AD2--
