Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <d74b6331-760c-84af-754c-0a06e40f01bf@felipetonello.com>
References: <0770df3d-7d10-09be-5667-a652104f66bb@felipetonello.com>
 <09B30424-316E-4423-9547-660CE6F902E7@holtmann.org> <45ee6cfc-7871-c600-0881-2ae7fa9a6955@felipetonello.com>
 <6B5EC9A7-4E31-4548-9F53-AFEC0163796D@holtmann.org> <d74b6331-760c-84af-754c-0a06e40f01bf@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Feb 2017 21:31:59 +0200
Message-ID: <CABBYNZJvFqD9eXygTi1W8nH2YsVctLGY9rhYQ2pLsuYDcQpCMA@mail.gmail.com>
Subject: Re: Update the connection's parameters
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Fri, Feb 3, 2017 at 8:23 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Marcel,
>
> On 02/02/17 10:30, Marcel Holtmann wrote:
>> Hi Felipe,
>>
>>>>> I've been working on the MIDI profile plugin for bluetoothd. This
>>>>> profile requires the lowest latency and connection interval possible.=
 In
>>>>> order to do that we need to update the connection parameters. There a=
re
>>>>> two ways of doing it, first is upon connection
>>>>> (HCI_LE_Create_Connection) and second is updating current connection
>>>>> link (HCI_LE_Connection_Update).
>>>>>
>>>>> The first time an LE slave (MIDI controller) device is connected to
>>>>> BlueZ, the plugin should be able to set this parameters for current
>>>>> connection and save these settings for persistence purposes.
>>>>>
>>>>> As of today, bluetoothd does support the persistence mechanist, which=
 is
>>>>> triggered by a mgmt's New Connection Parameter (0x001c) command, whic=
h
>>>>> in turn is triggered by L2CAP Connection Parameter Update Request or =
a
>>>>> HCI LE Remote Connection Parameter Request (BT 4.1).
>>>>>
>>>>> As mentioned before, this is not enough. Specially because in practic=
e
>>>>> LE slave devices don't send a any of those two requests mentioned abo=
ve.
>>>>>
>>>>> My idea is to set the connection parameter using
>>>>> HCI_LE_Connection_Update if one of the host controllers, master or
>>>>> slave, only supports 4.0. Then update the device info file with curre=
nt
>>>>> ConnectionParameters for persistence.
>>>>>
>>>>> In case both controllers support 4.1 and above, we should use the
>>>>> Connection Parameters Request Procedure (BT 4.1 Vol 6 Part B =C2=A75.=
1.17) in
>>>>> order to negotiate what is the best parameters for the connection.
>>>>>
>>>>> I hope this makes sense. If not, I appreciate your comments. :)
>>>>
>>>> we need to introduce a L2CAP socket option that allows for setting som=
e of the connection parameters. So that the kernel can consolidate these an=
d request them.
>>>
>>> Yes, this sounds great. What would you recommend to implement then?
>>> Using SOL_L2CAP or SOL_SOCKET with a new optname?
>>
>> we want to use SOL_BLUETOOTH. Unless there is a common SOL_SOCKET that w=
ould map here, but I hight doubt that is the case.
>>
>>>> I am not 100% we want to expose the actual values. Maybe it is better =
to have a latency parameter with high, default and low as values.
>>>>
>>>
>>> Yes.
>>>
>>> What would this option trigger the controller to do? Because as I have
>>> seen it really depends on HCI role and BT version, but I am not an
>>> expert in BT, so I appreciate any comments.
>>
>> It should not matter from the API point of view if you do this as slave =
or master. However inside the kernel, it needs to map to the right connecti=
on update procedure.
>
> Right, but if there is a socket option for a l2cap socket,  why then
> have a MGMT command for updating the connection parameter?

Btw, for outgoing connection we might want to trigger the right
parameters from the connection request, just as it is done when they
are loaded using Load Connection Parameters Command, anyway this
should cause the New Connection Parameter Event so the next time we
attempt to connect it should come back with the same parameters agreed
on the last connection. Also note that for passive scanning/auto
connect we would have to use the socket options on the listening
socket which is per adapter not per device, so it wont be possible to
consult the parameters from the socket requesting the ACL to be
connected.

--=20
Luiz Augusto von Dentz
