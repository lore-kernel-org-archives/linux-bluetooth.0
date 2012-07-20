Return-Path: <cyrus@holtmann.org>
Message-id: <1C62127382D249E49CDCD049E010D596@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, s.syam@samsung.com
References: <1342183675-27612-1-git-send-email-jaganath.k@samsung.com>
 <20120716105256.GB5868@aemeltch-MOBL1> <20120716105527.GC5868@aemeltch-MOBL1>
In-reply-to: <20120716105527.GC5868@aemeltch-MOBL1>
Subject: Re: [PATCH v1 1/2] Bluetooth: Move l2cap_chan_hold/put to l2cap_core.c
Date: Fri, 20 Jul 2012 12:02:22 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

--------------------------------------------------
From: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
Sent: Monday, July 16, 2012 4:25 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>; 
<linux-bluetooth@vger.kernel.org>; <s.syam@samsung.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: Move l2cap_chan_hold/put to 
l2cap_core.c

> On Mon, Jul 16, 2012 at 01:52:58PM +0300, Andrei Emeltchenko wrote:
>> Hi Jaganath,
>>
>> On Fri, Jul 13, 2012 at 06:17:54PM +0530, Jaganath Kanakkassery wrote:
>> > Refactor the code in order to use the l2cap_chan_destroy()
>> > from l2cap_chan_put() under the refcnt protection.
>> >
>> > Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> > Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>>
>> Both patches looks OK to me.
>>
>> Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>
>
> sorry old ab :(
>
> Reviewed-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> --

Ping.

Thanks,
Jaganath 

