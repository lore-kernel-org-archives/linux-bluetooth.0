Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?iso-8859-1?q?G=F6tz_Issel?= <me@goetzi.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603071619.11837.me@goetzi.de>
Subject: [Bluez-devel] SIM access profile & bluez ?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 7 Mar 2006 16:19:11 +0100

Hi folks, 

my aim is to use bluez and add the SIM access profile to it. I have a GSM 
module via serial port that also has its own SIM card reader as well as 
integrated audio-in and audio-out. The bluetooth hardware is also available 
via serial port and working with bluez & utils so far. My mobile phone is 
intended to be the card server, my linux machine the client.

The idea is to make the software somewhat general so that it will work with 
other bt and gsm hardware. 

My plan is to have an application (command line tool for now), that will be 
the controller of all interactions. So it will: 

- initialize the search to find  suitable devices (using sdp that comes with 
bluez)

- show search results and make a selection of a device possible (for the 
beginning this will only be a txt file as output and input)

- check the requirements of the connection and establish it (serial profile)

- ask for sap pin exchange (16 digits), gain txt file as input replacement

- ask for sim card pin (4 digits)
...

Are there any design ideas from anyone? Not asking for ready made solutions. 
Just wondering if the above mentioned plan is the right idea. I am not sure 
where to integrate the SAP profile still. 

thx,
goetz


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
