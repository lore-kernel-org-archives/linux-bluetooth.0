Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 19 Jun 2007 07:21:40 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <527177.38684.qm@web62315.mail.re1.yahoo.com>
MIME-Version: 1.0
Message-ID: <496894.75241.qm@web62303.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] bluez/alsa modules vs kernel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0437111339=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0437111339==
Content-Type: multipart/alternative; boundary="0-15538866-1182262900=:75241"
Content-Transfer-Encoding: 8bit

--0-15538866-1182262900=:75241
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

sorry I meant hcitool inq.... it sees the headset.
 -Walt

walt shekrota <penguinacity@yahoo.com> wrote: Hi,
 
 Ok being I never saw this page before I tried the plugz install on an (k)ubuntu 6.06.
 All the instruction went great. I loaded the extra libc6/libbluetooth2/libbluetooth2-dev ok.
 I started the headsetd and paired the headset but saw no driver to select in apps.
 sdptool browse shows permission denied on my headset address while hcitool dev responds fine. Also I created the asoundrc as from the example pointed to.
 
 Any ideas?
 
 Thanks.
 I have a feeling it's something goofy.
 -Walt
 
 Brad Midgley <bmidgley@gmail.com> wrote: Walt


 So where is plugz in terms of adoption? Like I was saying I don't see it anywhere in particular.... gentoo, ubuntu. (other  than CVS) 

some form of a2dpd etc from plugz will appear in the access linux platform. For the rest of us, plugz is a working example we refer back to when implementing the audio service that is going into bluez utils core. Then it will be deployed pretty widely. 

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
Get the Yahoo! toolbar and be alerted to new email wherever you're surfing. -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 
---------------------------------
We won't tell. Get more on shows you hate to love
(and love to hate): Yahoo! TV's Guilty Pleasures list.
--0-15538866-1182262900=:75241
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

sorry I meant hcitool inq.... it sees the headset.<br> -Walt<br><br><b><i>walt shekrota &lt;penguinacity@yahoo.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi,<br> <br> Ok being I never saw this page before I tried the plugz install on an (k)ubuntu 6.06.<br> All the instruction went great. I loaded the extra libc6/libbluetooth2/libbluetooth2-dev ok.<br> I started the headsetd and paired the headset but saw no driver to select in apps.<br> sdptool browse shows permission denied on my headset address while hcitool dev responds fine. Also I created the asoundrc as from the example pointed to.<br> <br> Any ideas?<br> <br> Thanks.<br> I have a feeling it's something goofy.<br> -Walt<br> <br> <b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">
 Walt<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br> So where is plugz in terms of adoption? Like I was saying I don't see it anywhere in particular.... gentoo, ubuntu. (other  than CVS) </blockquote><div><br><br>some form of a2dpd etc from plugz will appear in the access linux platform. For the rest of us, plugz is a working example we refer back to when implementing the audio service that is going into bluez utils core. Then it will be deployed pretty widely. <br><br>Brad<br></div><br></div><br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing
 list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><div>        </div><hr size="1">Get the Yahoo! toolbar and <a href="http://us.rd.yahoo.com/evt=48225/*http://new.toolbar.yahoo.com/toolbar/features/mail/index.php">be alerted to new email </a>wherever you're surfing. -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;

<hr size=1>We won't tell. Get more on <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265
">shows you hate to love</a><br>(and love to hate): <a href="http://us.rd.yahoo.com/evt=49980/*http://tv.yahoo.com/collections/265
">Yahoo! TV's Guilty Pleasures list.</a>
--0-15538866-1182262900=:75241--


--===============0437111339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0437111339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0437111339==--
