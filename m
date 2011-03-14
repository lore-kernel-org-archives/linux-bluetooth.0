Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 1/5] Add new UUID utility functions
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <4D7E8125.4030908@codeaurora.org>
Date: Mon, 14 Mar 2011 18:59:38 -0300
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Message-Id: <37C2799A-CA05-4714-A7BE-5FF913AF1C28@signove.com>
References: <1300128839-6293-1-git-send-email-epx@signove.com> <1300128839-6293-2-git-send-email-epx@signove.com> <4D7E8125.4030908@codeaurora.org>
To: Brian Gix <bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 14 Mar 2011, at 17:57 , Brian Gix wrote:

> Hi Elvis,
> 
> On 3/14/2011 11:53 AM, Elvis Pfützenreuter wrote:
>> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>> 
>> New UUID functions will store the UUIDs values on host order. Added
>> functions to create, compare and convert UUIDs.
> 
> [...]
> 
>> +
>> +void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
>> +{
>> +	switch (src->type) {
>> +	case BT_UUID128:
>> +		memcpy(dst, src, sizeof(bt_uuid_t));
>> +		dst->type = BT_UUID128;
> 
> Line not needed. It will get copied with the rest of the structure during memcpy.

Thanks for the review, I will send a fixed version of this patch only.