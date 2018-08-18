Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Raul Piper <raulpblooper@gmail.com>
Date: Sun, 19 Aug 2018 03:03:26 +0530
Message-ID: <CAEwN+MBjU=ZmbVyppH6_t45ZLaCRe_8FE7XFDSCnDoSBKKrAag@mail.gmail.com>
Subject: Failed to parse provisioning database file prov_db.json :
 BlueZ,Meshctl V5.50
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello ,
I have built and BlueZ 5.50 from the source and installed it on
raspberry PI 3 W0, but when I am trying to launch the meshctl tool -
using ./meshctl (from within or out side the mesh directory) i am
getting the below error  :

Failed to parse provisioning database file prov_db.json

I checked the online sanity onfthe above json file and it seems correct.



I tried doing the sudo hcitool -lescan - it shows the LE devices and also

bluetoothd -v gives 5.50 which shows my compilation and loading of the
new BlueZ is alteast correct.

I have already installed the c-json lib .

Is this a bug in meshctl?

Please assist !


Thanks in Advance !
