Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 00/22] Add AVDTP/A2DP decoding to btmon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJjxYkFbVepBkqyYr6k0=vEK3TByyvPjvb-P6jaeWvwsA@mail.gmail.com>
Date: Tue, 17 Nov 2015 09:40:25 +0100
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <83C3364E-09F9-4179-8A76-33F72C7EB5FA@holtmann.org>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl> <CABBYNZJjxYkFbVepBkqyYr6k0=vEK3TByyvPjvb-P6jaeWvwsA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Here's series of patches which adds decoding of AVDTP signalling channel
>> and A2DP codec capabilities information. Few things are missing:
>> - no fragmentation support
>> - some rarely used capabilities are not decoded
>> - ATRAC capabilities are not decoded
>> 
>> Other that above, pretty much everything should be decoded.
>> 
>> And some sample output from decoder:
>> 
>> < ACL Data TX: Handle 256 flags 0x00 dlen 6
>>      Channel: 1602 len 2 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Discover (0x01) Command: type 0x00 label 6 nosp 0
>>> ACL Data RX: Handle 256 flags 0x02 dlen 14
>>      Channel: 66 len 10 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Discover (0x01) Response Accept: type 0x00 label 6 nosp 0
>>        ACP SEID 1
>>          Media Type: Audio
>>          SEP Type: SRC
>>          In use: No
>>        ACP SEID 5
>>          Media Type: Audio
>>          SEP Type: SRC
>>          In use: No
>>        ACP SEID 3
>>          Media Type: Audio
>>          SEP Type: SRC
>>          In use: No
>>        ACP SEID 2
>>          Media Type: Audio
>>          SEP Type: SRC
>>          In use: No
> 
> I guess we can add it In use flag only when set.

actually btmon is suppose to decode and not be smart about when to show things. So lets really do print all parameters and not leave them out because they are unset.

>> < ACL Data TX: Handle 256 flags 0x00 dlen 7
>>      Channel: 1602 len 3 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Get Capabilities (0x02) Command: type 0x00 label 9 nosp 0
>>        ACP SEID: 3
>>> ACL Data RX: Handle 256 flags 0x02 dlen 23
>>      Channel: 66 len 19 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Get Capabilities (0x02) Response Accept: type 0x00 label 9 nosp 0
>>        Service Category: Media Transport
>>        Service Category: Media Codec
>>          Media Type: Audio
>>          Media Codec: Non-A2DP
>>            Vendor ID: 0x0000004f (APT Licensing Ltd.)
>>            Vendor Specific Codec ID: 0x0001 (aptX)
>>              Frequency: 0x30
>>                44100
>>                48000
>>              Channel Mode: 0x02
>>                Stereo
>>        Service Category: Content Protection
>>          Content Protection Type: SCMS-T
>> 
>> 
>> < ACL Data TX: Handle 256 flags 0x00 dlen 18
>>      Channel: 1602 len 14 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Set Configuration (0x03) Command: type 0x00 label 11 nosp 0
>>        ACP SEID: 1
>>        INT SEID: 1
>>        Service Category: Media Transport
>>        Service Category: Media Codec
>>          Media Type: Audio
>>          Media Codec: SBC
>>            Frequency: 0x20
>>              44100
>>            Channel Mode: 0x01
>>              Joint Channel
>>            Block Length: 0x10
>>              16
>>            Subbands: 0x04
>>              8
>>            Allocation Method: 0x01
>>              Loudness
>>            Minimum Bitpool: 2
>>            Maximum Bitpool: 53
> 
> Id got with a range instead of 2 field e.g. Bitpool: 2-53. Actually
> overall Id make this more compact instead of having another line for
> the decoded value just input in the same line with the hex value in
> parenthesis.

Actually the problem is not the bit pool. It is the others. It should be like this:

	Frequency: 44100 (0x20(	
	Block length: 16 (0x10)
	Allocation method: Loudness (0x01)

And please follow the styles I have introduced in the HCI portion and not make up new stuff. I actually want the strings to primary and also show the raw values.

> 
>>> ACL Data RX: Handle 256 flags 0x02 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Set Configuration (0x03) Response Accept: type 0x00 label 11 nosp 0
>> 
>>> ACL Data RX: Handle 256 flags 0x02 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Open (0x06) Response Accept: type 0x00 label 12 nosp 0
>> 
>> 
>> < ACL Data TX: Handle 256 flags 0x00 dlen 7
>>      Channel: 1602 len 3 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Start (0x07) Command: type 0x00 label 13 nosp 0
>>        ACP SEID: 1
>>> ACL Data RX: Handle 256 flags 0x02 dlen 6
>>      Channel: 66 len 2 [PSM 25 mode 0] {chan 2}
>>      AVDTP: Start (0x07) Response Accept: type 0x00 label 13 nosp 0
> 
> Would you be able to include the output above into the patch that
> introduce it? I think it is a bit better to see the formatting each
> patch is introducing and then have proper comments to them.

Why are we falling back into trying to cramp all stuff into a single line. btmon is verbose on purpose. Deal with i.

Regards

Marcel

