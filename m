Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121214092515.GA1521@x220>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
	<20121214092515.GA1521@x220>
Date: Fri, 14 Dec 2012 11:18:29 +0100
Message-ID: <CACLukzKV27rWzLNo9BeNYqBxBgZ2jW_x6z4dRZbAMZBk3ehVPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/13] network: Append version to Network and
 NetworkServer interfaces
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2012/12/14 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Luiz,
>
> On Fri, Dec 14, 2012, Luiz Augusto von Dentz wrote:
>> ---
>>  doc/network-api.txt           | 4 ++--
>>  profiles/network/connection.c | 2 +-
>>  profiles/network/server.c     | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> All patches in this set have been applied. Thanks.
>

just a few comments, Wouldn't it have been better to add an
API_VERSION macro and stick it besides each interface?, I haven't gone
deept through each patch but it just looks like you are only adding
the version number to each interface. In the future it could be
annoying to have to go through all the source code to increment just
the version number.

Regards.
