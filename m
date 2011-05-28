Return-Path: <cyrus@holtmann.org>
Message-ID: <4DE073C2.40607@ethicstech.in>
Date: Sat, 28 May 2011 09:32:10 +0530
From: Siva kumar <sivakumar@ethicstech.in>
MIME-Version: 1.0
To: Jaikumar Ganesh <jaikumarg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: How to implement just works type ssp pairing in bluez
References: <4DDA4FC9.3090302@ethicstech.in> <20110527112746.GB15238@dell.amr.corp.intel.com> <BANLkTin6co9=+exiZ=g6HVgj8NNwVcqe4w@mail.gmail.com>
In-Reply-To: <BANLkTin6co9=+exiZ=g6HVgj8NNwVcqe4w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jaikumar Ganesh wrote:
> Hi Siva:
>
> On Fri, May 27, 2011 at 4:27 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>   
>> Hi Siva,
>>
>> On Mon, May 23, 2011, Siva kumar wrote:
>>     
>>>             I have two android phones, when i connect two phones
>>> using bluetooth it generates passkey and displays it for our
>>> conformation, once we conform, pairing takes place , i was able to
>>> transmit and receive data via bluetooth. i want to change the
>>> pairing process to "just works" of SSP. so that the phones connect
>>> automatically without MITM protection. how to change the pairing
>>> mode of SSP from numerical comparison
>>>       
>> There are two ways how to do this:
>>
>> 1. Make sure neither side requires MITM by setting the security level
>> for each socket to low.
>>
>> 2. Set NoInputNoOutput as the IO capability for the agent on one or both
>> sides (you can override the Android agents capability e.g. by doing your
>> own CreatePairedDevice D-Bus method call).
>>
>> Johan
>>     
>
>
> Majority of Android phones don't use Bluez as the Bluetooth stack.
> If your phone uses Bluez, what Johan said will work.
> If not, post to the Android mailing lists as this is dedicated to Bluez.
>
>   
> Hello Jaikumar,
>   
Android is based on linux, I think Majority of Android phones uses only 
Bluez as the bluetooth stack, Can you please mention what are the other 
Bluetooth stack used in majority of Android phones. So that many of us 
like me can known about that.

Sivakumar

