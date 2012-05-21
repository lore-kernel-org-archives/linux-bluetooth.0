Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4FB4B13D.1010302@tieto.com>
References: <1337201737-5983-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1337202331.5970.269.camel@aeonflux>
	<CA+6KyKZ0vrPHoXXfWwJdiVLDR+59azRwWMhJbjndM+Aw_dKSwA@mail.gmail.com>
	<1337204910.5970.271.camel@aeonflux>
	<4FB4B13D.1010302@tieto.com>
Date: Mon, 21 May 2012 19:30:14 -0300
Message-ID: <CACJA=fVgzh9-RXBeJ=N7KRHDnEo_GTcVOnnv2dc-JMxKriBb4g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Use hci_conn data to handle failed LE
 Connection Complete
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej/Marcel,

On Thu, May 17, 2012 at 5:05 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Hi Marcel,
>
>
> On 16.05.2012 23:48, Marcel Holtmann wrote:
>>>>>
>>>>> =A0 =A0 =A0 hci_dev_lock(hdev);
>>>>>
>>>>> + =A0 =A0 if (ev->status) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 conn =3D hci_conn_hash_lookup_state(hdev, L=
E_LINK,
>>>>> BT_CONNECT);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!conn)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>>>>> +
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mgmt_connect_failed(hdev,&conn->dst, conn->=
type,
>>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con=
n->dst_type, ev->status);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_proto_connect_cfm(conn, ev->status);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 conn->state =3D BT_CLOSED;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_del(conn);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>>>>> + =A0 =A0 }
>>>>> +
>>>>> =A0 =A0 =A0 conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK,&ev->bdadd=
r);
>>>>> =A0 =A0 =A0 if (!conn) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn =3D hci_conn_add(hdev, LE_LINK,&ev->=
bdaddr);
>>>>
>>>>
>>>> this change is wrong. We are now treating every single adapter as bein=
g
>>>> broken. That is not acceptable.
>>>
>>>
>>> Why do you think these adapters are broken? As I explained in cover
>>> letter for v1, spec does not require peer address to be provided in
>>> Connection Complete which is reasonable since we can only have one
>>> pending connection request. Also as Claudio and Andre noticed such
>>> behaviour could be to simplify whitelist implementation - in case of
>>> connection request using whitelist it does not make sense to include
>>> specific peer address in event.
>>
>>
>> what has whitelist behavior to do with this event in the failure case?
>
>
> Just a sidenote on why some vendors may want to omit BD_ADDR and it does =
not
> make adapter broken. Not directly related to this scenario.

I was taking a look at Core spec change request document [1] and I found th=
is:

Erratum 4215, LE connection complete event missing exception
"... On failure, for this event, all other parameters are not valid."

It clearly states this is an expected behavior and nullify those
parameters doesn't make the adapter broken.

Thus, in case of failure, we should not rely on those parameters
(BD_ADDR included) in order to properly handle LE Connection Complete
Events.

>>>> We should only add a tweak if the BD_ADDR parameter is BDADDR_ANY and
>>>> not as a general rule. In addition if we do this, we need to print a
>>>> warning to dmesg to make this known.
>>>
>>>
>>> Perhaps we can just add warning in case BD_ADDR is not BDADDR_ANY and
>>> we cannot find hci_conn for it - in such case most probably something
>>> went wrong.
>>
>>
>> What are the adapters from Broadcom, CSR, TI and ST are returning in a
>> failure case? Are they all omitting the BD_ADDR value?
>
>
> No, I noticed this on BCM and based on previous comments it seems that th=
is
> is what BCM and ST(E) are doing while CSR and TI return BD_ADDR. Except t=
hat
> previously I was using ST-E chip which did return BD_ADDR so this is not
> even consistent per manufacturer.
>
> As said before, omitted BD_ADDR seems to be fine from spec perspective so=
 we
> should not require it to be present. Since we can have only one LE hci_co=
nn
> in BT_CONNECT state it's reasonable to use it here. This is already in
> patch.
>
> What could be indeed added to this patch is warning message in case BD_AD=
DR
> is not BDADDR_ANY and it does not match one stored in hci_conn (either
> adapter returns random BD_ADDR which is weird or something went wrong).

IMO, this warning message is not really necessary.

BR,

Andre

[1] - https://www.bluetooth.org/Technical/Specifications/enhancements.htm
(must be signed in Bluetooth SIG)
