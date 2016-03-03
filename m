Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHrp-j9a6FK4cRbJ_2Dm=0Pcqrp1Ez_czbNzMeQkKy6E=CqJfA@mail.gmail.com>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
	<CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
	<20160302204223.GA18853@kurtmc.Eroad.local>
	<CAHrp-j9a6FK4cRbJ_2Dm=0Pcqrp1Ez_czbNzMeQkKy6E=CqJfA@mail.gmail.com>
Date: Thu, 3 Mar 2016 18:31:23 +0200
Message-ID: <CABBYNZ+BODoiZvGZxEfM5kaNH+kDUqxp+6KfgkxGOhOHrgjZ4A@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ivan Deviatkin <devyatkin.ivan@gmail.com>
Cc: Kurt McAlpine <kurt@linux.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ivan,

On Thu, Mar 3, 2016 at 1:24 PM, Ivan Deviatkin <devyatkin.ivan@gmail.com> wrote:
> Hi Kurt,
>
>> On 2 March 2016 at 21:42, Kurt McAlpine <kurt@linux.com> wrote:
>> Hi Luiz,
>>
>> I too am having some with BlueZ 5.37 from git (I pulled today).
>>
>> I do see this but my android device cannot discover the GATT service within the
>> app. It is possible to pair with it, but not discover the services or even the
>> device within the app.
>>
>> I've tired "Bluetooth LE Scanner" and nRF Master Control Panel"
>>
>> Ivan if you have any success with this could you let me know how you did it?
>
>    Unfortunately I have cloned BlueZ today too and have exactly the
> same issues as you.
>    I believe some more investigation and fixes are required to make it work.
>

After removing the device, turn off/on the bluetooth, discover the
device using Android UI and then connecting using nRF master, or
whatever else since this apparently is bluedroid fault, this is the
outcome http://ix.io/oMm

It does connects, we do start sending responses but as soon as we send
any ATT request ourselves Bluedroid just seems unable to send any
request anymore. The spec is quite clear that we can send request as
well regardless if we are the peripheral or not, perhaps we can
disable our discovery when acting as a peripheral but not all profiles
have the GAP Peripheral must be the GATT server only and it is too bad
the test specification actually don't test this because now there are
probably a ton of Android devices just broken in this regard.



-- 
Luiz Augusto von Dentz
