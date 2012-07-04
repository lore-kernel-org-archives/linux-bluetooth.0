Return-Path: <cyrus@holtmann.org>
Message-ID: <1341408879.1963.25.camel@aeonflux>
Subject: Re: [PATCH -v3 18/19] cups: move it to profiles folder
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Wed, 04 Jul 2012 15:34:39 +0200
In-Reply-To: <1341406295-7669-18-git-send-email-gustavo@padovan.org>
References: <1341406295-7669-1-git-send-email-gustavo@padovan.org>
	 <1341406295-7669-18-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> ---
>  Makefile.tools       |   12 +-
>  cups/cups.h          |   38 ---
>  cups/hcrp.c          |  368 ---------------------
>  cups/main.c          |  896 --------------------------------------------------
>  cups/sdp.c           |  119 -------
>  cups/spp.c           |  118 -------
>  profiles/cups/cups.h |   38 +++
>  profiles/cups/hcrp.c |  368 +++++++++++++++++++++
>  profiles/cups/main.c |  896 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/cups/sdp.c  |  119 +++++++
>  profiles/cups/spp.c  |  118 +++++++
>  11 files changed, 1547 insertions(+), 1543 deletions(-)
>  delete mode 100644 cups/cups.h
>  delete mode 100644 cups/hcrp.c
>  delete mode 100644 cups/main.c
>  delete mode 100644 cups/sdp.c
>  delete mode 100644 cups/spp.c
>  create mode 100644 profiles/cups/cups.h
>  create mode 100644 profiles/cups/hcrp.c
>  create mode 100644 profiles/cups/main.c
>  create mode 100644 profiles/cups/sdp.c
>  create mode 100644 profiles/cups/spp.c

please stop moving things around until I agreed with any new directory
structure.

Regards

Marcel


