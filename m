Return-Path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "open list\:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial slave
In-Reply-To: <E1FFE8C1-97C9-4640-A12A-3AE37F9B655F@holtmann.org>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com> <1502102366-2760-2-git-send-email-loic.poulain@gmail.com> <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com> <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org> <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com> <161632C7-EBBF-47F5-86DC-453E10395B54@holtmann.org> <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com> <FCD47ED6-F01F-4921-97A3-BBC1D0263747@holtmann.org> <CALeDE9MeMHtCD8esCcznHjS+z6o7Ezh9dP1OZq=77DuYNS2=2A@mail.gmail.com> <0C198B33-8CB6-4D6A-B89F-35D3CD771135@holtmann.org> <92579650-5eb0-cdf2-405a-7c5be9c54770@gmail.com> <8CF7E37E-BF1C-4E32-AF3A-E44BA2E5A2B9@holtmann.org> <87shgqgo7b.fsf@eliezer.anholt.net> <E1FFE8C1-97C9-4640-A12A-3AE37F9B655F@holtmann.org>
Date: Thu, 17 Aug 2017 12:38:21 -0700
Message-ID: <877ey2t26q.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Eric,
>
>>>>>>> < HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen=
 1
>>>>>>>       01                                               .
>>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>>>>     Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
>>>>>>>       Status: Unknown HCI Command (0x01)
>>>>>>>=20
>>>>>>> And I am seeing fun stuff like failed frame assembly.
>>>>>>>=20
>>>>>>> [  888.687594] Bluetooth: hci0: BCM: chip id 94
>>>>>>> [  888.687821] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0182
>>>>>>> [  892.059023] Bluetooth: hci0: Frame reassembly failed (-84)
>>>>>>> [  892.316936] Bluetooth: hci0: BCM: failed to write clock (-56)
>>>>>>> [  892.429478] Bluetooth: hci0: BCM (001.002.009) build 0182
>>>>>>>=20
>>>>>>> Actually not providing the firmware makes the controller work. It h=
owever is stuck ad AA:AA:.. default address. Providing the firmware turns t=
he address active. However then it never completes.
>>>>>> I've tried on and off to get the BT working, there seems to lots of
>>>>>> options and bits needed including some patches to the bluez [1] stuff
>>>>>> but between not quite upstream kernel bits and numerous distros all
>>>>>> doing it slightly differently I've never got it to work well.
>>>>>>=20
>>>>>> The yocto [1] bits seem fairly representative of some the patches
>>>>>> flying around "to get it working" although I'm not sure how many of
>>>>>> these are actually required and how many are superfluous with this
>>>>>> patch set. There seems to be a firmware required that's not
>>>>>> distributed with linux-firmware which would also be nice to resolve.
>>>>> Non of these Yocto patches are actually needed. The culprit is the .o=
per_speed setting to be 4Mbps. Once you reduce that to 921600 thing will st=
art to work smoothly. I sent a patch that takes the .oper_speed out complet=
ely and only applies it for the ACPI based devices where we know that it wo=
rks.
>>>>>=20
>>>>> With my patch and the right DT entries for uart0 it actually works wi=
th =E2=80=9Cbtattach -B /dev/ttyAMA0 -P bcm=E2=80=9D. It will load the firm=
ware, configure it and head towards the right path.
>>>>>=20
>>>>> Obviously btattach is only an interim step here. Loic=E2=80=99s patch=
es for serdev integration and changing the DT to expose uart0 as serial-sla=
ve for Bluetooth is the right approach. Once Loic=E2=80=99s resends the pat=
ches we can get them into bluetooth-next and start merging these towards up=
stream. After that, Bluetooth should work just out of the box like with any=
 USB dongle.
>>>>>=20
>>>>> And the Yocto patches should be abandoned. If using H:5 (aka 3-Wire) =
instead of H:4 is possible, we could consider it, but as long as the UART w=
iring doesn=E2=80=99t cause any bit errors, it is not worth it.
>>>>>=20
>>>>> That said, I do see a "Bluetooth: hci0: Frame reassembly failed (-84)=
=E2=80=9D error. I need to figure out where that is. Frankly we really need=
 to hexdump the packet when this happens.
>>>>>=20
>>>>=20
>>>> I also meet this Frame reassembly failure, Seems we receive a 0x00 byt=
e from the controller (unknown pkt type).
>>>=20
>>> that means adding something like this will silence it.
>>>=20
>>> +#define BCM_RECV_NULL \
>>> +       .type =3D 0x00, \
>>> +       .hlen =3D 0, \
>>> +       .loff =3D 0, \
>>> +       .lsize =3D 0, \
>>> +       .maxlen =3D 0
>>> +
>>> +static int bcm_recv_null(struct hci_dev *hdev, struct sk_buff *skb)
>>> +{
>>> +       kfree_skb(skb);
>>> +       return 0;
>>> +}
>>> +
>>> static const struct h4_recv_pkt bcm_recv_pkts[] =3D {
>>>        { H4_RECV_ACL,      .recv =3D hci_recv_frame },
>>>        { H4_RECV_SCO,      .recv =3D hci_recv_frame },
>>>        { H4_RECV_EVENT,    .recv =3D hci_recv_frame },
>>>        { BCM_RECV_LM_DIAG, .recv =3D hci_recv_diag  },
>>> +       { BCM_RECV_NULL,    .recv =3D bcm_recv_null  },
>>> };
>>>=20
>>> It does silence it indeed. Maybe this is some of their markers to
>>> ensure that the baud rate change worked. Or it is the indication that
>>> the reset completed. Do you happen to know between which commands we
>>> receive it?
>>>=20
>>>> Regarding the speed, I'm unable to reach 3Mbps, I selected 921600
>>>> because this is the baudrate used by raspbian bt script.
>>>=20
>>> That is the same I experienced. The 921600 works fine, but trying
>>> 3Mbps doesn=E2=80=99t. However it seems with hciattach you can crank it=
 up to
>>> 3Mpbs somehow. Maybe the delay is just to short for the UART switching
>>> in that case.
>>>=20
>>>> Maybe they had some issues at higher speed (empirical value ?),
>>>> However 2Mbps seems ok on my side (need to double check/adjust).
>>>=20
>>> We have to make it a DT max-speed param anyway. So I am not that
>>> worried.
>>>=20
>>>> In a second step, need to check If we can use hardware flow control,
>>>> I heard that pin 16&17 are routed to the bcm RTS/CTS.  Since there is
>>>> no DMA usage, it could help.
>>=20
>> The BT's CTS/RTS are tied to 3v3/ground.
>>=20
>>> Eric, any chance you can dig out the recommendation for the Bluetooth
>>> controller usage? I would also like to see the recommended PCM
>>> settings for this hardware. It bet it is somehow wired up to the sound
>>> controller.
>>=20
>> BT's PCM is connected to gpio 28-31 on the pi3, which you can pinmux to
>> the i2s controller (pcm_gpio28 pin group).
>>=20
>> I'm not clear on what you're asking for, or where I would go to find
>> anything else.  However, for integration stuff on the board, Phil, Dom,
>> and Gordon at RPi are likely to know more.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/bluetooth/btbcm.h
>
> We have to send Set Sleepmode, Set PCM Int Params and Set PCM Format
> Params commands via Bluetooth HCI that will configure the sleep
> behavior and PCM parameters. So even if you route it via GPIO 28-31,
> you still need to tell the controller what parameters are used there.

Yeah, no clue about those.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlmV8K4ACgkQtdYpNtH8
nuizBw/9HAj9f2EdXIaQGmkUJcPuT18SA2k9vHfWOtpTS0IvOq9RKJJBpcM/L2Sg
pbVDDJkc5ITr8vSr8fZ3sDMRT9y/BJCztwUAHhtDrtOy/PUGXn5sHK7VNgetgJru
d4rDWPpVKsBl6v1v3BiQA2Em+SqI7hV51oGsJZzlIg9AK0e6yadBXF9bwV2YDFNJ
78xO5PJ5XA5lfvYvGx/7tofccZxseHxuP1bOqyisVVshvWTxZiN29umfbCCQxiQZ
PFazQAWJGZwLodzcd7tlwxmbSrsLwYlVLylKu5S991gHJ97WiTtS6zdYAmdPVEuP
vrWPodk/4kutiR9qSXqWpDbj3dOXC1Rvs8N2HAqQvQOW1/q234Hc8nTsNrNQSmE7
+PDRQnuyNrDQQOMV/eqUfTxWhF1CWqUDlsN1pkD/B8GJGZ9bp1wjSXZNHFGTsW6g
5KYcEyjNJdxFnrt0ziww6yIaRW5tADWQt61ynuB32fgZU1hk7T0sMDn8cyNgv6Ka
w/cGacFjf726EGTBCfCtzNg/fycxuIinTHqZNm6FSQtkHd+LO0OdBMtmnPsp5P85
1hJdvoYNFFtPiXn/AscJ9E2sQcXl4nNLdv2MuGnFNcJMxvGsO3nr5gQBil0jm8el
0VJ/ufsH+BQViV4wQYXuNLEjEU4+iwvmolawXebL20odLHXJ5KI=
=evcR
-----END PGP SIGNATURE-----
--=-=-=--
