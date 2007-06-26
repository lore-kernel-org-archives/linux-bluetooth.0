Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 26 Jun 2007 06:07:38 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706252149v1496a474xba400d960a1bfff6@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <40044.12822.qm@web62309.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] plugz install still not right
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1885959457=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1885959457==
Content-Type: multipart/alternative; boundary="0-668490456-1182863258=:12822"
Content-Transfer-Encoding: 8bit

--0-668490456-1182863258=:12822
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

so you type only 'headset' in that menu nothing preceding it. I get the couldn't open audio check soundcard message. And when the headset is off I see "unable to connect L2CAP socket"  on headsetd which makes sense.
 The description in the doc only says a2dpd for xmms.
 As for csr adapter, this is the same set I used with btsco and it worked.
 
 Thanks.
 -Walt

Brad Midgley <bmidgley@gmail.com> wrote: Walt

yes, I've tested xmms with headsetd using the alsa device "headset" and the alsa config recommended in the docs. 

no audio coming through can be a symptom of incorrect csr routing or a non-csr adapter.  http://bluetooth-alsa.sourceforge.net/contact.html has some things to check for this (sudo hciconfig hci0 revision) and look for "sco mapping: hci" 

Brad
 -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 
---------------------------------
Finding fabulous fares is fun.
Let Yahoo! FareChase search your favorite travel sites to find flight and hotel bargains.
--0-668490456-1182863258=:12822
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

so you type only 'headset' in that menu nothing preceding it. I get the couldn't open audio check soundcard message. And when the headset is off I see "unable to connect L2CAP socket"&nbsp; on headsetd which makes sense.<br> The description in the doc only says a2dpd for xmms.<br> As for csr adapter, this is the same set I used with btsco and it worked.<br> <br> Thanks.<br> -Walt<br><br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Walt<br><br>yes, I've tested xmms with headsetd using the alsa device "headset" and the alsa config recommended in the docs. <br><br>no audio coming through can be a symptom of incorrect csr routing or a non-csr adapter.  <a href="http://bluetooth-alsa.sourceforge.net/contact.html">http://bluetooth-alsa.sourceforge.net/contact.html</a> has some things to check for this (sudo <tt>hciconfig hci0 revision) and look for "sco
 mapping: hci" <br><br>Brad<br></tt> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;

<hr size=1>Finding fabulous fares is fun.<br><a href="http://farechase.yahoo.com/promo-generic-14795097;_ylc=X3oDMTFtNW45amVpBF9TAzk3NDA3NTg5BF9zAzI3MTk0ODEEcG9zAzEEc2VjA21haWx0YWdsaW5lBHNsawNxMS0wNw--
">Let Yahoo! FareChase search your favorite travel sites</a> to find flight and hotel bargains.
--0-668490456-1182863258=:12822--


--===============1885959457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1885959457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1885959457==--
