Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <1542380074.20050407140838@andric.com>
To: Marcel Holtmann <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add sdptool option for browsing with L2CAP_UUID
In-Reply-To: <1112714837.12406.51.camel@notepaq>
References: <381006269.20050404171656@andric.com>
 <1112714837.12406.51.camel@notepaq>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------EDDA2133127623D"
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
Date: Thu, 7 Apr 2005 14:08:38 +0200

------------EDDA2133127623D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 2005-04-05 at 17:27:17 Marcel Holtmann wrote:

> the patch is applied to the CVS. Maybe we should add another one to
> browse any UUID in general. Something like "--uuid 0x0003" for example.

Here is a patch that adds such an option.  It will be interesting to
see what browse info is returned with various weird uuid's. :)

------------EDDA2133127623D
Content-Type: text/plain; name="bluez-utils-2.15-sdpbrowse-uuid.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="bluez-utils-2.15-sdpbrowse-uuid.patch"

IyBibHVlei11dGlscy0yLjE1LXNkcGJyb3dzZS11dWlkLnBhdGNoCiMKIyBUaGlzIHBhdGNo
IGFkZHMgYSBgLS11dWlkJyBjb21tYW5kIGxpbmUgb3B0aW9uIHRvIHNkcHRvb2wsIHRvIHNw
ZWNpZnkgdGhlCiMgdXVpZCBvZiBhbiBhcmJpdHJhcnkgcHJvdG9jb2wgZm9yIGJyb3dzaW5n
LCBpbnN0ZWFkIG9mIFBVQkxJQ19CUk9XU0VfR1JPVVAuCiMgVGhlIHV1aWQgY2FuIGJlIHNw
ZWNpZmllZCBpbiBkZWNpbWFsLCBoZXggKHVzaW5nIGEgJzB4JyBwcmVmaXgpIG9yIG9jdGFs
CiMgKHVzaW5nIGEgJzAnIHByZWZpeCkuCiMKIyBEaW1pdHJ5IEFuZHJpYyA8ZGltaXRyeUBh
bmRyaWMuY29tPiwgMjAwNS0wNC0wNyAxMzo1OToyMQoKSW5kZXg6IHRvb2xzL3NkcHRvb2wu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9ibHVlei91dGlscy90b29scy9z
ZHB0b29sLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjAKZGlmZiAtdSAtZCAtcjEuMjAg
c2RwdG9vbC5jCi0tLSB0b29scy9zZHB0b29sLmMJNSBBcHIgMjAwNSAxNToyMDoxMCAtMDAw
MAkxLjIwCisrKyB0b29scy9zZHB0b29sLmMJNyBBcHIgMjAwNSAxMTo1NjoyNyAtMDAwMApA
QCAtMjA5NywxMiArMjA5NywxMyBAQAogCXsgImhlbHAiLCAgICAwLDAsICdoJyB9LAogCXsg
InRyZWUiLCAgICAwLDAsICd0JyB9LAogCXsgImwyY2FwIiwgICAwLDAsICdsJyB9LAorCXsg
InV1aWQiLCAgICAxLDAsICd1JyB9LAogCXsgMCwgMCwgMCwgMCB9CiB9OwogCiBzdGF0aWMg
Y2hhciAqYnJvd3NlX2hlbHAgPSAKIAkiVXNhZ2U6XG4iCi0JIlx0YnJvd3NlIFstLXRyZWVd
IFstLWwyY2FwXSBbYmRhZGRyXVxuIjsKKwkiXHRicm93c2UgWy0tdHJlZV0gWy0tbDJjYXBd
IFstLXV1aWQgdXVpZF0gW2JkYWRkcl1cbiI7CiAKIC8qCiAgKiBCcm93c2UgdGhlIGZ1bGwg
U0RQIGRhdGFiYXNlIChpLmUuIGxpc3QgYWxsIHNlcnZpY2VzIHN0YXJ0aW5nIGZyb20gdGhl
CkBAIC0yMTEyLDYgKzIxMTMsNyBAQAogewogCXN0cnVjdCBzZWFyY2hfY29udGV4dCBjb250
ZXh0OwogCWludCBvcHQ7CisJaW50IG51bTsKIAogCS8qIEluaXRpYWxpc2UgY29udGV4dCAq
LwogCW1lbXNldCgmY29udGV4dCwgJ1wwJywgc2l6ZW9mKHN0cnVjdCBzZWFyY2hfY29udGV4
dCkpOwpAQCAtMjEyNiw2ICsyMTI4LDEzIEBACiAJCWNhc2UgJ2wnOgogCQkJc2RwX3V1aWQx
Nl9jcmVhdGUoJmNvbnRleHQuZ3JvdXAsIEwyQ0FQX1VVSUQpOwogCQkJYnJlYWs7CisJCWNh
c2UgJ3UnOgorCQkJaWYgKHNzY2FuZihvcHRhcmcsICIlaSIsICZudW0pICE9IDEgfHwgbnVt
IDwgMCB8fCBudW0gPiAweGZmZmYpIHsKKwkJCQlwcmludGYoIkludmFsaWQgdXVpZCAlc1xu
Iiwgb3B0YXJnKTsKKwkJCQlyZXR1cm4gLTE7CisJCQl9CisJCQlzZHBfdXVpZDE2X2NyZWF0
ZSgmY29udGV4dC5ncm91cCwgbnVtKTsKKwkJCWJyZWFrOwogCQlkZWZhdWx0OgogCQkJcHJp
bnRmKGJyb3dzZV9oZWxwKTsKIAkJCXJldHVybiAtMTsK

------------EDDA2133127623D--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
