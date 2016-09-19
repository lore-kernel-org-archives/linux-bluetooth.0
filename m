Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALe7QMD7xAu3dJWY6SBg5DLRhkYUw8GSmkL9Ktm7ix=AxD9fqQ@mail.gmail.com>
References: <CALe7QMD7xAu3dJWY6SBg5DLRhkYUw8GSmkL9Ktm7ix=AxD9fqQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Sep 2016 18:27:51 +0300
Message-ID: <CABBYNZJhpbayvve2KZBhANtfOGnyji-m37n-ktofTZSej04mUw@mail.gmail.com>
Subject: Re: hciconfig piscan timeout issue
To: Wilson Perez <wilsonpp@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wilson,

On Mon, Sep 19, 2016 at 6:19 PM, Wilson Perez <wilsonpp@gmail.com> wrote:
> I'm having an issue with hciconfig in Bluez 5.41 when making my
> bluetooth device discoverable by means of the piscan command.  By
> executing the following:
> hciconfig hci0 piscan
> the bluetooth device is configured as discoverable but it remains
> discoverable until the system is rebooted or the noscan command is
> executed.

hciconfig does not honor the setting for bluetoothd as it uses the HCI
raw socket to send commands directly to the controller, what you
probably want to use is bluetoothctl discoverable command.

> I have set:
> DiscoverableTimeout = 30
> in /etc/bluetooth/main.conf and verified the setting is read and the
> timer configured accordingly by running bluetoothd in debug mode but
> it does not appear like the timer is executed.  I have also tried
> unsuccessfully several other settings including commenting out the
> line to use the default value of 180.
>
> If I run:
> dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0
> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
> string:Discoverable variant:boolean:true
> to make the bluetooth device discoverable, the DiscoverableTimeout
> timer works as expected.
>
> Is there anything I'm missing that is causing this unexpected behavior
> in Bluez 5.41?

Don't mix hci* tools with bluetoothd.


-- 
Luiz Augusto von Dentz
