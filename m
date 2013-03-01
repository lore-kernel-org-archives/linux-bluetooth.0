Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 13/16] Bluetooth: Fix busy condition testing for EIR and class updates
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130301083902.GA17957@x220.P-661HNU-F1>
Date: Fri, 1 Mar 2013 08:02:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <42168620-5890-4C6F-8BAD-E7EEC3EE4407@holtmann.org>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com> <1361951844-13719-14-git-send-email-johan.hedberg@gmail.com> <DCADC53A-261F-4CF0-A1CB-34DD7A49CA77@holtmann.org> <20130301073232.GC14811@x220.P-661HNU-F1> <022948B2-E98F-4815-85BF-5227D65B2E71@holtmann.org> <20130301083902.GA17957@x220.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


>>> One possible solution I can think of is that we update the CoD or EIR
>>> value in hdev as soon as we create a HCI command to update the value, as
>>> opposed to updating the hdev value when the HCI command completes. This
>>> would allow us to have sensible checks on whether new HCI commands need
>>> to be queued or not. We'd then have to have some flag to indicate that
>>> there are pending EIR or CoD commands so that any of these mgmt commands
>>> don't return a direct cmd_complete just because it looks like everything
>>> is fine based on the CoD/EIR values in hdev.
>> 
>> I see the dilemma now. Still not liking it that much. I wonder if we
>> should just force one command of each opcode present at all time. No
>> special handling for any of them. If you send the same opcode twice
>> before it returned, you get busy error.
> 
> That still doesn't completely solve the issue since what we have is not
> just the same command conflicting against another pending instance of
> itself but several different commands conflicting against each other
> (since they all can cause changes to the CoD or EIR).

that is indeed a problem. As much as I do not like it, maybe doing it like you did is the only way to handle this. Can you add a comment on why we are doing this and send an updated patch series.

Regards

Marcel

