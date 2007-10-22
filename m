Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <de4879e80710221221q47ed0e39w64c4ae526c94eca9@mail.gmail.com>
Date: Mon, 22 Oct 2007 16:21:23 -0300
From: thiagoss <thiagossantos@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19306_5043671.1193080883998"
Subject: [Bluez-devel] [PATCH] Removing unused variables from gsta2dpsink
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

------=_Part_19306_5043671.1193080883998
Content-Type: multipart/alternative;
	boundary="----=_Part_19307_27609427.1193080883998"

------=_Part_19307_27609427.1193080883998
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch removing unused variables from gsta2dpsink. Those were needed on alsa
plugin for sbc encoding, but they aren't in gsta2dpsink, because it is not
responsible for the encoding.

[]s

Thiago Sousa Santos

------=_Part_19307_27609427.1193080883998
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch removing unused variables from gsta2dpsink. Those were needed on alsa plugin for sbc encoding, but they aren&#39;t in gsta2dpsink, because it is not responsible for the encoding.<br><br>[]s<br><br>Thiago Sousa Santos
<br>

------=_Part_19307_27609427.1193080883998--

------=_Part_19306_5043671.1193080883998
Content-Type: text/x-patch; name=gsta2dpsink_unusedvariables.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f83d6cra
Content-Disposition: attachment; filename=gsta2dpsink_unusedvariables.patch

SW5kZXg6IGF1ZGlvL2dzdGEyZHBzaW5rLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
Ymx1ZXovdXRpbHMvYXVkaW8vZ3N0YTJkcHNpbmsuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42
CmRpZmYgLXUgLXIxLjYgZ3N0YTJkcHNpbmsuYwotLS0gYXVkaW8vZ3N0YTJkcHNpbmsuYwkxOCBP
Y3QgMjAwNyAyMzowMjoyNCAtMDAwMAkxLjYKKysrIGF1ZGlvL2dzdGEyZHBzaW5rLmMJMjIgT2N0
IDIwMDcgMTk6MDk6MjcgLTAwMDAKQEAgLTgzLDggKzgzLDYgQEAKIH07CiBzdHJ1Y3QgYmx1ZXRv
b3RoX2RhdGEgewogCXN0cnVjdCBpcGNfZGF0YV9jZmcgY2ZnOwkvKiBCbHVldG9vdGggZGV2aWNl
IGNvbmZpZyAqLwotCXVpbnQ4X3QgYnVmZmVyW0JVRkZFUl9TSVpFXTsJLyogRW5jb2RlZCB0cmFu
c2ZlciBidWZmZXIgKi8KLQlpbnQgY291bnQ7CQkJLyogVHJhbnNmZXIgYnVmZmVyIGNvdW50ZXIg
Ki8KIAlzdHJ1Y3QgYmx1ZXRvb3RoX2EyZHAgYTJkcDsJLyogQTJEUCBkYXRhICovCiB9OwogCkBA
IC00NjUsMTQgKzQ2MywxNCBAQAogCWRhdGEgaW4gdGhlIHBpcGUgLSB3ZSBoYXZlIHRvIGVtcHR5
IGl0ICovCiAJd2hpbGUgKDEpIHsKIAkJZXJyID0gZ19pb19jaGFubmVsX3JlYWQoc2luay0+c3Ry
ZWFtLAotCQkJCQkoZ2NoYXIgKikgc2luay0+ZGF0YS0+YnVmZmVyLAorCQkJCQkoZ2NoYXIgKikg
c2luay0+ZGF0YS0+YTJkcC5idWZmZXIsCiAJCQkJCShnc2l6ZSkgc2luay0+ZGF0YS0+Y2ZnLnBr
dF9sZW4sCiAJCQkJCSZyZWFkKTsKIAkJaWYgKGVyciAhPSBHX0lPX0VSUk9SX05PTkUgfHwgcmVh
ZCA8PSAwKQogCQkJYnJlYWs7CiAJfQogCi0JbWVtc2V0KHNpbmstPmRhdGEtPmJ1ZmZlciwgMCwg
c2l6ZW9mKHNpbmstPmRhdGEtPmJ1ZmZlcikpOworCW1lbXNldChzaW5rLT5kYXRhLT5hMmRwLmJ1
ZmZlciwgMCwgc2l6ZW9mKHNpbmstPmRhdGEtPmEyZHAuYnVmZmVyKSk7CiAKIAlyZXR1cm4gVFJV
RTsKIH0K
------=_Part_19306_5043671.1193080883998
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------=_Part_19306_5043671.1193080883998
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_19306_5043671.1193080883998--
