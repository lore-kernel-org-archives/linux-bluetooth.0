Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Hunyue Yau <hyau@mvista.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Tue, 30 Oct 2007 18:36:54 -0700
MIME-Version: 1.0
Message-Id: <200710301836.55311.hyau@mvista.com>
Subject: [Bluez-devel] Synchronization between SCO audio and HCI command
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I am looking at crash that happens during the close of the SCO socket 
after playing a moderately long (around 3-4 minutes) audio file.
Kernel version is 2.6.21 with the SCO audio patch version 4.2. Audio
is a 16bit, 8KHz wav file played through ALSA emulation using the plugz
ALSA plugins and headsetd. The bluetooth interface is a USB dongle with a 
CSR radio (Actiontec branded).  Command used to play it is:
aplay -D headset -B 1000000 p3.wav
where p3.wav s a 2997592 byte long 16bit, mono 8KHz wav file.
Audio plays until the close happens then it gets truncated. 

I have debugged the problem down to a synchronization issue between the
HCI command and the SCO data path. What happens is when userspace
closes the socket, it causes the OCF_DISCONNECT command to be sent after 
10ms. From net/bluetooth/sco.c:sco_chan_del() as part of hci_conn_put. The timer 
calls hci_conn_timeout in net/bluetooth/hci_conn.c which sends the command.

For the case of a USB dongle driven by drivers/bluetooth/hci_usb.c, commands
and SCO data are on different queues. So with a sufficiently long audio stream, 
there could be up to an entire socket buffer full of SKB's sitting in hci_usb.c's 
transmit queue. I have measured about 1 minute of audio which roughly works
out to be about 200K+. 

Since they are on different queues, the USB dongle can (and in this case, does) 
receive the OCF_DISCONNECT command before the SCO data is drained from the
queue. This upsets the dongle and causes it to reset itself since it continues to 
receive the SCO data after the OCF_DISCONNECT command. I have verified the
dongle has received the command with a USB sniffer and the dongle has 
acknowledge completion afterwhich it continues to receive data. 

Has anyone seen this and is there a way to synchronize the data? From what I
can tell, as soon as things are passed to hci_usb, there is no way the upper hci
layers can determine if the data associated with the original connection has 
really reached the bluetooth hardware. This does not appear to be a problem on
other hardware as they only have one queue (btuart.c is what I looked at.)

One possible work around is to blindly increase the timeout in hci_conn_put but has
other side effects and could be broken by increasing the socket buffers.

Thanks.

-- Hunyue

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
