Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130322110909.GA11186@x220.ger.corp.intel.com>
References: <1363788708-28355-1-git-send-email-andre.guedes@openbossa.org>
	<1363788708-28355-2-git-send-email-andre.guedes@openbossa.org>
	<20130322110909.GA11186@x220.ger.corp.intel.com>
Date: Tue, 26 Mar 2013 09:59:59 -0300
Message-ID: <CACJA=fVvdj89frEgNwN6AdSpAE_8Xpy=oYiJqngHUz3LFdo9Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix HCI request for Inquiry command
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 22, 2013 at 8:09 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Andre,
>
> On Wed, Mar 20, 2013, Andre Guedes wrote:
> > @@ -1079,6 +1077,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
> >  {
> >       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> >
> > +     hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
> > +
> >       if (status) {
> >               hci_conn_check_pending(hdev);
> >               hci_dev_lock(hdev);
>
> What about the hci_req_cmd_status call in the  hci_cmd_status_evt
> function? hci_req_cmd_status could call hci_req_cmd_complete in which
> case you'd get two calls to that function for the same event.

You are right. In case "status" is not zero, the callback function
will be called twice. This hci_req_cmd_complete call should go at the
end of hci_cs_inquiry, after the status check.

> I have a feeling that if you really want to consider all commands as
> completed based on command status events we should just skip the whole
> hci_req_cmd_status/complete distinction and remove the
> hci_req_cmd_status function completely (always calling cmd_complete).

I don't see any problem with this approach you suggested. If nobody
else is against this, I can do this change in the next version of this
patch set.

Regards,

Andre
