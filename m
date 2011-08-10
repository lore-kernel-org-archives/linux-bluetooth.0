Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Aug 2011 15:15:28 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: Gustavo Padovan <padovan@profusion.mobi>,
	Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
In-Reply-To: <CABBYNZKH4Ce1P6MSY9Nsz_Xf4+EQF5zs4dRo1VHhSoEWjWTnbg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1108101514180.29874@mathewm-linux>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com> <alpine.DEB.2.02.1108040901420.13578@mathewm-linux> <1312499377.2158.36.camel@THOR> <20110805191210.GA2537@joana> <alpine.DEB.2.02.1108081628030.29183@mathewm-linux> <20110809043210.GA2594@joana>
 <alpine.DEB.2.02.1108100942580.25878@mathewm-linux> <CABBYNZKH4Ce1P6MSY9Nsz_Xf4+EQF5zs4dRo1VHhSoEWjWTnbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Luiz -

On Wed, 10 Aug 2011, Luiz Augusto von Dentz wrote:

> Hi Mat,
>
> On Wed, Aug 10, 2011 at 8:38 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>>> +struct hci_chan {
>>> +       struct list_head list;
>>> +       struct hci_conn *conn;
>>> +       struct sk_buff_head data_q;
>>> +       unsigned int    sent;
>>> +}
>>
>> At the BlueZ summit last year, the group settled on using an "HCI channel"
>> as an abstraction for AMP logical links.  We have a hci_chan struct already
>> that you could add to.  Before making changes to HCI data structures, could
>> we first work on upstreaming the AMP HCI changes (which also include some
>> QoS-related code)?
>
> If just you told us this before I would have not spend time
> implementing it, so could you please sent this patches ASAP, otherwise
> I will just send mine that just address the prioritization

Your RFC patches for prioritized HCI queues are not in conflict with 
the AMP code.  It's just the proposed hci_chan structure that came up 
in this email thread.

My recent patches are the beginning of AMP upstreaming.  I was trying 
to get the generic L2CAP improvements in place first.  One of my 
coworkers is starting to work in parallel on upstreaming the HCI 
changes, but we need to create a suitable patch series for 
bluetooth-next.


> Btw, the thread intent is perhaps becoming too broad,  we should focus
> in small steps lets say first HCI Channel, then we continue from
> there.

I agree, it's hard to keep track of the various sub-threads at this 
point.  The HCI channel is a good place to start.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

