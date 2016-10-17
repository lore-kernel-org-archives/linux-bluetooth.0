Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Connection handler and btmgmt/bluetoothctl
To: <linux-bluetooth@vger.kernel.org>
References: <578439E0.5080703@epita.fr>
 <20160713055005.GA30167@t440s.P-661HNU-F1> <57D5D09E.7080801@epita.fr>
From: =?UTF-8?Q?Cl=c3=a9ment_Jacquemin?= <clement.jacquemin@epita.fr>
Message-ID: <5805609D.4080908@epita.fr>
Date: Tue, 18 Oct 2016 01:37:01 +0200
MIME-Version: 1.0
In-Reply-To: <57D5D09E.7080801@epita.fr>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am still looking for an answer about these two problems of timeout and 
notifications.

Thank you!

Le 11/09/2016 23:46, Clément Jacquemin a écrit :
> Thanks for your answer Johan!
>
> Le 13/07/2016 07:50, Johan Hedberg a écrit :
>> On Tue, Jul 12, 2016, Clément Jacquemin wrote:
>>> Another question about best practice. For the moment I use "btmgmt" to
>>> configure my daemon. However, the "bluetoothctl" binary seems to be a
>>> more
>>> stable alternative except that i cannot find any way to do the "le on"
>>> command as in "btmgmt".
>>> Is there any way to activate the low energy option with bluetoothctl?
>>
>> bluetoothctl talks to bluetoothd and bluetoothd already automatically
>> enables LE support whenever it's reported to be supported by the kernel.
>>
>> Johan
>
> I still have some questions.
>
> First, is there any equivalent of the 'bt_gatt_server_send_notification'
> method from "src/shared/gatt-server.c" but with the GATT D-BUS API. I
> did not find anything about that.
>
> Second, when one of my characteristic need more than 5 seconds to
> process the data, the client is systematically disconnect 5 seconds
> after requesting a read action on that characteristic. I suppose there
> is a timeout configuration somewhere, but where ?
>
> Clément.

-- 
Clément Jacquemin
Root GISTRE 2016
clement.jacquemin@epita.fr
