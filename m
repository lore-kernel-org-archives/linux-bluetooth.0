Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334162966.16897.122.camel@aeonflux>
References: <CACj007=jwOuFXOwXX9z+24KT_WvrCmFrVFp8ru_ncMuQriqYMQ@mail.gmail.com>
	<1334162966.16897.122.camel@aeonflux>
Date: Thu, 12 Apr 2012 20:38:33 +0530
Message-ID: <CACj007moPAWrPZ-bcu-J+QmkRVCV34QCKEiMAmdqtnpCn9WiNw@mail.gmail.com>
Subject: Re: [RFC] BITE test case TP/SEC/SEM/BV-10-C fails
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>, Naresh Gupta <naresh.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 11, 2012 at 10:19 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Hemant,
>
>> I have found a regression issue with latest kernel code. I am trying
>> to execute the test case for GAP TP/SEC/SEM/BV-10-C using BITE.
>> Below is the test purpose
>>
>> 5.4.4.6 TP/SEC/SEM/BV-10-C Security Mode 4 - Master
>> Verify that the IUT disconnects the connection if the initiating side
>> sends the L2CAP_ConnectReq without first enabling encryption. IUT has
>> 2.1 Host and 2.1 Con-troller. Tester has 2.1 Host and 2.1 Controller.
>>
>> As per my analysis,
>> 1) Host is sending HCI Disconnect request before L2CAP_ConnectReq is
>> sent from BITE Tester (It sends it after 5 seconds).
>> 2) This HCI Disconnect is initiated after 4 secs (approx), from host
>> side, since there is no other request received from Remote side after
>> creating ACL.
>>
>> static inline void hci_conn_put(struct hci_conn *conn)
>> {
>> .......
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (conn->state =3D=3D BT_CO=
NNECTED) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeo =3D ms=
ecs_to_jiffies(conn->disc_timeout);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!conn->o=
ut)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 timeo *=3D 2;
>> .......
>> }
>>
>> Here conn->disc_timeout =3D HCI_DISCONN_TIMEOUT =3D 2 Secs.
>>
>> I checked that this timeout has been changed in new kernel, and
>> earlier code, the mulitplication factor for incoming connection was
>> timeo *=3D 5 (20 even before).
>>
>> After increasing the timeout for hci disconnect to more than 5
>> seconds, test case TP/SEC/SEM/BV-10-C passes.
>> Could you confirm if this is acceptable fix to pass the test case.
>
> can we get the BITE tester fixed. It is stupid that it waits 5 seconds
> before sending the L2CAP_Connect_Req. File an errata against the BITE
> tester.
>
> I know that we passed this test case before and I tracked the timeout
> change back to a commit from me from 2009:
>
> commit 052b30b0a8eec8db5b18ad49effdf2a9ba4c1e1a
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date: =A0 Sun Apr 26 20:01:22 2009 +0200
>
> =A0 =A0Bluetooth: Add different pairing timeout for Legacy Pairing
>
> So clearly 3 years ago, this is a breakage in the BITE tester now.
> Someone else would have noticed in this time frame.
>
Thanks for the comments, we have raised the issue with AT4Wireless
now, and awaiting there feedback for the same.

> Regards
>
> Marcel
>
>



--=20
Best Regards
Hemant Gupta
ST-Ericsson India
