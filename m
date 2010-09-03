Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1009021441390.17665@linux-sea-02>
References: <AANLkTimnW0jk19cDG+r64Q+-HxdH2qdTBirTMB7ikr1W@mail.gmail.com>
	<alpine.DEB.2.00.1009021441390.17665@linux-sea-02>
Date: Fri, 3 Sep 2010 09:30:33 +0800
Message-ID: <AANLkTinrqQ0gbR0aQyojZHzFu6kSe6tuHTYFD7hdT=Qa@mail.gmail.com>
Subject: Re: [PATCH 16/22] Store new configuration values in l2cap_pinfo
From: haijun liu <liuhaijun.er@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 3, 2010 at 7:02 AM, Mat Martineau <mathewm@codeaurora.org> wrote:
>
> On Thu, 26 Aug 2010, haijun liu wrote:
>
>> From d093975dde6d85c824a5aaac943d676100810010 Mon Sep 17 00:00:00 2001
>> From: haijun.liu <haijun.liu@atheros.com>
>> Date: Mon, 23 Aug 2010 00:09:56 +0800
>> Subject: [PATCH 16/22] Store new configuration values in l2cap_pinfo.
>>
>> ---
>> include/net/bluetooth/l2cap.h |    9 +++++++++
>> 1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 2d864d4..f2dd65d 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -406,6 +406,15 @@ struct l2cap_pinfo {
>>        __u16           remote_mps;
>>        __u16           mps;
>>
>> +       __u8            ext_flowspec_enable;
>> +       struct ext_flow_spec    loc_efs;
>> +       struct ext_flow_spec    rem_efs;
>> +
>> +       __u8            extwin_enable;
>> +       __u16           extwin_size;
>> +       __u8            rem_extwin_enable;
>> +       __u16           rem_extwin_size;
>> +
>>        __le16          sport;
>>
>>        struct timer_list       retrans_timer;
>
> Regarding the new "extwin" structure members, have you considered changing
> the existing tx_win and remote_tx_win members to __u16 and using them with
> both standard and extended window sizes?
>
> The spec also requires that both directions of the link use the same type of
> control field (standard or extended).  After L2CAP configuration is done,
> all the information required for the transmit window is the control field
> type, tx_win, and remote_tx_win.  The control field would be set to
> 'extended' if a successful configuration response is sent or received for
> the extended window size option.
>
>
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>

Yes, we do, please look into the patch, we use __u16 for extwin_size &
rem_extwin_size
+       __u8            extwin_enable;
+       __u16           extwin_size;
+       __u8            rem_extwin_enable;
+       __u16           rem_extwin_size;

You are exactly right, in our implementation, choosing standard or
extended window,
it depends whether successful configuration response contain the
extended window size option.

-- 
Haijun Liu
