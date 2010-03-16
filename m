Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000201cac525$7f363040$7da290c0$@org>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org>
	 <000001cac51b$9563e060$c02ba120$@org>
	 <6b53b1991003160830s72c84d97m28900de9cbb1302c@mail.gmail.com>
	 <000201cac525$7f363040$7da290c0$@org>
Date: Tue, 16 Mar 2010 13:45:15 -0300
Message-ID: <6b53b1991003160945k11d147f5p7d621edfde473148@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow on
	L2CAP
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 16, 2010 at 1:26 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org
>> Sent: Tuesday, March 16, 2010 8:30 AM
>> To: Mat Martineau
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow
> on L2CAP
>>
>> Hi Mat,
>>
>> On Tue, Mar 16, 2010 at 12:15 PM, Mat Martineau
>> <mathewm@codeaurora.org> wrote:
>> > Gustavo -
>> >
>> >> -----Original Message-----
>> >> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> >> owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
>> >> Sent: Monday, March 15, 2010 5:26 PM
>> >> To: linux-bluetooth@vger.kernel.org
>> >> Cc: marcel@holtmann.org; gustavo@padovan.org
>> >> Subject: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow
>> >> on L2CAP
>> >>
>> >> Now can set/get Transmission Window size via sockopt.
>> >
>> > It would be better to use __u16 for the Tx Window size, so we can use
>> > extended window sizes in the future.  This is important for AMP, where
> the
>> > amount of data in-flight can be large enough for the extended Tx Window
> to
>> > matter.
>>
>> It's better to update it to __u16 when we actually implement the
>> Extended Tx Window.
>
> The advantage of doing it now is that the data type visible to userspace
> will not ever have to change.  Applications using these sockopts will not
> want to worry about this parameter being different types on different kernel
> versions.  Since this value needs to be range-checked anyway (normal Tx
> Window must fit in 6 bits), there isn't much downside to going with __u16
> for the sockopt interface now.  Extended Tx Window support is coming in the
> near term.

So we can just avoid to apply the patch for txWindow on userspace
BlueZ until we have Extended txWindow done. That will be fine to me,
since the next will be released only on 2.6.35 kernel, and Extended
txWindow is coming soon.

>
> Another possibility is that we determine the Tx Window automatically, and
> have no sockopt interface for it.  The current window of 63 could continue
> to be used for BR/EDR connections, and each AMP controller type could have a
> sensible extended Tx Window that considers its data rate and round trip
> time.

That's not a good idea, health profiles, for example,  will want to
use a txWindow = 1. They don't need the speed, just the reliability.

>
>
> Regards,
> Mat Martineau
> Qualcomm Innovation Center, Inc.,
> A member of the Code Aurora Forum
>
>
>



-- 
Gustavo F. Padovan
http://padovan.org
