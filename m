Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051206094558.26664.qmail@web36103.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051205113634.GA5487@acs.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Bluetooth-alsa Project :::: Not clear documentation
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
Date: Tue, 6 Dec 2005 01:45:58 -0800 (PST)

Hello,
The site "http://bluetooth-alsa.sourceforge.net/"
which discusses how to  use a bluetooth headset with
Linux, the steps explained in it is not at all clear
for example he asks us to 
# Install or update the required packages:

    * automake-1.7
    * libbluetooth-dev (aka libbluetooth-devel or
bluetooth-devel or bluez-libs)
    * libasound2-dev (aka alsa-devel)
    * a recent (2.6.11.7 or newer) kernel with
*integrated* alsa enabled (it won't work with the
"standalone" alsa drivers that are a separate download
from the kernel) 

Can i know where can i download the packages
libbluetooth-dev, libasound2-dev ?

2)Using SCO audio

   1. insert the module (or better, set up the alsa
configuration to load it)
   modprobe snd_bt_sco

Can somebody tell me where to find this snd_bt_sco
modlue ?


Pls somebody help me with this or give a clear picture
of how to proceed as i am stuck.

Thanks & Warm Regards,
Swathi

 


--- Andreas Beck <becka-bzus@bedatec.de> wrote:

> Swathi Mathur80 <swathi_mathur80@yahoo.com> wrote:
> > I want to do an audio transfer from an PC to an
> > headset and not from an headset to an PC. 
> 
> Direction doesn't quite matter, as it is a
> bidirectional link.
> 
> > I think i don't need the ALSA module as i don't
> intend to play
> > the audio file on my PC. 
> 
> Wrong. You need it, as the headset gets mapped as an
> audio device
> on the PC. 
> 
> > Can someone tell me what all the modules needed to
> be installed 
> 
> Read the bluetooth-alsa pages at
> http://bluetooth-alsa.sourceforge.net/
> 
> 
> CU, Andy
> 
> -- 
> = Andreas Beck                    |  Email : 
> <becka-sig@bedatec.de>         =
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
