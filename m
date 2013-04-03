Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Apr 2013 22:39:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add support for custom event terminated
 commands
Message-ID: <20130403193929.GA26555@x220.P-661HNU-F1>
References: <1365016283-25647-1-git-send-email-johan.hedberg@gmail.com>
 <1365016283-25647-2-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_OnCu+H0Mrtc+Zo30KxrPEaMcHUha_SRed=gEhaJv3vAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_OnCu+H0Mrtc+Zo30KxrPEaMcHUha_SRed=gEhaJv3vAA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Apr 03, 2013, Anderson Lizardo wrote:
> On Wed, Apr 3, 2013 at 3:11 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > -       hci_req_cmd_complete(hdev, opcode, ev->status);
> > +       if (ev->status ||
> > +           ((hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event)))
> > +               hci_req_cmd_complete(hdev, opcode, ev->status);
> 
> Any reason for the double parenthesis after || ?

Nope, just my own blindness :)

Johan
