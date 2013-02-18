Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 09:51:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Bluetooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 12/12] Bluetooth: Remove empty HCI event handlers
Message-ID: <20130218075146.GD17232@x220>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
 <1360767045-26958-13-git-send-email-johan.hedberg@gmail.com>
 <CAMXE1-pn2V-6mgvqpwDygaqgsUr90yV7BS_txyzGQytA4gTABw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMXE1-pn2V-6mgvqpwDygaqgsUr90yV7BS_txyzGQytA4gTABw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Sun, Feb 17, 2013, Andrei Emeltchenko wrote:
> > With the removal of hci_req_complete() several HCI event handles have
> > essentially become empty and can be removed.
> 
> It is still good to have debug traces.

If you need to trace exactly what HCI events are happening btmon and
hcidump are probably much more useful tools for that than kernel debug
logs. And even if you do want debug logs we can just add single BT_DBT()
calls to the hci_cmd_complete() and hci_cmd_status() functions instead
of creating a new function for every single event just for the sake of
having a debug log for them.

Johan
