Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2009 19:50:11 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: RE: How can I know BlueZ A2DP, AVRCP profile version.?
In-reply-to: <460D2014-0925-42BE-A769-697E9795D4A4@gmail.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>,
	'BlueZ development' <linux-bluetooth@vger.kernel.org>
Message-id: <000301c976ff$0a1339e0$1e39ada0$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <003501c961aa$588a4100$099ec300$%park@samsung.com>
 <1229712795.879.6.camel@californication>
 <460D2014-0925-42BE-A769-697E9795D4A4@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all

Does BlueZ Support A2DP as both Initiator and Acceptor role?

As far as I look-up the code , I could find A2DP as only INIT role. 

However both role are mandatory in A2DP 1.2, I believe BlueZ support both
role. 

If you know this role information, please let me know.

Thanks!


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Johan Hedberg
Sent: Saturday, December 20, 2008 3:13 AM
To: BlueZ development
Subject: Re: How can I know BlueZ A2DP, AVRCP profile version.?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

