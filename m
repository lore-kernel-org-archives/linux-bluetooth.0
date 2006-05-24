Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e85851c20605232041n2570cf9bk7a3f279358a63676@mail.gmail.com>
From: "Gloria Saripah Patara" <glowz.saripah@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <e85851c20605232040h2cb185bp780b724e667fc84d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_92791_29351913.1148442088000"
References: <e85851c20605230329s754c5187sf2528816a0e64d@mail.gmail.com>
	 <e85851c20605232040h2cb185bp780b724e667fc84d@mail.gmail.com>
Subject: [Bluez-users] Found -undefined reference-
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 May 2006 10:41:28 +0700

------=_Part_92791_29351913.1148442088000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have u ever met the error messages like these :

undefined reference to 'OBEX_Cleanup'

i used the command line below:

gcc -o code code.c -lbluetooth

it's occur when i try to call certain function or procedure which
declarated in obex.h file (header file in Openobex libraries).

file code.c is attached inside this message.
-----------------------
Thanks in advance....

------=_Part_92791_29351913.1148442088000
Content-Type: application/octet-stream; name="code.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="code.c"
X-Attachment-Id: f_enl4r54p

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDxmY250bC5o
Pg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPGdl
dG9wdC5oPg0KI2luY2x1ZGUgPHNpZ25hbC5oPg0KI2luY2x1ZGUgPGxpYmdlbi5oPg0KI2luY2x1
ZGUgPHN5cy9pb2N0bC5oPg0KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCiNpbmNsdWRlIDxzeXMv
bW1hbi5oPg0KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQoNCiNpbmNsdWRlIDxibHVldG9vdGgvYmx1
ZXRvb3RoLmg+DQojaW5jbHVkZSA8Ymx1ZXRvb3RoL2hjaS5oPg0KI2luY2x1ZGUgPGJsdWV0b290
aC9oY2lfbGliLmg+DQoNCiNpbmNsdWRlIDxyZWFkbGluZS9yZWFkbGluZS5oPg0KI2luY2x1ZGUg
PHJlYWRsaW5lL2hpc3RvcnkuaD4NCg0KI2luY2x1ZGUgImdvZXAuaCINCiNpbmNsdWRlICJvYmV4
LmMiDQoNCmludCBtYWluKCl7DQoJYmRhZGRyX3Qgc3JjLCBkZXN0Ow0KCWludCBtb2RlLCBvZDsN
CgljaGFyICpmaWxlTmFtZSA9ICJidC5zb2wiOw0KCQ0KCWJhY3B5KCZzcmMsIEJEQUREUl9BTlkp
Ow0KDQoJaWYgKChvZCA9IG9iZXhfb3Blbigmc3JjLCAmZ2V0X2NsaWVudCgpLCBjaGFubmVsKSkg
PCAwKSB7DQoJCXBlcnJvcigiQ2FuJ3QgZXN0YWJsaXNoIE9CRVggY29ubmVjdGlvbiIpOw0KCQll
eGl0KDEpOw0KCX0NCg0KCW1vZGUgPSBPQkVYX0ZJTEVfVFJBTlNGRVI7DQoJb2JleF9jb25uZWN0
KG9kLCBtb2RlKTsgLy9mdW5jdGlvbiBkZWNsYXJhdGVkIGluIGZpbGUgb2JleC5jIGFuZCBnb2Vw
LmgNCglwcmludGYoIkNvbm5lY3RlZFxuIik7DQoNCgkvLy4uLi4uLi4uLi4uLi4udHJhbnNmZXJy
aW5nIGZpbGUNCg0KCW9iZXhfZGlzY29ubmVjdChvZCk7IC8vZnVuY3Rpb24gZGVjbGFyYXRlZCBp
biBmaWxlIG9iZXguYyBhbmQgZ29lcC5oDQoJcHJpbnRmKCJEaXNjb25uZWN0ZWQuXG4iKTsgLy9m
dW5jdGlvbiBkZWNsYXJhdGVkIGluIGZpbGUgb2JleC5jIGFuZCBnb2VwLmgNCglvYmV4X2Nsb3Nl
KG9kKTsNCg0KCXJldHVybiAwOw0KfQ==
------=_Part_92791_29351913.1148442088000--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
