Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 01/14] Bluetooth: Periodic Inquiry and mgmt discovering event
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316521416.1937.70.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:12:19 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <03CE5F97-46C8-43F4-8887-C539DBB89E54@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-2-git-send-email-andre.guedes@openbossa.org> <1316521416.1937.70.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:23 AM, Marcel Holtmann wrote:

> Hi Andre,
> 
>> By using periodic inquiry command we're not able to detect correctly
>> when the controller has started inquiry.
>> 
>> Today we have this workaround in inquiry result event handler to set
>> the HCI_INQUIRY flag when it sees the first inquiry result event.
>> This workaround isn't enough because the device may be performing
>> an inquiry but the HCI_INQUIRY flag is not set. For instance, if
>> there is no device in range, no inquiry result event is generated,
>> consequently, the HCI_INQUIRY flags isn't set when it should so.
>> 
>> We rely on HCI_INQUIRY flag to implement the discovery procedure
>> properly. So, as we aren't able to clear/set the HCI_INQUIRY flag in
>> a reliable manner, periodic inquiry events shouldn't change the
>> HCI_INQUIRY flag. In future, if needed, we might add a new flag (e.g.
>> HCI_PINQUIRY) to know if the controller is performing periodic
>> inquiry.
>> 
>> Thus, due to that issue and in order to keep compatibility with
>> userspace, periodic inquiry events shouldn't send mgmt discovering
>> events.
> 
> I spend some time thinking about this and yes, we need to clean this
> mess up right now.
> 
> So intermixing inquiry with periodic inquiry was a bad idea and we
> should split this. So I think internally hci_dev needs a variable to
> track if we have enabled periodic inquiry or not. So it should express
> if periodic inquiry is on or off. Nothing else since we should not
> bother with trying to match periodic inquiry result to inquiry results.
> I would actually go this far that we should ignore inquiry result events
> from periodic inquiry.
> 
> Lets start creating some hci_dev internal state flags variable to track
> certain states/modes of the controller. As I said earlier, overloading a
> public API/ABI is not a good idea at all.
> 
> For tracking periodic inquiry state/mode we just need to be careful and
> take an inquiry result outside of start inquiry and inquiry complete as
> indication that periodic inquiry is active. There is still a potential
> false positive as you mentioned, but that also should not matter since
> periodic inquiry is suspending itself anyway. Important is just that we
> track inquiry and periodic inquiry states separately.
> 
> Another assumption is that periodic inquiry is only used by special
> applications and it is essentially triggered by 3rd party daemons doing
> something special for their needs. If periodic inquiry is enabled, I am
> even fine failing the mgmt_start_discovery command with an error.
> 

I agree.

> So in conclusion, I wanna have us tracking if the controller is
> currently doing periodic inquiry. And if you wanna export that state,
> then lets do it via debugfs.
> 
> Regards
> 
> Marcel
> 
> 

Andre
