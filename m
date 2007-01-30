Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0701301415u4f27bad8i3f165beaafb6161e@mail.gmail.com>
Date: Tue, 30 Jan 2007 17:15:59 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750701300639w59ec30f0n7eeeca203a513be5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_127875_3336327.1170195359258"
References: <80236d750701250229u61cbb820v929b8d0ad6ae3fb9@mail.gmail.com>
	<ef9938ec0701271830p6f171d9cu892458220baa9362@mail.gmail.com>
	<80236d750701300639w59ec30f0n7eeeca203a513be5@mail.gmail.com>
Subject: Re: [Bluez-users] multithread / multi process use
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

------=_Part_127875_3336327.1170195359258
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> 1 .can the daemon  hci manage simultenous requests from variuos
> process/threads without problem ?

yes.  Currently, if one process attempts to start a device inquiry
while one is already in progress, then hcid will raise a DBusException
and refuse to honor the second request.  The second process may still
listen for discovery and name lookup events.

> 2 .where I can find some api docs(if any) about the hcid ?

current document exists, but is difficult to find and not very
beginner friendly.  Downoad the bluez-utils source and look in
hcid/dbus-api.txt  You can use the attached python script as a
starting point.  It's not terribly elegant about detecting when an
inquiry is already in process, but I don't think that hcid is sending
standardized error codes in its exceptions...

-albert

------=_Part_127875_3336327.1170195359258
Content-Type: text/x-python; name="inquiry-with-names.py"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="inquiry-with-names.py"
X-Attachment-Id: f_exkw5a7c

aW1wb3J0IGdvYmplY3QKaW1wb3J0IGRidXMKCmltcG9ydCBkYnVzLmdsaWIKCmRlZiBvblJlbW90
ZU5hbWVVcGRhdGVkKCBhZGRyZXNzLCBuYW1lICk6CiAgICBwcmludCBhZGRyZXNzLCBuYW1lLmVu
Y29kZSgidXRmLTgiKQoKZGVmIG9uRGlzY292ZXJ5Q29tcGxldGVkKCk6CiAgICBwcmludCAiZGlz
Y292ZXJ5IGNvbXBsZXRlZCIKICAgIG1haW5sb29wLnF1aXQoKQoKYnVzID0gZGJ1cy5TeXN0ZW1C
dXMoKQpibHVleiA9IGJ1cy5nZXRfb2JqZWN0KCdvcmcuYmx1ZXonLCAnL29yZy9ibHVleicpCm1h
bmFnZXIgPSBkYnVzLkludGVyZmFjZShibHVleiwgJ29yZy5ibHVlei5NYW5hZ2VyJykKb2JqID0g
YnVzLmdldF9vYmplY3QoJ29yZy5ibHVleicsIG1hbmFnZXIuRGVmYXVsdEFkYXB0ZXIoKSkKYWRh
cHRlciA9IGRidXMuSW50ZXJmYWNlKG9iaiwgJ29yZy5ibHVlei5BZGFwdGVyJykKdHJ5OiAKICAg
IGFkYXB0ZXIuRGlzY292ZXJEZXZpY2VzKCkKZXhjZXB0IGRidXMuREJ1c0V4Y2VwdGlvbiwgZToK
ICAgIGlmIGUuYXJnc1swXSA9PSAiRGlzY292ZXIgaW4gcHJvZ3Jlc3MiOiAKICAgICAgICBwcmlu
dCAiaGNpZCByZXBvcnRzIGV4aXN0aW5nIGRldmljZSBkaXNjb3ZlcnkgYWxyZWFkeSBpbiBwcm9n
cmVzcy4iCgphZGFwdGVyLmNvbm5lY3RfdG9fc2lnbmFsKCAnRGlzY292ZXJ5Q29tcGxldGVkJywg
b25EaXNjb3ZlcnlDb21wbGV0ZWQgKQphZGFwdGVyLmNvbm5lY3RfdG9fc2lnbmFsKCAnUmVtb3Rl
TmFtZVVwZGF0ZWQnLCBvblJlbW90ZU5hbWVVcGRhdGVkICkKCm1haW5sb29wID0gZ29iamVjdC5N
YWluTG9vcCgpCm1haW5sb29wLnJ1bigpCg==
------=_Part_127875_3336327.1170195359258
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_127875_3336327.1170195359258
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_127875_3336327.1170195359258--
