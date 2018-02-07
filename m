Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Thomas Green <TGreen2@Sorenson.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: More keyboard issues
Date: Wed, 7 Feb 2018 19:48:13 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE020125730EF4@SLC-EXMB01.CORP.SRELAY.COM>
References: <C2BC44D770753C45AAAC42695FB5BE02012572F769@SLC-EXMB01.CORP.SRELAY.COM>
 <5252185.UFqE8F7bMa@ix>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Was this helpful to you?

Tom

-----Original Message-----
From: Thomas Green=20
Sent: Thursday, February 01, 2018 10:48 AM
To: 'Szymon Janc' <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: More keyboard issues

Szymon,

Thanks for the reply,
>Hi,
>
>On Saturday, 27 January 2018 01:20:21 CET Thomas Green wrote:
>> Hi all,
>>
>> I'm testing more keyboards with 5.48 and have found issues with two=20
>> other keyboards.  In this case the problem is during pairing.  The two k=
eyboards
>> in question are the SIIG AAZ2448 and the ANKER A7221.   The current issu=
e
>> is that during pairing of these two keyboards we are given a PIN code=20
>> display, so I enter it on the keyboard and nothing happens, and=20
>> eventually the pairing times out.
>>=20
>> [bluetooth]# pair 20:73:03:A4:18:4D
>> Attempting to pair with 20:73:03:A4:18:4D [CHG] Device=20
>> 20:73:03:A4:18:4D Connected: yes [agent] PIN code: 851841 [Anker=20
>> A7721]# [  282.174342] WARNING: at net/bluetooth/hci_conn.c:322
>> hci_conn_timeout+0x44/0x198() Failed to pair:
>> org.bluez.Error.AuthenticationTimeout
>> [Anker A7721]#
>>=20
>> This happens about 95% of the time.  The other 5% the pairing=20
>> completes and everything works fine.
>>=20
>> I could attach btmon output and output from running bluetoothd -d -n,=20
>> but nothing interesting happens from the time the pincode is=20
>> displayed and the timeout occurs.
>>=20
>> Where do I begin to look for why the pincode isn't being transmitted=20
>> back from the keyboards?  Why is it inconsistent?
>>=20
>> As an interesting side note the Apple keyboard that I'm having the=20
>> driver loading trouble uses the same pairing mechanism and it works=20
>> well every time. (and all of these keyboards worked fine in 4.101)
>
>Get full btmon logs first, ideally from the moment you power on BT adapter=
.
>
>--
>pozdrawiam
>Szymon Janc
>
>

The log file is attached to this email....

Tom
