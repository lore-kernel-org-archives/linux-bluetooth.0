Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602170948g37751aaeg7784484f5564eef2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
In-Reply-To: <e1effdeb0602161041i14382295l2eda08be4a515e3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8_17655912.1140198497887"
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
	 <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
	 <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
	 <1140025571.26072.94.camel@localhost>
	 <e1effdeb0602161041i14382295l2eda08be4a515e3d@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 17 Feb 2006 15:48:17 -0200

------=_Part_8_17655912.1140198497887
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is a patch to fix a small bug that skipped :)
I was not able to check this because the patch to fix the remove watch
 was required. When I sent the patch(timeout03.patch) the solution for
fix the remove watch function was not ready.

This patch fix the following bug:
With the hcid running restart the dbus-daemon before the discoverable
timeout expires. When the dbus-daemon is restarted the paths are
registered again, thefore the dbus_data stored in the path is
overwritten and the handler_timeout pointer becomes NULL.
The side-effect is turn off the timer and the discoverable mode will
be changed to connectable mode!

Regards,
Claudio

On 2/16/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>
> Here is the patch based on the registered D-Bus paths.
>
> This patch is working fine, except for the following case:
> After restart the D-Bus daemon, the paths are being registered
> properly. However, if you remove and after add the dongle the HCI
> events is not being received by the hcid anymore. This problem happens
> with older hcid versions too :-) I lost some hours trying to fix this
> weird problem.
>
> How reproduce the error:
> pre-condition: at least one dongle connected.
> 1. start the hcid "hcid -n"
> 2. restart the dbus-daemon "$/etc/init.d/dbus-1 restart"
> 3. remove and add the dongle. Note that the HCI removed/added device
> event are not received. If you run the hciconfig command you can see
> that the device is DOWN.
> Do you have any idea of what is happening? IMHO, it seems to a problem
> related to main loop add/remove watches function. I will investigate
> more and try give you a feedback later.
>
> I investigated how other applications are handling the D-Bus
> Disconnect event. All applications are exiting :-) Some linux
> distributions are changed the /etc/init.d/dbus-1including command to
> start the daemons(avahi, hald, ...). If we don't fix this bug, we can
> try use this approach :-)
>
> Do you have another comments about this patch?
>
> Regards,
> Claudio.
>
> On 2/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
> > > Here is patch to get/set the discoverable timeout.
> >
> > the patch is applied to the CVS, but you should watch out for compiler
> > warnings. They help you to find some bugs ;)
> >
> > dbus.c: In function 'register_dbus_path':
> > dbus.c:227: warning: assignment makes integer from pointer without a ca=
st
> >
> > > Currently, there isn't verification for a valid value range. Do you
> > > think that it is required?
> > > Should we define a minimum and a maximum value?
> >
> > I don't know. We will see.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_8_17655912.1140198497887
Content-Type: text/x-patch; name="timeout04.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="timeout04.patch"
X-Attachment-Id: f_ejsm5yv7

LS0tIGJsdWV6LXV0aWxzLWN2cy5vcmlnL2hjaWQvZGJ1cy5jCTIwMDYtMDItMTcgMTE6MzE6MDYu
MDAwMDAwMDAwIC0wMjAwCisrKyBibHVlei11dGlscy1jdnMtdGltZXIvaGNpZC9kYnVzLmMJMjAw
Ni0wMi0xNyAxMjo0MzozNC4wMDAwMDAwMDAgLTAyMDAKQEAgLTY3LDYgKzY3LDExIEBACiAJYmRh
ZGRyX3QgYmRhOwogfTsKIAorLyoKKyAqIFRpbWVvdXQgZnVuY3Rpb25zIFByb3R5cGVzCisgKi8K
K3N0YXRpYyBpbnQgZGlzY292ZXJhYmxlX3RpbWVvdXRfaGFuZGxlcih2b2lkICpkYXRhKTsKKwog
REJ1c0Nvbm5lY3Rpb24gKmdldF9kYnVzX2Nvbm5lY3Rpb24odm9pZCkKIHsKIAlyZXR1cm4gY29u
bmVjdGlvbjsKQEAgLTMxNSw2ICszMjAsMTMgQEAKIAllbHNlCiAJCXBkYXRhLT5tb2RlID0gcnAu
ZW5hYmxlOwkvKiBLZWVwIHRoZSBjdXJyZW50IHNjYW4gc3RhdHVzICovCiAKKwkvKiAKKwkgKiBF
bmFibGUgdGltZW91dCB0byBhZGRyZXNzIGRidXMgZGFlbW9uIHJlc3RhcnQsIHdoZXJlCisJICog
cmVnaXN0ZXIgdGhlIGRldmljZSBwYXRocyBpcyByZXF1aXJlZCBkdWUgY29ubmVjdGlvbiBsb3N0
LgorCSAqLworCWlmIChwZGF0YS0+bW9kZSAmIFNDQU5fSU5RVUlSWSkKKwkJcGRhdGEtPnRpbWVv
dXRfaGFuZGxlciA9ICZkaXNjb3ZlcmFibGVfdGltZW91dF9oYW5kbGVyOworCiAJbWVzc2FnZSA9
IGRidXNfbWVzc2FnZV9uZXdfc2lnbmFsKE1BTkFHRVJfUEFUSCwgTUFOQUdFUl9JTlRFUkZBQ0Us
CiAJCQkJCQkJQkxVRVpfTUdSX0RFVl9BRERFRCk7CiAJaWYgKG1lc3NhZ2UgPT0gTlVMTCkgewo=

------=_Part_8_17655912.1140198497887--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
