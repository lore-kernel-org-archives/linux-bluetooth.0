Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411746855-9936-1-git-send-email-fons@spotify.com>
Date: Mon, 29 Sep 2014 10:37:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> HCI_AUTO_CONN_DIRECT_REPORT_IND (associated to a new autoconnect
> action, 0x03) treats advertising reports like a combination of
> HCI_AUTO_CONN_DIRECT and HCI_AUTO_CONN_REPORT:
> 
> * Autoconnects on ADV_DIRECT_IND reports.
> * Notifies userland (MGMT_EV_DEVICE_FOUND) about ADV_IND reports.
> 
> This is useful to communicate with autoconnectable devices which
> advertise meaningful ADV_IND reports.
> 
> HCI_AUTO_CONN_DIRECT_REPORT_IND requires being able to simultaneously
> have a pending report and connection action. I merged pend_le_reports
> and pend_le_conns into the new pend_le_actions in order to make that
> possible while maintaining a unique list_head in hci_conn_parameters
> (action). This results in simpler handling of pending actions.

I am not really convinced that this is a good idea. In general either you really want Action 0x01 and only accept incoming connection or you want Action 0x02 and connect to the device no matter what.

Originally I had the idea that the advertising data that you receive from ADV_IND when Action 0x02 is in play gets also included in Device Connected event. My thinking there was that the Service Data might have changed and it would be useful to know ahead of time before starting any GATT procedures. However then it seems that was not really useful after all and I stopped considering it. Maybe this idea needs to be picked up again.

Regards

Marcel

