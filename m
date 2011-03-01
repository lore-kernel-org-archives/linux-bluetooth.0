Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6D0BC5.8040109@hschmitt.de>
Date: Tue, 01 Mar 2011 16:07:49 +0100
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Sim Access Profile
References: <1298549606-16594-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1298549606-16594-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
> Here you are the SAP codes adjusted to previous comments and API change.
> 
> /Waldek
> 
> 
> Waldemar Rymarkiewicz (4):
>   Sim Access Profile API
>   Sim Access Profile Manager
>   Sim Access Profile Server
>   Sim Access Profile dummy driver
> 
>  .gitignore      |    1 +
>  Makefile.am     |   22 +-
>  acinclude.m4    |   12 +
>  doc/sap-api.txt |   34 ++
>  sap/main.c      |   55 +++
>  sap/manager.c   |   93 ++++
>  sap/manager.h   |   22 +
>  sap/sap-dummy.c |  328 +++++++++++++
>  sap/sap.h       |  192 ++++++++
>  sap/server.c    | 1425 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sap/server.h    |   26 +
>  11 files changed, 2208 insertions(+), 2 deletions(-)
>  create mode 100644 doc/sap-api.txt
>  create mode 100644 sap/main.c
>  create mode 100644 sap/manager.c
>  create mode 100644 sap/manager.h
>  create mode 100644 sap/sap-dummy.c
>  create mode 100644 sap/sap.h
>  create mode 100644 sap/server.c
>  create mode 100644 sap/server.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Is there a chance to get comments on this?

Best Regards,
Harald

