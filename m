Return-Path: <cyrus@holtmann.org>
Message-ID: <1349863073.27233.111.camel@aeonflux>
Subject: Re: [PATCH v2 1/7] adapter: Read name in storage at init
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 11:57:53 +0200
In-Reply-To: <1349859520-8824-2-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349859520-8824-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
>  plugins/adaptername.c |    9 ++++++---
>  src/adapter.c         |   34 ++++++++++++++++++++++++++++++++++
>  src/adapter.h         |    1 +
>  3 files changed, 41 insertions(+), 3 deletions(-)

split this into two, one for the core, one for the plugin.

Regards

Marcel


