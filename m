Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473A9B06.8040108@moussaud.org>
Date: Wed, 14 Nov 2007 07:51:50 +0100
From: David MOUSSAUD <david@moussaud.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] [bluez-users] Problem activating audio service
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

Hi,

I'am trying to activate audio service for my bluetooth USB adapter 
(Berlkin FBT003).
I've installed the last bluez-lib (3.22) and bluez utils (3.22).

I've succeeded in pairing my bluetooth headset by when i'm trying to 
activate the audio service through dbus :
$dbus-send --system --print-reply --dest=org.bluez /org/bluez 
org.bluez.Manager.ActivateService string:audio
Error org.bluez.Error.NoSuchService: No such service

So i can't retrieve the unique bus name to create my headset object with 
dbus.

I'd like to use my headset for VoIp  application such Skype or Linphone.

Thanks for you help.

David

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
