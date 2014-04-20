Return-Path: <cyrus@holtmann.org>
Message-ID: <535421C1.8020507@gmail.com>
Date: Sun, 20 Apr 2014 23:36:33 +0400
From: Dmitry Grebennikov <dmitry.ew@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth support of intel 7260ac adapter
References: <5353FDE4.2030207@gmail.com> <DB8026B0-603E-4D2F-B725-A47BC503E8D1@holtmann.org> <53541D80.7010002@gmail.com>
In-Reply-To: <53541D80.7010002@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050902010402040808090801"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050902010402040808090801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.04.2014 23:18, Dmitry Grebennikov wrote:
> On 20.04.2014 23:07, Marcel Holtmann wrote:
>> Hi Dmitry,
>>
>>> Could you help me please to make my intel 7260ac wifi+bt adapter 
>>> work correctly?
>>>
>>> I bought it recently and installed in my laptop. Wifi works 
>>> perfectly (iwlwifi + firmware), while bluetooth controller isn't 
>>> detected with lspci, lshw completely.
>>>
>>> I found that Tedd Ho-Jeong An released bluetooth firmware for this 
>>> card.
>>> So I installed linux-firmware-git package, which contain needed 
>>> intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq file.
>>> I wrote to load btusb module in /etc/modules-load/
>>> I don't know how to force btusb driver to load firmware file.
>>> What could be the problem with detection only wireless network 
>>> controller, but not bluetooth?
>> the Bluetooth controller would show up as USB device. So you should 
>> look with lsusb. And check rfkill if you have a platform Bluetooth 
>> switch that will enable/disable the Bluetooth controller.
>>
>> Regards
>>
>> Marcel
>>
> Thanks for answer.
> I attach lsusb output, there are two rows with Intel Corp. Integrated 
> Rate Matching Hub, but I don't think it's what needed.
> That is the problem that there is no bluetooth adapter in rfkill:
> > # rfkill list
> > 2: samsung-wlan: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
> > 3: phy1: Wireless LAN
> >         Soft blocked: no
> >         Hard blocked: no
>
> Dmitry Grebennikov
Also, hciconfig output:
$  sudo hcitool scan
Device is not available: No such device
$  sudo hciconfig hci0 up
Can't get device info: No such device
$  sudo hciconfig hci0 unblock
Can't get device info: No such device

Thanks.

--------------050902010402040808090801
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 20.04.2014 23:18, Dmitry Grebennikov
      wrote:<br>
    </div>
    <blockquote cite="mid:53541D80.7010002@gmail.com" type="cite">On
      20.04.2014 23:07, Marcel Holtmann wrote:
      <br>
      <blockquote type="cite">Hi Dmitry,
        <br>
        <br>
        <blockquote type="cite">Could you help me please to make my
          intel 7260ac wifi+bt adapter work correctly?
          <br>
          <br>
          I bought it recently and installed in my laptop. Wifi works
          perfectly (iwlwifi + firmware), while bluetooth controller
          isn't detected with lspci, lshw completely.
          <br>
          <br>
          I found that Tedd Ho-Jeong An released bluetooth firmware for
          this card.
          <br>
          So I installed linux-firmware-git package, which contain
          needed intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq file.
          <br>
          I wrote to load btusb module in /etc/modules-load/
          <br>
          I don't know how to force btusb driver to load firmware file.
          <br>
          What could be the problem with detection only wireless network
          controller, but not bluetooth?
          <br>
        </blockquote>
        the Bluetooth controller would show up as USB device. So you
        should look with lsusb. And check rfkill if you have a platform
        Bluetooth switch that will enable/disable the Bluetooth
        controller.
        <br>
        <br>
        Regards
        <br>
        <br>
        Marcel
        <br>
        <br>
      </blockquote>
      Thanks for answer.
      <br>
      I attach lsusb output, there are two rows with Intel Corp.
      Integrated Rate Matching Hub, but I don't think it's what needed.
      <br>
      That is the problem that there is no bluetooth adapter in rfkill:
      <br>
      &gt; # rfkill list
      <br>
      &gt; 2: samsung-wlan: Wireless LAN
      <br>
      &gt;         Soft blocked: no
      <br>
      &gt;         Hard blocked: no
      <br>
      &gt; 3: phy1: Wireless LAN
      <br>
      &gt;         Soft blocked: no
      <br>
      &gt;         Hard blocked: no
      <br>
      <br>
      Dmitry Grebennikov
      <br>
    </blockquote>
    <font face="Droid Sans">Also, hciconfig output:<br>
      $  sudo hcitool scan<br>
      Device is not available: No such device<br>
      $  sudo hciconfig hci0 up<br>
      Can't get device info: No such device</font><br>
    <font face="Droid Sans">$  sudo hciconfig hci0 unblock<br>
      Can't get device info: No such device<br>
      <br>
      Thanks.<br>
    </font>
  </body>
</html>

--------------050902010402040808090801--
