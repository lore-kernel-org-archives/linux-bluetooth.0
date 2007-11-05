Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Mon, 5 Nov 2007 16:30:57 +0530
Message-ID: <019301c81f9b$24d85b50$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <20071105091147.GA23820@localhost>
Subject: Re: [Bluez-users] Problem with HSP/HFP in bluez-3.22
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

Hi Johan
Thanks for your help. I was earlier testing it with an application which had
HF service registered and not HS. Now I tested with Nokia HS-12W and it
works fine.  


Regards,
Sumeet 
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Johan
Hedberg
Sent: Monday, November 05, 2007 2:42 PM
To: BlueZ users
Subject: Re: [Bluez-users] Problem with HSP/HFP in bluez-3.22

Hi,

On Mon, Nov 05, 2007, Sumeet VERMA wrote:
> [root@dlhl0330 audio]# dbus-send --system --print-reply 
> --type=method_call --dest=:1.3 /org/bluez/audio 
> org.bluez.audio.Manager.CreateHeadset string:XX:XX:XX:11:65:00 method
return sender=:1.3 -> dest=:1.19  string "/org/bluez/audio/device3"
> [root@dlhl0330 audio]# dbus-send --system --print-reply 
> --type=method_call --dest=:1.3 /org/bluez/audio/device3 
> org.bluez.audio.Headset.Connect Error 
> org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with 
> signature "" on interface "org.bluez.audio.Headset" doesn't exist

The CreateHeadset method should actually be considered deprecated.
Currently it simply maps to CreateDevice so you might as well use that
instead. This is also the reason why you don't get an error for this call.
It seems that a HSP service record was not found on the remote device and
the Headset D-Bus interface is therefore not available for the created
object.

Are you sure the headset supports HSP? Can you discover it e.g. through
sdptool search --bdaddr <bdaddr> HS

What is the model of your headset?

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
