Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45312FB1.5090600@drick.de>
Date: Sat, 14 Oct 2006 20:42:57 +0200
From: Timo Drick <timo@drick.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] How to execute a command on link_key_request?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

i set up my headset with a usb bluetooth dongle. With bluez and btsco it 
works very well. I am able to use it with any voip application.
But i have to start btsco <address of headset> every time i want to 
establish a connection to the headset.
I see in the syslog that hcid receive following message every time i 
turn on my headset:
hcid[4593]: link_key_request (sba=00:0A:3A:6B:XX:XX, dba=00:0D:44:5C:XX:XX)

So is it possible to execute a command (e.g. btsco) when such request is 
received?
If btsco is up i can modify the .btscorc file to catch commands from my 
headset. So that is not the question.

best regards
       Timo Drick

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
