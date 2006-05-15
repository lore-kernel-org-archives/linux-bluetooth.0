Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <100466c40605150115k35c2c140n29d0a99a6ea49f80@mail.gmail.com>
From: "Antonio Terreno" <antonio.terreno@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] concurrent service searches
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
Date: Mon, 15 May 2006 10:15:47 +0200

KEkganVzdCByZXNlbmQgdGhpcyBtYWlsIGNvcyBsb29rcyBsaWtlIHRoZSBvdGhlciB0aW1lIHdh
cyBub3QgaW4Kc2ltcGxlIHRleHQsIHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZSkKCkhpIGFs
bCwKCndoeSBpZiBJIHN0YXJ0IG11bHRpcGxlIHNlcnZpY2VzIHNlYXJjaCBvbiBkaWZmZXJlbnQg
ZGV2aWNlcyAoYWx3YXlzCmxlc3MgdGhhbiA3KQoKaW4gdGhhdCB3YXk6CnNkcHRvb2wgYnJvd3Nl
ICJERVZJQ0VfQUREUiIKW2dub21lLW9iZXgtc2VuZCAtLWRlc3QgIkRFVklDRV9BRERSIiBmaWxl
MnNlbmQudHh0XSAob3B0aW9uYWwpCgpJIGdldCBhbHdheXMgZXJyb3JzIChvbiA0LTUgZGV2aWNl
cyBpcyBmaW5lLCBvbiAzLTIgZGV2aWNlcyBpcyAiRmFpbGVkCnRvIGNvbm5lY3QgdG8gU0RQIHNl
cnZlciBvbiAiREVWSUNFX0FERFIiOiBGaWxlIGRlc2NyaXB0b3IgaW4gYmFkCnN0YXRlIikKClRo
ZSBzaXR1YXRpb24gaXMgYmV0dGVyIGlmIEkgd2FpdCAxIG9yIGV2ZW4gMiBzZWMgYmVmb3JlIHN0
YXJ0aW5nIGEKbmV3IHNlYXJjaCBhbmQgc2VuZC4KClRoZSBwcm9ibGVtIHdhcyB0cmlnZ2VyZWQg
ZGV2ZWxvcGluZyBhIG11bHRpdGhyZWFkZWQgYmx1ZXRvb3RoIHNlcnZlcgppbiBqYXZhLCB3aXRo
IGF2ZXRhbmEgYmx1ZXRvb3RoLgpJIGRvbnQgaGF2ZSB0aGVzZSBwcm9ibGVtIHVzaW5nIHRoZSBz
YW1lIGNvZGUgb24gd2luZG93cy4uLi4KCgpUaGFua3MgaW4gYWR2YW5jZSwKYmVzdCByZWdhcmRz
CmFudG9uaW8KCi0tIAotLSAKQW50b25pbyBUZXJyZW5vCmh0dHA6Ly9hbnRvbmlvdGVycmVuby5q
YXZhMm1lLm9yZy8K


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
