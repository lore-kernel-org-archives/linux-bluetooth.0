Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 02 Apr 2007 23:12:48 +1200
To: bluez-devel@lists.sourceforge.net
From: "Jasper Mackenzie" <jasper@treshna.com>
MIME-Version: 1.0
Message-ID: <op.tp5lfmu1mz9ilx@rayleigh>
Subject: [Bluez-devel] Help getting Plugz going
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Gidday.

I am trying to get a JABRA BT135 working on my mums laptop with limited  
success.

Currently the older btsco way is 1/2 working, with mic working, poor  
quality, but working.
  The 'speaker' bit ... reciving audio is not working, as in theres no  
sound just a faint hiss, that starts and stops when the audio starts and  
stops, with beeps from the headest at appropriate times to indicate that  
it was recieving audio.
  btsco was run and compiled as per the Download and build instructions.

Due to the poor recording quality and the lack of playback, i figured that  
plugz would be the way to go.

I googled as much as i could for a more comprehensive howto on install ing  
and running Plugz, but only returned howtos for the btsco method,
Hence I am asking for help as to how to setup Plugz for an almost idiot.

What I tried:
  almost built from source, until i saw that debian has a bluetooth-alsa  
package (Debian Unstable)
copied .asoundrc to the home and root directories, ran headsetd -n
then tried to connect to the headset via various methods. Sorry dont have  
the box on hand, so i cant say what exact command i used to try and  
connect to the headset, but none of them produced any output from  
headsetd, and none produced any audio in te headset.

I wasnt sure whether or not I was to put the mac address of the headset in  
the asoundrc file or not, and if so where. it looked like these things  
were inherited from environmental variables.

so major concerns: what to do with asoundrc, how to run headsetd, and  
connect to headset.

The bluetooth adaptor is a D-Link cf card in a pcmcia converter, it is the  
HCI type (CSR) .. sorry all from crappy memory)

TIA

Jasper

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
