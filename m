Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: AW: [Bluez-users] Conflict bluetooth and soundcard
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAejKkYMP2t0iWvwvgIRffgQEAAAAA@t-online.de>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAejKkYMP2t0iWvwvgIRffgQEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412221212.32080.cijoml@volny.cz>
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
Date: Wed, 22 Dec 2004 12:12:32 +0100

Dne st 22. prosince 2004 11:49 Peter K. Martin napsal(a):
> Hi Michal,
>
> ##>
> ##>Compile and use LATEST vanilla kernel 2.6.10-rc3 and let us
> ##>know about
> ##>success.
> ##>
>
> I'm using SuSE 9.2 with kernel 2.6.8-24.5 and recompiled dmabt but no
> positiv result. Again the message Can't access Toshiba device /dev/toshiba
> occured. Then soundcard is also uncorrectly installed but this is to be
> solved by YaST at Sound --> options --> reset all.
> But the target is to have both available dmabt (bluetooth-function on of
> Toshiba-notebook) and a usable soundcard (in windows it is using PCI-bus 0
> and irq 11). So, do you have an idea to solve this problem?

The most probably it is ACPI problem solved in newer version of kernel - 
upgrade

>
> ##>We NEVER give help to users using vendor kernels.
> ##>
>
> Why? Marcel Holtmann helped me very well to get the whole BT-function with
> AP started. I tried to get help from SuSE, but this is not really good.
> Sometimes they have heard something about bluetooth and BT on
> Toshiba-notebook is a story itself. So, I'm happy about help from
> bluez-users, especially as Bluez is part of the kernel of SuSE 9.2
>
> So, PLEASE be so kind to help me in this case.

We offer help only to vanilla kernels and binaries compiled from source. We 
try help users with vendor kernels, but when it don't work we always 
recommend to upgrade to vanilla.
And most probably this si not BlueZ problem, but ACPI problem and ACPI was 
upgraded in 2.6.9 and 2.6.10


Michal
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
