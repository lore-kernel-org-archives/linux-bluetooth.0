Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357937329.1806.84.camel@aeonflux>
References: <1357922675-11718-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1357937329.1806.84.camel@aeonflux>
Date: Sun, 13 Jan 2013 17:29:11 +0200
Message-ID: <CABBYNZJJCW0oUOo_7F0VFcZVEFCVHZJpwGndke6P3T2pR9MqBg@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: Make map script a command line client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Christian Fetzer <christian.fetzer@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Christian,

On Fri, Jan 11, 2013 at 10:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Christian,
>
>> Rework the map-client test script into an interactive command line client.
>> Now multiple MCE functions can be called in one active session.
>> The script also allows to specify all filters or optional parameters including
>> auto completion.
>>
>> Change-Id: I9c9ede2bc958009c757384177cf06c081d984c98
>
> no Change-Id crap please.

I wonder if we should complicate more the testing scripts adding such
futures or start working in a proper C tool such as bluetoothctl e.g.
obexctl?

--
Luiz Augusto von Dentz
