Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <cpp4n0$4b3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] fedora3-BluetrekG2 log
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
Date: Wed, 15 Dec 2004 11:46:10 +0100

This is something like a log of what I've done in order to give headset 
support to a Fedora Core 3 new fresh installation. It is specific to the 
Bluetrek G2 headset.

____________________________________

0.-  I installed Fedora Core 3, workstation installation set. 
Additionally, I selected gnome-bluetooth package. The installed kernel 
is 2.6.9-1.667, and the current bluez rpms are the following:

[root@castejon ~]# rpm -qa | grep bluez
bluez-hcidump-1.11-1
bluez-utils-2.10-2
bluez-pin-0.23-3
bluez-libs-2.10-2
bluez-bluefw-1.0-6

I didn't touch anything relevant for the system behaviour now.
____________________________________

1.- I tried to look for Fedora rpm's updated versions of these packages 
but I didn't find them.
____________________________________

2.- For headset support I went to http://bluetooth-alsa.sourceforge.net/ 
and try to follow the build process. Nevertheless I found myself in some 
newbie troubles:
____________________________________

3.- I checked out the CVS repository

	cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
____________________________________

4.- I tried to compile

         ./bootstrap
         ./configure
____________________________________

5- I got the following error:
	...some info...
	./configure: line 3249: XIPH_PATH_AO: command not found
	...some info...
____________________________________

6.- As Marcel indicated in 
http://sourceforge.net/mailarchive/message.php?msg_id=10127139, the 
problem solves by installing libao-devel package (I found it at rpmfind.net)
____________________________________

7.- Now I went back to point 4 and try to compile again
	./bootstrap
         ./configure
	make
At this point make spat out lots of errors but all related to  not 
finding bluetooth.h and other libs, and blah, blah, blah..
____________________________________

8.- I downloaded and installed very successfully bluez-libs-2.12.tar.gz 
from http://www.bluez.org/download.html with ./configure, make, make 
install stuff,
____________________________________

9.- I went back to point 7 and installed btsco without problems
	
         make
         make install
         make maintainer-clean

         cd kernel
         make
         make install
         make clean
____________________________________

10.- Now, as indicated by Marcel I run depmod -e (does depmod -a also 
works?) because I was having problems for the next point, trying to load 
the snd_bt_sco module so I did:
	
	depmod -e
	modprobe snd_bt_sco

I guess the system is now prepared to meet a headset...
____________________________________
		
11.- From this point I'll log the steps I follow each time I wish to 
connect the headset,from a well known state (reboot), well, except that 
I already have to run manually "modprobe snd_bt_sco" because I haven't 
fix that "alias snd-card-0 snd_bt_sco" line in modules.conf (it seems 
that in this distribution the file is named modprobe.conf and has 
different format?) So, first of all I will stop the esound controller in 
case it's running

         esdctl stop
____________________________________

12.- I Set up local bluetooth device and daemon
	hciconfig hci0 up
	hcid
____________________________________

13.- At this moment I powered on the headset and brougth it to scanning 
mode (so the led is flicking in red and fashion blue)
____________________________________

14.- Run the btsco daemon with the headset's BT address

	[root@panzano ~]# btsco 00:06:C5:04:BB:54
	Device is 1:0

At this time, a notification window pops up claiming for the pin code. 
(Default is 0000). Entering the correct pin results in some interesting 
output from btsco:
	Device is 1:0
	Voice setting: 0x0060
	RFCOMM channel 1 connected
____________________________________

15.- btsco daemon was waiting for a confirmation so I should push the 
headset connect button. It suddenly shout a big bip (be careful, it 
hurts) and the connection is stablished (I can hear the channel noise)
The output from btsc is now something like this

[root@panzano ~]# btsco 00:06:C5:04:BB:54
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+VGS=10
Sending up speaker change 10
recieved AT+CKPD=200
....
____________________________________

16.- now I can send audio from the headset with something like
         [root@panzano ~]# aplay -B 1000000 -D plughw:Headset sound.wav
	or
	[root@panzano ~]# aplay -D plughw:Headset sound.wav

altough I have noticed that something like
	aplay -B 1000000 -D plughw:Headset /other/path/to/sound.wav
won't work
____________________________________

17.- My purpose now is to be able to terminate VoIP calls at the 
headset. Maybe it could be done easily redirecting all sound stream to 
the snd-card-0 device, or maybe it's difficult enough to figure out? I 
don't know, is somebody doing this by now?

______________________

thanks to all, your information and development is being great



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
