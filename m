Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] BT unter SuSE 9.2
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAp9jfLDv6IEmP6zr7RmCWTAEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1102599865.9988.210.camel@pegasus>
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
Date: Thu, 9 Dec 2004 15:39:54 +0100

Hi Marcel,

##>
##>> ##>maybe you simply have to run YaST once and activate Bluetooth.
##>> 
##>> In the meantime, I'm able to establish a connection to teh 
##>> Bluetooth-Modul. I solved the problem by the boot-command 
##>pci=noapci
##>
##>to what? Either it is "noapic" or "noacpi".

you are right boot-command is pci=noacpi

##>
##>Do you configured it with YaST? Otherwise the deamons might 
##>not start and don't forget to set your PIN.

the PIN is set, but - it seems so - not accepted by the BT-accesspoint,
although it is the same PIN - BT-accesspoint and Linux. I configured all by
YaST, only the dmabt I have to start seperately by the line-editor. How to
start it automatically?


##>Don't touch it. Check with "hcidump -X" what is going on.

I have to reboot with Linux in order to check this. The results later on!

Regards
Peter





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
