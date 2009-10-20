Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
References: <1256007499-19250-1-git-send-email-forrest.zhao@intel.com>
	 <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
Date: Tue, 20 Oct 2009 17:05:31 +0800
Message-ID: <ac8af0be0910200205q3c3b57a6o4bd66870c8c4778a@mail.gmail.com>
Subject: Re: [PATCH] Implements the OBEX server/SyncML client binding for
	syncEvolution (http://syncevolution.org/).
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "Zhao, Forrest" <forrest.zhao@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -53,6 +53,7 @@
>>  #define OPP_CHANNEL    9
>>  #define FTP_CHANNEL    10
>>  #define PBAP_CHANNEL   15
>> +#define SYNCEVOLUTION_CHANNEL  16
>>  #define PCSUITE_CHANNEL        24
>
> Do we want to call this "SYNCEVOLUTION" or "SYNCML"? Both has pros and
> cons. Treating it as generic SyncML capability hides the detail that
> it's currently based on SyncEvolution. Exposing SyncEvolution itself
> would allow to activate multiple different SyncML implementations at the
> same time.
>
> My preference would be to keep it as is, but I wanted to ask anyway.
I have the same idea as you do, and prefer to keep it as "SYNCEVOLUTION".

>
> Off topic: what is the "PC Suite Services server"?
>
It's Nokia OBEX PC Suite Services. Johan may know more details about it.

>> +       { "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
>> +                               "Enable OBEX server for Syncevolution client" },
>
> Mind the spelling: "syncevolution" (lower case) is the command line
> tool, "SyncEvolution" (camel case) the project. "Syncevolution" is a
> typo ;-)
>
Will fix it ASAP.

> Is there documentation that should be updated together with introducing
> the new feature?
The patch does not introduce any new d-bus API to obexd, so no doc need to
be updated.

>
>> +       if (option_syncevolution == TRUE) {
>> +               services |= OBEX_SYNCEVOLUTION;
>> +               bluetooth_init(OBEX_SYNCEVOLUTION, "OBEX server for"
>> +                               " Syncevolution client", NULL,
>> +                               SYNCEVOLUTION_CHANNEL, TRUE, FALSE, FALSE,
>> +                               NULL);
>> +       }
>> +
>
> Which string is going to appear in the service description (the SDP
> part)? This one here? Mentioning "SyncML" would be useful. So I suggest
> "OBEX server for SyncML, using SyncEvolution". Leave out the
> "SyncEvolution client", because the term client is a) overloaded
> (SyncML/OBEX/D-Bus) and b) SyncEvolution could be both client and server
> in this context (SAN => SyncML client, SyncML message => SyncML server).
>
OK. Will expose service name as "OBEX server for SyncML, using SyncEvolution"
since ProviderName attribute is not supported by obexd now.
