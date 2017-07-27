Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <5977D982.5070808@mail.zabtrans.ru>
 <CABBYNZ+GSc0_QvmOLdknYpv-Y6Gvcb6oEQf2AFUc_ZHWqZBZjw@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <597938D3.1070902@mail.zabtrans.ru>
Date: Thu, 27 Jul 2017 08:50:27 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+GSc0_QvmOLdknYpv-Y6Gvcb6oEQf2AFUc_ZHWqZBZjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

26.07.2017 16:05, Luiz Augusto von Dentz wrote:

 > It probably has been stopped already since the connection used for
 > StartDiscovery has been terminated. Btw, there are better tools to
 > test this, for instance bluetoothctl> scan [on/off]
 >

If the process "StartDiscovery" is stopped, why status "Discovering" not 
changed to "false"?

I need to start and stop scanning from the Bash script, bluetoothctl has 
the ability to manage from Bash scripts?
