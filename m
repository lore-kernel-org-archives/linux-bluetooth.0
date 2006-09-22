Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170609221047m4e0986fdt5c73b898eb84429f@mail.gmail.com>
Date: Fri, 22 Sep 2006 14:47:07 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1158869153.11194.60.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_35801_24103946.1158947227903"
References: <450603BA.3090302@vasmac.com> <1158050613.14015.1.camel@localhost>
	<Pine.LNX.4.63.0609121206040.17868@redbean.intranet.gw-instruments.de>
	<45081402.8020909@vasmac.com>
	<Pine.LNX.4.63.0609141052130.22339@redbean.intranet.gw-instruments.de>
	<1158313791.5233.9.camel@localhost>
	<d23110170609200748u4d16a947q9cfa716825ea44b7@mail.gmail.com>
	<1158764715.10356.0.camel@localhost>
	<d23110170609211259j164c0167ib751ab3ee2f75079@mail.gmail.com>
	<1158869153.11194.60.camel@localhost>
Subject: Re: [Bluez-devel] socket connect returns EAGAIN
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

------=_Part_35801_24103946.1158947227903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Ulisses,
>
> > > what about the server socket. In this case EAGAIN is fine.
> >
> > Yes, in this case EAGAIN is fine. However, I don't think we are even
> > calling bt_sock_wait_state() for a server socket (please, correct me
> > if I'm wrong) so changing EAGAIN to EINPROGRESS inside
> > bt_sock_wait_state() should just work, right? (we just  need to fix
> > rfcomm_session_create() too and that's it).
>
> looks like it is okay, care to send a patch.

Here is the patch. I'm running 2.6.18-mh1 plus the attached patch and
I have no problems so far (but it needs more testing so we can be sure
everything works).

Regards,

-- Ulisses

------=_Part_35801_24103946.1158947227903
Content-Type: text/x-patch; name=eagain-to-einprogress.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esev81fb
Content-Disposition: attachment; filename="eagain-to-einprogress.patch"

ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvYWZfYmx1ZXRvb3RoLmMgYi9uZXQvYmx1ZXRvb3Ro
L2FmX2JsdWV0b290aC5jCmluZGV4IDc4OGVhN2EuLjMwNWEwOTkgMTAwNjQ0Ci0tLSBhL25ldC9i
bHVldG9vdGgvYWZfYmx1ZXRvb3RoLmMKKysrIGIvbmV0L2JsdWV0b290aC9hZl9ibHVldG9vdGgu
YwpAQCAtMjc2LDcgKzI3Niw3IEBAIGludCBidF9zb2NrX3dhaXRfc3RhdGUoc3RydWN0IHNvY2sg
KnNrLCAKIAkJc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJVUFRJQkxFKTsKIAogCQlpZiAo
IXRpbWVvKSB7Ci0JCQllcnIgPSAtRUFHQUlOOworCQkJZXJyID0gLUVJTlBST0dSRVNTOwogCQkJ
YnJlYWs7CiAJCX0KIApkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jIGIv
bmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jCmluZGV4IDMzMmRkOGYuLjQ2OGRmM2IgMTAwNjQ0
Ci0tLSBhL25ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYworKysgYi9uZXQvYmx1ZXRvb3RoL3Jm
Y29tbS9jb3JlLmMKQEAgLTY0NCw3ICs2NDQsNyBAQCBzdGF0aWMgc3RydWN0IHJmY29tbV9zZXNz
aW9uICpyZmNvbW1fc2VzCiAJYWRkci5sMl9mYW1pbHkgPSBBRl9CTFVFVE9PVEg7CiAJYWRkci5s
Ml9wc20gICAgPSBodG9icyhSRkNPTU1fUFNNKTsKIAkqZXJyID0gc29jay0+b3BzLT5jb25uZWN0
KHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikgJmFkZHIsIHNpemVvZihhZGRyKSwgT19OT05CTE9D
Syk7Ci0JaWYgKCplcnIgPT0gMCB8fCAqZXJyID09IC1FQUdBSU4pCisJaWYgKCplcnIgPT0gMCB8
fCAqZXJyID09IC1FSU5QUk9HUkVTUykKIAkJcmV0dXJuIHM7CiAKIAlyZmNvbW1fc2Vzc2lvbl9k
ZWwocyk7Cg==
------=_Part_35801_24103946.1158947227903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_35801_24103946.1158947227903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_35801_24103946.1158947227903--
