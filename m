Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160302204223.GA18853@kurtmc.Eroad.local>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
	<CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
	<20160302204223.GA18853@kurtmc.Eroad.local>
Date: Thu, 3 Mar 2016 12:24:01 +0100
Message-ID: <CAHrp-j9a6FK4cRbJ_2Dm=0Pcqrp1Ez_czbNzMeQkKy6E=CqJfA@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Ivan Deviatkin <devyatkin.ivan@gmail.com>
To: Kurt McAlpine <kurt@linux.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kurt,

> On 2 March 2016 at 21:42, Kurt McAlpine <kurt@linux.com> wrote:
> Hi Luiz,
>
> I too am having some with BlueZ 5.37 from git (I pulled today).
>
> I do see this but my android device cannot discover the GATT service within the
> app. It is possible to pair with it, but not discover the services or even the
> device within the app.
>
> I've tired "Bluetooth LE Scanner" and nRF Master Control Panel"
>
> Ivan if you have any success with this could you let me know how you did it?

   Unfortunately I have cloned BlueZ today too and have exactly the
same issues as you.
   I believe some more investigation and fixes are required to make it work.

BR,
Ivan
