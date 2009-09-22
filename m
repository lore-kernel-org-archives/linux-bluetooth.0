Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2009 18:31:47 -0300
Message-ID: <f9d4bd30909221431p33970fe8weab8c440b3d35edf@mail.gmail.com>
Subject: [PATCH] Fix extra PropertyChanged signal sent after DeviceRemoved
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

for paired devices, there is an extra PropertyChanged signal sent
after DeviceRemoved:

signal sender=:1.78 -> dest=(null destination) serial=145
path=/org/bluez/24533/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Devices"
   variant       array [
      ]
signal sender=:1.78 -> dest=(null destination) serial=146
path=/org/bluez/24533/hci0; interface=org.bluez.Adapter;
member=DeviceRemoved
   object path "/org/bluez/24533/hci0/dev_00_1F_00_CE_BE_AF"
signal sender=:1.78 -> dest=(null destination) serial=147
path=/org/bluez/24533/hci0/dev_00_1F_00_CE_BE_AF;
interface=org.bluez.Device; member=PropertyChanged
   string "Paired"
   variant       boolean false


The patch to fix this issue is in my branch devel:

git://git.infradead.org/users/cktakahasi/bluez.git devel

I removed  "textfile_caseget()" call before call "textfile_casedel()",
let me know if you wanna keep this check, I can revert this minor
change.

Br,
Claudio

-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
