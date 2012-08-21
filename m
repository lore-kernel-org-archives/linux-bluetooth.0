Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345537878.29868.185.camel@pohly-mobl1.fritz.box>
References: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1345537878.29868.185.camel@pohly-mobl1.fritz.box>
Date: Tue, 21 Aug 2012 13:41:41 +0200
Message-ID: <CANT-zCV9exkSjQhvGqLVqdBL+GBvNG97EUnPGo55_AaAO60P+A@mail.gmail.com>
Subject: Re: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Aug 21, 2012 at 10:31 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Tue, 2012-08-21 at 09:23 +0200, Mikel Astiz wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> The client D-Bus documentation should mention that all transfer paths
>> contain a prefix consisting of the path of the session they belong to.
>>
>> This can be conveniently used by clients to install D-Bus signal matches
>> that concentrate on the relevant signals.
>> ---
>>  doc/client-api.txt |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> index 839a78c..7ca65cc 100644
>> --- a/doc/client-api.txt
>> +++ b/doc/client-api.txt
>> @@ -466,7 +466,7 @@ Transfer hierarchy
>>
>>  Service              org.bluez.obex.client
>>  Interface    org.bluez.obex.Transfer
>> -Object path  [variable prefix]/{transfer0,transfer1,...}
>> +Object path  [variable prefix]/{session0,session1,...}/{transfer0,...}
>>
>>  Methods              dict GetProperties()
>
> It would be even better to explicitly mention that the "[variable
> prefix]" here is the same as the "[variable prefix]" in the Session.

This documentation pattern can be widely found in Obexd and Bluez, as
well as oFono. It's implicit that the variable prefix matches in both
cases.

> Or perhaps change it like this?
>
> -Object path    [variable prefix]/{transfer0,transfer1,...}
> +Object path    [session prefix]/{transfer0,...}

Having said that, I'm not against using this other style. In that case
we would need to change lots of files for consistency.

Cheers,
Mikel
