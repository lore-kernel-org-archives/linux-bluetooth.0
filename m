Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Benjamin Eikel <benjamin@eikel.org>
Message-ID: <loom.20060209T124135-748@post.gmane.org>
References: <200602022157.52386.benjamin@eikel.org> <loom.20060205T233729-763@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Pairing a bluetooth keyboard
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
Date: Thu, 9 Feb 2006 11:45:11 +0000 (UTC)

>

Hello again,

I am wondering why nobody responds to my questions. If I am doing anything wrong
please tell me. I really do not know why this is not working and I did not find
anything about that on this mailing list or in the BlueZ documentation files.

Maybe you need more information so I logged some data with 'hcidump -X -V'. I
uploaded the log files because I do not want to post such a long text on this
mailing list. If this behaviour is not right, please tell me and I will post the
logs here.
I am using the same laptop, Bluetooth dongle and keyboard as in my first post.
First I did:

root@host:~# hcitool scan
Scanning ...
        00:KE:YB:OA:RD:00       Logitech Elite Keyboard
root@host:~# hidd --connect 00:KE:YB:OA:RD:00

The log is here: http://www.eikel.org/temp/hcidump-connect.log
After that I was able to type on the Bluetooth keyboard and everything was
working. Then I wanted to authorize and encrypt the connection:

root@host:~# hcitool auth 00:KE:YB:OA:RD:00
0000
HCI authentication request failed: Connection timed out

Same problem as in my first post, but I have logged it. Here is the file:
http://www.eikel.org/temp/hcidump-auth.log

Of course I have read these logs but I do not get any useful information from
it. There are two errors in the second log.
First:
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x02 bdaddr 00:KE:YB:OA:RD:00
    Error: Unknown Connection Identifier

Second:
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x1f handle 7 ptype 0x0008
    Error: Unspecified Error

But I do not know what these error messages want to tell me and what I could do
to get this working.

Maybe someone of you could be so friendly to tell me what I should do to get
this encryption working. Or tell me that it is impossible. Or tell me that I am
wrong here and where I should ask instead.

Regards,
Benjamin Eikel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
