Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050521130837.51168.qmail@web42001.mail.yahoo.com>
From: neelam goyal <neelam_minati@yahoo.com>
To: bluez-users@lists.sf.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1170885852-1116680917=:50140"
Subject: [Bluez-users] Problem with rfcomm!!
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
Date: Sat, 21 May 2005 06:08:37 -0700 (PDT)

--0-1170885852-1116680917=:50140
Content-Type: text/plain; charset=us-ascii

Hi,
 
I am Neelam working for Hewlett Packard Labs, India.
 
I am working on a project in which I need to send character string via Bluetooth from Linux Box to an application running on an iPAQ.
 
I am using Bluez on Linux for bluetooth support.
 
And for sending the string to the iPAQ i am connecting by rfcomm and then just cat a text file to the rfcomm device.
 
The commands I use are:
 
rfcomm connect /dev/rfcomm0 <dev addr> <channel no>
 
and the in another terminal i do:
 
cat test.txt > /dev/rfcomm0
 
The problem i am facing is with the number of characters my application receives.I have tried it on two kernels viz. 2.6.9 and 2.6.10........
 
it is working perfectly fine with 2.6.9 but in case of 2.6.20 only 19 characters are being send.......i just can't understand the reason........
 
Could anyone please help?
 
Thanks and regards
Neelam

		
---------------------------------
Do you Yahoo!?
 Make Yahoo! your home page   
--0-1170885852-1116680917=:50140
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am Neelam working for Hewlett Packard Labs, India.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am working on a project in which I need to send character string via Bluetooth from Linux Box to an application running on an iPAQ.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am using Bluez on Linux for bluetooth support.</DIV>
<DIV>&nbsp;</DIV>
<DIV>And for sending the string to the iPAQ i am connecting by rfcomm and then just cat a text file to the rfcomm device.</DIV>
<DIV>&nbsp;</DIV>
<DIV>The commands I use are:</DIV>
<DIV>&nbsp;</DIV>
<DIV>rfcomm connect /dev/rfcomm0 &lt;dev addr&gt; &lt;channel no&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>and the in another terminal i do:</DIV>
<DIV>&nbsp;</DIV>
<DIV>cat test.txt &gt; /dev/rfcomm0</DIV>
<DIV>&nbsp;</DIV>
<DIV>The problem i am facing is with the number of characters my application receives.I have tried it on two kernels viz. 2.6.9 and 2.6.10........</DIV>
<DIV>&nbsp;</DIV>
<DIV>it is working perfectly fine with 2.6.9 but in case of 2.6.20 only 19 characters are being send.......i just can't understand the reason........</DIV>
<DIV>&nbsp;</DIV>
<DIV>Could anyone please help?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks and regards</DIV>
<DIV>Neelam</DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
<a href="http://us.rd.yahoo.com/my/navbar/sethp/*http://www.yahoo.com/r/hs 
">Make Yahoo! your home page</a> 
 
 

--0-1170885852-1116680917=:50140--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
