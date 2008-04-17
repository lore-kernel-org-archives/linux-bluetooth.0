Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8A090.2257D253"
Date: Thu, 17 Apr 2008 21:37:08 +0800
Message-ID: <FFED2D1514034841A6270D98984E7D0C020FF6C4@pdsmsx415.ccr.corp.intel.com>
In-Reply-To: <4806FB47.8060109@tfh-berlin.de>
References: <FFED2D1514034841A6270D98984E7D0C020C7159@pdsmsx415.ccr.corp.intel.com>	<cc1649d10804141954h1be91b0an8b7e5bc6bfe8660b@mail.gmail.com><FFED2D1514034841A6270D98984E7D0C020FF4B8@pdsmsx415.ccr.corp.intel.com>
	<4806FB47.8060109@tfh-berlin.de>
From: "Zhu, Peter J" <peter.j.zhu@intel.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>,
	<rehle@tfh-berlin.de>, <skarzhevskyy@gmail.com>
Subject: Re: [Bluez-users] Unable to read data via RFCOMM socket from a
	JSR82 program running on phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A090.2257D253
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Thank you very much. I attach my code here.=20
rfcomm.c.tar.gz=20
    Server and client code written in C language via RFCOMM socket. They
run in two linux machines with USB BT dongle. They communicate very well
as expected, described in first mail of this thread.=20

MyBTMIDlet.java.tar.gz
     MIDlet making use of JSR82. It contains both server and client code
in one midlet. But in two phones, they can't communicate at all. Even
client can't find service registered by server.=20

My goal is of making client of MyBTMIDlet running in phone communicate
well with bluez server running in linux machine. Currently client can
find service registered by bluez server and sends data to bluez server,
but linux machine doesn't get any string sent by client, as described by
first mail of this thread, attached again here for your convenience.=20

Please help review the code. Thank you sooooooooooooooooo much.

Peter





David Rehle wrote:
> Peter,
>=20
> which phone are you using? I know, that Siemens S65 (very old i know)
> can not establish a connection to bluez without pin request.
>=20
> I did your job several times, so if you want, post your C and midp
> code, (only relevant connection code) i will have a look on it
>=20
> kind regards
>=20
> david
>=20
>=20
>=20
> Zhu, Peter J schrieb:
>> Hi Vlad
>>=20
>> Firstly thank you so much for giving this useful infomation. Yes, I
>> tested it between MIDlet running on phone and that MIDlet running on
>> desktop. Runs very well.  But that's between two JSR82 applications
>> rather than between a JSR82 and a C application utilizing bluez. Do
>> you have such case in hand so that I can test?  Thank you again.
>>=20
>> Peter
>>=20
>> Vlad Skarzhevskyy wrote:
>>> Hi Peter
>>>   We at bluecove.org constantly testing connections from JSR-82 on
>>> top of BlueZ on Linux to client on Mobile phone L2CAP or RFCOMM and
>>> back. No problems detected in BlueZ.
>>>   Make sure you are connecting to right service!
>>>=20
>>>   Look at this application as test
>>> http://snapshot.bluecove.org/bluecove-examples/bluecove-tester/  it
>>> runs on Linux and the MIDLet version can be installed on the phone.
>>>=20
>>> --
>>> Vlad
>>=20
>>
------------------------------------------------------------------------
-
>> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>> Don't miss this year's exciting event. There's still time to save
>> $100. Use priority code J8TL2D2.
>>
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/j
avaone
>> _______________________________________________=20
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>=20
>=20
>
------------------------------------------------------------------------
-
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save
> $100. Use priority code J8TL2D2.
>
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/j
avaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C8A090.2257D253
Content-Type: application/x-gzip;
	name="MyBTMIDlet.java.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: MyBTMIDlet.java.tar.gz
Content-Disposition: attachment;
	filename="MyBTMIDlet.java.tar.gz"

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

------_=_NextPart_001_01C8A090.2257D253
Content-Type: application/x-gzip;
	name="rfcomm.c.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: rfcomm.c.tar.gz
Content-Disposition: attachment;
	filename="rfcomm.c.tar.gz"

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

------_=_NextPart_001_01C8A090.2257D253
Content-Type: text/plain;
	name="Bluez-users Unable to read data via RFCOMM socket from a
	JSR82program running on phone.txt"
Content-Transfer-Encoding: base64
Content-Description: Bluez-users Unable to read data via RFCOMM socket from a
	JSR82program running on phone.txt
Content-Disposition: attachment;
	filename="Bluez-users Unable to read data via RFCOMM socket from a
	JSR82program running on phone.txt"

RnJvbTogYmx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQgb24gYmVoYWxm
IG9mIFpodSwgUGV0ZXINCkogW3BldGVyLmouemh1QGludGVsLmNvbV0NClNlbnQ6IFR1ZXNkYXks
IEFwcmlsIDE1LCAyMDA4IDk6NTkgQU0NClRvOiBibHVlei11c2Vyc0BsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQNClN1YmplY3Q6IFtCbHVlei11c2Vyc10gVW5hYmxlIHRvIHJlYWQgZGF0YSB2aWEgUkZD
T01NIHNvY2tldCBmcm9tIGENCkpTUjgycHJvZ3JhbSBydW5uaW5nIG9uIHBob25lDQoNCkhpLA0K
DQpUaGVzZSBkYXlzIEkgdHJpZWQgdG8gd3JpdGUgb25lIFJGQ09NTSBzb2NrZXQgc2VydmVyIHRo
YXQgcmVhZHMgaW5wdXQNCmZyb20gYSBKU1I4MiBjbGllbnQgcnVubmluZyBvbiBhIHBob25lIGJ1
dCBmYWlsZWQuIE15IHNlcnZlciBwcm9ncmFtDQpydW5zIG9uIGEgVWJ1bnR1IGd1dHN5IGRpc3Ry
aWJ1dGlvbi4gVGhpcyBzZXJ2ZXIgcmVnaXN0ZXJzIGEgc2VydmljZQ0Kd2l0aCBhIHVuaXF1ZSBV
VUlEIGFuZCBjbGllbnQgbG9va3MgZm9yIHRoaXMgc2VydmljZSBhbmQgc2VuZCBzb21lDQpzdHJp
bmcgcmVxdWVzdCB0byBzZXJ2ZXIgb25jZSBmb3VuZCBhbmQgdGhlbiBzZXJ2ZXIgc2VuZHMgYmFj
ayBzb21lDQpzdHJpbmcgZGF0YSByZXNwb25zZSB0byBjbGllbnQuIFRoYXQncyBpdC4gDQoNCj5G
cm9tIGJvdGggbG9nIG9mIEpTUjgyIGNsaWVudCBhbmQgaGNpZHVtcCBvdXRwdXQgaW4gbGludXgg
aG9zdCwgSSBjYW4NCnNlZSB0aGlzIHNlcnZpY2UgaXMgc3VjY2Vzc2Z1bGx5IGZvdW5kIGFuZCBh
IHN1Y2Nlc3NmdWwgY29ubmVjdGlvbiBpcw0Kc2V0dXAgYmV0d2VlbiBsaW51eCBob3N0IGFuZCBw
aG9uZS4gVGhpcyBzdWNjZXNzZnVsIGNvbm5lY3Rpb24gY2FuIGFsc28NCmJlIHZlcmlmaWVkIGJ5
IGJvdGggImhjaXRvb2wgY29uIiBhbmQgImwycGluZyIuIGwycGluZyBtZWFucyBMMkNBUCBsYXll
cg0KY29tbXVuaWNhdGlvbiBpcyBnb29kLCBJIHRoaW5rLiBUaGUgYWNjZXB0KCkgb2YgdGhpcyBz
ZXJ2ZXIgaXMNCnN1Y2Nlc2Z1bCwgYXMgd2VsbC4gQnV0IGF0IHNhbWUgdGltZSwgIHJlYWQoKSB3
aXRoIHNvY2tpZCByZXR1cm5lZCBieQ0KYWNjZXB0KCkganVzdCBibG9ja3MsICBhbmQgaGNpZHVt
cCBvdXRwdXQgc2hvd3MgdGhhdCBubyBkYXRhIGlzIHJlYWQNCmZyb20gbG93IGxldmVsIGhvc3Qg
aW50ZXJmYWNlLiANCg0KQW5vdGhlciBpbmZvIHRoYXQgbWlnaHQgYmUgdXNlZnVsIGlzIHRoYXQg
SSBhbHNvIHdyb3RlIGEgYmx1ZXogQyBjbGllbnQNCndpdGggUkZDT01NIHNvY2tldCB0aGF0IGRv
ZXMgc2FtZSB0aGluZyBhcyBKU1I4MiBjbGllbnQuIFRoZSBibHVlWiBDDQpjbGllbnQgcnVucyBp
biB0aGUgb3RoZXIgbGludXggbWFjaGluZS4gVGhlIHJlc3VsdCBpcyBwZXJmZWN0bHkgZ29vZCwN
CndpdGggZXZlcnl0aGluZyBnb2luZyB2ZXJ5IHNtb290aCBhcyBleHBlY3RlZC4gTm90aWNlYWJs
eSwgdGhpcw0KbGludXgtbGludXggc3VjY2Vzc2Z1bCBjb21tdW5pY2F0aW9uIGRvZXNuJ3QgcmVx
dWlyZSBhbnkgcGluDQppbnB1dC9wYWlyaW5nIHByb2Nlc3MuIFRoYXQncyBhIGJpdCBzdHJhbmdl
LiANCg0KQW55IGhlbHAgb3IgaW5mbyBpcyBleHRyZW1lbHkgYXBwcmVjaWF0ZWQuIFRoYW5rcyB0
byBibHVleiBhbmQgbGludXggYW5kDQphbGwgcGVvcGxlIGhlcmUuIA0KDQoNCi1QZXRlcg0KDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NClRoaXMgU0YubmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUg
MjAwOCBKYXZhT25lKFNNKSBDb25mZXJlbmNlIA0KRG9uJ3QgbWlzcyB0aGlzIHllYXIncyBleGNp
dGluZyBldmVudC4gVGhlcmUncyBzdGlsbCB0aW1lIHRvIHNhdmUgJDEwMC4gDQpVc2UgcHJpb3Jp
dHkgY29kZSBKOFRMMkQyLiANCmh0dHA6Ly9hZC5kb3VibGVjbGljay5uZXQvY2xrOzE5ODc1NzY3
MzsxMzUwMzAzODtwP2h0dHA6Ly9qYXZhLnN1bi5jb20vamF2YW9uZQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkJsdWV6LXVzZXJzIG1haWxpbmcgbGlz
dA0KQmx1ZXotdXNlcnNAbGlzdHMuc291cmNlZm9yZ2UubmV0DQpodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9ibHVlei11c2Vycw0K

------_=_NextPart_001_01C8A090.2257D253
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------_=_NextPart_001_01C8A090.2257D253
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C8A090.2257D253--
