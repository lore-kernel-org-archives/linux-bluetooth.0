Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Conflict bluetooth and soundcard
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAklRz+OMPMEe49ORKn91EJAEAAAAA@t-online.de>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAklRz+OMPMEe49ORKn91EJAEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200412221041.57016.cijoml@volny.cz>
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
Date: Wed, 22 Dec 2004 10:41:57 +0100

Compile and use LATEST vanilla kernel 2.6.10-rc3 and let us know about 
success.

We NEVER give help to users using vendor kernels.

Michal

Dne st 22. prosince 2004 10:27 Peter K. Martin napsal(a):
> Hi Marcel,
> again thanks a lot for your help. The problem of the bt-connection to the
> accesspoint seems to be solved. I have a littel additional question. There
> seems to be a confict between dmabt and the soundcard. When the soundcard
> is correctly installed, dmabt give the massage can't access bt-device. Then
> I reboot linux with the bootoption ACPI=oldboot --> dmabt works without any
> message and I'm able to reinstall the soundcard by YaST. But the next boot
> without bootoption give the same result, so I can use either dmabt or
> soundcard, They seem to use the same irq or dma-channel. How is this to be
> changed for dmabt???
>
> Regards
> Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
