Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALSoeMdtP4AxTK1-+gs+Xzo67U7KF11U0y2ihj3KKm5kwp8_og@mail.gmail.com>
References: <CALSoeMdtP4AxTK1-+gs+Xzo67U7KF11U0y2ihj3KKm5kwp8_og@mail.gmail.com>
Date: Sun, 21 Apr 2013 14:25:32 -0400
Message-ID: <CAJdJm_NatozmvH5SKEZvZ4GDeyb0vbxbtf61=4vPh1V7r=r7vA@mail.gmail.com>
Subject: Re: Access GATT characteristics with DBus in BlueZ 5.4
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Sandeep Mistry <sandeep.mistry@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Apr 20, 2013 at 5:11 PM, Sandeep Mistry
<sandeep.mistry@gmail.com> wrote:
> Hi, Is there a way to access GATT characteristics via DBus in BlueZ 5.4?
>
> In Bluez 4.101, I was abled to access them using the
> "org.bluez.Characteristic" interface.

So far, there is no GATT D-Bus API in BlueZ 5.x. The only way to
access GATT profiles in BlueZ 5.x is using existing profile specific
D-Bus APIs (thermometer, heart rate, proximity, cycling speed, HID
over GATT) or using C API (like gatttool does).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
