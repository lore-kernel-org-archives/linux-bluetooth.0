Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A9F65BD5-95F0-4DA8-B6DE-A8D4C8756269@holtmann.org>
References: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1362481981-7813-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<A9F65BD5-95F0-4DA8-B6DE-A8D4C8756269@holtmann.org>
Date: Wed, 6 Mar 2013 11:43:16 +0200
Message-ID: <CABBYNZJ_3jMMkNOUm_e1bwT=3Uq1t8u5D1xKj+eUuivnEZGyfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] obexd: Move Message.Get parameter attachment into dictionary
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 5, 2013 at 6:12 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Christian,
>
>> This is a preparation for adding additional parameters to Message.Get.
>> The parsing of the args dictionary is done in parse_get_options.
>>
>> The Attachment parameter has been moved into the args dictionary.
>> The parameter is now optional defaulting to true.
>> ---
>> doc/obex-api.txt   | 11 ++++++--
>> obexd/client/map.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--------
>> 2 files changed, 78 insertions(+), 14 deletions(-)
>>
>> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
>> index 759c4d8..9a78284 100644
>> --- a/doc/obex-api.txt
>> +++ b/doc/obex-api.txt
>> @@ -714,10 +714,10 @@ Message hierarchy
>> =================
>>
>> Service               org.bluez.obex
>> -Interface    org.bluez.obex.Message1
>> +Interface    org.bluez.obex.Message2
>> Object path   [variable prefix]/{session0,session1,...}/{message0,...}
>>
>> -Methods              object, dict Get(string targetfile, boolean attachment)
>> +Methods              object, dict Get(string targetfile, dict args)
>
> you can not do this. We need to support both APIs in this case. Also where is the discussion on this API change and especially why do we need it.

The discussion is in another thread but let me quote the important part here:

Use case
----------

Fractioned messages are used by some email push-services. Only the
first small part of the message is available on the phone.
The rest of the message has to be downloaded from the internet /
network. Which is slow, has high latency and causes additional costs.

For most of the messages, it might be enough for the user to have only
the first part of the fraction.
For other messages, the user might want to read the complete text.


Details from the spec
---------------------

The required attribute "reception_status" in the MAP-msg-listing is
set to "fractioned" for the specific message.
For normal messages it's set to "complete".

Two possibilities to download fractioned messages:
(1) Retreive complete message at once:
    One OBEX Get request (GetMessage omitting parameter FractionRequest)
    One OBEX Get response (bMessage)
    The MSE has to download the complete message from the internet and
deliver it transparently to the client

(2) Retreive message in fractions:
    Several OBEX Get requests (GetMessage, set parameter
FractionRequest to "first" or "more")
    Several OBEX Get responses (first: bMessage, further: bBody,
parameter FractionDeliver is set to "more" or "last")
    The fractions of one message must be downloaded sequentially and
it is not supported to interrupt by calling GetMessage for
    a different message


Blackberry seems to be doing this for emails, they keep it stored in
some server and only fractions of the message are in the device, so
with the current API it will force to download the remaining content
from the server.


--
Luiz Augusto von Dentz
