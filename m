Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41EB8C5C.2090708@cc.hut.fi>
From: Heikki Vuolteenaho <hvuoltee@cc.hut.fi>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Receiving multiple (>2) incoming rfcomm connections?
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
Date: Mon, 17 Jan 2005 11:58:52 +0200

Hi all,

I'm trying to create a simple application that receives incoming rfcomm 
connections from Nokia Series60 phones and listens for incoming data.

This is how I'm doing it currently:

for (i = 1...n) {
   Listen on channel 1, rfcomm port i (rfcomm listen i)
   Wait until incoming connection received
   Start a new thread that handles incoming data on /dev/rfcomm<i>
}


For one or two connections, it works ok. However, when I try to connect 
a third device, nothing happens. Nothing shows up even on hcidump when I 
try to connect the third phone. On the phone I receive error 
EPageTimedOut(-6004), which according to my friend means that the phone 
could not get any kind of connection.

Any ideas why it's not working? Thanks in advance,

-Hege-



Setup details:
-Compaq Evo laptop with Debian
-Conceptronic USB BT (CSR)
-Various Nokia phones (6630, 6600, Ngage, 3650)
-Python pyserial module for reading the serial port



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
