Return-Path: <xuan--2006.11.06--bluez-devel--lists.sourceforge.net@baldauf.org>
Message-ID: <454F9626.8020806@baldauf.org>
Date: Mon, 06 Nov 2006 21:08:06 +0100
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?=
 <xuan--2006.11.06--bluez-devel--lists.sourceforge.net@baldauf.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [patch] Broadcom BCM2045 SCO workaround
References: <454F7267.9010409@baldauf.org> <1162834966.31808.58.camel@aeonflux.holtmann.net>
In-Reply-To: <1162834966.31808.58.camel@aeonflux.holtmann.net>
Content-Type: multipart/alternative;
 boundary="------------070609080700010208050201"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070609080700010208050201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Marcel Holtmann wrote:
> Hi Xuan,
>   
Hello Marcel,
>   
>> The Broadcom BCM2045 chipset seems to be also one of those chipsets
>> which report the SCO maximum packet incorrectly. The attached patch
>> works around this problem. With this workaround, a bluetooth USB
>> dongle with this chipset is able to send SCO data correctly.
>>
>> The fix was verified using this USB dongle (MSI StarKey 2.0 (Ver
>> 222-BW))
>>         Bus 002 Device 004: ID 0a5c:2101 Broadcom Corp.
>>         Device Descriptor:
>>           bLength                18
>>           bDescriptorType         1
>>           bcdUSB               2.00
>>           bDeviceClass          224 Wireless
>>           bDeviceSubClass         1 Radio Frequency
>>           bDeviceProtocol         1 Bluetooth
>>           bMaxPacketSize0        64
>>           idVendor           0x0a5c Broadcom Corp.
>>           idProduct          0x2101
>>           bcdDevice            0.00
>>           iManufacturer           1 Broadcom Corp
>>           iProduct                2 BCM92045DG Non-UHE
>>           iSerial                 0
>>           bNumConfigurations      1
>>     
>
> is this a dongle with HID proxy support or not. If yes, then you need
> the HCI_RESET quirk otherwise you don't. So please check if it still
> works after not including the HCI_RESET quirk.
>   
It seems that HCI_RESET is not needed. (Interestingly, during testing, I
now encounter in about 20% of the cases very loud noise. This seems like
wrong data being played (like a synchronization error). However, this
problem happens both with and without HCI_RESET.)
> Regards
>
> Marcel
>
>   
ciao,
Xuân.



--------------070609080700010208050201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1162834966.31808.58.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">Hi Xuan,
  </pre>
</blockquote>
Hello Marcel,
<blockquote cite="mid1162834966.31808.58.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">The Broadcom BCM2045 chipset seems to be also one of those chipsets
which report the SCO maximum packet incorrectly. The attached patch
works around this problem. With this workaround, a bluetooth USB
dongle with this chipset is able to send SCO data correctly.

The fix was verified using this USB dongle (MSI StarKey 2.0 (Ver
222-BW))
        Bus 002 Device 004: ID 0a5c:2101 Broadcom Corp.
        Device Descriptor:
          bLength                18
          bDescriptorType         1
          bcdUSB               2.00
          bDeviceClass          224 Wireless
          bDeviceSubClass         1 Radio Frequency
          bDeviceProtocol         1 Bluetooth
          bMaxPacketSize0        64
          idVendor           0x0a5c Broadcom Corp.
          idProduct          0x2101
          bcdDevice            0.00
          iManufacturer           1 Broadcom Corp
          iProduct                2 BCM92045DG Non-UHE
          iSerial                 0
          bNumConfigurations      1
    </pre>
  </blockquote>
  <pre wrap=""><!---->
is this a dongle with HID proxy support or not. If yes, then you need
the HCI_RESET quirk otherwise you don't. So please check if it still
works after not including the HCI_RESET quirk.
  </pre>
</blockquote>
It seems that HCI_RESET is not needed. (Interestingly, during testing,
I now encounter in about 20% of the cases very loud noise. This seems
like wrong data being played (like a synchronization error). However,
this problem happens both with and without HCI_RESET.)<br>
<blockquote cite="mid1162834966.31808.58.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">
Regards

Marcel

  </pre>
</blockquote>
ciao,<br>
Xu&acirc;n.<br>
<br>
<br>
</body>
</html>

--------------070609080700010208050201--
