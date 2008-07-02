Return-Path: <cyrus@holtmann.org>
Message-ID: <486BCD3C.7090203@endrelia.com>
Date: Wed, 02 Jul 2008 14:47:24 -0400
From: Frank Mandarino <fmandarino@endrelia.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <004b01c8da77$c65e95b0$531bc110$%park@samsung.com>
	<1214806529.11537.12.camel@violet.holtmann.net>
In-Reply-To: <1214806529.11537.12.camel@violet.holtmann.net>
Content-Type: multipart/mixed; boundary="------------030003070806070906000808"
Subject: Re: [Bluez-devel] bccmd(csr_bcsp.c) bug Report
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
--------------030003070806070906000808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Marcel Holtmann wrote:
> Hi,
> 
>> I think that do_command function (csr_bcsp.c) could have a problem 
>>
>> if we receive both UBCSP_PACKET_SENT and UBCSP_PACKET_RECEIVED
>> simultaneously from ubcsp_poll function.
>>
>> An expected scenario is that UBCSP_PACKET_SENT comes earlier than
>> UBCSP_PACKET_RECEIVED.
>>
>> But if we get them at the same time this could be a problem because
>> “sent=1” is located after checking “sent==1”.
>>
>> It means that this program doesn’t know UBCSP_PACKET_SENT even if we
>> already receive it.
> 
> please sent a patch (unified diff) for it.
> 
> Regards
> 
> Marcel

Hi Marcel,

I sent in a patch for this back in August 2006
(http://article.gmane.org/gmane.linux.bluez.devel/8836).

The patch still applies to the latest CVS source.  I have attached it to
this post.

Regards
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada

--------------030003070806070906000808
Content-Type: text/plain;
 name="csr_bcsp.c.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="csr_bcsp.c.txt"

SW5kZXg6IHV0aWxzL3Rvb2xzL2Nzcl9iY3NwLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTog
L2N2c3Jvb3QvYmx1ZXovdXRpbHMvdG9vbHMvY3NyX2Jjc3AuYyx2CnJldHJpZXZpbmcgcmV2
aXNpb24gMS42CmRpZmYgLXUgLXIxLjYgY3NyX2Jjc3AuYwotLS0gdXRpbHMvdG9vbHMvY3Ny
X2Jjc3AuYwkyNiBKdWwgMjAwNiAxMzozMjo0NSAtMDAwMAkxLjYKKysrIHV0aWxzL3Rvb2xz
L2Nzcl9iY3NwLmMJMzAgQXVnIDIwMDYgMTU6MDY6NTYgLTAwMDAKQEAgLTE4OCwxOSArMTg4
LDYgQEAKIAl3aGlsZSAoMSkgewogCQlkZWxheSA9IHViY3NwX3BvbGwoJmFjdGl2aXR5KTsK
IAotCQlpZiAoYWN0aXZpdHkgJiBVQkNTUF9QQUNLRVRfUkVDRUlWRUQpIHsKLQkJCWlmIChz
ZW50ICYmIHJlY2VpdmVfcGFja2V0LmNoYW5uZWwgPT0gNSAmJgotCQkJCQlyZWNlaXZlX3Bh
Y2tldC5wYXlsb2FkWzBdID09IDB4ZmYpIHsKLQkJCQltZW1jcHkocnAsIHJlY2VpdmVfcGFj
a2V0LnBheWxvYWQsCi0JCQkJCQkJcmVjZWl2ZV9wYWNrZXQubGVuZ3RoKTsKLQkJCQlicmVh
azsKLQkJCX0KLQotCQkJcmVjZWl2ZV9wYWNrZXQubGVuZ3RoID0gNTEyOwotCQkJdWJjc3Bf
cmVjZWl2ZV9wYWNrZXQoJnJlY2VpdmVfcGFja2V0KTsKLQkJCXRpbWVvdXQgPSAwOwotCQl9
Ci0KIAkJaWYgKGFjdGl2aXR5ICYgVUJDU1BfUEFDS0VUX1NFTlQpIHsKIAkJCXN3aXRjaCAo
dmFyaWQpIHsKIAkJCWNhc2UgQ1NSX1ZBUklEX0NPTERfUkVTRVQ6CkBAIC0yMTQsNiArMjAx
LDE5IEBACiAJCQl0aW1lb3V0ID0gMDsKIAkJfQogCisJCWlmIChhY3Rpdml0eSAmIFVCQ1NQ
X1BBQ0tFVF9SRUNFSVZFRCkgeworCQkJaWYgKHNlbnQgJiYgcmVjZWl2ZV9wYWNrZXQuY2hh
bm5lbCA9PSA1ICYmCisJCQkJCXJlY2VpdmVfcGFja2V0LnBheWxvYWRbMF0gPT0gMHhmZikg
eworCQkJCW1lbWNweShycCwgcmVjZWl2ZV9wYWNrZXQucGF5bG9hZCwKKwkJCQkJCQlyZWNl
aXZlX3BhY2tldC5sZW5ndGgpOworCQkJCWJyZWFrOworCQkJfQorCisJCQlyZWNlaXZlX3Bh
Y2tldC5sZW5ndGggPSA1MTI7CisJCQl1YmNzcF9yZWNlaXZlX3BhY2tldCgmcmVjZWl2ZV9w
YWNrZXQpOworCQkJdGltZW91dCA9IDA7CisJCX0KKwogCQlpZiAoZGVsYXkpIHsKIAkJCXVz
bGVlcChkZWxheSAqIDEwMCk7CiAK
--------------030003070806070906000808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--------------030003070806070906000808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030003070806070906000808--
