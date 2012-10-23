Return-Path: <cyrus@holtmann.org>
Message-ID: <1351003482.1785.28.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: Remove unnecessary include export.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 07:44:42 -0700
In-Reply-To: <1350999140-7481-2-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
	 <1350999140-7481-2-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> For files only using THIS_MODULE and/or EXPORT_SYMBOL, map
> them onto including export.h -- or if the file isn't even
> using those, then just delete the include.

have you actually check this on other architectures like PowerPC or
Sparc?

commit 8c520a59927a5600973782505dbb750d985057c4
Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date:   Wed May 23 04:04:22 2012 -0300

    Bluetooth: Remove unnecessary headers include
    
    Most of the include were unnecessary or already included by some other
    header.
    Replace module.h by export.h where possible.

Regards

Marcel


