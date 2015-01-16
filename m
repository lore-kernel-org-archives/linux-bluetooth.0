Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150116105342.GB1630@t440s.lan>
References: <1421240985-28944-1-git-send-email-jpawlowski@google.com>
	<1421240985-28944-2-git-send-email-jpawlowski@google.com>
	<20150116105342.GB1630@t440s.lan>
Date: Fri, 16 Jan 2015 12:52:19 +0100
Message-ID: <CAD0=r8x_pcyg+hsx3BZzsGz5Cu0rbSw4cKwrSwC+jEY2MSTW-g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] Bluetooth: Add restarting to service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Jan 16, 2015 at 11:53 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Jakub,
>
> On Wed, Jan 14, 2015, Jakub Pawlowski wrote:
> > +static void restart_le_scan(struct hci_dev *hdev)
> > +{
> > +     /* If controller is not scanning we are done. */
> > +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> > +             return;
>
> Since this function is only called from mgmt_device_found() can this
> condition actually ever be true?


Marcel proposed adding this check there, the rationale is in this mesage:
"""
so here you should check if we are scanning or not and if this extra
handling of restarts is actually needed.

In addition you might really want to check that this is the LE
scanning phase. I know that checking for
LE_SCAN would do that, but this is a bit dangerous since this code
path can also be entered from BR/EDR
inquiry results.
"""
http://article.gmane.org/gmane.linux.bluez.kernel/57005

>
> > +
> > +     queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
> > +                        msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
> > +}
>
> What you should probably be checking for however is that scan_end <
> jiffies + msecs_to_jiffies(DISCOV_LE_RESTART_DELAY) since then you know
> that the scanning will have stopped by the tame the restart work gets
> activated. Or am I thinking wrong here?

le_scan_disable_work that is used to disable scan is canceling
le_scan_restart, to make sure we won't try to restart after disabling
scan.
Also le_scan_restart_work have check to not start the restart process
when the scan is already disabled.

So I think it won't fix any bug. It will however save few cycles by
not queuing this work, so I'll add that check.

>
> >       if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> > -         (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
> > +         (rssi == HCI_RSSI_INVALID ||
> > +         (rssi < hdev->discovery.rssi && !test_bit(
> > +                     HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
>
> What I meant by splitting this is that the !test_bit would start on a
> new line. That way you wouldn't need to break the line right after (
>
> Johan
