Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 16 Jun 2007 12:51:59 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706141217q4c88eb74mc5b8b6de0592775c@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <986615.21440.qm@web62301.mail.re1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============2101364671=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2101364671==
Content-Type: multipart/alternative; boundary="0-1195509256-1182023519=:21440"
Content-Transfer-Encoding: 8bit

--0-1195509256-1182023519=:21440
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok maybe this more appropriately describes my concern. I am using btsco. Why can't the code just use the alsa driver why must there be a headset component driver? ie I change the driver in skype to headset not alsa for my sound card.
 In my mind if that were the case it would always be a kernel component interfaced with that doesn't break in every release.
 
 Thanks for any info.
 -Walt
 
Brad Midgley <bmidgley@gmail.com> wrote: walt


 Isn't there an alsa interface that can be used without patching? 
 ie Do all applications that use alsa when it's in the kernel, patch?


I'm not sure what you're asking. Have you tried out plugz are you only talking about btsco? Also which headset are you working with? 

There is a recommended kernel patch regardless of which approach you use for voice headsets. See plugz/patches for the sco-flowcontrol patch.

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
Shape Yahoo! in your own image.  Join our Network Research Panel today!
--0-1195509256-1182023519=:21440
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ok maybe this more appropriately describes my concern. I am using btsco. Why can't the code just use the alsa driver why must there be a headset component driver? ie I change the driver in skype to headset not alsa for my sound card.<br> In my mind if that were the case it would always be a kernel component interfaced with that doesn't break in every release.<br> <br> Thanks for any info.<br> -Walt<br> <br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <b class="gmail_sendername">walt<br><br></b><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br> Isn't there an alsa interface that can be used without patching? <br> ie Do all applications that use alsa when it's in the kernel, patch?</blockquote></div><br><br>I'm not sure what you're asking. Have you tried out
 plugz are you only talking about btsco? Also which headset are you working with? <br><br>There is a recommended kernel patch regardless of which approach you use for voice headsets. See plugz/patches for the sco-flowcontrol patch.<br><br>Brad<br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
      <hr size=1>Shape Yahoo! in your own image.  
<a href="http://us.rd.yahoo.com/evt=48517/*http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7">Join our Network Research Panel today!</a>

--0-1195509256-1182023519=:21440--


--===============2101364671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2101364671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2101364671==--
