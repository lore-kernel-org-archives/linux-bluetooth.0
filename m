Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380668636-30654-5-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
	<1380668636-30654-5-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 1 Oct 2013 19:44:32 -0400
Message-ID: <CAJdJm_PB5vceysBY=hOiD9+JetndMxxYwTicu-vxqF7sggGtLg@mail.gmail.com>
Subject: Re: [PATCH 4/7] Bluetooth: Remove hci_cs_le_create_conn event handler
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guedes,

On Tue, Oct 1, 2013 at 7:03 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> This patch removes the hci_cs_le_create_conn event handler since this
> handling is now done in create_le_connection_complete() callback in
> hci_conn.c.

Did you mean "... now done in initiate_le_connection_complete()
callback in hci_core.c" ?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
