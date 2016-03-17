Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: No Connected=false event on iPhone app kill.
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
In-Reply-To: <CABBYNZ+D5NcZUQQ+RjM1HK5Dp5KB0V7Q3qeh8JWnCSgy4Lw++Q@mail.gmail.com>
Date: Thu, 17 Mar 2016 15:37:53 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4E13A8D7-3D62-44C5-9B1F-A1788BFE8C4F@gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com> <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com> <DE03A908-C3D3-4467-AB9F-3CD11C2539C7@gmail.com> <CABBYNZKCr53JJGVjPq65_aH8vp3LfCpymPmPPpZ_NwPosWFHSA@mail.gmail.com> <48839EC2-6A8E-4110-8224-229ACCAC5854@gmail.com> <CABBYNZK1G+M-ge+XdBGpwKXw+w6Hau4E3Xc+-KyMr7BDRL1-ug@mail.gmail.com> <55A7F9E2-32E1-4618-8E8A-CEC75F464025@gmail.com> <CABBYNZLEvn4Gw2=ukc8o+WZoaQ13FZSm5cX3xoczGC2D5g1Y0g@mail.gmail.com> <CABBYNZJxdzs620LZCAqSEuC4p3goa1=m=Jmh2erxY66NmDFoVg@mail.gmail.com> <C3C308DE-48EE-4A57-8CC7-7B230D0BF6D8@gmail.com> <CABBYNZ+FYuUp+Bt-BKs96U04HF-kw1ugvujPSCpvgVzdh3wH8A@mail.gmail.com> <CABBYNZ+D5NcZUQQ+RjM1HK5Dp5KB0V7Q3qeh8JWnCSgy4Lw++Q@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On 17 Mar 2016, at 13:22, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Tonis,
> 
> On Thu, Mar 17, 2016 at 1:20 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> 
>>> I tried the patches and they did not seem to work unfortunately.
>>> 
>>> here are the valgrind and btmon logs:
>>> patch 1: http://pastebin.com/raw/pKbLtBAw
>>> patch 2: http://pastebin.com/raw/sW68M3vK
> 
> Btw, if you are seeing gatt_client_remove_all_notify_in_range in the
> trace that is probably because the version you are running is not
> patched as the first patch removes it, so something is not right with
> your setup.
> 
>>> Since this is the first time for me to apply patches, maybe its good to verify my patching/building process?
>>> 
>>> $ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git
>>> $ checkout 5.37 commit
>> 
>> No need to checkou 5.37, we want to check the result using the
>> upstream version so it can be added to 5.38
>> 
>>> 
>>> store the 2 patches in .patch files
>>> 
>>> $ git apply patch1.patch
>> 
>> This is correct.
>> 
>>> rebuild the blueZ with:
>>> 
>>> $ ./configure --enable-experimental && make
>>> $ make install && ln -svf ../libexec/bluetooth/bluetoothd /usr/sbin
>>> $ install -v -dm755 /etc/bluetooth && install -v -m644 src/main.conf /etc/bluetooth/main.conf
>>> 
>>> run the bluetooth again
>>> $ sudo /usr/sbin/bluetoothd -E -d
>>> 
>>> verify that it still crashes and try to apply the patch2 as well (without cloning the repo again e.g keeping the patch1 changes)
>> 
>> Just apply the 2 together, and take a look at HACKING how to build and
>> run from the source tree since you probably don't want to replace the
>> BlueZ that is coming with your distro.
> 

Thanks for pointing me to the HACKING file. I think I managed to use the latest blueZ with the patches this time.

I do not observe the crash anymore and I get the connected=false signal. The only problem now is that this signal(and bluetooth disconnect on iPhone side) happens after ~15s. This is a bit slow for us and I will try to find a solution to indicate it a bit faster.

These are the g-properties-changed for my Device after killing the iPhone app.
{'UUIDs', <@as []>} : {'ServicesResolved', <false>} : {'Connected', <false>}


Thanks again, I really appreciate the quick replies from you!


> 
> 
> -- 
> Luiz Augusto von Dentz

