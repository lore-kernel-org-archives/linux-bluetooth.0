Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Cc: lessig@uni-weimar.de
From: Christian.Lessig@t-online.de
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1AbdUK-1W3pE80@cmpmail03.bbul.t-online.de>
Subject: [Bluez-users] problems setting up an SPP profile connection
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
Date: Wed, 31 Dec 2003 11:22:04 +0100

Hallo,

I've got problems to set up an SPP (serial port profile) connection. I
can connect and bind to the second device (a bluetooth chip for
industrial purpose) but I don't know how to receive messages. In the
assumption that rfcomm0 behaves like ttyS0 I wrote a little C programm
where I open the rfcomm0-file, set the parameter, write something and
wait for response. But I don't receive anything.

When I connect under Windows and send AT commands over the hyperterminal
it works and the device is responding.
 
I also tried to use the rfcommd. I thought propably I need the daemon to
receive messages, but direct after starting it exits. I found nowhere a
appropriate config file for rfcommd so I used this:

session_x {
  channel 1;
}

Regards,

Christian Lessig, Bauhaus University Weimar




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
