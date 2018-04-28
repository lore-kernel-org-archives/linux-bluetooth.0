Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@zabzd.ru>
Subject: Re: Algorithm for create serial connection without rfcomm
To: linux-bluetooth@vger.kernel.org
References: <000301d347db$df1dd300$9d597900$@com>
 <6B2D6FC09217DA4280D35175FA16A620688418CA@msceml521-mbx.china.huawei.com>
 <457BA4F48509464E9000537839AF501857261694@msceml521-mbx.china.huawei.com>
 <59E7EBF9.3050705@zabzd.ru>
 <457BA4F48509464E9000537839AF501857261990@msceml521-mbx.china.huawei.com>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1DDAB@msceml522-mbx.china.huawei.com>
 <59E946F9.1060501@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E01D@msceml522-mbx.china.huawei.com>
 <59ED2E3D.7030809@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F1E6D0@msceml522-mbx.china.huawei.com>
 <59F92B55.0@zabzd.ru>
 <7CC793D56C5DD04ABFAFBF59EB0D4A3650F23FDB@msceml522-mbx.china.huawei.com>
 <480C9E29A742984996B50276401889F36B33E940@msceml521-mbx.china.huawei.com>
 <5AE03410.7070806@zabzd.ru>
 <CAAu3APYXpqO77M0AhAVD-EnOapXAOXsAD4e26x5ULTVCxfSreg@mail.gmail.com>
Message-ID: <5AE3EA6A.5020407@zabzd.ru>
Date: Sat, 28 Apr 2018 11:28:42 +0800
MIME-Version: 1.0
In-Reply-To: <CAAu3APYXpqO77M0AhAVD-EnOapXAOXsAD4e26x5ULTVCxfSreg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No, nothing is clear yet.

I use bash script for manage bluetooth, dbus-send command help me use DBus.

All programm need serial device ex: /dev/ttyS0 or for bluetooth 
/dev/rfcomm0 created.

I can not understand whether a device will be created, or it should be 
created by myself. And how to create a device with a given name ex: 
/dev/rfcomm0

After run ./spp-profile  script will the device file be created in /dev 
directory?
