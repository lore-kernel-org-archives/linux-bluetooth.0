Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041021080034.18912.qmail@web41109.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Limit to maximum UDP packet size
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 21 Oct 2004 01:00:34 -0700 (PDT)

Hi 

I have set up a PAN between two notebooks. I've
managed to stream data using udp packets from one
computer to another and it works fine. My problem
occurs when I send udp packet sizes larger than 55000
bytes. When I do an ifconfig, it seems that bytes are
being sent out from one computer to another but my
program refuses to read the data from the packets. 

My program is just a simple program that sends data
fro one computer to another with no fancy code. Why
should udp behave like this?

Besides that I think you guys are doing a great job
with bluez!!


		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
