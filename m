Return-Path: <jd@freeshell.org>
Date: Sat, 24 Jul 2004 02:36:27 -0500 (CDT)
From: "J.D." <jd@freeshell.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.27rc3 and Bluetooth
In-Reply-To: <1090055676.4558.15.camel@pegasus>
Message-ID: <Pine.NEB.4.60.0407240115590.25504@norge.freeshell.org>
References: <Pine.NEB.4.60.0407131537590.12135@norge.freeshell.org>
 <1089826204.4517.0.camel@pegasus>  <Pine.NEB.4.60.0407141844100.22049@mx.freeshell.org>
 <1090055676.4558.15.camel@pegasus>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1002946765-1090654587=:25504"
List-ID: <bluez-devel.lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1002946765-1090654587=:25504
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Marcel,

Great!  I'll CC this message to the mailing list.

Regarding the bt3c_cs error message, I merely have a personal 
preference for error messages *without* a kernel panic. (aiee!)
I do appreciate you sharing your view on the specific problem.

I finally burned some time, studied the code, and created a
working patch for bt3c_cs.c (patch attached).  It adds a test
in bt3c_release to check whether the DEV_CONFIG_PENDING bit of
link->state is clear before a call to bt3c_close.  If the
DEV_CONFIG_PENDING bit is not clear, bt3c_open has failed,
and never succeeded in a call to hci_register_dev and friends.

When loading the firmware fails, the unpatched code ignores the
failure of bt3c_open, goes ahead with bt3c_close, and invokes 
hci_unregister_dev and friends (despite the fact that
hci_register_dev was never called), thus provoking a kernel panic
with the NULL pointer dereference. (aiee!)

I suspect the 2.6 kernel may have the same problem by casual
inspection, but I have neither confirmed the existence of a problem
through testing of the 2.6 kernel, nor carefully traced that code
of Linux 2.6 for possible key differences.

With Linux 2.4 and the patch, I was able to temporarily erase 
"/usr/lib/hotplug/firmware/BT3CPCC.bin", and insert the Bluetooth
card with a kernel error message, but no panic.  After replacing
the file, and re-inserting the card, everything worked again.

(BTW, thank you Marcel for the tip on disabling the SCO support;
network transfers via bluetooth do not stall on that machine like
they did with SCO enabled.)

Kind regards,

- John

--
http://jodarom.sdf1.org/



On Sat, 17 Jul 2004, Marcel Holtmann wrote:

> Hi John,
>
>> Thank you for the information.  I just wrote you because your name was on
>> the patch that caused my kernel to panic.  What's the mailing list of
>> choice for bluetooth bugs in the Linux kernel?
>
> check the MAINTAINERS file in the Linux kernel source code. It says the
> BlueZ developer mailing list for the Bluetooth subsystem.
>
>> I issued the commands,
>>
>>    cd /usr/lib/hotplug/firmware
>>    ln -s /etc/bluetooth/firmware/BT3CPCC.bin BT3CPCC.bin
>>
>> and all was happy again.
>>
>> If you ever feel the initiative, making the system spit out a somewhat
>> succinct and relevant error message, as opposed to a full kernel panic
>> (aiee!) is much preferred by Linux users who desire to maintain the
>> illusion that Linux is a stable operating system.  =)
>
> the error message was there:
>
> 	bt3c_cs: Firmware request failed.
> 	Unable to handle kernel NULL pointer ...
>
> So there must be a NULL pointer somewhere when the firmware can't be
> loaded into kernel space. I don't know if it is in the Bluetooth or the
> PCMCIA subsystem. I have no 2.4 system where I can check this.
>
>> ... but personally I'm satisfied at the moment.  At least on a different
>> machine (running 2.4.27rc2), when the bluetooth USB device randomly locks
>> during repeated or extended transmissions, a nice message appears in the
>> log, ("kernel: NETDEV WATCHDOG: bnep0: transmit timed out"), and the
>> device works again after physically being unplugged and plugged back in
>> again.
>
> Maybe it helps if you compile your kernel without the SCO support option
> for the hci_usb driver. Disable CONFIG_BLUEZ_HCIUSB_SCO.
>
> Regards
>
> Marcel
>
>
--0-1002946765-1090654587=:25504
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch-2.4.27-rc3-bt3c_why_panic-jd.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.NEB.4.60.0407240236270.25504@norge.freeshell.org>
Content-Description: kernel patch - bt3c_cs - missing firmware?  Don't panic!
Content-Disposition: attachment; filename="patch-2.4.27-rc3-bt3c_why_panic-jd.diff"

ZGlmZiAtdXJOIGtlcm5lbC1zb3VyY2UtMi40LjI3LXJjMy5vcmlnL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0M2NfY3MuYyBrZXJuZWwtc291cmNlLTIuNC4yNy1y
YzMvZHJpdmVycy9ibHVldG9vdGgvYnQzY19jcy5jDQotLS0ga2VybmVsLXNv
dXJjZS0yLjQuMjctcmMzLm9yaWcvZHJpdmVycy9ibHVldG9vdGgvYnQzY19j
cy5jCVNhdCBKdW4gMjYgMDM6NTM6MDMgMjAwNA0KKysrIGtlcm5lbC1zb3Vy
Y2UtMi40LjI3LXJjMy9kcml2ZXJzL2JsdWV0b290aC9idDNjX2NzLmMJRnJp
IEp1bCAyMyAyMzoxNjowMyAyMDA0DQpAQCAtODk2LDcgKzg5Niw4IEBADQog
CWJ0M2NfaW5mb190ICppbmZvID0gbGluay0+cHJpdjsNCiANCiAJaWYgKGxp
bmstPnN0YXRlICYgREVWX1BSRVNFTlQpDQotCQlidDNjX2Nsb3NlKGluZm8p
Ow0KKwkJaWYgKCEobGluay0+c3RhdGUgJiBERVZfQ09ORklHX1BFTkRJTkcp
KQ0KKwkJCWJ0M2NfY2xvc2UoaW5mbyk7DQogDQogCU1PRF9ERUNfVVNFX0NP
VU5UOw0KIA0K

--0-1002946765-1090654587=:25504--
