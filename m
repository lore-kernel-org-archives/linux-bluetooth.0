Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Apr 2014 15:49:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow discovery during advertising
Message-ID: <20140423124947.GA5786@t440s.lan>
References: <1397588651-13459-1-git-send-email-lukasz.rymanowski@tieto.com>
 <20140423113722.GA2967@t440s.lan>
 <CAMudyAv12xVQzPJQRRMcNuQeAh7s9Q5B2c-z1AS+uoK+MjXepA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMudyAv12xVQzPJQRRMcNuQeAh7s9Q5B2c-z1AS+uoK+MjXepA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Apr 23, 2014, Lukasz Rymanowski wrote:
> On 23 April 2014 13:37, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Lukasz,
> >
> > On Tue, Apr 15, 2014, Lukasz Rymanowski wrote:
> >> With this patch it is possible to start scan when device does
> >> advertising.
> >>
> >> Most of chips do support such state combination, so there is no reason
> >> for blocking it here.
> >> If chip does not support this, kernel should get command status event
> >> with command disallowed status which should not make any problems.
> >>
> >> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> >> ---
> >>  net/bluetooth/mgmt.c | 7 -------
> >>  1 file changed, 7 deletions(-)
> >>
> >> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> index 54abbce..57cef73 100644
> >> --- a/net/bluetooth/mgmt.c
> >> +++ b/net/bluetooth/mgmt.c
> >> @@ -3474,13 +3474,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> >>                       goto failed;
> >>               }
> >>
> >> -             if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
> >> -                     err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
> >> -                                      MGMT_STATUS_REJECTED);
> >> -                     mgmt_pending_remove(cmd);
> >> -                     goto failed;
> >> -             }
> >> -
> >>               /* If controller is scanning, it means the background scanning
> >>                * is running. Thus, we should temporarily stop it in order to
> >>                * set the discovery scanning parameters.
> >
> > The general principle we've been following is that we don't send HCI
> > commands to the controller that we know will fail. In this case we do
> > track the supported states in hdev->le_states so you should be using
> > that to determine whether the command should fail or not.
> >
> Yes that was my first idea, but number of possible states combination
> is just "amazing", plus I checked  all dual mode controllers I had
> around me and all of them do support that state combinations which we
> need here. Have you seen controllers doing different? I so, why they
> do it :) ?

To be honest I haven't kept statistics of which controllers support this
and which don't. It's possible that all of the ones I have do support
it. However since we do have the information at our hands I don't see
why we wouldn't take advantage of it. In fact this should be just the
first step towards improving many other checks for simultaneous LE
operations.

To keep the code readable you'll probably want to have these checks in
separate helper functions. E.g. something like:

	bool hci_dev_can_scan(struct hci_dev *hdev, u8 scan_type);

That would take into account the supported states, current state
(advertising or not, etc) as well as the desired scan type. Later, we
could have similar ones for checking whether we can start advertising,
initiating an LE connection, etc.

Johan
