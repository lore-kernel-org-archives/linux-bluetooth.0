Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <aa32413d0910200618p2fe3a940j304a5e598b0a04ac@mail.gmail.com>
References: <1256007499-19250-1-git-send-email-forrest.zhao@intel.com>
	 <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
	 <ac8af0be0910200205q3c3b57a6o4bd66870c8c4778a@mail.gmail.com>
	 <aa32413d0910200618p2fe3a940j304a5e598b0a04ac@mail.gmail.com>
Date: Wed, 21 Oct 2009 09:26:00 +0800
Message-ID: <ac8af0be0910201826q63095e5el49c4b5b05f0f0e64@mail.gmail.com>
Subject: Re: [PATCH] Implements the OBEX server/SyncML client binding for
	syncEvolution (http://syncevolution.org/).
From: Zhao Forrest <forrest.zhao@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Patrick Ohly <patrick.ohly@intel.com>,
	"Zhao, Forrest" <forrest.zhao@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>>
>>>> +       if (option_syncevolution == TRUE) {
>>>> +               services |= OBEX_SYNCEVOLUTION;
>>>> +               bluetooth_init(OBEX_SYNCEVOLUTION, "OBEX server for"
>>>> +                               " Syncevolution client", NULL,
>>>> +                               SYNCEVOLUTION_CHANNEL, TRUE, FALSE, FALSE,
>>>> +                               NULL);
>>>> +       }
>>>> +
>>>
>>> Which string is going to appear in the service description (the SDP
>>> part)? This one here? Mentioning "SyncML" would be useful. So I suggest
>>> "OBEX server for SyncML, using SyncEvolution". Leave out the
>>> "SyncEvolution client", because the term client is a) overloaded
>>> (SyncML/OBEX/D-Bus) and b) SyncEvolution could be both client and server
>>> in this context (SAN => SyncML client, SyncML message => SyncML server).
>>>
>> OK. Will expose service name as "OBEX server for SyncML, using SyncEvolution"
>> since ProviderName attribute is not supported by obexd now.
>
> If it's consensus the right way would be exposing SyncEvolution
> through ProviderName, please add a comment to the code telling that,
> so someone remember to fix it by the time obexd supports it.
>
Thank you for reminding. A FIXME comment will be put here.
