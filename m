Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43B58827.1020102@mackintoshweb.com>
From: Terry Mackintosh <terry@mackintoshweb.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Authentication problem
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
Date: Fri, 30 Dec 2005 14:19:03 -0500

Hi

While I've read FAQs and HOWTOs on bluethooth until I'm about blue, the 
solution to my problem evades me.

What I have:
Old PII laptop running ROCK Linux, 2.4.24 kernel
Kensington USB bluetooth adapter.
Motorola V710 picture phone, new

What I want to do:
Get pictures off the phone and onto the laptop.

Progress so far:
The hardware all seems to be working.
The software mostly seems to be working.
The phone is seen from the laptop by the command line tools.

The problem:
Any attempt to make a connection with the phone results in the phone 
popping a dialog box that asks if it is OK to bond, followed by a 
request for a PIN.
No matter what PIN is given, it is always wrong. I have done "echo 1234 
 > /etc/bluetooth/pin" to no avail.
On the laptop side, the PIN aspect of the conversation is seen as an 
"Invalid exchange" when doing:

sdptool browse 00:15:A8:E4:F5:6B

When doing:
hcitool cc 00:15:A8:E4:F5:6B

it quits instantly complaining of a time out, but never waiting for any 
response from the phone.
The phone again pops a dialog asking "Bond with ...?", then a PIN 
prompt, but the PIN fails and hcitool timed out long ago anyway.

I looked at the log, it just confirmed the above in more detail.

Any help greatly appreciated.
Thanks

-- 
Terry Mackintosh <terry@mackintoshweb.com>
http://www.mackintoshweb.com/mars/ Mars Society, FL chapter.
Proudly powered by ROCKLinux, Apache, PHP, PostgreSQL, etc.
"If you don't know where you are going, how can you get there?"


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
