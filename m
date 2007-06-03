Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 3 Jun 2007 16:02:23 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706031548m725fa8c3wabcb72a10e15cfb5@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <718248.43136.qm@web62305.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] alsa module rebuild
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2137438407=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2137438407==
Content-Type: multipart/alternative; boundary="0-73131855-1180911743=:43136"
Content-Transfer-Encoding: 8bit

--0-73131855-1180911743=:43136
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

yes this is in all the kernels under include/linux/freezer.h.
 I don't see an include for it in the bt code.
 Without digging into it deeper I can't explain the 3 different behaviors...
 
 2.6.18 compiles fine
 2.6.20 warning (apparently deadly)
 2.6.21 where I am not gets pages of errors. My post of these held for admin approval due to length.
 
 Is it me or does the code not scale to later kernels?
 I'm lost.
 Thanks.
 -Walt

Brad Midgley <bmidgley@gmail.com> wrote: Walt

try_to_freeze seems to do something real if config_pm is defined and otherwise it is a trivial function. either way it should be there, at least in 2.6.17 in sched.h.

things may have changed more recently. 

Brad

 

       
---------------------------------
Pinpoint customers who are looking for what you sell. 
       
---------------------------------
Get the free Yahoo! toolbar and rest assured with the added security of spyware protection. 
--0-73131855-1180911743=:43136
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

yes this is in all the kernels under include/linux/freezer.h.<br> I don't see an include for it in the bt code.<br> Without digging into it deeper I can't explain the 3 different behaviors...<br> <br> 2.6.18 compiles fine<br> 2.6.20 warning (apparently deadly)<br> 2.6.21 where I am not gets pages of errors. My post of these held for admin approval due to length.<br> <br> Is it me or does the code not scale to later kernels?<br> I'm lost.<br> Thanks.<br> -Walt<br><br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Walt<br><br>try_to_freeze seems to do something real if config_pm is defined and otherwise it is a trivial function. either way it should be there, at least in 2.6.17 in sched.h.<br><br>things may have changed more recently. <br><br>Brad<br><br> </blockquote><br><p> 
      <hr size=1><a href="http://us.rd.yahoo.com/evt=48250/*http://searchmarketing.yahoo.com/arp/sponsoredsearch_v9.php?o=US2226&cmp=Yahoo&ctv=AprNI&s=Y&s2=EM&b=50">Pinpoint customers </a>who are looking for what you sell. <p>&#32;
      <hr size=1><a href="http://us.rd.yahoo.com/evt=48226/*http://new.toolbar.yahoo.com/toolbar/features/norton/index.php">Get the free Yahoo! toolbar</a> and rest assured with the added security of spyware protection.
 
--0-73131855-1180911743=:43136--


--===============2137438407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2137438407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2137438407==--
