Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APZCzOMRWR1fLO2LmOPBbYRfCvRUfra5O2XYvtibSwY9Tw@mail.gmail.com>
References: <CAOwdT4=_T4zXX-S0c5h+siL9Pa2DoNAAFB+fK4gTaPqKnP5N5w@mail.gmail.com>
 <CAOwdT4nAa7JLf1465Mrb64JPk91DgcjRcFqet750obeeEjVxLw@mail.gmail.com> <CAAu3APZCzOMRWR1fLO2LmOPBbYRfCvRUfra5O2XYvtibSwY9Tw@mail.gmail.com>
From: "Gabriel A. Zorrilla" <gaz082@gmail.com>
Date: Sun, 28 Jan 2018 19:27:47 -0300
Message-ID: <CAOwdT4mHHKLB-k7wXk2VkdW+GgvsOAODn7wUrP1bSoD03_zEig@mail.gmail.com>
Subject: Re: lescan stops after 10-15 minutes (bluez 5.48)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

Dont think so. The size of the dumps are over 4k sometimes and
sometimes less and the btmon output does not mention any buffer size
issue.

But i'm no expert.

Thanks!

On Sun, Jan 28, 2018 at 6:44 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello
>
> On 28 January 2018 at 19:44, Gabriel A. Zorrilla <gaz082@gmail.com> wrote:
>> Hello there. I'm really desperate here. I'm trying to work with BLE in
>> my Pi3. When i do:
>>
>> sudo hcitools lescan (with or without -duplicates) the Pi scans
>> normally then stops after about 10-15 minutes.
>
> Could it be similar to the following issue on GitHub?
> https://github.com/ttu/ruuvitag-sensor/pull/34
>
>
>>
>> Here I made some btmon dumps:
>> without duplicates: http://termbin.com/ox3z
>> with duplicates: http://termbin.com/6nnn
>>
>> * Pi3
>> * Raspbian with 4.9.66-v7+ kernel.
>> * Embedded bluetooth.
>> * Compilled bluez 5.48
>>
>> Don't know what extra info you would need to diagnose this. Perhaps
>> it's a common bug in the Pi3 Raspbian distro, but cant find
>> information about this on the web. Been googling for a week.
>>
>> I really want to make this work, so dont hesitate in asking me some
>> tests and such.
>>
>> Thanks and regards,
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Gabriel A. Zorrilla
