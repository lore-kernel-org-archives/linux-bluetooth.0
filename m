Return-Path: <cyrus@holtmann.org>
Subject: Re: Baseband Packet Type for Mobile Terminated (incoming) ACL
 Connection.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 19 Oct 2011 09:28:10 -0700
In-Reply-To: <5D9D8931B4C84345B8A50CA879B0CE195BD2CE12@fmsmsx501.amr.corp.intel.com>
References: <5D9D8931B4C84345B8A50CA879B0CE195BD2CE12@fmsmsx501.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319041692.15441.152.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

> We are facing a problem wherein controller always uses DM1 baseband packets for outgoing ACL traffic in case of MT connection. The issue is because host doesn't change the packet types to be used after MT connection is up if HCI_Version is >= 3 (Bluetooth Core Specification 2.0 + EDR) and hence controller uses the default (DM1) baseband packets. The relevant code from hci_event.c is pasted below:
> 
>        if (!conn->out && hdev->hci_ver < 3) {
>             struct hci_cp_change_conn_ptype cp;
>             cp.handle = ev->handle;
>             cp.pkt_type = cpu_to_le16(conn->pkt_type);
>             hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE,
>                             sizeof(cp), &cp);
>         }
> 
> Also, controller seems to be doing right thing here by using DM1 packets as specification for HCI_Change_Connection_Packet_Type and HCI_Create_Connection states that:
> 
> "When sending HCI ACL Data Packets the Link Manager shall only use the packet type(s) specified by the Packet_Type command parameter or the always-allowed DM1 packet type."
> 
> Could someone let us know if there is an alternate way to configure the packet types to be used by controller for MT connection and what are the basis/reference for this implementation in Bluez means not to change the packet types if HCI_Version is >= 3? I tried to find the information from specification but could not find any information there.

so this is what I wrote when I made this change back in 2008:

commit a8746417e864da1ed36dd2432a399fbeb843c2a0
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Jul 14 20:13:46 2008 +0200

    [Bluetooth] Track connection packet type changes
    
    The connection packet type can be changed after the connection has been
    established and thus needs to be properly tracked to ensure that the
    host stack has always correct and valid information about it.
    
    On incoming connections the Bluetooth core switches the supported packet
    types to the configured list for this controller. However the usefulness
    of this feature has been questioned a lot. The general consent is that
    every Bluetooth host stack should enable as many packet types as the
    hardware actually supports and leave the decision to the link manager
    software running on the Bluetooth chip.
    
    When running on Bluetooth 2.0 or later hardware, don't change the packet
    type for incoming connections anymore. This hardware likely supports
    Enhanced Data Rate and thus leave it completely up to the link manager
    to pick the best packet type.

So if I understand this correctly what you are saying, then the local
controller has an incoming connection and since we do not change the
packet types, it treats it literally to just use DM1.

My understanding was that the link manager always uses all possible
packets types until restricted by the host stack. So the default packet
type list in the controller should be all available types.

So even if you read the specification in a way that the execution of
changing the packet types is needed to allow anything other than DM1,
then I am still questioning why the EDR packet types are not used. Since
due to their inverted logic, they should be on by default. Or what is
the default packet type mask of this controller?

Regards

Marcel


