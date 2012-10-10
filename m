Return-Path: <cyrus@holtmann.org>
Message-ID: <1349863238.27233.112.camel@aeonflux>
Subject: Re: [PATCH v2 7/7] adapter: Move saved config to ini-file format
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 12:00:38 +0200
In-Reply-To: <1349859520-8824-8-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349859520-8824-8-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Read and write config file in ini-file format.
> If the file can not be loaded, try to convert legacy configuration.
> ---
>  TODO          |    6 ++
>  src/adapter.c |  206 ++++++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 180 insertions(+), 32 deletions(-)

split these also into two, one for the core and one for the TODO file.

Regards

Marcel


