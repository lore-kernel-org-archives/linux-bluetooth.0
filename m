Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bluez 5.40 - RegisterApplication as Client
Date: Fri, 8 Jul 2016 11:44:48 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D743728@S0MSMAIL111.arc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have registered an application as a Gatt client using the GattManager1 interface with an ObjectManager providing the profiles as implementations of the GattProfile1 interface.

As soon as I register one profile, any other profile gets accepted as well, e.g. I registered a blood pressure profile with the supported services, but bluetoothd is also accepting data from a weight scale device without having its service registered on the application side.

Is this a bug?

Kind regards,
Johannes

