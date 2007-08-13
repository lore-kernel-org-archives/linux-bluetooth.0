Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 13 Aug 2007 08:53:52 -0700 (PDT)
From: Je Co <hulcjje@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <46C05A50.10004@gmail.com>
MIME-Version: 1.0
Message-ID: <910003.94030.qm@web32408.mail.mud.yahoo.com>
Subject: [Bluez-users] OBEXFTP: Mavin? Whats the default PIN?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1865427670=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1865427670==
Content-Type: multipart/alternative; boundary="0-1052593917-1187020432=:94030"
Content-Transfer-Encoding: 8bit

--0-1052593917-1187020432=:94030
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

After your help, I installed d-bus and I was able to use hciconfig,  hcitools.
My Absolute-box sees my SE K750i.

My biggest need is to get mp3 files to the phone. When this is working (pffff),  I will try to get pictures of the phone to the laptop. In the end I hope to do things with my agenda.

Googling around learned me I had to use OpenObex/Obexftp to transfer files between laptop and phone. I managed to install this software (I think).

Eventually, I could give the command 'obexftp -b -p somefile'. Scanning starts,  phone is found, tries to connect on channel 6, phone asks if unknown device is permitted to have access, and then it asks for a PIN. All seems ok, it's like when I'm using my windows-machine.

But where can I find the PIN? Googling learned there should be a file PIN in the /etc/bluetooth-dir. It isn't there. I made one, but that didn't have any effect. 

Googling learned there's a prog which is needed to tranfer the PIN? All the commands I encountered were not recognized. Do I need extra software (I'm not using KDE or Gnome, so don't have access to some tools which are mentioned). 

I looked into the hcid.conf, but it seems to me it's all about incoming (to the laptop) connections? I hoped to get rid off the PIN with 'security none', but  that didn't help either.

What also puzzles me is that the phone tells me ' mavin'  tries to connect.  
According to what I read, I expected 'BlueZ' (found this also in hcid.conf). 'mavin' seems to be a (hard to configure) CF-card, I'm working with an USB-dongle (lsusb doesn't show 'mavin', I expected it to see there).

I'v got the feeling I'm close to the solution, but after hours of trying/searching, please help.

(Another unsolved issue is that when I ask the phone to search for bluetooth-devices, my laptop doesn't show up).

Thanks in advance,
Jeu

   



 
  
       
---------------------------------
Park yourself in front of a world of choices in alternative vehicles.
Visit the Yahoo! Auto Green Center.
--0-1052593917-1187020432=:94030
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

After your help, I installed d-bus and I was able to use hciconfig,&nbsp; hcitools.<br>My Absolute-box sees my SE K750i.<br><br>My biggest need is to get mp3 files to the phone. When this is working (pffff),&nbsp; I will try to get pictures of the phone to the laptop. In the end I hope to do things with my agenda.<br><br>Googling around learned me I had to use OpenObex/Obexftp to transfer files between laptop and phone. I managed to install this software (I think).<br><br>Eventually, I could give the command 'obexftp -b -p somefile'. Scanning starts,&nbsp; phone is found, tries to connect on channel 6, phone asks if unknown device is permitted to have access, and then it asks for a PIN. All seems ok, it's like when I'm using my windows-machine.<br><br>But where can I find the PIN? Googling learned there should be a file PIN in the /etc/bluetooth-dir. It isn't there. I made one, but that didn't have any effect. <br><br>Googling learned there's a prog which is needed to
 tranfer the PIN? All the commands I encountered were not recognized. Do I need extra software (I'm not using KDE or Gnome, so don't have access to some tools which are mentioned). <br><br>I looked into the hcid.conf, but it seems to me it's all about incoming (to the laptop) connections? I hoped to get rid off the PIN with 'security none', but&nbsp; that didn't help either.<br><br>What also puzzles me is that the phone tells me ' mavin'&nbsp; tries to connect.&nbsp; <br>According to what I read, I expected 'BlueZ' (found this also in hcid.conf). 'mavin' seems to be a (hard to configure) CF-card, I'm working with an USB-dongle (lsusb doesn't show 'mavin', I expected it to see there).<br><br>I'v got the feeling I'm close to the solution, but after hours of trying/searching, please help.<br><br>(Another unsolved issue is that when I ask the phone to search for bluetooth-devices, my laptop doesn't show up).<br><br>Thanks in advance,<br>Jeu<br><br>&nbsp; 
 <br><br><br><br>&nbsp;<br>  <p>&#32;



      <hr size=1>Park yourself in front of a world of choices in alternative vehicles.<br><a href="http://us.rd.yahoo.com/evt=48246/*http://autos.yahoo.com/green_center/;_ylc=X3oDMTE5cDF2bXZzBF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDZ3JlZW4tY2VudGVy">Visit the Yahoo! Auto Green Center.</a>
--0-1052593917-1187020432=:94030--


--===============1865427670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1865427670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1865427670==--
