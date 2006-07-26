Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <99f8b4660607261555t5a297fe1y6df50e93b9517548@mail.gmail.com>
Date: Wed, 26 Jul 2006 22:55:22 +0000
From: "Sebastien Henrio" <sebastien.henrio@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21246_2756715.1153954522491"
Subject: [Bluez-devel] A2DP: signaling channel never closed
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

------=_Part_21246_2756715.1153954522491
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I found a bad behaviour in alsa-plugin: signaling channel is never
closed. So if remote device doesn't close it (and It's recommended to
keep it opened), alsa plugin will open a new signaling channel for
each connection, until remote device isnot able to accept any new
L2CAP connection.

to reproduce the bug, you must have a device that doesn't close the
signaling channel and then simply press STOP and PLAY several times on
XMMS using alsa plugin....

So I just close signaling channel before doing a free of a2dp
structure. another fix can be to use the signaling channel for next
connection

In this patch I also add the parsing of sbc parameters (bitpool, sub
band and block len).

I think it's important to merge signaling patch in CVS.

adding the ability to configure the codec is of course less important.


I found also another bug and I don't know how to solve it.  When you
use XMMS with alsa output plugin (or other apps like amarok...) when I
do a brutal disconnection of the SNK after several seconds xmms (or
amarok) uses 100% of my cpu I have some idea but I don't know how to
fiw it

Best regards
Sebastien

------=_Part_21246_2756715.1153954522491
Content-Type: application/octet-stream; name=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eq3utxj1
Content-Disposition: attachment; filename="patch"

SW5kZXg6IHBjbV9hMmRwLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXRvb3Ro
LWFsc2EvYnRzY28vYWxzYS1wbHVnaW5zL3BjbV9hMmRwLmMsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMTMKZGlmZiAtcjEuMTMgcGNtX2EyZHAuYwo5NzcsOTc5ZDk3Ngo8IAlhMmRwLT5zYmMuc3Vi
YmFuZHMgPSA4OyAvLyBzYWZlIGRlZmF1bHQKPCAJYTJkcC0+c2JjLmJsb2NrcyA9IDE2OyAvLyBz
YWZlIGRlZmF1bHQKPCAJYTJkcC0+c2JjLmJpdHBvb2wgPSAzMjsgLy8gcmVjb21tZW5kZWQgdmFs
dWUgNTMsIHNhZmUgZGVmYXVsdCBpcyAzMgoxMjEyYTEyMTAsMTIxMgo+IAlpZiAoYTJkcC0+Y29u
dHJvbF9zayA+IGZpbGVubyhzdGRlcnIpKQo+IAkJY2xvc2UoYTJkcC0+Y29udHJvbF9zayk7Cj4g
CjEzNDVhMTM0NiwxMzQ3Cj4gCWxvbmcgYml0cG9vbCA9IC0xLHN1YmJuZCA9IC0xLCBibGtsZW4g
PSAtMTsKPiAKMTM4MGExMzgzLDE0MTAKPiAJCWlmICghc3RyY21wKGlkLCAic2JjX2JpdHBvb2wi
KSkgewo+IAkJCWlmICgoZXJyID0gc25kX2NvbmZpZ19nZXRfaW50ZWdlcihuLCAmYml0cG9vbCAp
KSA8IDAgJiYKPiAJCQkJCSggYml0cG9vbCA8IDAgfHwgMjU0IDwgYml0cG9vbCkpICB7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTkRFUlIoIlRoZSBmaWVsZCBmb3IgYml0cG9v
bCBtdXN0IGJlIGFuIHVuc2lnbmVkIGludGVnZXIiKTsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+IAkJCWNv
bnRpbnVlOwo+IAkJfQo+IAo+IAkJaWYgKCFzdHJjbXAoaWQsICJzYmNfYmxrbGVuIikpIHsKPiAJ
CQlpZiAoKGVyciA9IHNuZF9jb25maWdfZ2V0X2ludGVnZXIobiwgJmJsa2xlbikpIDwgMCAmJgo+
IAkJCQkJKCBibGtsZW4gIT0gNCAmJiBibGtsZW4gIT0gOCAmJiBibGtsZW4gIT0gMTIgJiYgYmxr
bGVuICE9IDE2KSkgewo+IAkJCQlTTkRFUlIoIlRoZSBmaWVsZCBmb3IgYmxvY2tsZW4gbXVzdCBi
ZSBlaXRoZXIgNCwgOCwgMTIgb3IgMTYiKTsKPiAJCQkJcmV0dXJuIGVycjsKPiAJCQl9Cj4gCQkJ
Y29udGludWU7Cj4gCQl9Cj4gCj4gCQlpZiAoIXN0cmNtcChpZCwgInNiY19zdWJiYW5kIikpIHsK
PiAJCQlpZiAoKGVyciA9IHNuZF9jb25maWdfZ2V0X2ludGVnZXIobiwgJnN1YmJuZCkpIDwgMCAm
Jgo+IAkJCQkgKCBzdWJibmQgIT0gNCAmJiBzdWJibmQgIT0gOCkpIHsKPiAJCQkJU05ERVJSKCJU
aGUgZmllbGQgZm9yIHN1YmJhbmQgbXVzdCBiZSBlaXRoZXIgNCBvciA4Iik7Cj4gCQkJCXJldHVy
biBlcnI7Cj4gCQkJfQo+IAkJCWNvbnRpbnVlOwo+IAkJfQo+IAo+IAoxNDI4YTE0NTksMTQ3Nwo+
IAlhMmRwLT5zYmMuc3ViYmFuZHMgPSA4OyAvLyBzYWZlIGRlZmF1bHQKPiAJYTJkcC0+c2JjLmJs
b2NrcyA9IDE2OyAvLyBzYWZlIGRlZmF1bHQKPiAJYTJkcC0+c2JjLmJpdHBvb2wgPSAzMjsgLy8g
cmVjb21tZW5kZWQgdmFsdWUgNTMsIHNhZmUgZGVmYXVsdCBpcyAzMgo+IAo+IAlpZiAoYml0cG9v
bCAhPSAtMSl7Cj4gCQlEQkcoInNiYyA6IGJpdHBvb2wgJWQiICwgKGludCliaXRwb29sKTsKPiAJ
CWEyZHAtPnNiYy5iaXRwb29sID0gKGludCliaXRwb29sOwo+IAl9Cj4gCj4gCWlmIChibGtsZW4g
IT0gLTEpewo+IAkJREJHKCJzYmMgOiBzdWJiYW5kcyAlZCIgLCAoaW50KXN1YmJuZCk7Cj4gCQlh
MmRwLT5zYmMuc3ViYmFuZHMgPSAoaW50KXN1YmJuZDsKPiAJfQo+IAo+IAlpZiAoYmxrbGVuICE9
IC0xKXsKPiAJCURCRygic2JjIDogYmxrbGVuICVkIiAsIChpbnQpYmxrbGVuKTsKPiAJCWEyZHAt
PnNiYy5ibG9ja3MgPSAoaW50KWJsa2xlbjsKPiAJfQo+IAo=
------=_Part_21246_2756715.1153954522491
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_21246_2756715.1153954522491
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_21246_2756715.1153954522491--
