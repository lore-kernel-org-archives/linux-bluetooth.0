Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001F63875E1AF5428162B5A2D3ED1BDD8FAF@IRSMSX101.ger.corp.intel.com>
References: <001F63875E1AF5428162B5A2D3ED1BDD8E98@IRSMSX101.ger.corp.intel.com>
	<20120105141946.GA8667@x220>
	<4f05c20d.0b52650a.405a.ffffffe4@mx.google.com>
	<001F63875E1AF5428162B5A2D3ED1BDD8FAF@IRSMSX101.ger.corp.intel.com>
Date: Fri, 6 Jan 2012 16:19:36 +0200
Message-ID: <CAP2uLp79iZR5sQiSfjXp_jVXS2QL441=WpTSD=crGm+sysQVuA@mail.gmail.com>
Subject: Re: [PATCH] Breaks in A2DP playback during device search
From: Amir Hadar <amir.hadar.ti@gmail.com>
To: "Aj, SanthoshX" <santhoshx.aj@intel.com>
Cc: "Hedberg, Johan" <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Holtmann, Marcel" <marcel.holtmann@intel.com>,
	"Nair, Rashmi G" <rashmi.g.nair@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> We encountered the same dilemma and suggested a solution using Flow
>> specification.
>>
>> The Flow Specification HCI relates to an ACL handle and not a specific
>> L2CAP channel. If we intend to configure the Flow Spec using socket
>> option then different profiles might overrun each other settings.
>>
>> The other option of using the mgmt is not too good either. Since this
>> command is "Link" related and not "Adapter/Device" related, the daemon
>> dbus API would have to receive the ACL handle as parameter or introduce
>> a new property on Device node which might not exist. Note that one can
>> create an L2CAP socket without interfacing the daemon.
>>
>> My humble opinion is to set the Flow Spec per socket (l2cap/rfcomm)
>> using socket options. Store it per channel and send accumulated flow
>> spec on every change per ACL.
>>
>> - channel changed its flow sepc
>> - channel with flow spec was closed
>>
>> All done in the kernel, no changes to the daemon.
>>
>> Kind Regards,
>> Amir Hadar
>>
>>
>
> Thanks for your valuable inputs; as mentioned earlier please note we are
> currently using Android Froyo (2.2.2) which has bluez version 4.47 &
> kernel version 2.6.32.
>
> Using Flow specification is seems to be good. I will change it to flow spec
> instead of qos setup command.
>
> I want to know one thing if we want to use setsockopt to send flow spec
> (add new socket option SO_L2CAP_OQOS) just handle it l2cap.c to send hci
> flow spec command,
> that's what you are suggesting?
>

First as said before you must submit your patch based on latest
bluetooth-next kernel (not on 2.6.32).

Second,  You should get acceptance on adding new socket option. As I
remember there was an objection on adding new socket options though in
this case I think it is the correct solution.

Here is a short RFC
I would suggest to store the flow spec parameters in the l2cap_chan struct.
Store the current active flow spec (also add pending_flow_spec) in the
hci_conn struct. In hci_connect after
the acl is connected call a new function hci_calc_flow_spec which goes
over all l2cap channel (hci_chan->list) and accumulate flow spec params.
Set the hci_conn pending flow spec and send the HCI cmd. In hci_event add
case for the command complete and a "cs" function for handling the response.
In this function set the active flow spec.
When an l2cap channel disconnect and the ACL is still active you should call
the hci_calc_flow_spec again to accumulate the params for the rest of
l2cap channels connected. (You should work out the details).

BTW,
The flow spec params in the hci_conn and l2cap_chan can help us in the
future in building trafic shaping on the hci_sched_acl.

Amir
