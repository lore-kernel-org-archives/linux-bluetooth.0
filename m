Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0611101338v1902b247if13f2239622f1a3a@mail.gmail.com>
Date: Fri, 10 Nov 2006 18:38:06 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb0611101009t24de879fk3bca7ed96821514e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_60863_453591.1163194686855"
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610241647.20895.denis.kenzior@trolltech.com>
	<1162214837.24333.69.camel@localhost>
	<200611091149.13916.denis.kenzior@trolltech.com>
	<e1effdeb0611101009t24de879fk3bca7ed96821514e@mail.gmail.com>
Subject: Re: [Bluez-devel] Proposed DTD
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

------=_Part_60863_453591.1163194686855
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/10/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> On 11/8/06, Denis KENZIOR <denis.kenzior@trolltech.com> wrote:
> > Marcel,
> >
> > On Monday 30 October 2006 23:27, Marcel Holtmann wrote:
> > > Hi Denis,
> > >
> > >
> > > to get this started, I like to see the method
> > >
> > > string GetRemoteServiceRecordAsXML(string address, uint32 handle)
> > >
> > > from the org.bluez.Adapter interface gets implemented and make it using
> > > the simple service-record.dtd I put into the CVS.
> >
> > Here's a patch that imlements
> >
> > string GetRemoteServiceRecordAsXML(string address, uint32 handle)
> >
> > >
> > > I choose to simplify the DTD a lot. After having a discussion about XML
> >
> > Yes, I saw this.  I have made some changes to the DTD however.  Mainly I've
> > added the int* data types and have removed the 'data' type since it was not
> > used anywhere anymore.
> >
> > > and binary representation from the SDP part of the specification, I am
> > > pretty certain, that we should support both. The binary representation
> > > will cover all tasks ever possible with SDP and it is the default. For
> > > convenience we will additionally support XML as record description, but
> > > it will only cover up to 90% of all cases, but it will be simpler to use
> > > and easier to understand and that should be fine.
> > >
> >
> > I'm concerned about this.  BlueZ dbus developers have explicitly and
> > repeatedly stated that their intent is to make the dbus interface as
> > high-level as possible.  This is why the interface is so nice and easy to
> > use, particularly from languages other than C.  Binary SDP record
> > representation/registration just does not fit.  I would strongly encourage
> > that we adopt an XML format for both view and registration of SDP records,
> > and that it should be the default.
> >
> > There's also the issue of GPL.  Anybody who wants to create such binary
> > records and cannot link against the GPL'd libbluetooth would need to spend
> > (perhaps considerable) time duplicating what is already there in order to
> > produce such data structures.
> >
> > > This means that all length fields are not represented in XML. They will
> > > be chosen automatically as needed. The same applies to the UUID. So it
> > > leaves only int* and uint* where the actual size will be taken care of
> > > as part of the type name.
> >
> > I totally agree with this and this was my original thought as well.  Hopefully
> > the dtd is getting closer to being finalized.  This reminds me, do you still
> > want to base sdptool on XML if an appropriate (no external dependency) parser
> > is written?  I don't want to spend time on this unless it is wanted and the
> > DTD is stabilized.
> >
> > Regards,
> > Denis
> >
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
> >
> >
>
> Hi Denis,
>
> the patch is in cvs now!
>
> The sdp-xml.* were moved to common directory.
>
> Some points to be improved:
> 1. append_and_grow_string: avoid a lot of strlen calls and string copy
> 2. Analyze if it is possible use sdp_buf_t instead of string_t
> 3. I got some system bus disconnection messages when calling
> GetRemoteServiceRecordAsXML consecutively. We need fix this bug.
>
> BR,
> Claudio.
> --

Hi Marcel, Denis,

this patch replaces string_t by sdp_buf_t and fix system bus
disconnection problem. Check if this patch make sense or if it is
better keep  string_t.

BR,
Claudio
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_60863_453591.1163194686855
Content-Type: text/x-patch; name=remove_string_t.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eud3ukdd
Content-Disposition: attachment; filename="remove_string_t.patch"

SW5kZXg6IGhjaWQvZGJ1cy1zZHAuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9ibHVl
ei91dGlscy9oY2lkL2RidXMtc2RwLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNTUKZGlmZiAt
dSAtcjEuNTUgZGJ1cy1zZHAuYwotLS0gaGNpZC9kYnVzLXNkcC5jCTEwIE5vdiAyMDA2IDE3OjU5
OjE1IC0wMDAwCTEuNTUKKysrIGhjaWQvZGJ1cy1zZHAuYwkxMCBOb3YgMjAwNiAyMToyMTowMyAt
MDAwMApAQCAtNTgsNyArNTgsNiBAQAogI2luY2x1ZGUgInNkcC14bWwuaCIKIAogI2RlZmluZSBN
QVhfSURFTlRJRklFUl9MRU4JMjkJLyogIlhYOlhYOlhYOlhYOlhYOlhYLzB4WVlZWVlZWVlcMCIg
Ki8KLSNkZWZpbmUgREVGQVVMVF9YTUxfQlVGRkVSX1NJWkUgMTAyNAogCiBzdHJ1Y3Qgc2Vydmlj
ZV9wcm92aWRlciB7CiAJY2hhciAqb3duZXI7CS8qIG51bGwgZm9yIHJlbW90ZSBzZXJ2aWNlcyBv
ciB1bmlxdWUgbmFtZSBpZiBsb2NhbCAqLwpAQCAtMTAwLDMxICs5OSwyNiBAQAogCWNoYXIgICAg
ICAgICAgICAqaW5mb19uYW1lOwogfSBzZHBfc2VydmljZV90OwogCi10eXBlZGVmIHN0cnVjdCB7
Ci0JaW50IHNpemU7Ci0JY2hhciAqc3RyOwotfSBzdHJpbmdfdDsKLQogc3RhdGljIHZvaWQgYXBw
ZW5kX2FuZF9ncm93X3N0cmluZyh2b2lkICpkYXRhLCBjb25zdCBjaGFyICpzdHIpCiB7Ci0Jc3Ry
aW5nX3QgKnN0cmluZyA9IChzdHJpbmdfdCAqKWRhdGE7Ci0JY2hhciAqbmV3YnVmOworCXNkcF9i
dWZfdCAqYnVmZiA9IChzZHBfYnVmX3QgKikgZGF0YTsKKwlpbnQgbGVuOwogCi0JaW50IG9sZGxl
biA9IHN0cmxlbihzdHJpbmctPnN0cik7Ci0JaW50IG5ld2xlbiA9IHN0cmxlbihzdHIpOwotCQot
CWlmICgob2xkbGVuICsgbmV3bGVuICsgMSkgPiBzdHJpbmctPnNpemUpIHsKLQkJbmV3YnVmID0g
KGNoYXIgKikgbWFsbG9jKHN0cmluZy0+c2l6ZSAqIDIpOwotCQlpZiAoIW5ld2J1ZikKLQkJCXJl
dHVybjsKKwlsZW4gPSBzdHJsZW4oc3RyKTsKIAotCQltZW1jcHkobmV3YnVmLCBzdHJpbmctPnN0
ciwgb2xkbGVuKzEpOwotCQlzdHJpbmctPnNpemUgKj0gMjsKLQkJZnJlZShzdHJpbmctPnN0cik7
Ci0JCXN0cmluZy0+c3RyID0gbmV3YnVmOwkJCisJaWYgKGJ1ZmYtPmJ1Zl9zaXplIDwgKGJ1ZmYt
PmRhdGFfc2l6ZSArIGxlbiArIDEpKSB7CisJCWlmICghYnVmZi0+YnVmX3NpemUpCisJCQlidWZm
LT5idWZfc2l6ZSA9IDE7CisKKwkJYnVmZi0+YnVmX3NpemUgKz0gbGVuOworCQlidWZmLT5kYXRh
ID0gcmVhbGxvYyhidWZmLT5kYXRhLCBidWZmLT5idWZfc2l6ZSk7CisJCWlmICghYnVmZi0+ZGF0
YSkKKwkJCXJldHVybjsKIAl9CiAKLQlzdHJjYXQoc3RyaW5nLT5zdHIsIHN0cik7CisJLyogSW5j
bHVkZSB0aGUgTlVMTCBjaGFyYWN0ZXIgKi8KKwltZW1jcHkoYnVmZi0+ZGF0YSArIGJ1ZmYtPmRh
dGFfc2l6ZSwgc3RyLCBsZW4gKyAxKTsKKwlidWZmLT5kYXRhX3NpemUgKz0gbGVuOwogfQogCiAv
KiBGSVhNRTogIG1vdmUgdG8gYSBjb21tb24gZmlsZSAqLwpAQCAtNjQ4LDggKzY0Miw4IEBACiAJ
REJ1c01lc3NhZ2UgKnJlcGx5OwogCWNvbnN0IGNoYXIgKmRzdDsKIAlpbnQgc2Nhbm5lZDsKLQlz
dHJpbmdfdCByZXN1bHQ7Ci0JCisJc2RwX2J1Zl90IHJlc3VsdDsKKwogCWlmICghY3R4dCkKIAkJ
cmV0dXJuOwogCkBAIC02ODUsNyArNjc5LDYgQEAKIAogCXJlcGx5ID0gZGJ1c19tZXNzYWdlX25l
d19tZXRob2RfcmV0dXJuKGN0eHQtPnJxKTsKIAotCXJlc3VsdC5zdHIgPSAwOwogCQogCXJlYyA9
IHNkcF9leHRyYWN0X3BkdShyc3AsICZzY2FubmVkKTsKIAlpZiAocmVjID09IE5VTEwpIHsKQEAg
LTY5MywyMCArNjg2LDIxIEBACiAJCWdvdG8gZG9uZTsKIAl9CiAKLQlyZXN1bHQuc3RyID0gbWFs
bG9jKHNpemVvZihjaGFyKSAqIERFRkFVTFRfWE1MX0JVRkZFUl9TSVpFKTsKLQlyZXN1bHQuc2l6
ZSA9IERFRkFVTFRfWE1MX0JVRkZFUl9TSVpFOwotCQorCW1lbXNldCgmcmVzdWx0LCAwLCBzaXpl
b2Yoc2RwX2J1Zl90KSk7CisKIAlzZHBfY2FjaGVfYXBwZW5kKE5VTEwsIGRzdCwgcmVjKTsKIAog
CWNvbnZlcnRfc2RwX3JlY29yZF90b194bWwocmVjLCAmcmVzdWx0LCBhcHBlbmRfYW5kX2dyb3df
c3RyaW5nKTsKIAotCWRidXNfbWVzc2FnZV9hcHBlbmRfYXJncyhyZXBseSwKLQkJREJVU19UWVBF
X1NUUklORywgJnJlc3VsdC5zdHIsCi0JCURCVVNfVFlQRV9JTlZBTElEKTsKKwlpZiAocmVzdWx0
LmRhdGEpIHsKKwkJZGJ1c19tZXNzYWdlX2FwcGVuZF9hcmdzKHJlcGx5LAorCQkJCURCVVNfVFlQ
RV9TVFJJTkcsICZyZXN1bHQuZGF0YSwKKwkJCQlEQlVTX1RZUEVfSU5WQUxJRCk7CiAKKwkJZnJl
ZShyZXN1bHQuZGF0YSk7CisJfQogZG9uZToKIAlzZW5kX21lc3NhZ2VfYW5kX3VucmVmKGN0eHQt
PmNvbm4sIHJlcGx5KTsKLQlmcmVlKHJlc3VsdC5zdHIpOwogZmFpbGVkOgogCXRyYW5zYWN0aW9u
X2NvbnRleHRfZnJlZShjdHh0KTsKIH0K
------=_Part_60863_453591.1163194686855
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_60863_453591.1163194686855
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_60863_453591.1163194686855--
