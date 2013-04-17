Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130417091835.GF6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
	<1365117675-2202-10-git-send-email-andre.guedes@openbossa.org>
	<20130417091835.GF6637@x220>
Date: Wed, 17 Apr 2013 19:18:05 -0300
Message-ID: <CACJA=fWu_qOxKc8cTD2-QKyeF+LgFKf9oAX7pLy=wQ_54361nQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] Bluetooth: Update le_scan_disable_work to use HCI request
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 17, 2013 at 6:18 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Andre,
>
> On Thu, Apr 04, 2013, Andre Guedes wrote:
> > +static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
> > +{
> > +     struct hci_command_hdr *last_cmd;
> > +     u16 opcode;
> > +
> > +     BT_DBG("status %d", status);
> > +
> > +     /* Get opcode from the last command sent */
> > +     last_cmd = (void *) hdev->sent_cmd->data;
> > +     opcode = __le16_to_cpu(last_cmd->opcode);
> > +
> > +     switch (opcode) {
> > +     case HCI_OP_LE_SET_SCAN_ENABLE:
> > +             if (status) {
> > +                     BT_ERR("Failed to disable LE scanning: status %d",
> > +                            status);
> > +                     return;
> > +             }
> > +
> > +             hci_dev_lock(hdev);
> > +             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +             hci_dev_unlock(hdev);
> > +             break;
> > +
> > +     case HCI_OP_INQUIRY:
> > +             if (status) {
> > +                     hci_dev_lock(hdev);
> > +                     hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +                     hci_dev_unlock(hdev);
> > +                     return;
> > +             }
> > +
> > +             break;
> > +     }
> > +}
> > +
> >  static void le_scan_disable_work(struct work_struct *work)
> >  {
> >       struct hci_dev *hdev = container_of(work, struct hci_dev,
> >                                           le_scan_disable.work);
> >       struct hci_cp_le_set_scan_enable cp;
> > +     struct hci_request req;
> > +     int err;
> >
> >       BT_DBG("%s", hdev->name);
> >
> > +     if (hdev->discovery.state != DISCOVERY_FINDING)
> > +             return;
> > +
> > +     hci_req_init(&req, hdev);
> > +
> >       memset(&cp, 0, sizeof(cp));
> > +     cp.enable = LE_SCAN_DISABLE;
> > +     hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> > +
> > +     /* If we are running the interleaved discovery, also add the inquiry
> > +      * HCI command to the HCI request.
> > +      */
> > +     if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
> > +             struct hci_cp_inquiry inq_cp;
> > +             /* General inquiry access code (GIAC) */
> > +             u8 lap[3] = { 0x33, 0x8b, 0x9e };
> > +
> > +             hci_dev_lock(hdev);
> > +             inquiry_cache_flush(hdev);
> > +             hci_dev_unlock(hdev);
> > +
> > +             memset(&inq_cp, 0, sizeof(inq_cp));
> > +             memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> > +             inq_cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
> > +             hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
> > +     }
> >
> > -     hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> > +     err = hci_req_run(&req, le_scan_disable_work_complete);
> > +     if (err)
> > +             BT_ERR("Failed to disable LE scanning: err %d", err);
> >  }
>
> I don't really like the complexity of the logic here with having to peek
> at hdev->sent_cmd to figure out what's going on in the callback. Maybe
> instead do this in two separate steps, i.e. send the HCI_OP_INQUIRY only
> in the callback for the HCI_OP_LE_SET_SCAN_ENABLE. Alternatively look
> into the possibility of using our recently introduced _sync API, though
> you'll first need to have a patch to add a hci_cmd_sync() which
> internally acquires the request lock.

I took a look at the possibility of using __hci_cmd_sync here, but
this approach isn't going to work. le_scan_disable_work and cmd_work
are both queued on hdev->workqueue. This means, if we call
__hci_cmd_sync here, the worker thread goes to sleep and the HCI
command is not sent until le_scan_disable_work finishes.

About the idea of doing this in two steps, as you suggested, I can
implement it. However, IMO, things can get more complex. IIRC, one of
the motivations of the HCI Request API is we be able to send several
command and handle them all in a single place (the request complete
callback) instead of spreading the handling in hci_event.c. If we
follow this chaining approach, we'll spread interleaved discovery
logic and command complete handling in several functions in
hci_core.c, making this code even more "spaghetty".

Regards,

Andre
