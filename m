Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPcThSFEfLyb09r_AuyabEuP31Y1+WNjzpDHHcXANWt+4ovPog@mail.gmail.com>
References: <CAPcThSFEfLyb09r_AuyabEuP31Y1+WNjzpDHHcXANWt+4ovPog@mail.gmail.com>
Date: Tue, 13 Oct 2015 08:12:00 +1000
Message-ID: <CAPcThSF-Segu_1iz5+4qa78pm9yYV-7fE3N5C4oSO66jyatTaA@mail.gmail.com>
Subject: Re: Device class 0 read from Microsoft Designer Mouse (Bluetooth 4.0)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, forgot to paste the DeviceFound message during scan operation
for this device:


signal sender=:1.2 -> dest=(null destination) serial=356
path=/org/bluez/969/hci1; interface=org.bluez.Adapter;
member=DeviceFound
   string "E1:52:15:B9:F3:E4"
   array [
      dict entry(
         string "Address"
         variant             string "E1:52:15:B9:F3:E4"
      )
      dict entry(
         string "Class"
         variant             uint32 0
      )
      dict entry(
         string "Icon"
         variant             string "input-mouse"
      )
      dict entry(
         string "RSSI"
         variant             int16 -41
      )
      dict entry(
         string "Name"
         variant             string "Designer Mouse"
      )
      dict entry(
         string "Alias"
         variant             string "Designer Mouse"
      )
      dict entry(
         string "LegacyPairing"
         variant             boolean false
      )
      dict entry(
         string "Paired"
         variant             boolean false
      )
      dict entry(
         string "Broadcaster"
         variant             boolean false
      )
      dict entry(
         string "UUIDs"
         variant             array [
               string "00001812-0000-1000-8000-00805f9b34fb"
            ]
      )
   ]

On Tue, Oct 13, 2015 at 8:10 AM, Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
> Hi community,
>
> Recently I got a Microsoft Designer Mouse which supports bluetooth 4.0
> but it doesn't work on Ubuntu 15.04 with bluez4-4.101-0ubuntu25.
> Although I can pair with it, I can't connect with it.
>
> I've noticed that the Class value read in relevant DeviceFound message
> is 0 (full message in the bottom), and to my surprise there is no
> "org.bluez.Input" interface exposed on relevant object created after
> pairing therefore I can't invoke the Connect() method on such
> interface.
>
> Furthermore, after pairing its object path is contained in the Devices
> property of local adapter, but the linkkeys file contains no relevant
> entry.
>
> Home come bluez reads class value 0 from this device? does this
> attribute to no input interface exported by bluez? how can I better
> attack this problem?
>
> Many thanks for any advice.
>
> Cheers,
> Harry
