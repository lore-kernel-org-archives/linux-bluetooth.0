Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLnvwa5Xa=cg1eNdppJHynPj+HZChrmVAS52HCk49zmTw@mail.gmail.com>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
	<CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
	<20160302204223.GA18853@kurtmc.Eroad.local>
	<CABBYNZLnvwa5Xa=cg1eNdppJHynPj+HZChrmVAS52HCk49zmTw@mail.gmail.com>
Date: Thu, 3 Mar 2016 12:20:07 +0100
Message-ID: <CAHrp-j9gwh1_aASF2O7nv0GvUMPXafMGG8R5c401iYZ+Vjnfiw@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Ivan Deviatkin <devyatkin.ivan@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kurt McAlpine <kurt@linux.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On 3 March 2016 at 10:34, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Do you guys remember that you have to advertise to be able to connect:
>
> ...
>
> Even with this I couldn't manage to connect using Android, even though
> it can find it but there is nothing set as a name (possible a bug in
> our end), if I do enable BR/EDR than it attempts to connect over it
> (priceless!) instead of LE where it got the advertisement.
>

   I have setup my Bluetooth dongle via:
"
   # activate bluetooth
   sudo hciconfig hci0 up
   sudo hciconfig hci0 pscan
   # set advertise data: "hello world"
   sudo hcitool -i hci0 cmd 0x08 0x0008 48 45 4c 4c 4f 57 4f 52 4c 44
   # start advertising as connectable
   sudo hciconfig hci0 leadv
"

   And it works OK (pairing, retrieveing of services list) for BlueZ
5.27 in connection to my Android phone, except issues with name of
services.
   Is anything missed or should be done additionally for latest BlueZ?
