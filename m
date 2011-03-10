Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 16:05:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/4] Sim Access Profile Manager
Message-ID: <20110310140550.GA22537@jh-x301>
References: <1298549606-16594-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1298549606-16594-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298549606-16594-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Feb 24, 2011, Waldemar Rymarkiewicz wrote:
> Add a SAP plugin main file and the plugin manager. Also include the SAP
> plugin in the Makefile.
> ---
>  Makefile.am   |    7 ++++
>  acinclude.m4  |    6 ++++
>  sap/main.c    |   55 +++++++++++++++++++++++++++++++++
>  sap/manager.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sap/manager.h |   22 +++++++++++++
>  sap/server.c  |   48 +++++++++++++++++++++++++++++
>  sap/server.h  |   26 ++++++++++++++++
>  7 files changed, 257 insertions(+), 0 deletions(-)
>  create mode 100644 sap/main.c
>  create mode 100644 sap/manager.c
>  create mode 100644 sap/manager.h
>  create mode 100644 sap/server.c
>  create mode 100644 sap/server.h

I've applied the first two patches, but the third one has some coding
style issues which I will comment on shortly.

Johan
