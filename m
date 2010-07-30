Return-Path: <cyrus@holtmann.org>
Subject: seeking debug advice for a hanging serial device
From: Steve Castellotti <sc@puzzlebox.info>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Jul 2010 13:19:36 -0700
Message-ID: <1280521176.2338.45.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all-

    I am in the process of writing a device driver for a consumer-grade
Bluetooth EEG headset which presents packets of information through a
serial protocol, transmitting data packets at 512 Hz. The code is being
written in Python using the Pyserial module and has been verified to
work reliably when executed on the Windows platform.

    However under Linux, the device frequently hangs within 5 seconds of
attempting to read the data stream.

    This occurs whether through my code (which is platform agnostic) or
simply cat'ing the RFCOMM device from a console (both in normal and raw
mode).

    I have tested this hardware using three different Bluetooth adapters
on six different systems running three different Linux distributions on
two different processor architectures, all with the same results:

Windows XP: Works without error

Windows Vista: Works without error

Fedora 12 (x86): Fails on two different systems running the same/latest
software updates available
    bluez-4.58-1.fc12.i686
    kernel 2.6.32.16-141.fc12.i686.PAE

Fedora 13 (x86): Fails
    bluez-4.64.1.fc13.i686
    kernel 2.6.33.6-147.fc13.i686.PAE

Maemo 5 (ARM): Fails
    bluez 4.60-0maemo1.5+0m5
    kernel 2.6.28-omap1


    Under Linux, I am connecting to my device with the following
command:

rfcomm connect rfcomm0 XX:XX:XX:XX:XX:XX 3


    I connect on the third channel because the first channel is also a
serial port but is used for operating the headset as a hands-free device
for connecting to a mobile phone or VOIP application. The second channel
does not respond.


    If I simply run:

cat /dev/rfcomm0


    I will get packet bytes dumped to the console for 2 seconds or so,
then the device hangs until I disconnect (sometimes requiring "rfcomm
release /dev/rfcomm0" or power cycling the device).

    When running through my code I am careful to set the baud rate and
similar parameters exactly as described in the device documentation. The
portion of the code which reads from the device executes in a separate
thread from the processing of the data within the packets, so there
should be no issues regards a buffer under-run or similar (and I have
also tested code which simple reads from the device and prints bytes to
the console as the sole process in the main thread). The same result
occurs however, I might receive packets for 2-5 seconds, then the device
(or at least the Bluetooth connection) hangs.

    If I connect to the device using rfcomm in "raw" mode ("-r") then
the system itself will actually hang along with the device, requiring a
complete power-cycle of my test machine as well to fully recover.

    On very rare occasions I have managed to access the stream past the
first several seconds, in which case the device will continue to operate
quite happily for an hour or more without interruption. This is without
changes to code or connection procedure.


    I am at a complete loss as to how to proceed next with further
debugging. Granted I am coding in Python which is perhaps one layer
removed from the hardware versus coding in C, but the identical code and
modules work without issue under Windows on multiple systems.

    Can anyone please offer me some pointers or directions to explore?

    I am happy to produce any sort of relevant kernel or Bluetooth
device debug logs if they might prove relevant (though I would
appreciate a link to a document or procedure explaining a preferred
method for collecting such data).


Cheers


Steve Castellotti



