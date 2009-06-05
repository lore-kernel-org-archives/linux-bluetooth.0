Return-Path: <cyrus@holtmann.org>
Message-ID: <4A294403.8000503@gdatech.co.in>
Date: Fri, 05 Jun 2009 21:42:51 +0530
From: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Headset not working with Linux2.6.28 ubuntu Intrepid
References: <4A251CA6.5090205@gdatech.co.in> <4A293628.3090105@gdatech.co.in> <1244215296.23850.65.camel@localhost.localdomain>
In-Reply-To: <1244215296.23850.65.camel@localhost.localdomain>
Content-Type: multipart/alternative;
 boundary="------------050301050304000804080003"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050301050304000804080003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Marcel for the clarifications to my queries.

Yes I will try using the bluetoothd. Is there any instructions available 
with the Bluez doc on enabling the plugins for the bluetoothd?

Thanks & Regards,
Benjamin

Marcel Holtmann wrote:
> Hi Benjamin,
>
> no top posting on the mailing list. This is a requirement and not a
> recommendation.
>
>   
>> Can anyone tell whether snd-bt-sco driver and the btsco application are 
>> still supported in the Linux 2.6.28 and Bluez latest versions?
>>     
>
> They haven't been supported for over 3 years. And most likely will not
> work or crash your system.
>
>   
>> Which are the required ALSA driver for the Bluetooth audio to work?
>>     
>
> The bluetoothd comes with plugins for ALSA and GStreamer and PulseAudio
> has a native plugin, too.
>
> Regards
>
> Marcel
>
>
>
>   


--------------050301050304000804080003
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks Marcel for the clarifications to my queries. <br>
<br>
Yes I will try using the bluetoothd. Is there any instructions
available with the Bluez doc on enabling the plugins for the bluetoothd?<br>
<br>
Thanks &amp; Regards,<br>
Benjamin<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid:1244215296.23850.65.camel@localhost.localdomain"
 type="cite">
  <pre wrap="">Hi Benjamin,

no top posting on the mailing list. This is a requirement and not a
recommendation.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Can anyone tell whether snd-bt-sco driver and the btsco application are 
still supported in the Linux 2.6.28 and Bluez latest versions?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
They haven't been supported for over 3 years. And most likely will not
work or crash your system.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Which are the required ALSA driver for the Bluetooth audio to work?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The bluetoothd comes with plugins for ALSA and GStreamer and PulseAudio
has a native plugin, too.

Regards

Marcel



  </pre>
</blockquote>
<br>
</body>
</html>

--------------050301050304000804080003--
