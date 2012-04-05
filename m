Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405154121.GB4102@x220.P-661HNU-F1>
References: <1333603129-18813-1-git-send-email-hemant.gupta@stericsson.com>
	<20120405105824.GH32212@x220>
	<CACj007=AXwV6DRp40dfCwacqBk6VPAvfo+VjfgX6vpwVAV2dFQ@mail.gmail.com>
	<20120405154121.GB4102@x220.P-661HNU-F1>
Date: Thu, 5 Apr 2012 21:15:31 +0530
Message-ID: <CACj007mi7gBsPNZu_5LM+Ww5LJV_tsXTxKJihS6tqEM1t-J8sw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Send Discovery Stopped event when discovery fails
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 9:11 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Thu, Apr 05, 2012, Hemant Gupta wrote:
>> I found this issue because I found the following situation that LE
>> Scan failed to start (in my case because of Limited resources). At
>> that time, the discovery state was DISCOVERY_STARTING. In that case,
>> user space, had already started the discovery session, which is freed
>> only on receiving the event in MGMT_EV_DISCOVERING, with state set to
>> FALSE. If you look at the code of mgmt_start_discovery_failed ()
>> below, which will be called when LE Scan failed to start, no
>> MGMT_EV_DISCOVERING is sent to user space, so user space would never
>> free the discovery session that it has created while calling
>> start_discovery. In short Inquiry never finishes.
>
> That's a bug in user space and it should be fixed there. I.e. user space
> should be fixed to handle the command status/complete for
> start_discovery properly.

Thanks for the comment, I will try to fix and upload the patch for review ASAP.
>
>> > So who sends the appropriate command complete event to start_discovery
>> > now? I don't see any other place that would do it.
>>
>> It is being sent from the mgmt_discovering(hdev, 0); called because of
>> call to hci_discovery_set_state, which will set state to
>> DISCOVERY_STOPPED, since the current state would in this case be
>> DISCOVERY_STARTING.
>
> If the "discovering" parameter passed to mgmt_discovering is 0 then
> mgmt_discovering will only look for a pending MGMT_OP_STOP_DISCOVERY and
> not MGMT_OP_START_DISCOVERY. So it still looks to me like there'd be a
> missing command complete.
>
Yups that's correct, sorry missed it.

> Anyway, like I said this looks more like something we need to fix in
> user space before making the next release.
>
> Johan



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
