Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <1598723318.20050407211922@andric.com>
To: Marcel Holtmann <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Add sdptool option for browsing with L2CAP_UUID
In-Reply-To: <1112881490.9047.73.camel@pegasus>
References: <381006269.20050404171656@andric.com>
 <1112714837.12406.51.camel@notepaq>  <1542380074.20050407140838@andric.com>
 <1112881490.9047.73.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------8E1D28E2B42F15"
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
Date: Thu, 7 Apr 2005 21:19:22 +0200

------------8E1D28E2B42F15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 2005-04-07 at 15:44:50 Marcel Holtmann wrote:

> Maybe we should add somekind of short name to UUID translation function,
> because the numeric values are hard to remember.

Here's an easy hack: I reused the existing uuid16_names array for
looking up (partial) matches.  You can also get a list of recognized
names.  If you think it would be nicer to add a separate name list
(i.e. made from the names in sdp.h), let me know.

------------8E1D28E2B42F15
Content-Type: text/plain; name="bluez-utils-2.15-sdpbrowse-uuid2.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="bluez-utils-2.15-sdpbrowse-uuid2.patch"

IyBibHVlei11dGlscy0yLjE1LXNkcGJyb3dzZS11dWlkMi5wYXRjaAojCiMgRXh0ZW5kIHRo
ZSAtLXV1aWQgb3B0aW9uIG9mIHNkcHRvb2wgYnJvd3NlLCB0byBhZGRpdGlvbmFsbHkgcmVj
b2duaXplIHV1aWQncwojIGJ5IG5hbWUgaW5zdGVhZCBvZiBudW1iZXIuICBUaGUgZXhpc3Rp
bmcgdXVpZDE2X25hbWVzIGFycmF5IGlzIHVzZWQgZm9yIHRoaXMKIyBwdXJwb3NlLiAgWW91
IGRvbid0IGhhdmUgdG8gc3BlY2lmeSB0aGUgZnVsbCBuYW1lLCBhcyBsb25nIGFzIGl0IG1h
dGNoZXMKIyB1bmFtYmlndW91c2x5LiAgQWxzbywgYnkgc3BlY2lmeWluZyAiLS11dWlkIGxp
c3QiLCB5b3UgY2FuIGdldCBhIGZ1bGwgbGlzdCBvZgojIGF2YWlsYWJsZSB1dWlkIG5hbWVz
LgojCiMgRGltaXRyeSBBbmRyaWMgPGRpbWl0cnlAYW5kcmljLmNvbT4sIDIwMDUtMDQtMDcg
MjE6MDU6MzUKCkluZGV4OiB0b29scy9zZHB0b29sLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2c3Jvb3QvYmx1ZXovdXRpbHMvdG9vbHMvc2RwdG9vbC5jLHYKcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjIxCmRpZmYgLXUgLWQgLXIxLjIxIHNkcHRvb2wuYwotLS0gdG9vbHMvc2Rw
dG9vbC5jCTcgQXByIDIwMDUgMTM6NDM6MjMgLTAwMDAJMS4yMQorKysgdG9vbHMvc2RwdG9v
bC5jCTcgQXByIDIwMDUgMTk6MDM6MzQgLTAwMDAKQEAgLTIxMDMsNyArMjEwMyw4IEBACiAK
IHN0YXRpYyBjaGFyICpicm93c2VfaGVscCA9IAogCSJVc2FnZTpcbiIKLQkiXHRicm93c2Ug
Wy0tdHJlZV0gWy0tdXVpZCB1dWlkXSBbLS1sMmNhcF0gW2JkYWRkcl1cbiI7CisJIlx0YnJv
d3NlIFstLXRyZWVdIFstLXV1aWQgdXVpZF0gWy0tbDJjYXBdIFtiZGFkZHJdXG4iCisJIlVz
ZSAtLXV1aWQgbGlzdCB0byBnZXQgYSBsaXN0IG9mIHBvc3NpYmxlIFVVSURzXG4iOwogCiAv
KgogICogQnJvd3NlIHRoZSBmdWxsIFNEUCBkYXRhYmFzZSAoaS5lLiBsaXN0IGFsbCBzZXJ2
aWNlcyBzdGFydGluZyBmcm9tIHRoZQpAQCAtMjExMiw3ICsyMTEzLDcgQEAKIHN0YXRpYyBp
bnQgY21kX2Jyb3dzZShpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAJc3RydWN0IHNlYXJj
aF9jb250ZXh0IGNvbnRleHQ7Ci0JaW50IG9wdCwgbnVtOworCWludCBvcHQsIGk7CiAKIAkv
KiBJbml0aWFsaXNlIGNvbnRleHQgKi8KIAltZW1zZXQoJmNvbnRleHQsICdcMCcsIHNpemVv
ZihzdHJ1Y3Qgc2VhcmNoX2NvbnRleHQpKTsKQEAgLTIxMjUsMTEgKzIxMjYsMzQgQEAKIAkJ
CWNvbnRleHQudHJlZSA9IDE7CiAJCQlicmVhazsKIAkJY2FzZSAndSc6Ci0JCQlpZiAoc3Nj
YW5mKG9wdGFyZywgIiVpIiwgJm51bSkgIT0gMSB8fCBudW0gPCAwIHx8IG51bSA+IDB4ZmZm
ZikgewotCQkJCXByaW50ZigiSW52YWxpZCB1dWlkICVzXG4iLCBvcHRhcmcpOworCQkJaWYg
KCFzdHJjYXNlY21wKG9wdGFyZywgImxpc3QiKSkgeworCQkJCWZvciAoaSA9IDA7IGkgPCB1
dWlkMTZfbWF4OyArK2kpCisJCQkJCXByaW50ZigiMHglMDR4OiAlc1xuIiwgdXVpZDE2X25h
bWVzW2ldLm51bSwgdXVpZDE2X25hbWVzW2ldLm5hbWUpOwogCQkJCXJldHVybiAtMTsKKwkJ
CX0gZWxzZSBpZiAoc3NjYW5mKG9wdGFyZywgIiVpIiwgJmkpID09IDEpIHsKKwkJCQlpZiAo
aSA8IDAgfHwgaSA+IDB4ZmZmZikgeworCQkJCQlwcmludGYoIkludmFsaWQgdXVpZCAlc1xu
Iiwgb3B0YXJnKTsKKwkJCQkJcmV0dXJuIC0xOworCQkJCX0KKwkJCQlzZHBfdXVpZDE2X2Ny
ZWF0ZSgmY29udGV4dC5ncm91cCwgaSk7CisJCQl9IGVsc2UgeworCQkJCWludCBsZW4gPSBz
dHJsZW4ob3B0YXJnKTsKKwkJCQlpbnQgbWF0Y2ggPSAtMTsKKwkJCQlmb3IgKGkgPSAwOyBp
IDwgdXVpZDE2X21heDsgKytpKSB7CisJCQkJCWlmICghc3RybmNhc2VjbXAob3B0YXJnLCB1
dWlkMTZfbmFtZXNbaV0ubmFtZSwgbGVuKSkgeworCQkJCQkJaWYgKG1hdGNoID49IDApIHsK
KwkJCQkJCQlwcmludGYoIkFtYmlndW91cyB1dWlkICVzXG4iLCBvcHRhcmcpOworCQkJCQkJ
CXJldHVybiAtMTsKKwkJCQkJCX0KKwkJCQkJCW1hdGNoID0gaTsKKwkJCQkJfQorCQkJCX0K
KwkJCQlpZiAobWF0Y2ggPCAwKSB7CisJCQkJCXByaW50ZigiSW52YWxpZCB1dWlkICVzXG4i
LCBvcHRhcmcpOworCQkJCQlyZXR1cm4gLTE7CisJCQkJfQorCQkJCXNkcF91dWlkMTZfY3Jl
YXRlKCZjb250ZXh0Lmdyb3VwLCB1dWlkMTZfbmFtZXNbbWF0Y2hdLm51bSk7CiAJCQl9Ci0J
CQlzZHBfdXVpZDE2X2NyZWF0ZSgmY29udGV4dC5ncm91cCwgbnVtKTsKIAkJCWJyZWFrOwog
CQljYXNlICdsJzoKIAkJCXNkcF91dWlkMTZfY3JlYXRlKCZjb250ZXh0Lmdyb3VwLCBMMkNB
UF9VVUlEKTsK

------------8E1D28E2B42F15--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
