Return-Path: <cyrus@holtmann.org>
Message-ID: <49C18674.80801@gmail.com>
Date: Thu, 19 Mar 2009 02:40:36 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Set Tmin and Tmax for inquiry?
References: <49C10E12.3030708@gmail.com> <49C15CC3.3010409@gmail.com> <463DDAC5-0E5C-4BD4-B167-F7590A01EADC@gmail.com>
In-Reply-To: <463DDAC5-0E5C-4BD4-B167-F7590A01EADC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for reply. I have talk to Vudentz at #blues and now know that 
both sets of Tmin and Tmax are hardcoded. He also said me that I can use 
software scheduler, so I do.
Also he said that API's interval is longer (min 16, max 24) because 
there is name resolution feature.
So, I wonder - why this feature is not optional? I think not all 
application need name resolution. Another idea (Vudentz's idea) is to 
hardcode min 10 to API - if chip is smart it will able to end work earlier.


Carles Cufi пишет:
> Hi Ilya,
>
> The hcitool application uses the HCI library function hci_send_req() 
> to send a periodic inquiry request to the controller. The max and min 
> periods are hardcoded to 16 and 10 respectively, and there is no user 
> option to change those. In the case of your python script I can't tell 
> you for sure because I haven't looked at the code of the python BlueZ 
> bindings, but if the API call it presents to you has no Tmin and Tmax 
> that means it's hardcoded there too. The bluetoothd (formerly called 
> hcid) has absolutely nothing to do with the hcitool since this tool 
> bypasses it completely. For python, you should look at the code for 
> the bindings and find out how the API implementation handles your call.
>
> -- 
> Carles
>
> On Mar 18, 2009, at 9:42 PM, Ilya Rubtsov wrote:
>
>> Oops. Mistake. Right is: 'max 24 min 16 lap 0x9e8b33 len 8 num 0' 
>> (StartDiscovery) and 'max 16 min 10 lap 0x9e8b33 len 8 num 0' (hcitool)
>>
>> Ilya Rubtsov пишет:
>>
>>> Hi
>>>
>>> I'm developing an application for bluecasting. So period of periodic 
>>> inquire is important for me.
>>> AFAIK, inquire process takes 10.24 seconds (Bluetooth 2.0). But if I 
>>> use StartDiscovery method in python script, then I see this in hcidump:
>>>
>>> < HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
>>>  max 24 min 16 lap 0x9e8b33 len 8 num 0
>>>
>>> and I get "Inquiry Complete" event every ~24-30 second. But if I use 
>>> 'hcitool spinq', then I see:
>>>
>>> < HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
>>>  max 24 min 16 lap 0x9e8b33 len 8 num 0
>>>
>>> and "Inquiry Complete" event takes place every ~13-15 seconds. And 
>>> in both cases all remote devices is being founded, so I don't see 
>>> any reason for longer inquiring. AFAIK HCID internally sets Tmin and 
>>> Tmax parameters, but is there any way to affect to its 'decision'?
>>>
>>> P.S. Excuse me for my English :(
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

