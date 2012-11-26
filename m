Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Nov 2012 13:56:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michael Knudsen <michaelknudsendk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Michael Knudsen <m.knudsen@samsung.com>
Subject: Re: [PATCH v2 0/3] mgmt:  read supported codecs
Message-ID: <20121126115646.GA27165@x220>
References: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353679170-3738-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Nov 23, 2012, Michael Knudsen wrote:
>   Bluetooth:  Add HCI Coding Format definitions
>   Bluetooth:  Support the read codecs operation

Since these are user space patches they should not be prefixed with
"Bluetooth". Also please just use one space after the colon. The
appropriate prefix for the first patch would be "lib" and for the second
one "mgmt".

>   Doco:  List the read codecs operation

The prefix should be "doc". And please remove the double spaces here as
well.

Johan
