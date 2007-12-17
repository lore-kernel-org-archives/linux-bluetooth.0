Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712162315v53bf668et553413d6dbc81551@mail.gmail.com>
Date: Mon, 17 Dec 2007 08:15:26 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197853381.8050.58.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12216_14031547.1197875726806"
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
	<1197853381.8050.58.camel@aeonflux>
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

------=_Part_12216_14031547.1197875726806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 17, 2007 2:03 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Bastien,
>
> > > > > Attached patch does the following
> > > > >
> > > > > * about dialog code is simpler
> > > >
> > > > you can't use gtk_dialog_run for the applet's about dialog. It will
> > > > block and thus block all PIN requests. The current code is this way for
> > > > a reason.
> > >
> > > Didn't know that. I now use g_object_set which also reduces the amount
> > > of code considerably.
> >
> > You can still use gtk_show_about_dialog(). It removes the close
> > callback, and makes sure that only one dialogue shows up, and removes a
> > lot of boiler-plate code (it doesn't use a separate main loop like
> > gtk_dialog_run does). The gtk_dialog_run avoidance in the callbacks is
> > still needed.
>
> not sure why I haven't done it that way. Maybe it was not available when
> I wrote the initial version. However now the requirements are GTK 2.10
> or later. So if we can simplify code, I am all for it.
>
> Regards
>
Attached two patches

One uses gtk-show-about-dialog
The other makes sure that the windows always get an icon

Jaap

------=_Part_12216_14031547.1197875726806
Content-Type: text/x-patch; name=bluez-gnome-window-icon.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faao911k0
Content-Disposition: attachment; filename=bluez-gnome-window-icon.patch

SW5kZXg6IGFwcGxldC9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvYXBwbGV0L21haW4uYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45MApkaWZmIC11IC1y
MS45MCBtYWluLmMKLS0tIGFwcGxldC9tYWluLmMJMTcgRGVjIDIwMDcgMDE6NDE6MTkgLTAwMDAJ
MS45MAorKysgYXBwbGV0L21haW4uYwkxNyBEZWMgMjAwNyAwNzowOTo1MCAtMDAwMApAQCAtMTgx
Miw2ICsxODEyLDcgQEAKICNpZmRlZiBIQVZFX0xJQk5PVElGWQogCW5vdGlmeV9pbml0KCJibHVl
dG9vdGgtbWFuYWdlciIpOwogI2VuZGlmCisJZ3RrX3dpbmRvd19zZXRfZGVmYXVsdF9pY29uX25h
bWUgKCJzdG9ja19ibHVldG9vdGgiKTsKIAogCWNvbm4gPSBkYnVzX2dfYnVzX2dldChEQlVTX0JV
U19TWVNURU0sICZlcnJvcik7CiAJaWYgKGVycm9yICE9IE5VTEwpIHsK
------=_Part_12216_14031547.1197875726806
Content-Type: text/x-patch; name=bluez-gnome-gtk-show-about-dialog.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faao9d6s1
Content-Disposition: attachment;
	filename=bluez-gnome-gtk-show-about-dialog.patch

SW5kZXg6IGFwcGxldC9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvYXBwbGV0L21haW4uYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45MApkaWZmIC11IC1y
MS45MCBtYWluLmMKLS0tIGFwcGxldC9tYWluLmMJMTcgRGVjIDIwMDcgMDE6NDE6MTkgLTAwMDAJ
MS45MAorKysgYXBwbGV0L21haW4uYwkxNyBEZWMgMjAwNyAwNzowODozMyAtMDAwMApAQCAtMTUy
MSw1MCArMTUyMSw0OCBAQAogCQkiQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0PiIs
CiAJCU5VTEwKIAl9OwotCUd0a1dpZGdldCAqZGlhbG9nOwotCi0JZGlhbG9nID0gZ3RrX2Fib3V0
X2RpYWxvZ19uZXcoKTsKLQotCWd0a193aW5kb3dfc2V0X2ljb25fbmFtZShHVEtfV0lORE9XKGRp
YWxvZyksICJzdG9ja19ibHVldG9vdGgiKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X25hbWUo
R1RLX0FCT1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJXygiQmx1ZXRvb3RoIEFwcGxldCIpKTsK
LQotCWd0a19hYm91dF9kaWFsb2dfc2V0X3ZlcnNpb24oR1RLX0FCT1VUX0RJQUxPRyhkaWFsb2cp
LCBWRVJTSU9OKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X2NvcHlyaWdodChHVEtfQUJPVVRf
RElBTE9HKGRpYWxvZyksCi0JCQkiQ29weXJpZ2h0IFx4YzJceGE5IDIwMDUtMjAwNyBNYXJjZWwg
SG9sdG1hbm4iKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X2NvbW1lbnRzKEdUS19BQk9VVF9E
SUFMT0coZGlhbG9nKSwKLQkJCV8oIkEgQmx1ZXRvb3RoIG1hbmFnZXIgZm9yIHRoZSBHTk9NRSBk
ZXNrdG9wIikpOwotCi0JZ3RrX2Fib3V0X2RpYWxvZ19zZXRfbG9nb19pY29uX25hbWUoR1RLX0FC
T1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJCSJzdG9ja19ibHVldG9vdGgiKTsKLQotCWd0a19h
Ym91dF9kaWFsb2dfc2V0X3VybF9ob29rKGFib3V0X3VybF9ob29rLCBOVUxMLCBOVUxMKTsKLQot
CWd0a19hYm91dF9kaWFsb2dfc2V0X2VtYWlsX2hvb2soYWJvdXRfZW1haWxfaG9vaywgTlVMTCwg
TlVMTCk7Ci0KLQlndGtfYWJvdXRfZGlhbG9nX3NldF93ZWJzaXRlKEdUS19BQk9VVF9ESUFMT0co
ZGlhbG9nKSwKLQkJCQkJCSJodHRwOi8vd3d3LmJsdWV6Lm9yZyIpOwotCi0JZ3RrX2Fib3V0X2Rp
YWxvZ19zZXRfd2Vic2l0ZV9sYWJlbChHVEtfQUJPVVRfRElBTE9HKGRpYWxvZyksCi0JCQkJCQkJ
Ind3dy5ibHVlei5vcmciKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X2F1dGhvcnMoR1RLX0FC
T1VUX0RJQUxPRyhkaWFsb2cpLCBhdXRob3JzKTsKLQotCWd0a19hYm91dF9kaWFsb2dfc2V0X3Ry
YW5zbGF0b3JfY3JlZGl0cyhHVEtfQUJPVVRfRElBTE9HKGRpYWxvZyksCi0JCQkJCQlfKCJ0cmFu
c2xhdG9yLWNyZWRpdHMiKSk7Ci0KLQlnX3NpZ25hbF9jb25uZWN0KGRpYWxvZywgImNsb3NlIiwK
LQkJCQlHX0NBTExCQUNLKGNsb3NlX2NhbGxiYWNrKSwgTlVMTCk7Ci0KLQlnX3NpZ25hbF9jb25u
ZWN0KGRpYWxvZywgInJlc3BvbnNlIiwKLQkJCQlHX0NBTExCQUNLKGNsb3NlX2NhbGxiYWNrKSwg
TlVMTCk7Ci0KLQlndGtfd2lkZ2V0X3Nob3dfYWxsKGRpYWxvZyk7CisgCisgICAgICAgIGNvbnN0
IGNoYXIgKnRyYW5zbGF0b3JzOworICAgICAgICB0cmFuc2xhdG9ycyA9IF8oInRyYW5zbGF0b3It
Y3JlZGl0cyIpOworIAorICAgICAgICBjb25zdCBjaGFyICpsaWNlbnNlW10gPSB7CisgICAgICAg
ICAgICAgICAgTl8oIlRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5ICIKKyAgICAgICAgICAgICAgICAiaXQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkg
IgorICAgICAgICAgICAgICAgICJ0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIg
dmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAiCisgICAgICAgICAgICAgICAgIihhdCB5b3Vy
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uXG4iKSwKKyAgICAgICAgICAgICAgICBOXygiVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2Vm
dWwsICIKKyAgICAgICAgICAgICAgICAiYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0
IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YgIgorICAgICAgICAgICAgICAgICJNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlICIK
KyAgICAgICAgICAgICAgICAiR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy5cbiIpLAorICAgICAgICAgICAgICAgIE5fKCJZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAiCisgICAgICAgICAgICAg
ICAgImFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiBJZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUu
b3JnL2xpY2Vuc2VzLz4uIikKKyAgICAgICAgfTsKKworICAgICAgICBjaGFyICpsaWNlbnNlX3Ry
YW5zOworICAgICAgICAKKyAgICAgICAgbGljZW5zZV90cmFucyA9IGdfc3RyY29uY2F0IChfKGxp
Y2Vuc2VbMF0pLCAiXG4iLCBfKGxpY2Vuc2VbMV0pLCAiXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF8obGljZW5zZVsyXSksICJcbiIsIE5VTEwpOworCisJZ3RrX2Fi
b3V0X2RpYWxvZ19zZXRfdXJsX2hvb2sgKGFib3V0X3VybF9ob29rLCBOVUxMLCBOVUxMKTsKKwln
dGtfYWJvdXRfZGlhbG9nX3NldF9lbWFpbF9ob29rIChhYm91dF9lbWFpbF9ob29rLCBOVUxMLCBO
VUxMKTsKKworICAgICAgICBndGtfc2hvd19hYm91dF9kaWFsb2cgKE5VTEwsCisJCQkgICAgICAg
InByb2dyYW0tbmFtZSIsIF8oIkJsdWV0b290aCBBcHBsZXQiKSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAidmVyc2lvbiIsIFZFUlNJT04sCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImNvcHlyaWdodCIsICJDb3B5cmlnaHQgXHhjMlx4YTkgMjAwNS0yMDA3IE1hcmNl
bCBIb2x0bWFubiIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNvbW1lbnRzIiwg
XygiQSBCbHVldG9vdGggbWFuYWdlciBmb3IgdGhlIEdOT01FIGRlc2t0b3AiKSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiYXV0aG9ycyIsIGF1dGhvcnMsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgInRyYW5zbGF0b3ItY3JlZGl0cyIsIHRyYW5zbGF0b3JzLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ3ZWJzaXRlIiwgImh0dHA6Ly93d3cuYmx1ZXou
b3JnIiwKKwkJCSAgICAgICAid2Vic2l0ZS1sYWJlbCIsIF8oIkJsdWV6IFdlYnNpdGUiKSwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibG9nby1pY29uLW5hbWUiLCAic3RvY2tfYmx1
ZXRvb3RoIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAid3JhcC1saWNlbnNlIiwg
VFJVRSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibGljZW5zZSIsIGxpY2Vuc2Vf
dHJhbnMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7CisgICAgICAgIGdf
ZnJlZSAobGljZW5zZV90cmFucyk7CiB9CiAKKwogc3RhdGljIHZvaWQgc2V0dGluZ3NfY2FsbGJh
Y2soR09iamVjdCAqd2lkZ2V0LCBncG9pbnRlciB1c2VyX2RhdGEpCiB7CiAJY29uc3QgY2hhciAq
Y29tbWFuZCA9ICJibHVldG9vdGgtcHJvcGVydGllcyI7Cg==
------=_Part_12216_14031547.1197875726806
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
------=_Part_12216_14031547.1197875726806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_12216_14031547.1197875726806--
