Return-Path: <cyrus@holtmann.org>
Message-ID: <4B02B1B9.40104@start.ca>
Date: Tue, 17 Nov 2009 09:22:49 -0500
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thilo_Rie=DFner?= <thilo@riessner.de>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth dead after suspend
References: <200911171333.47667.thilo@riessner.de>
In-Reply-To: <200911171333.47667.thilo@riessner.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thilo:

On 11/17/2009 07:33 AM, Thilo Rießner wrote:
> Hello, my bluetooth works fine after normal boot, bat after suspending and
> resuming, it is dead. With my old installation (openSuSE 11.1) it was the
> same, but the problem could be solved by restarting bluetooth (rcbluetooth
> restart). With the new openSuSE 11.2 the rcbluetooth script vanished. As far
> as I understood, bluetooth gets started via dbus. But even a rcdbus restart
> does not help. Any idea of a quirk or workaround?
> Thanks in advance for any help.
>
> Thilo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

On my Opensuse 11.2 there is a file

/etc/init.d/bluez-coldplug

which, on examination, seems to control start/stop etc of bluetooth. Is 
this relevant to your concern?

On my desktop system if I plug in my adapter right after the system 
boots, Kbluetooth framework appears automagically. I will try it again 
after my system goes to sleep sometime.
