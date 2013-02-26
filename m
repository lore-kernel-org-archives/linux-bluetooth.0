Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 13:53:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH BlueZ 2/2] adapter: add a btd_create_stored_device() call
Message-ID: <20130226115328.GB2750@x220>
References: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
 <1361699686-12341-3-git-send-email-ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361699686-12341-3-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 24, 2013, Antonio Ospite wrote:
>   store_sdp_record

Why do you need to export this. Where do you get the input data from?

>   str2ba

This is a libbluetooth function. See my comment about that in my
previous email.

>   adapter_get_device
>   device_set_name
>   device_set_temporary
>   device_set_trusted

I have nothing against adding a btd_ prefix to these.

Johan
