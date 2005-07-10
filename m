Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9NOFRPSVVWEEGN40G3PL"
Message-Id: <20050710224918.A15613CE@arbetsmyra.dyndns.org>
Subject: [Bluez-devel] Strange hci_get_route() result
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
Date: Mon, 11 Jul 2005 00:47:33 +0200


--------------Boundary-00=_9NOFRPSVVWEEGN40G3PL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 



Hi
On my system there's something fishy going on with the library function 
"hci_get_route()". When I use several dongels simultaneously it returns 
wrong value. I might be doing things wrong too of cource. This code 
below:
	str2ba("00:11:22:33:44:55", &ba);
	dev_id = hci_get_route(&ba);
	printf("%d\n", dev_id);

Prints "-1" as device id when I have one dongle attached and it prints 
"1" when I've got two. Both are incorrect, it should be 0.

However, if I apply the patch below it works much better. I find it 
very strange though if such a basic function is buggy, so what 
am I doing wrong? 

Regards
/Ronny




--------------Boundary-00=_9NOFRPSVVWEEGN40G3PL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hci-lib.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hci-lib.diff"

SW5kZXg6IGxpYnMvc3JjL2hjaS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2JsdWV6
L2xpYnMvc3JjL2hjaS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjc1CmRpZmYgLXUgLXAgLXIx
Ljc1IGhjaS5jCi0tLSBsaWJzL3NyYy9oY2kuYwk5IEp1bCAyMDA1IDE3OjA5OjEwIC0wMDAwCTEu
NzUKKysrIGxpYnMvc3JjL2hjaS5jCTEwIEp1bCAyMDA1IDIyOjQwOjIwIC0wMDAwCkBAIC01MjIs
NyArNTIyLDcgQEAgc3RhdGljIGludCBfX3NhbWVfYmRhZGRyKGludCBkZCwgaW50IGRldgogCiBp
bnQgaGNpX2dldF9yb3V0ZShiZGFkZHJfdCAqYmRhZGRyKQogewotCXJldHVybiBoY2lfZm9yX2Vh
Y2hfZGV2KEhDSV9VUCwgX19vdGhlcl9iZGFkZHIsCisJcmV0dXJuIGhjaV9mb3JfZWFjaF9kZXYo
SENJX1VQLCBfX3NhbWVfYmRhZGRyLAogCQkJCShsb25nKSAoYmRhZGRyID8gYmRhZGRyIDogQkRB
RERSX0FOWSkpOwogfQogCg==

--------------Boundary-00=_9NOFRPSVVWEEGN40G3PL--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
