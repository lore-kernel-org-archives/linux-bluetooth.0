Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2015 21:34:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] Bluetooth: Move address type check for
 hci_conn_params
Message-ID: <20150630183446.GA18938@t440s>
References: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
 <20150630115555.GA29126@t440s.lan>
 <CAD0=r8xhkPSsWYiZH4BQP_xNp8A1W0GiHgk8BCbvi5RC0VM6SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8xhkPSsWYiZH4BQP_xNp8A1W0GiHgk8BCbvi5RC0VM6SQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Jun 30, 2015, Jakub Pawlowski wrote:
> On Tue, Jun 30, 2015 at 4:55 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Jakub,
> >
> > On Wed, Jun 24, 2015, Jakub Pawlowski wrote:
> >> @@ -2822,10 +2822,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> >>  {
> >>       struct hci_conn_params *params;
> >>
> >> -     /* The conn params list only contains identity addresses */
> >> -     if (!hci_is_identity_address(addr, addr_type))
> >> -             return NULL;
> >> -
> >>       list_for_each_entry(params, &hdev->le_conn_params, list) {
> >>               if (bacmp(&params->addr, addr) == 0 &&
> >>                   params->addr_type == addr_type) {
> >> @@ -2842,10 +2838,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> >>  {
> >>       struct hci_conn_params *param;
> >>
> >> -     /* The list only contains identity addresses */
> >> -     if (!hci_is_identity_address(addr, addr_type))
> >> -             return NULL;
> >> -
> >>       list_for_each_entry(param, list, action) {
> >>               if (bacmp(&param->addr, addr) == 0 &&
> >>                   param->addr_type == addr_type)
> >
> > Both of the above could be called for HCI events related to non-paired
> > devices that use private addresses. In such a case these identity
> > address checks would prevent unnecessary iteration of the (potentially
> > long) list. Do we really want to remove them?
> 
> Right now hci_conn_params struct can be used only for identity
> addresses. In upcoming patches I want to use it as piece of connect
> mechanism for all addresses, including RPA's. For that reason I have
> to remove this check. I can also create new structure, or separate
> list and use it for new connect mechanism, what do you think ?

Ok, now I understand. You *want* to have RPAs in the lists. I have a
feeling that using the same list will in the end result in the simplest
code. You just need to make sure that these entries don't stay there
forever and that they are appropriately updated with the identity
address info if we receive it from the remote during pairing.

Johan
