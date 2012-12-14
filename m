Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzKV27rWzLNo9BeNYqBxBgZ2jW_x6z4dRZbAMZBk3ehVPA@mail.gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
	<20121214092515.GA1521@x220>
	<CACLukzKV27rWzLNo9BeNYqBxBgZ2jW_x6z4dRZbAMZBk3ehVPA@mail.gmail.com>
Date: Fri, 14 Dec 2012 12:37:45 +0200
Message-ID: <CABBYNZK0rvLcmzpXWyccxrAd0NPAiO6hJKBtby=N0Cu-pNGhOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/13] network: Append version to Network and
 NetworkServer interfaces
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot <sancane@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 14, 2012 at 12:18 PM, Santiago Carot <sancane@gmail.com> wrote:
> Hi,
>
> 2012/12/14 Johan Hedberg <johan.hedberg@gmail.com>:
>> Hi Luiz,
>>
>> On Fri, Dec 14, 2012, Luiz Augusto von Dentz wrote:
>>> ---
>>>  doc/network-api.txt           | 4 ++--
>>>  profiles/network/connection.c | 2 +-
>>>  profiles/network/server.c     | 2 +-
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> All patches in this set have been applied. Thanks.
>>
>
> just a few comments, Wouldn't it have been better to add an
> API_VERSION macro and stick it besides each interface?, I haven't gone
> deept through each patch but it just looks like you are only adding
> the version number to each interface. In the future it could be
> annoying to have to go through all the source code to increment just
> the version number.

Each interface is independent, so if you break lets say
org.bluez.Network1 API you just change it not everything.

--
Luiz Augusto von Dentz
