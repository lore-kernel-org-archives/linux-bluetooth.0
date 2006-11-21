Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 21 Nov 2006 23:29:49 +0100
From: Alexandre Campo <Alexandre.Campo@ulb.ac.be>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061121232949.07b6fc6f@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] impact of distance on quality of transmission ?
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

I am working with a bunch of robots and I communicate with them using bluetooth connections.
I am trying to receive data from 7 robots at the same time.

For this, I simply connect to each robot using a program linked against libbluetooth,
that makes use of sockets and rfcomm.

Using only one robot, we manage to receive pretty well the data.
Using 7 robots things get complicated. If robots are close (~1 meter) from the bluetooth
dongle, we receive all the data.

As soon as the robots are far from the dongle (~2 meters and more) we start observing errors
in the data transmitted.

I am surprised because :
* we do not exceed the bt bandwidth (< 800 kb/s)
* we use SOCK_STREAM sockets that are supposed to be reliable

My questions :
* any idea of what causes these mistakes ?
* how to avoid transmission errors ?


Thanks a lot for your help,
Alexandre Campo.


------------------------------------------------------------------------

Details :
I use a belkin bt usb adapter (100m range)

info from usbview : 

BCM92045DG Non-UHE
Manufacturer: Broadcom Corp
Speed: 12Mb/s (full)
USB Version:  2.00

The robots have 

a bluetooth serial port module :
http://www.national.com/pf/LM/LMX9820A.html#General%20Description

a phycomp 2.45 GHz antenna :
http://www.phycomp-components.com/ (website unavailable ?)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
