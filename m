Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
References: <1071791711.6635.18.camel@pegasus>
In-Reply-To: <1071791711.6635.18.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200312190128.44892.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 19 Dec 2003 01:28:44 +0100

GREAT work Marcel! :)

Now we want release of HID support for keyboards and mouses etc :)

Michal

Dne p=E1tek 19 prosinec 2003 00:55 Marcel Holtmann napsal(a):
> Hi Folks,
>
> I don't wanna make big words about it, but after 8 months there are new
> releases of the BlueZ libs and utils packages. So let the changelogs
> speak for themselfs:
>
> BlueZ libs 2.5:
>         Add decoding of Bluetooth 1.2 features.
>         Add link manager version parameter for Bluetooth 1.2.
>         Add new company identifiers.
>         Support for transmit power level.
>         Support for park, sniff and hold mode.
>         Support for role switch.
>         Support for reading the clock offset.
>         Use R1 for default value of pscan_rep_mode.
>
> BlueZ utils 2.4:
>         hcitool changes:
>                 Increase number of inquiry responses.
>                 Support for transmit power level.
>                 Minor updates.
>         hciconfig changes:
>                 Display all 8 bytes of the features.
>                 Add support for reading and writing of IAC.
>                 Correct decoding class of device.
>                 Use Ericsson revision command for ST Microelectronics
> devices. Display AVM firmware version with 'revision' command. New code f=
or
> CSR specific revision information.
>         hciattach changes:
>                 Support for ST Microelectronics specific initialization.
>                 Support for 3Com card version 3.0.
>                 Support for TDK, IBM and Socket cards.
>                 Support for initial baud rate.
>         Update man pages.
>         Fixes for some memory leaks.
>
> For the BlueZ libs I don't plan another release, because the new major
> version of the Bluetooth library is making good progress. But for the
> BlueZ Utils I want to make another release that addresses the problems
> with the pin_helper program. I think the C based bluez-pin is a good
> idea and maybe we should also integrate the DBus support into the next
> release. So I like to get comments on this and if you have patches,
> please resend them.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
