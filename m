Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712181352u1d802bfava194bf372cb5f232@mail.gmail.com>
Date: Tue, 18 Dec 2007 22:52:43 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197918266.8050.90.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23637_12002729.1198014763564"
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
	<1197853381.8050.58.camel@aeonflux>
	<8a8adccc0712162315v53bf668et553413d6dbc81551@mail.gmail.com>
	<1197918266.8050.90.camel@aeonflux>
Subject: Re: [Bluez-devel] [PATCH] Beautify about dialog
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

------=_Part_23637_12002729.1198014763564
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 17, 2007 8:04 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
> > > > > > > Attached patch does the following
> > > > > > >
> > > > > > > * about dialog code is simpler
> > > > > >
> > > > > > you can't use gtk_dialog_run for the applet's about dialog. It will
> > > > > > block and thus block all PIN requests. The current code is this way for
> > > > > > a reason.
> > > > >
> > > > > Didn't know that. I now use g_object_set which also reduces the amount
> > > > > of code considerably.
> > > >
> > > > You can still use gtk_show_about_dialog(). It removes the close
> > > > callback, and makes sure that only one dialogue shows up, and removes a
> > > > lot of boiler-plate code (it doesn't use a separate main loop like
> > > > gtk_dialog_run does). The gtk_dialog_run avoidance in the callbacks is
> > > > still needed.
> > >
> > > not sure why I haven't done it that way. Maybe it was not available when
> > > I wrote the initial version. However now the requirements are GTK 2.10
> > > or later. So if we can simplify code, I am all for it.
> > >
> > Attached two patches
> >
> > One uses gtk-show-about-dialog
>
> fix the coding style for this one. I can already see that it messes up
> the whitespaces. We use tabs and no whitespace in front of the ( in
> function declarations.

Attached patch with coding style fixup attached

Jaap

------=_Part_23637_12002729.1198014763564
Content-Type: text/x-patch;
 name=gnome-bluetooth-gtk-show-about-dialog.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_facz1j1v0
Content-Disposition: attachment;
	filename=gnome-bluetooth-gtk-show-about-dialog.patch

SW5kZXg6IGFwcGxldC9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvYXBwbGV0L21haW4uYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45MwpkaWZmIC11IC1y
MS45MyBtYWluLmMKLS0tIGFwcGxldC9tYWluLmMJMTggRGVjIDIwMDcgMjA6Mjc6NTggLTAwMDAJ
MS45MworKysgYXBwbGV0L21haW4uYwkxOCBEZWMgMjAwNyAyMTo0OTo1OSAtMDAwMApAQCAtMTUy
NCw0OCArMTUyNCw0OSBAQAogCQkiQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0PiIs
CiAJCU5VTEwKIAl9OwotCUd0a1dpZGdldCAqZGlhbG9nOwotCi0JZGlhbG9nID0gZ3RrX2Fib3V0
X2RpYWxvZ19uZXcoKTsKLQotCWd0a193aW5kb3dfc2V0X2ljb25fbmFtZShHVEtfV0lORE9XKGRp
YWxvZyksICJzdG9ja19ibHVldG9vdGgiKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X25hbWUo
R1RLX0FCT1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJXygiQmx1ZXRvb3RoIEFwcGxldCIpKTsK
LQotCWd0a19hYm91dF9kaWFsb2dfc2V0X3ZlcnNpb24oR1RLX0FCT1VUX0RJQUxPRyhkaWFsb2cp
LCBWRVJTSU9OKTsKIAotCWd0a19hYm91dF9kaWFsb2dfc2V0X2NvcHlyaWdodChHVEtfQUJPVVRf
RElBTE9HKGRpYWxvZyksCi0JCQkiQ29weXJpZ2h0IFx4YzJceGE5IDIwMDUtMjAwNyBNYXJjZWwg
SG9sdG1hbm4iKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X2NvbW1lbnRzKEdUS19BQk9VVF9E
SUFMT0coZGlhbG9nKSwKLQkJCV8oIkEgQmx1ZXRvb3RoIG1hbmFnZXIgZm9yIHRoZSBHTk9NRSBk
ZXNrdG9wIikpOwotCi0JZ3RrX2Fib3V0X2RpYWxvZ19zZXRfbG9nb19pY29uX25hbWUoR1RLX0FC
T1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJCSJzdG9ja19ibHVldG9vdGgiKTsKKwljb25zdCBj
aGFyICp0cmFuc2xhdG9yczsKKwl0cmFuc2xhdG9ycyA9IF8oInRyYW5zbGF0b3ItY3JlZGl0cyIp
OworIAorCWNvbnN0IGNoYXIgKmxpY2Vuc2VbXSA9IHsKKwkJTl8oIlRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5ICIKKwkJ
Iml0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMg
cHVibGlzaGVkIGJ5ICIKKwkJInRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yICIKKwkJIihhdCB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uXG4iKSwKKwkJTl8oIlRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCAiCisJCSJidXQgV0lUSE9VVCBBTlkgV0FS
UkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiAiCisJCSJNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlICIK
KwkJIkdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuXG4iKSwKKwkJ
Tl8oIllvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlICIKKwkJImFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiBJZiBub3QsIHNlZSA8
aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uIikKKwl9OworCisJY2hhciAqbGljZW5zZV90
cmFuczsKKyAgICAgICAgCisJbGljZW5zZV90cmFucyA9IGdfc3RyY29uY2F0KF8obGljZW5zZVsw
XSksICJcbiIsIF8obGljZW5zZVsxXSksICJcbiIsCisJCQkJICAgIF8obGljZW5zZVsyXSksICJc
biIsIE5VTEwpOwogCiAJZ3RrX2Fib3V0X2RpYWxvZ19zZXRfdXJsX2hvb2soYWJvdXRfdXJsX2hv
b2ssIE5VTEwsIE5VTEwpOwotCiAJZ3RrX2Fib3V0X2RpYWxvZ19zZXRfZW1haWxfaG9vayhhYm91
dF9lbWFpbF9ob29rLCBOVUxMLCBOVUxMKTsKIAotCWd0a19hYm91dF9kaWFsb2dfc2V0X3dlYnNp
dGUoR1RLX0FCT1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJImh0dHA6Ly93d3cuYmx1ZXoub3Jn
Iik7Ci0KLQlndGtfYWJvdXRfZGlhbG9nX3NldF93ZWJzaXRlX2xhYmVsKEdUS19BQk9VVF9ESUFM
T0coZGlhbG9nKSwKLQkJCQkJCQkid3d3LmJsdWV6Lm9yZyIpOwotCi0JZ3RrX2Fib3V0X2RpYWxv
Z19zZXRfYXV0aG9ycyhHVEtfQUJPVVRfRElBTE9HKGRpYWxvZyksIGF1dGhvcnMpOwotCi0JZ3Rr
X2Fib3V0X2RpYWxvZ19zZXRfdHJhbnNsYXRvcl9jcmVkaXRzKEdUS19BQk9VVF9ESUFMT0coZGlh
bG9nKSwKLQkJCQkJCV8oInRyYW5zbGF0b3ItY3JlZGl0cyIpKTsKLQotCWdfc2lnbmFsX2Nvbm5l
Y3QoZGlhbG9nLCAiY2xvc2UiLAotCQkJCUdfQ0FMTEJBQ0soY2xvc2VfY2FsbGJhY2spLCBOVUxM
KTsKLQotCWdfc2lnbmFsX2Nvbm5lY3QoZGlhbG9nLCAicmVzcG9uc2UiLAotCQkJCUdfQ0FMTEJB
Q0soY2xvc2VfY2FsbGJhY2spLCBOVUxMKTsKLQotCWd0a193aWRnZXRfc2hvd19hbGwoZGlhbG9n
KTsKKwlndGtfc2hvd19hYm91dF9kaWFsb2coTlVMTCwKKyNpZiBHVEtfQ0hFQ0tfVkVSU0lPTigy
LDEyLDApCisJCQkgICAgICAicHJvZ3JhbS1uYW1lIiwgXygiQmx1ZXRvb3RoIEFwcGxldCIpLAor
I2Vsc2UKKwkJCSAgICAgICJuYW1lIiwgXygiQmx1ZXRvb3RoIEFwcGxldCIpLAorI2VuZGlmCisJ
CQkgICAgICAidmVyc2lvbiIsIFZFUlNJT04sCisJCQkgICAgICAiY29weXJpZ2h0IiwgIkNvcHly
aWdodCBceGMyXHhhOSAyMDA1LTIwMDcgTWFyY2VsIEhvbHRtYW5uIiwKKwkJCSAgICAgICJjb21t
ZW50cyIsIF8oIkEgQmx1ZXRvb3RoIG1hbmFnZXIgZm9yIHRoZSBHTk9NRSBkZXNrdG9wIiksCisJ
CQkgICAgICAiYXV0aG9ycyIsIGF1dGhvcnMsCisJCQkgICAgICAidHJhbnNsYXRvci1jcmVkaXRz
IiwgdHJhbnNsYXRvcnMsCisJCQkgICAgICAid2Vic2l0ZSIsICJodHRwOi8vd3d3LmJsdWV6Lm9y
ZyIsCisJCQkgICAgICAid2Vic2l0ZS1sYWJlbCIsIF8oIkJsdWV6IFdlYnNpdGUiKSwKKwkJCSAg
ICAgICJsb2dvLWljb24tbmFtZSIsICJzdG9ja19ibHVldG9vdGgiLAorCQkJICAgICAgIndyYXAt
bGljZW5zZSIsIFRSVUUsCisJCQkgICAgICAibGljZW5zZSIsIGxpY2Vuc2VfdHJhbnMsCisJCQkg
ICAgICBOVUxMKTsKKwlnX2ZyZWUobGljZW5zZV90cmFucyk7CiB9CiAKIHN0YXRpYyB2b2lkIHNl
dHRpbmdzX2NhbGxiYWNrKEdPYmplY3QgKndpZGdldCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQo=
------=_Part_23637_12002729.1198014763564
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
------=_Part_23637_12002729.1198014763564
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_23637_12002729.1198014763564--
