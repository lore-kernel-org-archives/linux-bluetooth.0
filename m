Return-Path: <cyrus@holtmann.org>
Message-ID: <1337928909.15105.88.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Use hci_conn data to handle failed LE
 Connection Complete
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 25 May 2012 08:55:09 +0200
In-Reply-To: <CACJA=fVgzh9-RXBeJ=N7KRHDnEo_GTcVOnnv2dc-JMxKriBb4g@mail.gmail.com>
References: <1337201737-5983-1-git-send-email-andrzej.kaczmarek@tieto.com>
	 <1337202331.5970.269.camel@aeonflux>
	 <CA+6KyKZ0vrPHoXXfWwJdiVLDR+59azRwWMhJbjndM+Aw_dKSwA@mail.gmail.com>
	 <1337204910.5970.271.camel@aeonflux> <4FB4B13D.1010302@tieto.com>
	 <CACJA=fVgzh9-RXBeJ=N7KRHDnEo_GTcVOnnv2dc-JMxKriBb4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >>>>>
> >>>>>       hci_dev_lock(hdev);
> >>>>>
> >>>>> +     if (ev->status) {
> >>>>> +             conn = hci_conn_hash_lookup_state(hdev, LE_LINK,
> >>>>> BT_CONNECT);
> >>>>> +             if (!conn)
> >>>>> +                     goto unlock;
> >>>>> +
> >>>>> +             mgmt_connect_failed(hdev,&conn->dst, conn->type,
> >>>>>
> >>>>> +                                 conn->dst_type, ev->status);
> >>>>> +             hci_proto_connect_cfm(conn, ev->status);
> >>>>> +             conn->state = BT_CLOSED;
> >>>>> +             hci_conn_del(conn);
> >>>>> +             goto unlock;
> >>>>> +     }
> >>>>> +
> >>>>>       conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,&ev->bdaddr);
> >>>>>       if (!conn) {
> >>>>>               conn = hci_conn_add(hdev, LE_LINK,&ev->bdaddr);
> >>>>
> >>>>
> >>>> this change is wrong. We are now treating every single adapter as being
> >>>> broken. That is not acceptable.
> >>>
> >>>
> >>> Why do you think these adapters are broken? As I explained in cover
> >>> letter for v1, spec does not require peer address to be provided in
> >>> Connection Complete which is reasonable since we can only have one
> >>> pending connection request. Also as Claudio and Andre noticed such
> >>> behaviour could be to simplify whitelist implementation - in case of
> >>> connection request using whitelist it does not make sense to include
> >>> specific peer address in event.
> >>
> >>
> >> what has whitelist behavior to do with this event in the failure case?
> >
> >
> > Just a sidenote on why some vendors may want to omit BD_ADDR and it does not
> > make adapter broken. Not directly related to this scenario.
> 
> I was taking a look at Core spec change request document [1] and I found this:
> 
> Erratum 4215, LE connection complete event missing exception
> "... On failure, for this event, all other parameters are not valid."
> 
> It clearly states this is an expected behavior and nullify those
> parameters doesn't make the adapter broken.
> 
> Thus, in case of failure, we should not rely on those parameters
> (BD_ADDR included) in order to properly handle LE Connection Complete
> Events.

if this is so, then we should only do that and strictly enforce only one
LE connection attempt at a time. Also then there is no need to bother
with trying to check for the BD_ADDR later.

Regards

Marcel


