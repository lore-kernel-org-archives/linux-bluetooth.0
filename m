Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <63778.80.109.89.243.1176237837.squirrel@webmail.uni-ak.ac.at>
In-Reply-To: <1176233650.18096.22.camel@violet>
References: <62204.80.109.89.243.1176201047.squirrel@webmail.uni-ak.ac.at>
	<1176214966.18096.2.camel@violet>
	<60881.80.109.89.243.1176233471.squirrel@webmail.uni-ak.ac.at>
	<1176233650.18096.22.camel@violet>
Date: Tue, 10 Apr 2007 22:43:57 +0200 (CEST)
From: gerhard.ramsebner@uni-ak.ac.at
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20070410224357_69739"
Subject: Re: [Bluez-users] RecHandle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_20070410224357_69739
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Marcel,

my idea was to have an embedded device automatically connecting to a host
system providing rfcomm. This embedded device might go down from time to
time but should normaly be streaming sensor data. To keep things easy I
thougt it would be advantageous to avoid implementing an ip streaming in
favour of rfcomm.
Thatfor on hostside I wrote a script to have 'rfcomm listen' restarted
everytime it goes down due to hangup. The embedded device should
{,re}connect to it whenever it starts up.

This is working quite well with a single connection. I'm not planning to
have more than one but the script would be more elegante if this were
possible.
But this also does mean that I have to offer to stop a channel without
closing one of the others.

You don't think that this is a good idea, do you?
Respect to all taking part!

Regards,
gerhard


2 files attached:
rc_rfcomm - bash start/stopscript (replace the function 'boot_mesg',
'evaluate_retval' and 'echo_warning' with something appropriate or get
their definitions here:
http://www.linuxfromscratch.org/blfs/downloads/6.2.0/blfs-bootscripts-20060910.tar.bz2)
rfcomm_listen - bash daemon script called from rc_rfcomm.
------=_20070410224357_69739
Content-Type: application/octet-stream; name="rfcomm_listen"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rfcomm_listen"

IyEvYmluL2Jhc2gKClBJREZJTEU9JChiYXNlbmFtZSAkezB9KQpQSURGSUxFPSR7UElERklMRSUu
Kn0KUElERklMRT0vdmFyL3J1bi8ke1BJREZJTEV9LnBpZAoKaWYgWyAtZSAke1BJREZJTEV9IF0K
dGhlbgoJcHJpbnRmICIqKiogJXMgOiBwaWRmaWxlIGV4aXN0c1xuIiAkezB9ID4mMgoJZXhpdCAx
CmVsc2UKCXRvdWNoICR7UElERklMRX0gJiYgZWNobyAkJCA+ICR7UElERklMRX0KCWlmIFsgISAt
ZSAke1BJREZJTEV9IF0KCXRoZW4KCQlwcmludGYgIioqKiAlcyA6IGZhaWxlZCB0byBjcmVhdGUg
cGlkZmlsZVxuIiAkezB9ID4mMgoJCWV4aXQgMQoJZmkKZmkKClNDSEVEVUxFPSdraWxsICR7IX07
IHJtIC1mICR7UElERklMRX07IGV4aXQnCnRyYXAgIiR7U0NIRURVTEV9IiAzCnRyYXAgIiR7U0NI
RURVTEV9IiA2CnRyYXAgIiR7U0NIRURVTEV9IiA5CnRyYXAgIiR7U0NIRURVTEV9IiAxNQoKd2hp
bGUgdHJ1ZQpkbwoJbmljZSAtbiAxMCByZmNvbW0gbGlzdGVuIDE+L2Rldi9udWxsIDI+L2Rldi9u
dWxsICR7Kn0gJgoJd2FpdCAkeyF9CgkjIHByZXZlbnQgRG9TIGF0dGFjawoJc2xlZXAgMQpkb25l
Cg==
------=_20070410224357_69739
Content-Type: application/octet-stream; name="rc_rfcomm"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rc_rfcomm"

IyEvYmluL3NoCgouIC9ldGMvc3lzY29uZmlnL3JjCi4gJHJjX2Z1bmN0aW9ucwoKY2FzZSAiJDEi
IGluCglzdGFydCkKCQlib290X21lc2cgIlN0YXJ0aW5nIHJmY29tbS4uLiIKCQluaWNlIC1uIDEw
IHJmY29tbV9saXN0ZW4gLUEgLS1jaGFubmVsPTEgaGNpMCAmCgkJIyByZmNvbW1fbGlzdGVuIHRh
a2VzIHRpbWUgdG8gY3JlYXRlIHBpZGZpbGUKCQlzbGVlcCAxCgkJIyByZmNvbW1fbGlzdGVuIGV4
aXRzIGlmIHBpZGZpbGUgZXhpc3RzCgkJaWYgWyAkeyF9IC1lcSAkKGNhdCAvdmFyL3J1bi9yZmNv
bW1fbGlzdGVuLnBpZCkgXQoJCXRoZW4KCQkJZGlzb3duICR7IX0gJiYgc2RwdG9vbCBhZGQgLS1j
aGFubmVsPTEgU1AKCQllbHNlCgkJCS9iaW4vZmFsc2UKCQlmaQoJCWV2YWx1YXRlX3JldHZhbAoJ
CTs7CgoJc3RvcCkKCQlib290X21lc2cgIlN0b3BwaW5nIHJmY29tbS4uLiIKCQlXQVJOPTAKCQlp
ZiBbIC1lIC92YXIvcnVuL3JmY29tbV9saXN0ZW4ucGlkIF0KCQl0aGVuCgkJCWtpbGwgJChjYXQg
L3Zhci9ydW4vcmZjb21tX2xpc3Rlbi5waWQpCgkJCSMgcmZjb21tX2xpc3RlbiB0YWtlcyB0aW1l
IHRvIHJlbW92ZSBwaWRmaWxlZAoJCQlzbGVlcCAxCgkJZWxzZQoJCQllY2hvICJwaWRmaWxlIGRv
ZXMgbm90IGV4aXN0IgoJCQlXQVJOPTEKCQlmaQoJCWlmIFsgLWUgL3Zhci9ydW4vcmZjb21tX2xp
c3Rlbi5waWQgXQoJCXRoZW4KCQkJZWNobyAicGlkZmlsZSBzdGlsbCBleGlzdHMiCgkJCVdBUk49
MQoJCWZpCgkJUmVjSGFuZGxlcz0kKHNkcHRvb2wgc2VhcmNoIC0tYmRhZGRyIGxvY2FsIFNQIFwK
CQkJfCBncmVwICdTZXJ2aWNlIFJlY0hhbmRsZScgXAoJCQl8IHNlZCAncy9eU2VydmljZSBSZWNI
YW5kbGU6IC8vJykKCQlmb3IgUmVjSGFuZGxlIGluICR7UmVjSGFuZGxlc30KCQlkbwoJCQlzZHB0
b29sIGRlbCAke1JlY0hhbmRsZX0KCQlkb25lCgkJaWYgWyAke1dBUk59IC1ndCAwIF0KCQl0aGVu
CgkJCWVjaG9fd2FybmluZwoJCQlleGl0CgkJZmkKCQkvYmluL3RydWUKCQlldmFsdWF0ZV9yZXR2
YWwKCQk7OwoKCXJlc3RhcnQpCgkJJDAgc3RvcAoJCXNsZWVwIDEKCQkkMCBzdGFydAoJCTs7CgoJ
c3RhdHVzKQoJCXN0YXR1c3Byb2MgcmZjb21tX2xpc3RlbgoJCXJmY29tbSAtYQoJCWVjaG8KCQlz
ZHB0b29sIHNlYXJjaCAtLWJkYWRkciBsb2NhbCBTUAoJCTs7CgoJKikKCQllY2hvICJVc2FnZTog
JDAge3N0YXJ0fHN0b3B8cmVzdGFydHxzdGF0dXN9IgoJCWV4aXQgMQoJCTs7CmVzYWMK
------=_20070410224357_69739
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_20070410224357_69739
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_20070410224357_69739--
