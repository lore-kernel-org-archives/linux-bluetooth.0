Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1534714610.5879.11.camel@intel.com>
References: <CAEwN+MBjU=ZmbVyppH6_t45ZLaCRe_8FE7XFDSCnDoSBKKrAag@mail.gmail.com>
 <1534714610.5879.11.camel@intel.com>
From: Raul Piper <raulpblooper@gmail.com>
Date: Tue, 21 Aug 2018 00:13:05 +0530
Message-ID: <CAEwN+MC+33Te21rHpKVcE0HV1c_zugJ1FVR+2uj1vcBrygUQBg@mail.gmail.com>
Subject: Re: Failed to parse provisioning database file prov_db.json :
 BlueZ,Meshctl V5.50
To: "Stotland, Inga" <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Inga,
it gives the below logs :

pi@raspberrypi:~/blueZ $ meshctl -c mesh

Failed to parse local node configuration file mesh/local_node.json



pi@raspberrypi:~/blueZ $ meshctl -v

meshctl: 5.50

i need to do export before executing above commands

pi@raspberrypi:~ $ LD_LIBRARY_PATH=/usr/local/lib

pi@raspberrypi:~ $ export LD_LIBRARY_PATH



to avoid the below error :

pi@raspberrypi:~ $ meshctl -v

meshctl: error while loading shared libraries: libjson-c.so.4: cannot
open shared object file: No such file or directory


can you please assist?
or any  experimental patch I could use on BlueZ

Thanks in advance
Best Regards,
Rp

On Mon, Aug 20, 2018 at 3:06 AM, Stotland, Inga <inga.stotland@intel.com> wrote:
> Hi Raul,
> On Sun, 2018-08-19 at 03:03 +0530, Raul Piper wrote:
>> Hello ,
>> I have built and BlueZ 5.50 from the source and installed it on
>> raspberry PI 3 W0, but when I am trying to launch the meshctl tool -
>> using ./meshctl (from within or out side the mesh directory) i am
>> getting the below error  :
>>
>> Failed to parse provisioning database file prov_db.json
>>
>> I checked the online sanity onfthe above json file and it seems correct.
>>
>>
>>
>> I tried doing the sudo hcitool -lescan - it shows the LE devices and also
>>
>> bluetoothd -v gives 5.50 which shows my compilation and loading of the
>> new BlueZ is alteast correct.
>>
>> I have already installed the c-json lib .
>>
>> Is this a bug in meshctl?
>>
>> Please assist !
>>
>>
>> Thanks in Advance !
>
> Are you using the default json file? If so, there's a bug in meshctl
> for reading from default location (just subimmted a patch for that).
>
> Meanwhile, try running:
>  ./meshctl -c mesh
>
> Regards,
> Inga
>
