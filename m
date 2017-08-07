Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Kai Ruhnau <kai.ruhnau@target-sg.com>
Subject: Bluez can crash with SIGSEGV while registering an LE advertisement
Message-ID: <fec372b2-6ef9-8273-ebe6-ea25083ee4b9@target-sg.com>
Date: Mon, 7 Aug 2017 15:50:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm able to crash Bluez 4.43 with SIGSEGV. The Bluez code hasn't changed
in that area since, so it should (not) work in more recent versions as
well. The code that reproduces the problem on my embedded platform is
here:
https://github.com/Tragetaschen/bluez-advertisement-registration-sigsegv

The problem is that while calling
org.bluez.LEAdvertisingManager1.RegisterAdvertisement, Bluez sends two
method calls to the given object path:

- org.freedesktop.DBus.Properties.GetAll

- org.freedesktop.DBus.ObjectManager.GetManagedObjects

When these two methods are replied to in order (GetAll then
GetManagedObjects), everything works as expected. When the order is
reversed, Bluez sends an error for the RegisterAdvertisement with
"Failed to parse advertisement" after the GetManagedObjects returns and
then dies by a SIGSEGV when GetAll returns.

My DbusCore implementation uses a thread pool to dispatch incoming
method calls and doesn't have the necessary ordering requirements.


Cheers,

Kai

--
Kai Ruhnau
Software Manager
T:+49 202 769302 19

Target Systemelektronik GmbH & Co. KG
Heinz-Fangman-Stra=C3=9Fe 4
42287 Wuppertal

Amtsgericht Wuppertal HRA 23898
Pers=C3=B6nlich haftende Gesellschafterin
Target Systemelektronik Beteiligungs GmbH
Heinz-Fangman-Stra=C3=9Fe 4, 42287 Wuppertal
Amtsgericht Wuppertal HRB 25346
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Stein
--
