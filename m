Return-Path: <steve.crane@rococosoft.com>
Subject: Re: Release of new BlueZ libs and utils
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>, Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1071791711.6635.18.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071828905.26243.613.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 19 Dec 2003 10:15:06 +0000
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,
The corresponding RPM packages are now there too.

Cheers,
Steve

On Thu, 2003-12-18 at 23:55, Marcel Holtmann wrote:
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
>                 Use Ericsson revision command for ST Microelectronics devices.
>                 Display AVM firmware version with 'revision' command.
>                 New code for CSR specific revision information.
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
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
