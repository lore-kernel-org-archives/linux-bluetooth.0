Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimq_OEIplkLijA2TZLPz4tKOU7b4V-IYR_om_Px@mail.gmail.com>
References: <AANLkTimq_OEIplkLijA2TZLPz4tKOU7b4V-IYR_om_Px@mail.gmail.com>
Date: Thu, 15 Jul 2010 15:38:27 +0300
Message-ID: <AANLkTilowPoE7LnbmZ4RDPqTyB7QlZ2Yp5WBFctpT2_C@mail.gmail.com>
Subject: Re: Question about obexd
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-2?Q?Rafa=B3_Michalski?= <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/7/15 Rafa³ Michalski <michalski.raf@gmail.com>:
> Hello
>
> I'd like to ask which functions in obexd daemon are involved in
> exporting: outgoing calls list, incoming calls list, missed calls list
> -  from phone to paired device (headset or carkit), and how it
> generally works ?
> I would be graceful for any help.

PBAP related driver depend on the platform, so lets say the platform
has tracker backend then you should configure --with-phonebook=tracker
and then phonebook-tracker.c will be compiled. As for the interface
this drivers should implement the functions in phonebook.h.

Does this answer your question?

-- 
Luiz Augusto von Dentz
Computer Engineer
