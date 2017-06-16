Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
In-Reply-To: <15900B5C-F25F-4077-B1BA-A4C3F59FD95C@holtmann.org>
References: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
 <15900B5C-F25F-4077-B1BA-A4C3F59FD95C@holtmann.org>
From: Marcos Scriven <marcos@scriven.org>
Date: Fri, 16 Jun 2017 09:31:43 +0100
Message-ID: <CA+zKUV+N5PZ9AP+GNTUFWCMG4cHwJ6EKU9pig_76ggTDACE0XA@mail.gmail.com>
Subject: Re: Questions on event masks (specifically in tools/3dsp.c)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel

I did try btmon, but was only seeing other devices about the house,
nothing that looked liked the 3D glasses, no matter how many times I
press the sync button on the glasses.

As the glasses were quite cheap, I went ahead and opened them up, to
find it's based on the Broadcom 20730, which is only Bluetooth 3.0
according to the datasheet:
http://www.cypress.com/file/298211/download

It specifically mentioned 3D glasses support in section 1.3:

"The CYW20730, combined with the CYW20702, provides full system
support for 3D glasses on televisions. The CYW20702 gets frame
synchronization signals from the TV, converts them into proprietary
timing control messages, then passes these messages to the CYW20730.
The CYW20730 uses these messages to synchronize the shutter control
for the 3D glasses with the television frames."

However, there's no such CYW20702 chip on the board, but instead a
Sitronix ST9902:
http://www.datasheetspdf.com/datasheet/download.php?id=948278

The description for that is:

"ST9902 is an integrated circuit for liquid-crystal shutter glasses
driver. It combines a DC/DC converter that generates a specified
voltage level as the output voltage source to the four-channel analog
switches. Each analog switch has a dedicated input control pin and a
dedicated output analog pin. The analog switches can be used as the
lens driver in a 3D glasses system application. 16K-byte EEPROM is
suitable for the MCU-based system, which can use EEPROM as a code or
data storage unit. ST9902 chip is integrated into a 16-pin QFN package
and only a few external passive components are require"

So that seems to be just a simple I2C controller for the shutters
themselves, whereas the companion CYW20702 looks like a full Bluetooth
4.0 processor.

I thus have no idea how this is even works, the datasheet for the
CYW20730 doesn't explain how it would work to control 3D glasses
without the CYW20702 - I'm presuming it must therefore have been
programmed by the manufacturer of the glasses. Would you agree that
means it could only support the legacy 3D glasses profile?

It would also seem it's BR/EDR only - but should I then still see
output in btmon, or is that Bluetooth LE only?

Thanks

Marcos

On Fri, Jun 16, 2017 at 6:29 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcos,
>
>> (NB I've resent this as plain text)
>>
>> I've been trying out /tools/3dsp.c on a Raspberry Pi 3. There's some
>> background in this thread that Marcel mentioned
>> http://www.spinics.net/lists/linux-bluetooth/msg62198.html
>>
>> The Raspberry Pi uses the Broadcom bcm43438 chip, which according to
>> the registration documents does support connectionless slave broadcast
>>
>> I don't see any errors, but nothing seems to happen, so have been
>> taking a close look at the code, especially the start_glasses method.
>>
>> In there I see the event masks:
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316
>>
>> uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
>> uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };
>
> run btmon -w trace.log and post the binary trace.log file. Also look at Bluetooth 4.1 or later core spec.
>
> Regards
>
> Marcel
>
