Return-Path: <cyrus@holtmann.org>
Message-Id: <460D2014-0925-42BE-A769-697E9795D4A4@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1229712795.879.6.camel@californication>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: How can I know BlueZ A2DP, AVRCP profile version.?
Date: Fri, 19 Dec 2008 20:12:43 +0200
References: <003501c961aa$588a4100$099ec300$%park@samsung.com> <1229712795.879.6.camel@californication>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Dec 19, 2008, at 20:53, Marcel Holtmann wrote:
>> How can I know BlueZ A2DP, AVRCP profile version.?
>>
>> As far as I search on the web site, A2DP,AVRCP version is 1.0  
>> respectively
>>
>> But I expect BlueZ version is higher than we search.
>
> I think that Johan and Luiz can give you more detailed answers here.
> However normally BlueZ follows the latest specs., but in the case of
> AVRCP I am sure we only implement some of the optional features.

For A2DP we support 1.2, or at least that's the spec version I've been  
using when doing the implementation. For AVRCP we've used the latest  
spec. version but since we don't have metadata transfer support yet we  
can only claim 1.0 conformance (the code might actually register a SDP  
record with a higher version so you'll need to modify that if you  
intend to do qualification).

Johan
