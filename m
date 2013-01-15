Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358195633-29303-5-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
	<1358195633-29303-5-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Jan 2013 21:06:12 -0400
Message-ID: <CAJdJm_OgQeZ+aB=jtLuRKB-p57msmHK5tW9aVjWvKRo5RFARrg@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: Fix write_scan_enable when HCI_AUTO_OFF is set
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jan 14, 2013 at 4:33 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> [...]
> Since mgmt_powered() no longer takes care of the write_scan_enable we
> also need to ensure that it's part of the hci_setup procedure and hence
> the set_bredr_scan() function needs to be moved into hci_core.c from
> mgmt.c.

Small typo: hci_core.c -> hci_event.c

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
