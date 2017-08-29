Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Not set name from main.conf
References: <59A504D3.6070809@mail.zabtrans.ru>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <59A52C53.3020209@mail.zabtrans.ru>
Date: Tue, 29 Aug 2017 16:56:51 +0800
MIME-Version: 1.0
In-Reply-To: <59A504D3.6070809@mail.zabtrans.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> You should probably disable the hostname plugin if you don't want it
> to set the name and alias, alternatively, you can set a different
> alias using the Alias property with bluetoothctl or your own tool.


Why hostname plugin ignore main.conf options?

how to disable this plugin? If it is disabled only when compiled bluez, 
then this is not the best way!

How can I set the name assigned without user action, I know of no other 
way than the main.conf
