Return-Path: <cyrus@holtmann.org>
Message-ID: <55BD1603.9020301@gmail.com>
Date: Sat, 01 Aug 2015 20:54:59 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Adam Moore <adam.moore@savantsystems.com>,
	Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Problems with incoming connection request on Nexus 4
References: <55B83614.8090702@gmail.com> <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org> <55BA16BA.5060302@gmail.com> <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org> <55BA2290.8090308@gmail.com> <2C03C1D8-0784-4DA4-93AF-FC8A1C874681@holtmann.org> <CAN_7+YaBFZqhCUF1m_5nNnCbn9inJmKJ6tXVmJ=Ks09A4_6utA@mail.gmail.com> <D1E1442B.ADA2%adam.moore@savant.com>
In-Reply-To: <D1E1442B.ADA2%adam.moore@savant.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam and Lukasz,

thanks for your feedback and insight. I'll let you know when I make 
progress.

Florian

On 08/01/2015 12:41 AM, Adam Moore wrote:
> I just saw this happen on a Nexus 9 (running build LMY47X/5.1.1) when it
> successfully established a BR/EDR connection to my peripheral running
> Linux 3.14 and BlueZ 5.32.
>
> After restarting BT from Settings I started getting LE connections.
>
> I have also have the BR/EDR Not Supported bit set in the peripheral's
> advertising flags.
>
> I'll keep an eye on this too.
>
> On 7/31/15, 12:47 PM, "linux-bluetooth-owner@vger.kernel.org on behalf of
> Lukasz Rymanowski" <linux-bluetooth-owner@vger.kernel.org on behalf of
> lukasz.rymanowski@gmail.com> wrote:
>
>> Hi Florian,
>>
>> On Thu, Jul 30, 2015 at 6:00 PM, Marcel Holtmann <marcel@holtmann.org>
>> wrote:
>>>
>>> Hi Florian,
>>>
>>>>>>>> Symptoms:
>>>>>>>> - The connection request times out.
>>>>>>>> - bt_io_accept() is being called but the accept_cb (=connect_cb)
>>> only gets called when the request times out.
>>>>>>>> - the device is stuck in the CONNECT READY state and never
>>> reaches the CONNECTED state
>>>>>>>>
>>>>>>>>
>>>>>>>> Any ideas how I could analyze/solve that problem? I'm stuck on
>>> this for many hours already...
>>>>>>>
>>>>>>> what does btmon actually tell you about what is going on with HCI.
>>>>>>
>>>>>> = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)
>>> [hci0] 0.629837
>>>>>> @ Advertising Added: 1
>>>>>> < HCI Command: LE Set Advertising Para.. (0x08|0x0006) plen 15
>>> [hci0] 4.398493
>>>>>>         Min advertising interval: 1280.000 msec (0x0800)
>>>>>>         Max advertising interval: 1280.000 msec (0x0800)
>>>>>>         Type: Connectable undirected - ADV_IND (0x00)
>>>>>>         Own address type: Public (0x00)
>>>>>>         Direct address type: Public (0x00)
>>>>>>         Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>>>>>>         Channel map: 37, 38, 39 (0x07)
>>>>>>         Filter policy: Allow Scan Request from Any, Allow Connect
>>> Request from Any (0x00)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>> [hci0] 4.401392
>>>>>>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>>>>>>         Status: Success (0x00)
>>>>>> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>>> [hci0] 4.401484
>>>>>>         Advertising: Enabled (0x01)
>>>>>>> HCI Event: Command Complete (0x0e) plen 4
>>> [hci0] 4.402277
>>>>>>       LE Set Advertise Enable (0x08|0x000a) ncmd 1
>>>>>>         Status: Success (0x00)
>>>>>>
>>>>>> There is no connection related HCI activity going on at all on the
>>> Nexus 4 side. You can see from the debug logs that I sent before, that
>>> the connection is being initiated correctly. The bt_io_accept() call
>>> does return without error, just the accept callback never gets called.
>>> To me it seems as if the Nexus4 was not responding to the incoming
>>> connect request.
>>>>>
>>>>> we are advertising now. If the HCI traffic stays this way, then we
>>> are basically waiting for the central to connect to us. It is up to your
>>> Nexus 4 to connect.
>>>>>
>>>>> If it would connect, then you would see an LE Connect Complete event
>>> indicated that the connection has been established.
>>
>>
>> Actually I recall  that we face the same on Nexus 4 being in
>> peripheral role some time ago. That time our analyzes shows that it is
>> chip or firmware issue. Unfortunately I don't remember if we got rid
>> of it or not. If you have latest firmware and issue is still there,
>> that's a bad luck.
>>
>>>
>>>>
>>>> Sorry, I left out the actual connection part the first time. Here it
>>> is:
>>>>
>>>> = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)
>>> [hci0] 0.248759
>>>>> HCI Event: Connect Request (0x04) plen 10
>>> [hci0] 9.147279
>>>>         Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
>>>>         Class: 0x5a020c
>>>>           Major class: Phone (cellular, cordless, payphone, modem)
>>>>           Minor class: Smart phone
>>>>           Networking (LAN, Ad hoc)
>>>>           Capturing (Scanner, Microphone)
>>>>           Object Transfer (v-Inbox, v-Folder)
>>>>           Telephony (Cordless telephony, Modem, Headset)
>>>>         Link type: ACL (0x01)
>>>
>>> this is a BR/EDR connection. So it seems even while it sees you
>>> advertise on LE, it then connects using BR/EDR. Since Bluetooth 4.0 did
>>> not allow BR/EDR and LE at the same time. Only Bluetooth 4.1 relaxed
>>> this.
>>>
>>> But it is hilarious that your phone stack sees an LE advertising and
>>> then connects to you over BR/EDR.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>
>> £ukasz
>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Statement of Confidentiality
>
> The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

