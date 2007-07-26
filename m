Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46A8962A.2010207@yandex.ru>
Date: Thu, 26 Jul 2007 16:40:10 +0400
From: Irakli Tsagareli <itsagareli@yandex.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] simultaneous read/write on SCO channel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I'm writing a small code to test HandsFree capabilities between my phone 
and PC. everything works fine for audio playback (on the PC, I can hear 
sound file played on the phone and in case of incoming call, I can hear 
a voice of remote subscriber) but when I try at the same time to send 
some audio data to the handset via same socket, send() function returns 
"Invalid argument" error. I tried to create new socket for writing (same 
way I created listening socket), creation succeeds, but connect fails 
with "Device or resource busy". can anybody be so kind and explain, how 
can I read and write data through SCO channel simultaneously ?

thank you and best regards,
kern.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
