Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: New interface to change LE connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAB512GvJ0fz_Tvade+FRorr+Oi2wWLfPq5fjLqAETHzwP9oD4w@mail.gmail.com>
Date: Thu, 30 Jul 2015 13:53:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <67005075-9A4D-43CB-B305-281A3A7AA0D8@holtmann.org>
References: <CAB512Gt-cdR_QT-Sed2W9Avp1SbtsC7eiKY+KL6gXjZeB+A86g@mail.gmail.com> <B268BBF2-7D56-456F-957C-6B4B77A1DAE0@holtmann.org> <CAB512GvJ0fz_Tvade+FRorr+Oi2wWLfPq5fjLqAETHzwP9oD4w@mail.gmail.com>
To: Seungyoun Ju <sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seungyoun,

>>> I plan to provide the kernel interface which is used by user space's
>>> bluez to change LE connection parameters.
>>> 
>>> This is my first trial to implement new feature so I need help.
>>> Would you please give me a comment ?
>>> Are there any better ways ?
>>> 
>>> < Why this is required >
>>> When the LE connection is in idle state (e.g. no traffic),
>>> it is better to increase a connection interval for power saving reason.
>>> Or it needs to reduce a connection interval for a fast response time.
>>> And it may need to change a supervision timeout to detect link loss
>>> faster or looser.
>>> 
>>> It is better to control these kind of things as per application's needs.
>>> So I want to provide the interface to change LE connection parameters.
>>> 
>>> < Current state >
>>> There is no interface to change LE connection parameters for already
>>> connected link.
>>> 
>>> And LE connection parameter is only configured by remote device like below ways.
>>> - remote device(slave) requests a change using l2cap connection
>>> parameter request.
>>> - remote device(master) sends HCI_OP_LE_CONN_UPDATE.
>>> - If above configured parameters are loaded during adapter init.,
>>>  those are automatically applied during connection setup.
>>> 
>>> < How to implement >
>>> When I roughly thought, below ways are possible.
>>> 
>>> 1. Add new MGMT (e.g. MGMT_OP_UPDATE_CONN_PARAM)
>>>  In mgmt handler, based on the role and local / remote LE features,
>>>  do connection parameter update procedure as follows.
>>>  - If remote and local devices both support "HCI_LE_CONN_PARAM_REQ_PROC",
>>>  send HCI_OP_LE_CONN_UPDATE
>>>  - If either the remote or local or both do not support
>>> "HCI_LE_CONN_PARAM_REQ_PROC",
>>>    - if local is master,
>>>    send HCI_OP_LE_CONN_UPDATE.
>>>    - if local is slave,
>>>    send L2CAP_CONN_PARAM_UPDATE_REQ via l2cap signal channel.
>>>  => Main concern of this way is that it is possible to access l2cap from mgmt.
>>> 
>>> 2. Add new MGMT and L2CAP socket option
>>>  - user space's bluez should know own role
>>>  - user space's bluez may know remote / local le features.
>>>    Or, based on the le features, net/core's l2cap may select a procedure.
>>> 
>>> 3. Add new MGMT and send L2CAP command from user space's bluez
>>>  - user space's bluez should know own role
>>>  - user space's bluez may know remote / local le features.
>>>    Or, based on the le features, net/core's l2cap may select a procedure.
>> 
>> actually LE connection parameters should only be a L2CAP socket option. Either you are using a fixed channel for ATT or you are using a LE connection oriented L2CAP channel. In both cases the natural fit is L2CAP socket as an entry point for setting different connection parameters.
>> 
> 
> Thank you for a valuable comment.
> 
>> Also what is set from userspace can only be a suggestion. The kernel would have to make the final call on what parameters it configures with the remote device. Especially with LE connection oriented L2CAP you can have multiple connections which each device. So the most demanding one should have its parameters applied to the link.
>> 
>> And the difference between using the 4.0 method via L2CAP (which is peripheral triggered only) and the 4.1 method for doing this directly via LL is an implementation detail that will be hidden in the kernel. Userspace should just tell the kernel what parameters it prefers. And if possible, the kernel will accommodate it.
>> 
>> That all said, make a proposal for L2CAP socket options to read and configure the connection parameters.
>> 
> 
> This is my proposal based on your comment.
> Can I go forward with this way ?
> 
> ---
> include/net/bluetooth/bluetooth.h | 8 ++++++++
> net/bluetooth/l2cap_sock.c        | 6 ++++++
> 2 files changed, 14 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h
> b/include/net/bluetooth/bluetooth.h
> index 38d8a34..c81c749 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -119,6 +119,14 @@ struct bt_voice {
> #define BT_SNDMTU 12
> #define BT_RCVMTU 13
> 
> +#define BT_CONNECTION_PARAMS 14
> +struct bt_connection_params {
> + __u16 min_interval;
> + __u16 max_interval;
> + __u16 slave_latency;
> + __u16 supv_timeout;
> +};
> +

go with it for now. We will refine it once you have the whole patch done and semantics to test out. Please also ensure to provide l2cap-tester patches to verify the correct behavior.

Regards

Marcel

