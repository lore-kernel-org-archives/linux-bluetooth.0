Return-Path: <cyrus@holtmann.org>
Message-ID: <4CBEAA45.4010702@Atheros.com>
Date: Wed, 20 Oct 2010 14:07:25 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Suraj Sumangala
	<Suraj.Sumangala@Atheros.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	"joakim.xj.ceder@stericsson.com" <joakim.xj.ceder@stericsson.com>,
	"arunkr.singh@stericsson.com" <arunkr.singh@stericsson.com>
Subject: Re: [PATCH 1/1] Add Sim Access Plugin
References: <1287561308-18611-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <1287561308-18611-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1287561308-18611-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On 10/20/2010 1:25 PM, Waldemar Rymarkiewicz wrote:
> Sim Access plugin implements Sim Access Profile server role
> according to the Bluetooth Sim Access Profile v1.1 specification.
> ---
>   .gitignore      |    1 +
>   Makefile.am     |   25 +-
>   acinclude.m4    |   14 +
>   doc/sap-api.txt |   57 ++
>   sap/main.c      |   54 ++
>   sap/manager.c   |   94 ++++
>   sap/manager.h   |   21 +
>   sap/sap-dummy.c |  306 +++++++++++
>   sap/sap-ste.c   | 1265 ++++++++++++++++++++++++++++++++++++++++++++++
>   sap/sap.h       |  187 +++++++
>   sap/server.c    | 1516 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   sap/server.h    |   23 +
>   12 files changed, 3559 insertions(+), 4 deletions(-)
>   create mode 100644 doc/sap-api.txt
>   create mode 100644 sap/main.c
>   create mode 100644 sap/manager.c
>   create mode 100644 sap/manager.h
>   create mode 100644 sap/sap-dummy.c
>   create mode 100644 sap/sap-ste.c
I am assuming that this is the ST specific plugin. May be you can just 
keep the dummy plugin only so that someone can use that as a reference.
>   create mode 100644 sap/sap.h
>   create mode 100644 sap/server.c
>   create mode 100644 sap/server.h

I guess it would be better if you can split this into multiple patches 
so that it would be easier to review.

Regards
Suraj
