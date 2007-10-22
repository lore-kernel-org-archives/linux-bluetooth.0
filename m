Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <88a477560710220150y756f8e7dj333b46eb5d9f6f68@mail.gmail.com>
Date: Mon, 22 Oct 2007 10:50:44 +0200
From: "Matthias Teege" <mteege@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Authorization denied: Authorization agent does not
	exist
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

Moin,

I try to use my bluetooth mouse with bluez under opensuse 10.3. I've
used the instructions on the bluez wiki to pair and activate the
mouse:

% dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez org.bluez.Manager.ActivateService string:input
method return sender=:1.2 -> dest=:1.336
   string ":1.3"

% dbus-send --system --type=method_call --print-reply --dest=":1.3"
/org/bluez/input org.bluez.input.Manager.CreateDevice
string:00:02:76:00:D3:12
method return sender=:1.3 -> dest=:1.505
   string "/org/bluez/input/pointing0"

I can connect from the notebook to the mouse with:

% dbus-send --system --type=method_call --print-reply --dest=":1.3"
/org/bluez/input/pointing0 org.bluez.input.Device.Connect
method return sender=:1.3 -> dest=:1.3038

Now I try to reconnect automatically which doesn't work as expected.
If I press a button on the mouse I've got

Oct 22 10:33:57 sus input[2846]: Incoming connection on PSM 17
Oct 22 10:33:58 sus input[2846]: Incoming connection on PSM 19
Oct 22 10:33:58 sus input[2846]: Authorization denied: Authorization
agent does not exist

How Do I disable the need for authorisation for my mouse?

Many thanks
Matthias

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
