Return-Path: <cyrus@holtmann.org>
Message-ID: <4CBFE96A.9090805@Atheros.com>
Date: Thu, 21 Oct 2010 12:49:06 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Suraj Sumangala
	<Suraj.Sumangala@Atheros.com>
Subject: Re: [PATCH 3/4] Sim Access Profile Server
References: <1287576681-12669-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <1287576681-12669-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1287576681-12669-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 10/20/2010 5:41 PM, Waldemar Rymarkiewicz wrote:
> Add a Sim Access Server to the SAP plugin and a framework for the dummy
> sap driver as well.
> ---
>   Makefile.am     |    3 +-
>   sap/sap-dummy.c |   85 ++++
>   sap/sap.h       |  187 +++++++
>   sap/server.c    | 1476 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 1745 insertions(+), 6 deletions(-)
>   create mode 100644 sap/sap-dummy.c
>   create mode 100644 sap/sap.h


Looks like this patch does not apply successfully on the latest Bluez 
tree after applying the first two. Can you verify that?

Regards
Suraj
