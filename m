Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431EF25D.4050103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO over UART
References: <4302F91F.7020202@umit.at> <4303A01D.6030104@xmission.com> <4305B185.2080604@umit.at> <430C16EE.4090501@xmission.com> <431EA16B.3060805@umit.at>
In-Reply-To: <431EA16B.3060805@umit.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Sep 2005 07:59:57 -0600

David,

Who did you talk to at infineon? Gumstix is switching to their PBA31307 
chip which is also supposed to support sco over hci (it's hinted at in 
their docs) but not spelled out anywhere. And it shouldn't be 
end-of-lifed all that soon...

I would hope that all three chips behave the same for sco...

Gumstix is going to cover the bases with pcm too. When they switch to 
the PBA, they are going to wire the sco pcm connections to one of 
xscale's pcm i/o. We should be able to use sco over pcm.

Sco over pcm will require some devel work but it might actually be the 
perfect time to use libalsa since it will just be a regular pcm driver 
with extra signaling on top for connect/disconnect/volume.

Brad

David Bannach wrote:
> brad,
> 
> this is the answer from infineon (after waiting a couple of weeks):
> 
> "ROK104001 has PD status (Product Discontinuation). Last order date is 
> November 31, 2005.
> For the Product Discontinuation please click 
> http://www.infineon.convergy.de/upload/documents/2005/cPD_036_05.pdf
> Infineon has no other BT with embedded flash.
> 
> ROK104001 do not support SCO-traffic via HCI feature.
> 
> Inquiry: We would like to transfer SCO-traffic via HCI. Is this possible 
> with the ROK104 001?"
> 
> 
> 
> for testing i used the tools 'scotest' and 'hstest' to prevent running 
> into trubles with btsco/alsa.
> 
> david
> 
> 
> Brad Midgley wrote:
> 
>> David,
>>
>> It doesn't seem to help anything...
>>
>> # hcitool cmd 0x3f 0x001d 0x00
>> < HCI Command: ogf 0x3f, ocf 0x001d, plen 1
>>   00
>> > HCI Event: 0x0e plen 4
>>   07 1D FC 00
>>
>> but then I haven't been able to confirm that I've done all the right 
>> things to get btsco to work on gumstix.
>>
>> This doesn't look right:
>>
>> btsco v0.4a
>> Device is 0:0
>> Voice setting: 0x0060
>> RFCOMM channel 2 connected
>> speaker volume: 0 mic volume: 0
>> driver is in use
>> Can't connect SCO audio channel
>> : Device or resource busy
>>
>> where the "driver is in use" message first appears when trying to play 
>> music to the audio device.
>>
>> Brad
>>
>> David Bannach wrote:
>>
>>> brad,
>>>
>>>> What is the ericsson command and how do you inject it into hci?
>>>>
>>>> Is the rok101008 similar in this respect to the rok104001? That's 
>>>> what's on the gumstix.com board and I've been *very* interested in 
>>>> getting sco working with this. I thought it couldn't be coaxed into 
>>>> using hci.
>>>
>>>
>>>
>>>
>>> the command is "ericsson_set_sco_data_path". i found it in this 
>>> document (only): 
>>> http://www.vs.inf.ethz.ch/res/proj/smart-its/dl/ROK_101_007_revR1C-HCI_ericsson_specific.pdf 
>>>
>>>
>>> i use hcitool for sending the command to the module, e.g. the 
>>> following line will set the sco mapping to hci:
>>>
>>>    hcitool cmd 0x3f 0x001d 0x00
>>>
>>> the rok101008 and rok104001 seem very similar. at least the command 
>>> above returns a positive response on both devices. i did not notice 
>>> differences of these devices so far. actually i want to get sco 
>>> running on the rok104001 which is built into a qbic (pxa based 
>>> wearable) but it's easier to try things with an external module 
>>> attached to a notebook.
>>>
>>> i'm still having the problem that bluez does not send any sco data to 
>>> the module. i'm really curious about your results.
>>>
>>> david
>>>
>>>
>>> -------------------------------------------------------
>>> SF.Net email is Sponsored by the Better Software Conference & EXPO
>>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
>>> Practices
>>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing 
>>> & QA
>>> Security * Process Improvement & Measurement * 
>>> http://www.sqe.com/bsce5sf
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>
>>
>>
>> -------------------------------------------------------
>> SF.Net email is Sponsored by the Better Software Conference & EXPO
>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
>> Practices
>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing 
>> & QA
>> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
