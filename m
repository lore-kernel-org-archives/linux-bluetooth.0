Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 May 2013 14:03:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix mgmt handling of power on failures
Message-ID: <20130528110310.GA7539@x220.P-661HNU-F1>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_Mwp_xGNVPtV-ntbUtfZj63kuzcAPYy1yTHTATWofAqZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Mwp_xGNVPtV-ntbUtfZj63kuzcAPYy1yTHTATWofAqZA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, May 28, 2013, Anderson Lizardo wrote:
> On Tue, May 28, 2013 at 3:07 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > +int mgmt_set_powered_failed(struct hci_dev *hdev, int err)
> > +{
> > +       struct pending_cmd *cmd;
> > +
> > +       cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
> > +       if (!cmd)
> > +               return -ENOENT;
> > +
> > +       err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED,
> > +                        MGMT_STATUS_FAILED);
> > +
> > +       mgmt_pending_remove(cmd);
> > +
> > +       return err;
> > +}
> > +
> 
> Was the "err" parameter value supposed to be used on this function?

As I mentioned in my reply to Marcel it's there so this can be easily
extended to have a special mapping to the exact mgmt error returned (and
now it seems that this mapping will be implemented before this goes
upstream).

Johan
