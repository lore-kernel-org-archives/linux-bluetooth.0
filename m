Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] fix build
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Oct 2011 09:00:24 -0700
In-Reply-To: <1318866965-11091-1-git-send-email-frederic.danis@linux.intel.com>
References: <1318866965-11091-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318867227.15441.104.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

> src/eir.c: In function 'eir_parse':
> src/eir.c:72: error: 'name_len' may be used uninitialized in this function
> 
> and
> 
> thermometer/thermometer.c: In function 'destroy_char':
> thermometer/thermometer.c:79: error: implicit declaration of function 'g_slist_free_full'

please split this into two patches.

The fix for thermometer/thermometer.c is fine, but for src/eir.c I think
it is better to rewrite that function with a more clean and simpler
version.

Regards

Marcel


