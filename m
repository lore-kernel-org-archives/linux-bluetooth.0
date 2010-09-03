Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1009021430120.17665@linux-sea-02>
References: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
	<alpine.DEB.2.00.1009021430120.17665@linux-sea-02>
Date: Fri, 3 Sep 2010 09:19:52 +0800
Message-ID: <AANLkTikwV_OuKXy05L5BLZE=hKruA4HOVMY_fhjN=aHJ@mail.gmail.com>
Subject: Re: [PATCH 13/22] Add three new options for l2cap_options which used
 in setsockopt & getsockopt
From: haijun liu <liuhaijun.er@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 3, 2010 at 5:41 AM, Mat Martineau <mathewm@codeaurora.org> wrote:
>
> On Thu, 26 Aug 2010, haijun liu wrote:
>
>> From 897b281d14ba4cf9a5fbbf5ba65b84c85e688737 Mon Sep 17 00:00:00 2001
>> From: haijun.liu <haijun.liu@atheros.com>
>> Date: Mon, 23 Aug 2010 00:00:26 +0800
>> Subject: [PATCH 13/22] Add three new options for l2cap_options which
>> used in setsockopt & getsockopt.
>>
>> ---
>> include/net/bluetooth/l2cap.h |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index d0ae9f5..4f87aec 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -65,6 +65,9 @@ struct l2cap_options {
>>        __u8  fcs;
>>        __u8  max_tx;
>>        __u16 txwin_size;
>> +       __u8  hschan_req;
>> +       __u8  guaranteed;
>> +       __u8  reconfig;
>> };
>>
>> #define L2CAP_CONNINFO  0x02
>
> How are each of these new options used?
>
> Are any of the new options changeable after the socket is connected?
>
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>

I accept David suggestion, I am waiting your patch merged.

Yes, these are changeable.

-- 
Haijun Liu
