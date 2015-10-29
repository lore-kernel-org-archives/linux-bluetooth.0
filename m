Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+i1r=i_ihLb2Yocc4+3Bw7Py7ru8SwBweJeBp1jsicFg@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
 <CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
 <CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
 <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
 <CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
 <CAEZxfGPPoYOX=yGDP2TQFRw7GY_zCXZrPYuDxxK8jt49veyjyg@mail.gmail.com>
 <CAHmfHqQLmiGep3nKZ-Vq8RHqvG-SwVJhvUJSnDJZ6+jGeAFXpg@mail.gmail.com>
 <CAEZxfGPdU0fzp_P-7AJDSF+xCnXPqVUHs8fs8SA1jpDiRp2urg@mail.gmail.com> <CABBYNZ+i1r=i_ihLb2Yocc4+3Bw7Py7ru8SwBweJeBp1jsicFg@mail.gmail.com>
From: Leon Nicholls <lnicholls@google.com>
Date: Wed, 28 Oct 2015 20:02:09 -0700
Message-ID: <CAHmfHqRKpY=0ot6htP=GdB3C=rHQn0jp-o6rvvYSpzKzeriePQ@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7b67604ea5a6a40523358ac6
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b67604ea5a6a40523358ac6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Following Fran=C3=A7ois instructions to explicitly stop the scan, here are
the latest logs. I'm getting a "GATT Error Unknown" in the browser,
although that might not be an error on the driver level but maybe just
due to a timeout on the browser level.

--047d7b67604ea5a6a40523358ac6
Content-Type: text/plain; charset=US-ASCII; name="shell.txt"
Content-Disposition: attachment; filename="shell.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_igbna9l31

Y2hyb25vc0Bsb2NhbGhvc3QgLyAkIHN1ZG8gYnRtb24gLXcgfi9Eb3dubG9hZHMvYnRtb24uYnRz
bm9vcApCbHVldG9vdGggbW9uaXRvciB2ZXIgNS4zNQo9IE5ldyBJbmRleDogMUM6M0U6ODQ6MEQ6
Rjk6RjggKEJSL0VEUixVU0IsaGNpMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDAuMjQzMDk3
CjwgSENJIENvbW1hbmQ6IERpc2Nvbm5lY3QgKDB4MDF8MHgwMDA2KSBwbGVuIDMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFtoY2kwXSAyMS42NTA3NzEKICAgICAgICBIYW5kbGU6IDMyCiAgICAgICAgUmVh
c29uOiBSZW1vdGUgVXNlciBUZXJtaW5hdGVkIENvbm5lY3Rpb24gKDB4MTMpCj4gSENJIEV2ZW50
OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSAyMS42NTIzMTMKICAgICAgRGlzY29ubmVjdCAoMHgwMXwweDAwMDYpIG5jbWQgMQogICAg
ICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKPiBIQ0kgRXZlbnQ6IFZlbmRvciAoMHhmZikgcGxl
biA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDIxLjY2NzM3NAogICAg
ICAgIDgyIDcwIDkwIDgwIDEwIDM2IDU5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAucC4u
LjZZICAgICAgICAgCj4gSENJIEV2ZW50OiBEaXNjb25uZWN0IENvbXBsZXRlICgweDA1KSBwbGVu
IDQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAyMS42NjgzNjAKICAgICAgICBTdGF0dXM6IFN1
Y2Nlc3MgKDB4MDApCiAgICAgICAgSGFuZGxlOiAzMgogICAgICAgIFJlYXNvbjogQ29ubmVjdGlv
biBUZXJtaW5hdGVkIEJ5IExvY2FsIEhvc3QgKDB4MTYpCkAgRGV2aWNlIERpc2Nvbm5lY3RlZDog
MEY6MDQ6RTA6NTE6NDQ6OEIgKDIpIHJlYXNvbiAy
--047d7b67604ea5a6a40523358ac6
Content-Type: application/octet-stream; name="btmon (4).btsnoop"
Content-Disposition: attachment; filename="btmon (4).btsnoop"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_igbna9kr0

YnRzbm9vcAAAAAABAAAH0QAAABAAAAAQAAAAAAAAAAAA4gDohDdiWQAB+PkNhD4caGNpMAAAAAAA
AAAGAAAABgAAAAIAAAAAAOIA6IV+ChMGBAMgABMAAAAGAAAABgAAAAMAAAAAAOIA6IV+EBkPBAAB
BgQAAAAJAAAACQAAAAMAAAAAAOIA6IV+Su7/B4JwkIAQNlkAAAAGAAAABgAAAAMAAAAAAOIA6IV+
TsgFBAAgABY=
--047d7b67604ea5a6a40523358ac6--
