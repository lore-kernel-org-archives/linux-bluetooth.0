Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5307d89f0708051338w35288418x915abd247233c324@mail.gmail.com>
Date: Sun, 5 Aug 2007 22:38:19 +0200
From: "Patrick Libert" <patrick.libert@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Info Dinovo LCD driver
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

Hello Marcel,

I patched bluez-utils succesfully for the Dinovo MEDIA Pad LCD driver.
The example program supplied with it works!
But it won't work automaticaly at startup.
This is the example of /etc/default/bluetooth:

HIDD_ENABLED=1
HIDD_OPTIONS="-i 00:07:61:45:5F:0D --connect 00:07:61:3E:15:1A --server"
                                  [_ this is my dongle
[_this is the Media Pad

So, when I startup my computer, I have to press one the keyboard Pad
buttons to activate the Media Pad,
then it's connected , the keyboard buttons works but the lcd won't work.
To get he lcd to work I have to do manually:
sudo hidd -i 00:07:61:45:5F:0D --connect 00:07:61:3E:15:1A, then the
lcd gets also activated.
I don't have to use the "--connect" option in /etc/default/bleutooth
for my keyoard and mouse! They work automatically.

I appreciate your help!

Kind regards,

Patrick Libert

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
