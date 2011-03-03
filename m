Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinhMeLRoG8GPrU8C9cNydj2Jxvfvp7PZ-7MCqGC@mail.gmail.com>
References: <AANLkTimCFW3bZkmm_B8VfViMC1A+rDjWRnE5OSB7eCCJ@mail.gmail.com>
	<1299174593.18332.42.camel@novo.hadess.net>
	<AANLkTinhMeLRoG8GPrU8C9cNydj2Jxvfvp7PZ-7MCqGC@mail.gmail.com>
Date: Thu, 3 Mar 2011 19:19:55 +0100
Message-ID: <AANLkTi=A3sk1dpz2bZuSKyp9tS0zsYpB3Nrx=ZNRPA1Y@mail.gmail.com>
Subject: Re: New device driver: Nintendo Wii Remote
From: David Herrmann <dh.herrmann@googlemail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 3, 2011 at 7:06 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> On Thu, Mar 3, 2011 at 6:49 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> On Thu, 2011-03-03 at 18:42 +0100, David Herrmann wrote:
>>> Hi
>>>
>>> The Nintendo Wii Remote (short Wiimote) is the remote for the Nintedo
>>> Wii console and communicates via bluetooth. There have been many
>>> approaches to write linux drivers (incomplete list:
>>> http://wiibrew.org/wiki/Wiimote/Library), however, they all are
>>> written as separate libraries and not as device drivers. This has the
>>> disadvantage, that the application must actively connect to the
>>> wiimote (probably performing a bt-inquiry beforehand) instead of
>>> listening for incoming connections.
>>> The latter one can be achieved by listening on the HID l2cap channels
>>> (psm 0x11 and 0x13), though, the wiimote does not follow the HID
>>> standard. Since the bluez input-plugin listens on these ports, the
>>> driver needs to be integrated into the bluez-daemon or kernel to work
>>> properly.
>>
>> You can do the pairing by hacking bluetoothd:
>> https://bugzilla.gnome.org/show_bug.cgi?id=603845
>>
>> This is the first thing to fix to get proper Wiimote access. Marcel
>> would also like the pairing and PIN setting to be handled directly in
>> bluetoothd for this device.

Wait no, I didn't do it via dbus, you're right. This would require zero bytes to
be part of the PIN. But the suggestion from Marcel (hardcoding the PIN with
PnP identification) does not work as I explained, there are 2 PINs used and
only the driver knows which PIN to use. (Well, the user has to define which
pairing method to use and so the driver chooses the right PIN). So I think the
only way is handling the PIN-related code inside the wiimote driver.

David
