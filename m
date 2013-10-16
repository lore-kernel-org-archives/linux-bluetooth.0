Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 15:31:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/6] Bluetooth: Set the scan response data when needed
Message-ID: <20131016123153.GA6306@x220.p-661hnu-f1>
References: <1381907811-33872-3-git-send-email-marcel@holtmann.org>
 <CAJdJm_NtG8XyMYFL5DbiAiuwN=-kf-WFzckiiY_7uSpowTGKYA@mail.gmail.com>
 <20131016122801.GA2803@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131016122801.GA2803@x220.p-661hnu-f1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 16, 2013, Johan Hedberg wrote:
> On Wed, Oct 16, 2013, Anderson Lizardo wrote:
> > On Wed, Oct 16, 2013 at 3:16 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > +static void update_scan_rsp_data(struct hci_request *req)
> > > +{
> > > +       struct hci_dev *hdev = req->hdev;
> > > +       struct hci_cp_le_set_scan_rsp_data cp;
> > > +       u8 len;
> > > +
> > > +       if (!lmp_le_capable(hdev))
> > > +               return;
> > > +
> > > +       memset(&cp, 0, sizeof(cp));
> > > +
> > > +       len = create_scan_rsp_data(hdev, cp.data);
> > > +
> > > +       if (hdev->adv_data_len == len &&
> > > +           memcmp(cp.data, hdev->adv_data, len) == 0)
> > > +               return;
> > > +
> > > +       memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> > > +       hdev->adv_data_len = len;
> > 
> > Shouldn't you be using hdev->scan_rsp_data/scan_rsp_data_len here?
> > 
> > (I still haven't read the later patches, so this may already be fixed.)
> 
> Nope, it's still broken upstream. Good that you noticed it. Bad that I
> didn't and bad that it seems Marcel didn't actually test this one
> properly ;)

I just sent a patch to fix this which Marcel can push if he's fine with
it.

Johan
