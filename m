Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 10:27:28 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
    gustavo@padovan.org
Subject: Re: [RFCv1 00/11] Handling physical and logical link
In-Reply-To: <20121025133510.GA14818@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1210261018280.2459@mathewm-linux>
References: <1350493622.26318.114.camel@aeonflux> <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1351170668.1785.93.camel@aeonflux> <20121025133510.GA14818@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel and Andrei -

On Thu, 25 Oct 2012, Andrei Emeltchenko wrote:

> Hi Marcel,
>
> On Thu, Oct 25, 2012 at 06:11:08AM -0700, Marcel Holtmann wrote:
>> Hi Andrei,
>>
>>> Set of patches adding handling for physical and logical link
>>> complete events.
>>>
>>> Changes:
>>> 	* rfcv1: Rebased on top of Mat's patches, preserve Marcel's ack for
>>> 	not-changed-much patches only.
>>> 	* rfcv0: original
>>
>> all in all, this looks pretty good to me.
>>
>> Mat, can you take an extra look at it as well.
>>
>> What is actually missing after this set of patches?
>
> Still a lot. First it is finishing physical link establishment and then
> channel move.

I looked things over and don't have any major comments or issues.

The main AMP/A2MP/L2CAP task right now is to get the right information 
propagated to L2CAP using l2cap_physical_cfm() and 
l2cap_logical_cfm().  After that, there are the various "Placeholder" 
comments in l2cap_core.c

There is another piece of work involving L2CAP ERTM resegmentation 
that depends on MSG_MORE support:

http://www.spinics.net/lists/linux-bluetooth/msg25615.html


--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
