Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 5 Mar 2007 12:41:34 -0800 (PST)
From: walt shekrota <penguinacity@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <190537.59911.qm@web62311.mail.re1.yahoo.com>
Subject: [Bluez-users] Bluez and Alsa vs OSS!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0067832192=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0067832192==
Content-Type: multipart/alternative; boundary="0-1196144331-1173127294=:59911"
Content-Transfer-Encoding: 8bit

--0-1196144331-1173127294=:59911
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have my headset working reasonably with a kernel that has Alsa enabled but not the OSS emulation ie I do not have a /dev/dsp sym link. Works good.
 Now I decided I needed the OSS enabled as there are some older apps I cannot use without the emulation. I redid the kernel and came up with it. The proper OSS device sym links show up in dev and work properly yet the whole headset discovery issue goes out the window. Alsa appears to work fine
 When invoking btsco it discovers the proper card and device but the open fails saying device does not exist.
 Does anyone know this issue?
 
 Thanks for any help.
 -Walt
 
 
---------------------------------
Now that's room service! Choose from over 150,000 hotels 
in 45,000 destinations on Yahoo! Travel to find your fit.
--0-1196144331-1173127294=:59911
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have my headset working reasonably with a kernel that has Alsa enabled but not the OSS emulation ie I do not have a /dev/dsp sym link. Works good.<br> Now I decided I needed the OSS enabled as there are some older apps I cannot use without the emulation. I redid the kernel and came up with it. The proper OSS device sym links show up in dev and work properly yet the whole headset discovery issue goes out the window. Alsa appears to work fine<br> When invoking btsco it discovers the proper card and device but the open fails saying device does not exist.<br> Does anyone know this issue?<br> <br> Thanks for any help.<br> -Walt<br> <p>&#32;

<hr size=1>Now that's room service! <a href="http://travel.yahoo.com/hotelsearchpage;_ylc=X3oDMTFtaTIzNXVjBF9TAzk3NDA3NTg5BF9zAzI3MTk0ODEEcG9zAzIEc2VjA21haWx0YWdsaW5lBHNsawNxMS0wNw--
">Choose from over 150,000 hotels <br>in 45,000 destinations on Yahoo! Travel</a> to find your fit.
--0-1196144331-1173127294=:59911--


--===============0067832192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0067832192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0067832192==--
