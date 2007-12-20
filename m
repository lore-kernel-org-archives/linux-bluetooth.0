Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712201424v792ae6d7pd8265ed5795164ac@mail.gmail.com>
Date: Thu, 20 Dec 2007 23:24:22 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198020137.8050.203.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_39177_23459782.1198189462857"
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
	<1197853381.8050.58.camel@aeonflux>
	<8a8adccc0712162315v53bf668et553413d6dbc81551@mail.gmail.com>
	<1197918266.8050.90.camel@aeonflux>
	<8a8adccc0712181352u1d802bfava194bf372cb5f232@mail.gmail.com>
	<1198020137.8050.203.camel@aeonflux>
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

------=_Part_39177_23459782.1198189462857
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 19, 2007 12:22 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jaap,
>
> > > > > > > > > Attached patch does the following
> > > > > > > > >
> > > > > > > > > * about dialog code is simpler
> > > > > > > >
> > > > > > > > you can't use gtk_dialog_run for the applet's about dialog. It will
> > > > > > > > block and thus block all PIN requests. The current code is this way for
> > > > > > > > a reason.
> > > > > > >
> > > > > > > Didn't know that. I now use g_object_set which also reduces the amount
> > > > > > > of code considerably.
> > > > > >
> > > > > > You can still use gtk_show_about_dialog(). It removes the close
> > > > > > callback, and makes sure that only one dialogue shows up, and removes a
> > > > > > lot of boiler-plate code (it doesn't use a separate main loop like
> > > > > > gtk_dialog_run does). The gtk_dialog_run avoidance in the callbacks is
> > > > > > still needed.
> > > > >
> > > > > not sure why I haven't done it that way. Maybe it was not available when
> > > > > I wrote the initial version. However now the requirements are GTK 2.10
> > > > > or later. So if we can simplify code, I am all for it.
> > > > >
> > > > Attached two patches
> > > >
> > > > One uses gtk-show-about-dialog
> > >
> > > fix the coding style for this one. I can already see that it messes up
> > > the whitespaces. We use tabs and no whitespace in front of the ( in
> > > function declarations.
> >
> > Attached patch with coding style fixup attached
>
> I don't see the advantage of this patch. Especially with this ugly ifdef
> for the program-name bug, I decided to not apply it.

The "program-name" thing actually solved a bug in GTK+. See [1]
The ugly ifdef you don't have to do if you use g_set_application_name
[2]. Can you explain what's against against using
g_set_application_name? It seems a handy function to me. You call it
once in main and it's set correctly for error dialogs etc.

> Especially the
> license crap is not worth doing it. There is no need that the UI shows
> the license in the about dialog.

As a first time contributor to bluez-gnome I'm confused.

You request me to do all kind of changes,  which I do. I can
understand that because you don't want to spend your time fixing up
patches of others.
You agree with Bastien if it results in simplification its good.  You
ask me to fix the coding style. I do that and also don't use
g_set_application_name because you don't like it. Then you don't apply
it because you say you don't like ifdef and the license.

If you don't count the license code my patch replaces 13 functions
with just 1. Isn't that a simplification?

I'm interested in helping out with bluez-gnome because I think it's a
great app. However if the way this patch got treated is the normal way
I'm not sure if I will have the motivation to submit other patches

Anyway, licenses are shown in many GTK programs. To name a few GIMP,
gedit, nautilus, eog, gnome-terminal, gnome-power-manager, all
gnome-games, gcalculator

But in case you don't want the license. I attached two versions of the
patch. They both use g_set_application_name to remove the #if but one
is with the license and the other isn't.

In case you still don't want g_set_application you can alternatively
bump the GTK+ requirement to 2.12 and use the "program-name" property

> You can still fill in the code for the URL and email hooks to make the
> actually work. I didn't bother so far, because the default screen thing
> seem to be wrong. You should use the screen where the actual about
> dialog is present. However I am not so deep into GDK to tell what is the
> correct way here.
>
I'm no expert either on that. I copied the code from network manager.
Leaving it as it is now in CVS (i.e. about dialog shows the links but
they don't work) doesn't seem like a good idea to me because users are
likely to run into this issue. I'd recommend one of the two following
1. Remove gtk_about_dialog_set_url_hook and gtk_about_dialog_set_email_hook
2. Use the code of the patch I sent you. It might be correct because
it's in Network Manager Applet.

Jaap

[1] http://bugzilla.gnome.org/show_bug.cgi?id=345822
[2] http://library.gnome.org/devel/glib/unstable/glib-Miscellaneous-Utility-Functions.html#g-set-application-name

------=_Part_39177_23459782.1198189462857
Content-Type: text/x-patch;
	name=bluez-gnome-gtk-show-about-dialog-without-license.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fafughfc0
Content-Disposition: attachment;
	filename=bluez-gnome-gtk-show-about-dialog-without-license.patch

SW5kZXg6IGFwcGxldC9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvYXBwbGV0L21haW4uYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45NApkaWZmIC11IC1y
MS45NCBtYWluLmMKLS0tIGFwcGxldC9tYWluLmMJMTkgRGVjIDIwMDcgMDE6MDY6MDUgLTAwMDAJ
MS45NAorKysgYXBwbGV0L21haW4uYwkyMCBEZWMgMjAwNyAyMTozODoxMSAtMDAwMApAQCAtMTUy
NCw0OCArMTUyNCwyMyBAQAogCQkiQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0PiIs
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
OwogCiAJZ3RrX2Fib3V0X2RpYWxvZ19zZXRfdXJsX2hvb2soYWJvdXRfdXJsX2hvb2ssIE5VTEws
IE5VTEwpOwotCiAJZ3RrX2Fib3V0X2RpYWxvZ19zZXRfZW1haWxfaG9vayhhYm91dF9lbWFpbF9o
b29rLCBOVUxMLCBOVUxMKTsKIAotCWd0a19hYm91dF9kaWFsb2dfc2V0X3dlYnNpdGUoR1RLX0FC
T1VUX0RJQUxPRyhkaWFsb2cpLAotCQkJCQkJImh0dHA6Ly93d3cuYmx1ZXoub3JnIik7Ci0KLQln
dGtfYWJvdXRfZGlhbG9nX3NldF93ZWJzaXRlX2xhYmVsKEdUS19BQk9VVF9ESUFMT0coZGlhbG9n
KSwKLQkJCQkJCQkid3d3LmJsdWV6Lm9yZyIpOwotCi0JZ3RrX2Fib3V0X2RpYWxvZ19zZXRfYXV0
aG9ycyhHVEtfQUJPVVRfRElBTE9HKGRpYWxvZyksIGF1dGhvcnMpOwotCi0JZ3RrX2Fib3V0X2Rp
YWxvZ19zZXRfdHJhbnNsYXRvcl9jcmVkaXRzKEdUS19BQk9VVF9ESUFMT0coZGlhbG9nKSwKLQkJ
CQkJCV8oInRyYW5zbGF0b3ItY3JlZGl0cyIpKTsKLQotCWdfc2lnbmFsX2Nvbm5lY3QoZGlhbG9n
LCAiY2xvc2UiLAotCQkJCUdfQ0FMTEJBQ0soY2xvc2VfY2FsbGJhY2spLCBOVUxMKTsKLQotCWdf
c2lnbmFsX2Nvbm5lY3QoZGlhbG9nLCAicmVzcG9uc2UiLAotCQkJCUdfQ0FMTEJBQ0soY2xvc2Vf
Y2FsbGJhY2spLCBOVUxMKTsKLQotCWd0a193aWRnZXRfc2hvd19hbGwoZGlhbG9nKTsKKwlndGtf
c2hvd19hYm91dF9kaWFsb2coTlVMTCwKKwkJCSAgICAgICJ2ZXJzaW9uIiwgVkVSU0lPTiwKKwkJ
CSAgICAgICJjb3B5cmlnaHQiLCAiQ29weXJpZ2h0IFx4YzJceGE5IDIwMDUtMjAwNyBNYXJjZWwg
SG9sdG1hbm4iLAorCQkJICAgICAgImNvbW1lbnRzIiwgXygiQSBCbHVldG9vdGggbWFuYWdlciBm
b3IgdGhlIEdOT01FIGRlc2t0b3AiKSwKKwkJCSAgICAgICJhdXRob3JzIiwgYXV0aG9ycywKKwkJ
CSAgICAgICJ0cmFuc2xhdG9yLWNyZWRpdHMiLCB0cmFuc2xhdG9ycywKKwkJCSAgICAgICJ3ZWJz
aXRlIiwgImh0dHA6Ly93d3cuYmx1ZXoub3JnIiwKKwkJCSAgICAgICJ3ZWJzaXRlLWxhYmVsIiwg
XygiQmx1ZXogV2Vic2l0ZSIpLAorCQkJICAgICAgImxvZ28taWNvbi1uYW1lIiwgInN0b2NrX2Js
dWV0b290aCIsCisJCQkgICAgICBOVUxMKTsKIH0KIAogc3RhdGljIHZvaWQgc2V0dGluZ3NfY2Fs
bGJhY2soR09iamVjdCAqd2lkZ2V0LCBncG9pbnRlciB1c2VyX2RhdGEpCkBAIC0xODM0LDYgKzE4
MDksOCBAQAogCWlmIChpbnN0YW5jZSA9PSBOVUxMKQogCQlndGtfZXhpdCgwKTsKIAorCWdfc2V0
X2FwcGxpY2F0aW9uX25hbWUgKF8oIkJsdWV0b290aCBBcHBsZXQiKSk7CisKIAlndGtfd2luZG93
X3NldF9kZWZhdWx0X2ljb25fbmFtZSgic3RvY2tfYmx1ZXRvb3RoIik7CiAKICNpZmRlZiBIQVZF
X0xJQk5PVElGWQo=
------=_Part_39177_23459782.1198189462857
Content-Type: text/x-patch; name=bluez-gnome-gtk-show-about-dialog.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fafugpu31
Content-Disposition: attachment;
	filename=bluez-gnome-gtk-show-about-dialog.patch

SW5kZXg6IGFwcGxldC9tYWluLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvYXBwbGV0L21haW4uYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45NApkaWZmIC11IC1y
MS45NCBtYWluLmMKLS0tIGFwcGxldC9tYWluLmMJMTkgRGVjIDIwMDcgMDE6MDY6MDUgLTAwMDAJ
MS45NAorKysgYXBwbGV0L21haW4uYwkyMCBEZWMgMjAwNyAyMTozNDoyMCAtMDAwMApAQCAtMTUy
NCw0OCArMTUyNCw0NCBAQAogCQkiQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0PiIs
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
KTsKKwlndGtfc2hvd19hYm91dF9kaWFsb2coTlVMTCwKKwkJCSAgICAgICJ2ZXJzaW9uIiwgVkVS
U0lPTiwKKwkJCSAgICAgICJjb3B5cmlnaHQiLCAiQ29weXJpZ2h0IFx4YzJceGE5IDIwMDUtMjAw
NyBNYXJjZWwgSG9sdG1hbm4iLAorCQkJICAgICAgImNvbW1lbnRzIiwgXygiQSBCbHVldG9vdGgg
bWFuYWdlciBmb3IgdGhlIEdOT01FIGRlc2t0b3AiKSwKKwkJCSAgICAgICJhdXRob3JzIiwgYXV0
aG9ycywKKwkJCSAgICAgICJ0cmFuc2xhdG9yLWNyZWRpdHMiLCB0cmFuc2xhdG9ycywKKwkJCSAg
ICAgICJ3ZWJzaXRlIiwgImh0dHA6Ly93d3cuYmx1ZXoub3JnIiwKKwkJCSAgICAgICJ3ZWJzaXRl
LWxhYmVsIiwgXygiQmx1ZXogV2Vic2l0ZSIpLAorCQkJICAgICAgImxvZ28taWNvbi1uYW1lIiwg
InN0b2NrX2JsdWV0b290aCIsCisJCQkgICAgICAid3JhcC1saWNlbnNlIiwgVFJVRSwKKwkJCSAg
ICAgICJsaWNlbnNlIiwgbGljZW5zZV90cmFucywKKwkJCSAgICAgIE5VTEwpOworCWdfZnJlZShs
aWNlbnNlX3RyYW5zKTsKIH0KIAogc3RhdGljIHZvaWQgc2V0dGluZ3NfY2FsbGJhY2soR09iamVj
dCAqd2lkZ2V0LCBncG9pbnRlciB1c2VyX2RhdGEpCkBAIC0xODM0LDYgKzE4MzAsOCBAQAogCWlm
IChpbnN0YW5jZSA9PSBOVUxMKQogCQlndGtfZXhpdCgwKTsKIAorCWdfc2V0X2FwcGxpY2F0aW9u
X25hbWUgKF8oIkJsdWV0b290aCBBcHBsZXQiKSk7CisKIAlndGtfd2luZG93X3NldF9kZWZhdWx0
X2ljb25fbmFtZSgic3RvY2tfYmx1ZXRvb3RoIik7CiAKICNpZmRlZiBIQVZFX0xJQk5PVElGWQo=

------=_Part_39177_23459782.1198189462857
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------=_Part_39177_23459782.1198189462857
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_39177_23459782.1198189462857--
